# Postgresql
Для лабораторных работ использую Macbook Air M2 чипсет amr64, OS Sonoma 14.6.1, система виртуализации VMware Fusion, при выполнении лабораторной работы использовал образ vagrantbox bento/ubuntu-22.04.

## Цель домашнего задания
Научиться настраивать репликацию и создавать резервные копии в СУБД PostgreSQL

- Цель
1) Настроить hot_standby репликацию с использованием слотов
2) Настроить правильное резервное копирование

## Выполнение

- Разворачиваем виртуалки в Vagrant (master,slave,barman) с помощью Ansible устанавливаем postgresql 16 и barman 3.* версии и донастроиваем сервера.

```
Postrgresql % vagrant up
Bringing machine 'master' up with 'vmware_desktop' provider...
Bringing machine 'slave' up with 'vmware_desktop' provider...
Bringing machine 'barman' up with 'vmware_desktop' provider...
==> master: Checking if box 'bento/ubuntu-22.04' version '202401.31.0' is up to date...
==> master: Verifying vmnet devices are healthy...
==> master: Starting the VMware VM...
==> master: Waiting for the VM to receive an address...
==> master: Forwarding ports...
    master: -- 22 => 2222
==> master: Waiting for machine to boot. This may take a few minutes...
    master: SSH address: 172.16.203.171:22
    master: SSH username: vagrant
    master: SSH auth method: password
==> master: Machine booted and ready!
==> slave: Checking if box 'bento/ubuntu-22.04' version '202401.31.0' is up to date...
==> slave: Verifying vmnet devices are healthy...
==> slave: Fixed port collision for 22 => 2222. Now on port 2200.
==> slave: Starting the VMware VM...
==> slave: Waiting for the VM to receive an address...
==> slave: Forwarding ports...
    slave: -- 22 => 2200
==> slave: Waiting for machine to boot. This may take a few minutes...
    slave: SSH address: 172.16.203.172:22
    slave: SSH username: vagrant
    slave: SSH auth method: password
==> slave: Machine booted and ready!
==> barman: Checking if box 'bento/ubuntu-22.04' version '202401.31.0' is up to date...
==> barman: Verifying vmnet devices are healthy...
==> barman: Fixed port collision for 22 => 2222. Now on port 2201.
==> barman: Starting the VMware VM...
==> barman: Waiting for the VM to receive an address...
==> barman: Forwarding ports...
    barman: -- 22 => 2201
==> barman: Waiting for machine to boot. This may take a few minutes...
    barman: SSH address: 172.16.203.173:22
    barman: SSH username: vagrant
    barman: SSH auth method: password
==> barman: Machine booted and ready!
```

<details><summary>ansible-playbook postgresql.yaml</summary>
    
