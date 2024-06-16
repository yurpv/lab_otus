# Настраиваем центральный сервер сбор логов

## Цели домашнего задания

- Научится проектировать централизованный сбор логов.
- Рассмотреть особенности разных платформ для сбора логов.

Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, при выполнении лабораторной работы использовал образ vagrantbox bento/ubuntu-24.04.

## Описание домашнего задания

- В Vagrant разворачиваем 2 виртуальные машины web и log
- на web настраиваем nginx
- на log настраиваем центральный лог сервер на любой системе на выбор: journald, rsyslog, elk.
- настраиваем аудит, следящий за изменением конфигов nginx

Все критичные логи с web должны собираться и локально и удаленно. Все логи с nginx должны уходить на удаленный сервер (локально только критичные).
Логи аудита должны также уходить на удаленную систему.

Формат сдачи ДЗ - vagrant + ansible

## Пошаговая инструкция выполнения домашнего задания

### Создаём виртуальные машины

- Создаём каталог, в котором будут храниться настройки виртуальной машины. В каталоге создаём файл с именем [Vagrantfile](./Vagrantfile)
- Результатом выполнения команды vagrant up станут 2 созданные виртуальные машины
- Заходим на web-сервер: vagrant ssh web

> Дальнейшие действия выполняются от пользователя root

- Переходим в root пользователя
```
vagrant ssh web
vagrant@web:~$ sudo -i
```


- Для правильной работы c логами, нужно, чтобы на всех хостах было настроено одинаковое время. Проверми дату на rsyslog и web
```
root@web:~# date
Sun Jun 15 01:06:22 PM MSK 2024
...
root@rsyslog:~# date
Sun Jun 15 01:08:00 PM MSK 2024
```

- Проверим, что nginx работает корректно
```
root@web:~# systemctl status nginx
● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; preset: enabled)
     Active: active (running) since Sun 2024-06-15 13:14:37 MSK; 6min ago
       Docs: man:nginx(8)
   Main PID: 4812 (nginx)
      Tasks: 3 (limit: 4549)
     Memory: 2.3M (peak: 2.8M)
        CPU: 7ms
     CGroup: /system.slice/nginx.service
             ├─4812 "nginx: master process /usr/sbin/nginx -g daemon on; master_process on;"
             ├─4813 "nginx: worker process"
             └─4814 "nginx: worker process"

Jun 15 13:14:37 web systemd[1]: Starting nginx.service - A high performance web server and a reverse proxy server...
Jun 15 13:14:37 web systemd[1]: Started nginx.service - A high performance web server and a reverse proxy server.
...
root@web:~# ss -tln | grep 80
LISTEN 0      511          0.0.0.0:80        0.0.0.0:*          
LISTEN 0      511             [::]:80           [::]:*     
```

> Также работу nginx можно проверить на хосте. В браузере ввведем в адерсную строку <http://192.168.65.11>
<img width="988" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/e1c50e9a-dbb0-4fd0-8511-89990f1f0967">

### Настройка сервера сбора логов

- Откроем ещё одно окно терминала и подключимся по ssh к ВМ log: vagrant ssh rsyslog
- Перейдем в пользователя root: sudo -i
```
vagrant ssh rsyslog
vagrant@rsyslog:~$ sudo -i
```

> Все настройки Rsyslog хранятся в файле /etc/rsyslog.conf, проверим их.
```
root@rsyslog:~# cat /etc/rsyslog.conf
...
# provides UDP syslog reception
module(load="imudp")
input(type="imudp" port="514")

# provides TCP syslog reception
module(load="imtcp")
input(type="imtcp" port="514")
...
$IncludeConfig /etc/rsyslog.d/*.conf
$template RemoteLogs,"/var/log/rsyslog/%HOSTNAME%/%PROGRAMNAME%.log"
*.* ?RemoteLogs
& ~
```

> Видим что все необходимые настройки были добавлены при развертывании системы с помощью Ansible

