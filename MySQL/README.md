# MySQL
Для лабораторных работ использую Macbook Air M2 чипсет amr64, OS Sonoma 14.6.1, система виртуализации VMware Fusion, при выполнении лабораторной работы использовал образ vagrantbox bento/ubuntu-22.04.

## Цель домашнего задания
Репликация mysql

- Цель
Поработать с реаликацией MyAQL.

## Что нужно сделать?
В материалах приложены ссылки на вагрант для репликации и дамп базы bet.dmp

Базу развернуть на мастере и настроить так, чтобы реплицировались таблицы:
```
| bookmaker   |
| competition |
| market      |
| odds        |
| outcome     |
```
Настроить GTID репликацию

## Выполнение

- Разворачивает виртуалки в Vagrant (master,slave) с установкой mysql версии 8.0

```
vagrant up
```

- Percona устанавливается при разворачивании стенда и переносит необходимый конфиг.


По умолчанию Percona хранит файлы в таком виде:

- Основной конфиг в /etc/mysql/
- Так же инклудится директориā /etc/mysql/mysql.conf.d/ - куда мы и будем складывать наши конфиги
- Дата файлы в /var/lib/mysql

- Проверяем службу mysql
```
root@master:~# systemctl status mysql
● mysql.service - Percona Server
     Loaded: loaded (/lib/systemd/system/mysql.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2024-09-05 02:12:26 MSK; 2h 9min left
   Main PID: 1009 (mysqld)
     Status: "Server is operational"
      Tasks: 41 (limit: 2207)
     Memory: 450.2M
        CPU: 39.540s
     CGroup: /system.slice/mysql.service
             └─1009 /usr/sbin/mysqld

Sep 05 02:12:25 master systemd[1]: Starting Percona Server...
Sep 05 02:12:26 master systemd[1]: Started Percona Server.
```

- Подключаемся к mysql и меняем пароль для доступа к полному функционалу

```
mysql -uroot 

ALTER USER USER() IDENTIFIED BY 'P@ssw0rd';
```