```
Postrgresql % ansible-playbook postgresql.yaml                        

PLAY [all] *******************************************************************************************************************************************************************************************************

TASK [update] ****************************************************************************************************************************************************************************************************
ok: [slave]
ok: [master]
ok: [barman]

TASK [Upgrade all packages] **************************************************************************************************************************************************************************************
changed: [slave]
changed: [master]
changed: [barman]

TASK [Set timezone to Europe/Moscow] *****************************************************************************************************************************************************************************
ok: [slave]
ok: [barman]
ok: [master]

TASK [Install required packages] *********************************************************************************************************************************************************************************
ok: [master]
ok: [barman]
ok: [slave]

TASK [Set up Postgres repo] **************************************************************************************************************************************************************************************
changed: [barman]
changed: [master]
changed: [slave]

TASK [Download PostgreSQL key and add it to system keyring] ******************************************************************************************************************************************************
ok: [barman]
ok: [master]
ok: [slave]

PLAY [DB] ********************************************************************************************************************************************************************************************************

TASK [Update apt cache] ******************************************************************************************************************************************************************************************
ok: [master]
ok: [slave]

TASK [Install PostgreSQL] ****************************************************************************************************************************************************************************************
ok: [master]
ok: [slave]

PLAY [barman] ****************************************************************************************************************************************************************************************************

TASK [Update apt cache] ******************************************************************************************************************************************************************************************
ok: [barman]

TASK [Install PostgreSQL] ****************************************************************************************************************************************************************************************
ok: [barman]

PLAY [install postgres 16 and set up replication] ****************************************************************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************************************************************************************
ok: [master]
ok: [slave]

TASK [postgres_master : Create a Superuser PostgreSQL database user] *********************************************************************************************************************************************
skipping: [slave]
ok: [master]

TASK [postgres_master : copy postgresql.conf] ********************************************************************************************************************************************************************
skipping: [slave]
ok: [master]

TASK [postgres_master : copy pg_hba.conf] ************************************************************************************************************************************************************************
skipping: [slave]
ok: [master]

TASK [postgres_master : Restart Postgresql] **********************************************************************************************************************************************************************
skipping: [slave]
changed: [master]

TASK [postgres_replication : stop postgresql-server on slave] ****************************************************************************************************************************************************
skipping: [master]
changed: [slave]

TASK [postgres_replication : Remove files from data catalog] *****************************************************************************************************************************************************
skipping: [master]
changed: [slave]

TASK [postgres_replication : copy files from master to slave] ****************************************************************************************************************************************************
skipping: [master]
changed: [slave]

TASK [postgres_replication : Ensure PostgreSQL is listening] *****************************************************************************************************************************************************
skipping: [master]
ok: [slave]

TASK [postgres_replication : Restart Postgresql] *****************************************************************************************************************************************************************
skipping: [master]
changed: [slave]

PLAY [install and setting barman] ********************************************************************************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************************************************************************************
ok: [barman]
ok: [master]
ok: [slave]

TASK [barman : install base tools] *******************************************************************************************************************************************************************************
skipping: [master]
skipping: [slave]
ok: [barman]

TASK [barman : install barman and postgresql packages on barman] *************************************************************************************************************************************************
skipping: [master]
skipping: [slave]
ok: [barman]

TASK [barman : install barman-cli and postgresql packages on nodes] **********************************************************************************************************************************************
skipping: [master]
ok: [slave]
ok: [barman]

TASK [barman : generate SSH key for postgres] ********************************************************************************************************************************************************************
skipping: [slave]
skipping: [barman]
ok: [master]

TASK [barman : generate SSH key for barman] **********************************************************************************************************************************************************************
skipping: [master]
skipping: [slave]
ok: [barman]

TASK [barman : fetch all public ssh keys master] *****************************************************************************************************************************************************************
skipping: [slave]
skipping: [barman]
changed: [master]

TASK [barman : transfer public key to barman] ********************************************************************************************************************************************************************
skipping: [slave]
skipping: [barman]
ok: [master -> barman(192.168.57.13)]

TASK [barman : fetch all public ssh keys barman] *****************************************************************************************************************************************************************
skipping: [master]
skipping: [slave]
changed: [barman]

TASK [barman : transfer public key to barman] ********************************************************************************************************************************************************************
skipping: [master]
skipping: [slave]
ok: [barman -> master(192.168.57.11)]

TASK [barman : Create barman user] *******************************************************************************************************************************************************************************
skipping: [slave]
skipping: [barman]
ok: [master]

TASK [barman : restart postgresql-server on master] **************************************************************************************************************************************************************
skipping: [slave]
skipping: [barman]
changed: [master]

TASK [barman : Create DB for backup] *****************************************************************************************************************************************************************************
skipping: [slave]
skipping: [barman]
ok: [master]

TASK [barman : Add tables to otus_backup] ************************************************************************************************************************************************************************
skipping: [slave]
skipping: [barman]
ok: [master]

TASK [barman : copy .pgpass] *************************************************************************************************************************************************************************************
skipping: [master]
skipping: [slave]
ok: [barman]

TASK [barman : copy barman.conf] *********************************************************************************************************************************************************************************
skipping: [master]
skipping: [slave]
ok: [barman]

TASK [barman : copy master.conf] *********************************************************************************************************************************************************************************
skipping: [master]
skipping: [slave]
changed: [barman]

TASK [barman : barman switch-wal master] *************************************************************************************************************************************************************************
skipping: [master]
skipping: [slave]
changed: [barman]

TASK [barman : barman cron] **************************************************************************************************************************************************************************************
skipping: [master]
skipping: [slave]
changed: [barman]

PLAY RECAP *******************************************************************************************************************************************************************************************************
barman                     : ok=20   changed=6    unreachable=0    failed=0    skipped=7    rescued=0    ignored=0   
master                     : ok=21   changed=5    unreachable=0    failed=0    skipped=16   rescued=0    ignored=0   
slave                      : ok=16   changed=6    unreachable=0    failed=0    skipped=21   rescued=0    ignored=0   

```
</details>

-  Проверяем параметры подключения в файле на master и slave /etc/postgresql/16/main/pg_hba.conf
```
root@master:~# cat /etc/postgresql/16/main/pg_hba.conf
# PostgreSQL Client Authentication Configuration File
#
# Database administrative login by Unix domain socket
local   all             postgres                               trust 

# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                          trust
# IPv4 local connections:
host    all             all             127.0.0.1/32            scram-sha-256
# IPv6 local connections:
host    all             all             ::1/128                 scram-sha-256
# Allow replication connections from localhost, by a user with the
# replication privilege.
local   replication     all                                     peer
host    replication     all             127.0.0.1/32            scram-sha-256
host    replication     all             ::1/128                 scram-sha-256
host    replication     replication     192.168.57.11/32        scram-sha-256
host    replication     replication     192.168.57.12/32        scram-sha-256
host    all             barman          192.168.57.13/32        scram-sha-256
host    replication     barman          192.168.57.13/32        scram-sha-256
```
```
root@slave:~# cat /etc/postgresql/16/main/pg_hba.conf
# PostgreSQL Client Authentication Configuration File
#
# Database administrative login by Unix domain socket
local   all             postgres                               trust 

# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                          trust
# IPv4 local connections:
host    all             all             127.0.0.1/32            scram-sha-256
# IPv6 local connections:
host    all             all             ::1/128                 scram-sha-256
# Allow replication connections from localhost, by a user with the
# replication privilege.
local   replication     all                                     peer
host    replication     all             127.0.0.1/32            scram-sha-256
host    replication     all             ::1/128                 scram-sha-256
```

