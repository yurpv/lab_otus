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

> Видим что все необходимые настройки были добавлены при развертывании системы с помощью Ansible. </br>
> Данные параметры будут отправлять в папку /var/log/rsyslog логи, которые будут приходить от других серверов. Например, Access-логи nginx от сервера web, будут идти в файл /var/log/rsyslog/web/nginx_access.log

- Перезапускаем службу rsyslog, если ошибок не допущено, то у нас будут видны открытые порты TCP,UDP 514
```
root@rsyslog:~# ss -tunlp | grep 514
udp   UNCONN 0      0                  0.0.0.0:514       0.0.0.0:*    users:(("rsyslogd",pid=3092,fd=5))        
udp   UNCONN 0      0                     [::]:514          [::]:*    users:(("rsyslogd",pid=3092,fd=6))        
tcp   LISTEN 0      25                 0.0.0.0:514       0.0.0.0:*    users:(("rsyslogd",pid=3092,fd=7))        
tcp   LISTEN 0      25                    [::]:514          [::]:*    users:(("rsyslogd",pid=3092,fd=8)) 
```

### Далее настроим отправку логов с web-сервера

- Заходим на web сервер: vagrant ssh web
- Переходим в root пользователя: sudo -i
- Находим в файле /etc/nginx/nginx.conf раздел с логами и приводим их к следующему виду

> Так как мы все настроили с помощью Ansible, проверяем верно у нас все добавилось.

```
root@web:~# cat /etc/nginx/nginx.conf
...
##
        # Logging Settings
        ##

        access_log /var/log/nginx/access.log;
        access_log syslog:server=192.168.65.10:514,tag=nginx_access,severity=info;
        error_log /var/log/nginx/error.log;
        error_log syslog:server=192.168.65.10:514,tag=nginx_error;

```

По умолчанию, error-логи отправляют логи, которые имеют severity: error, crit, alert и emerg. Если трубуется хранили или пересылать логи с другим severity, то это также можно указать в
настройках nginx.

- Поскольку наше приложение работает без ошибок, файл nginx_error.log не будет создан. Чтобы сгенерировать ошибку, можно переместить файл веб-страницы, который открывает nginx
```
mv /var/www/html/index.nginx-debian.html /var/www/ 
```

- После этого если зайдем на страницу nginx в браузере, то получим 403 ошибку.
<img width="989" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/5f2c8db5-b310-4238-bd28-7a43aec3b247">

- Далее заходим на log-сервер и смотрим информацию об nginx

```
root@rsyslog:~# cat /var/log/rsyslog/web/nginx_access.log
2024-06-16T13:28:48+03:00 web nginx_access: 192.168.65.1 - - [16/Jun/2024:13:28:48 +0300] "GET / HTTP/1.1" 200 409 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 YaBrowser/24.4.0.0 Safari/537.36"
2024-06-16T13:30:04+03:00 web nginx_access: 192.168.65.1 - - [16/Jun/2024:13:30:04 +0300] "GET / HTTP/1.1" 304 0 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 YaBrowser/24.4.0.0 Safari/537.36"
...
root@rsyslog:~# cat /var/log/rsyslog/web/nginx_error.log 
2024-06-16T13:42:25+03:00 web nginx_error: 2024/06/16 13:42:25 [error] 3456#3456: *3 directory index of "/var/www/html/" is forbidden, client: 192.168.65.1, server: _, request: "GET / HTTP/1.1", host: "192.168.65.11"
2024-06-16T13:42:26+03:00 web nginx_error: 2024/06/16 13:42:26 [error] 3456#3456: *3 directory index of "/var/www/html/" is forbidden, client: 192.168.65.1, server: _, request: "GET / HTTP/1.1", host: "192.168.65.11"
2024-06-16T13:53:07+03:00 web nginx_error: 2024/06/16 13:53:07 [error] 3457#3457: *5 directory index of "/var/www/html/" is forbidden, client: 192.168.65.1, server: _, request: "GET / HTTP/1.1", host: "192.168.65.11"
```

> Видим, что логи отправляются корректно. 

### Настройка аудита, контролирующего изменения конфигурации nginx
- За аудит отвечает утилита rsyslog, для этого нужно настроить и сервер, и клиент.
- Настройка клиента
- Создаем новый конфигурационный файл и добавляем следующие строки:
```
root@web:~# cat /etc/rsyslog.d/audit.conf
$ModLoad imfile
$InputFileName /var/log/nginx/access.log
$InputFileTag tag_access_log:
$InputFileStateFile access_log
$InputFileSeverity crit
$InputFileFacility local6
$InputRunFileMonitor
```
> После перезапускаем rsyslog "systemctl restart rsyslog" и проверяем на файлыы на сервере логов.
<img width="541" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/591532b3-c065-4812-8795-4e324e93021a">