- Репликацию будем настраивать с использованием GTID. Что это такое и зачем это надо можно почитать [здесь](https://dev.mysql.com/doc/refman/5.6/en/replication-gtids-concepts.html).

- - Следует обратить внимание, что атрибут server-id на мастер-сервере должен обязательно отличаться от server-id слейв-сервера. Проверить какая переменная установлена в текущий момент можно следующим образом
```
mysql> SELECT @@server_id;
+-------------+
| @@server_id |
+-------------+
|           1 |
+-------------+
1 row in set (0.00 sec)
```

- Убеждаемся что GTID включен
```
mysql> SHOW VARIABLES LIKE 'gtid_mode';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| gtid_mode     | ON    |
+---------------+-------+
1 row in set (0.03 sec)
```

- Создадим тестовую базу bet и загрузим в нее дамп и проверим
```
mysql> CREATE DATABASE bet;
Query OK, 1 row affected (0.01 sec)
```
```
root@master:~# mysql -uroot -p -D bet < /home/vagrant/bet.dmp
```
```
mysql> USE bet;
Database changed
mysql> SHOW TABLES;
+------------------+
| Tables_in_bet    |
+------------------+
| bookmaker        |
| competition      |
| events_on_demand |
| market           |
| odds             |
| outcome          |
| v_same_event     |
+------------------+
7 rows in set (0.00 sec)
```

- Создадим полþзователā для репликации и даем ему права на эту саму репликацию:
```
mysql> CREATE USER 'repl'@'%' IDENTIFIED BY '!OtusLinux2024';
Query OK, 0 rows affected (0.02 sec)
```
```
mysql> SELECT user,host FROM mysql.user where user='repl';
+------+------+
| user | host |
+------+------+
| repl | %    |
+------+------+
1 row in set (0.00 sec)
```
```
mysql> GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%';
Query OK, 0 rows affected (0.01 sec)

mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.01 sec)
```

- Правим в /etc/my.cnf.d/01-base.cnf директиву server-id = 2

```bash
SELECT @@server_id;

+-------------+
| @@server_id |
+-------------+
|           2 |
+-------------+
1 row in set (0.00 sec)
```

- Раскомментируем в /etc/my.cnf.d/05-binlog.cnf строки

```bash
#replicate-ignore-table=bet.events_on_demand
#replicate-ignore-table=bet.v_same_event
```

> Таким образом указываем таблицы которые будут игнорироваться при репликации

- Заливаем дамп мастера и убеждаемся, что база есть и она без лишних таблиц

```bash
systemctl start mysql
cat /var/log/mysqld.log | grep 'root@localhost:' | awk '{print $11}'
S6;(/Jlg!MrZ
mysql -uroot -p'S6;(/Jlg!MrZ'

ALTER USER USER() IDENTIFIED BY 'iGdnT#^7H&Bs';

SOURCE /vagrant/master.sql
SHOW DATABASES LIKE 'bet';

+----------------+
| Database (bet) |
+----------------+
| bet            |
+----------------+
1 row in set (0.00 sec)

USE bet;
SHOW TABLES;

+---------------+
| Tables_in_bet |
+---------------+
| bookmaker     |
| competition   |
| market        |
| odds          |
| outcome       |
+---------------+
5 rows in set (0.00 sec)
```

> видим что таблиц v_same_event и events_on_demand нет

- Ну и собственно подключаем и запускаем слейв

```bash
CHANGE MASTER TO MASTER_HOST = "192.168.56.11", MASTER_PORT = 3306, MASTER_USER = "repl", MASTER_PASSWORD = "!OtusLinux2018", MASTER_AUTO_POSITION = 1;
START SLAVE;
SHOW SLAVE STATUS\G

*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.56.11
                  Master_User: repl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000002
          Read_Master_Log_Pos: 119864
               Relay_Log_File: slave-relay-bin.000002
                Relay_Log_Pos: 119864
        Relay_Master_Log_File: mysql-bin.000002
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes           
```

- Видно что репликация работает, gtid работает и игнорятся таблички по заданию

```bash
               Slave_IO_State: Waiting for master to send event
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
       Replicate_Ignore_Table: bet.events_on_demand,bet.v_same_event
           Retrieved_Gtid_Set: 000d1310-cba8-11ec-a2f2-5254004d77d3:1
            Executed_Gtid_Set: 000d1310-cba8-11ec-a2f2-5254004d77d3:1
```

- Проверим репликацю в действии. На мастере

```bash
USE bet;
INSERT INTO bookmaker (id,bookmaker_name) VALUES(1,'1xbet');
SELECT * FROM bookmaker;

+----+----------------+
| id | bookmaker_name |
+----+----------------+
|  1 | 1xbet          |
|  4 | betway         |
|  5 | bwin           |
|  6 | ladbrokes      |
|  3 | unibet         |
+----+----------------+
5 rows in set (0.00 sec)
```

- На слейве

```bash
SELECT * FROM bookmaker;

+----+----------------+
| id | bookmaker_name |
+----+----------------+
|  1 | 1xbet          |
|  4 | betway         |
|  5 | bwin           |
|  6 | ladbrokes      |
|  3 | unibet         |
+----+----------------+
5 rows in set (0.00 sec)
```

- В binlog-ах на cлейве также видно последнее изменение, туда же он пишет информацию о GTID

```bash
SHOW BINLOG EVENTS;
+------------------+-----+----------------+-----------+-------------+------------------------------------------------------------------------+
| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                                                   |
+------------------+-----+----------------+-----------+-------------+------------------------------------------------------------------------+
| mysql-bin.000001 |   4 | Format_desc    |         2 |         123 | Server ver: 5.7.37-40-log, Binlog ver: 4                               |
| mysql-bin.000001 | 123 | Previous_gtids |         2 |         154 |                                                                        |
| mysql-bin.000001 | 154 | Gtid           |         1 |         219 | SET @@SESSION.GTID_NEXT= '000d1310-cba8-11ec-a2f2-5254004d77d3:2'     |
| mysql-bin.000001 | 219 | Query          |         1 |         292 | BEGIN                                                                  |
| mysql-bin.000001 | 292 | Query          |         1 |         419 | use `bet`; INSERT INTO bookmaker (id,bookmaker_name) VALUES(1,'1xbet') |
| mysql-bin.000001 | 419 | Xid            |         1 |         450 | COMMIT /* xid=1221 */                                                  |
+------------------+-----+----------------+-----------+-------------+------------------------------------------------------------------------+
6 rows in set (0.00 sec)
```