### Проверка репликации: 

- На хосте master в psql проверяем список БД:
```
root@master:~# sudo psql -U postgres
psql (16.4 (Ubuntu 16.4-1.pgdg22.04+1))
Type "help" for help.

postgres=# \l
                                                       List of databases
   Name    |  Owner   | Encoding | Locale Provider |   Collate   |    Ctype    | ICU Locale | ICU Rules |   Access privileges   
-----------+----------+----------+-----------------+-------------+-------------+------------+-----------+-----------------------
 demo      | postgres | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |            |           | 
 postgres  | postgres | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |            |           | 
 template0 | postgres | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |            |           | =c/postgres          +
           |          |          |                 |             |             |            |           | postgres=CTc/postgres
 template1 | postgres | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |            |           | =c/postgres          +
           |          |          |                 |             |             |            |           | postgres=CTc/postgres
(4 rows)
```

- На хосте slave также в psql также проверим список БД (команда \l), в списке БД должна появится БД demo.
```
root@slave:~# sudo psql -U postgres
psql (16.4 (Ubuntu 16.4-1.pgdg22.04+1))
Type "help" for help.

postgres=# \l
                                                       List of databases
   Name    |  Owner   | Encoding | Locale Provider |   Collate   |    Ctype    | ICU Locale | ICU Rules |   Access privileges   
-----------+----------+----------+-----------------+-------------+-------------+------------+-----------+-----------------------
 demo      | postgres | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |            |           | 
 postgres  | postgres | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |            |           | 
 template0 | postgres | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |            |           | =c/postgres          +
           |          |          |                 |             |             |            |           | postgres=CTc/postgres
 template1 | postgres | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |            |           | =c/postgres          +
           |          |          |                 |             |             |            |           | postgres=CTc/postgres
(3 rows)
```

- Также можно проверить репликацию другим способом: 
На хосте master в psql вводим команду: select * from pg_stat_replication;
На хосте slave в psql вводим команду: select * from pg_stat_wal_receiver;
Вывод обеих команд должен быть не пустым. 
```
postgres=# select * from pg_stat_replication;
-[ RECORD 1 ]----+------------------------------
pid              | 65805
usesysid         | 16384
usename          | replication
application_name | 16/main
client_addr      | 192.168.57.12
client_hostname  | 
client_port      | 33952
backend_start    | 2024-09-17 09:51:13.784037+03
backend_xmin     | 
state            | streaming
sent_lsn         | 0/290000D8
write_lsn        | 0/290000D8
flush_lsn        | 0/290006E8
replay_lsn       | 0/290006E8
write_lag        | 00:00:00.001052
flush_lag        | 00:00:00.001052
replay_lag       | 00:00:00.001052
sync_priority    | 0
sync_state       | async
reply_time       | 2024-09-17 09:54:24.536475+03
-[ RECORD 2 ]----+------------------------------
pid              | 65814
usesysid         | 16385
usename          | barman
application_name | barman_receive_wal
client_addr      | 192.168.57.13
client_hostname  | 
client_port      | 41148
backend_start    | 2024-09-17 09:52:01.672454+03
backend_xmin     | 
state            | streaming
sent_lsn         | 0/290000D8
write_lsn        | 0/290000D8
flush_lsn        | 0/29000000
replay_lsn       | 
write_lag        | 00:00:10.009961
flush_lag        | 00:02:20.130624
replay_lag       | 00:02:20.130624
sync_priority    | 0
sync_state       | async
reply_time       | 2024-09-17 09:54:21.850501+03
```
```
postgres=# select * from pg_stat_wal_receiver;
-[ RECORD 1 ]---------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
pid                   | 63660
status                | streaming
receive_start_lsn     | 0/29000000
receive_start_tli     | 1
written_lsn           | 0/290000D8
flushed_lsn           | 0/29000000
received_tli          | 1
last_msg_send_time    | 2024-09-17 09:55:17.730047+03
last_msg_receipt_time | 2024-09-17 09:55:17.712382+03
latest_end_lsn        | 0/290000D8
latest_end_time       | 2024-09-17 09:54:47.717219+03
slot_name             | 
sender_host           | 192.168.57.11
sender_port           | 5432
conninfo              | user=replication password=******** channel_binding=prefer dbname=replication host=192.168.57.11 port=5432 fallback_application_name=16/main sslmode=prefer sslcompression=0 sslcertmode=allow sslsni=1 ssl_min_protocol_version=TLSv1.2 gssencmode=prefer krbsrvname=postgres gssdelegation=0 target_session_attrs=any load_balance_hosts=disable
```
> На этом настройка репликации завершена. 
