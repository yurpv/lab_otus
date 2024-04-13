# Инициализация системы. Systemd.

Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, так при выполнении лабораторной работы необходим vagrantbox Centos 8 ARM, а его на app.vagrantup.com нет, данное дз сделал в cloud.vk.com, на тестовой vm Centos 8.

- Перед тем как начинать, обновил систему и доставил необходимые компоненты
```
[centos@test yum.repos.d]$ sudo dnf update
CentOS Linux 8 - AppStream                                                                                                                      329 kB/s | 8.4 MB     00:26    
CentOS Linux 8 - BaseOS                                                                                                                         181 kB/s | 4.6 MB     00:25    
CentOS Linux 8 - Extras                                                                                                                         711  B/s |  11 kB     00:15    
Dependencies resolved.
================================================================================================================================================================================
 Package                                           Architecture              Version                                                         Repository                    Size
================================================================================================================================================================================
Installing:
 kernel                                            x86_64                    4.18.0-348.7.1.el8_5                                            baseos                       7.0 M
 kernel-core                                       x86_64                    4.18.0-348.7.1.el8_5                                            baseos                        38 M
 kernel-modules                                    x86_64                    4.18.0-348.7.1.el8_5                                            baseos                        30 M
```
```
[centos@test yum.repos.d]$ yum install -y redhat-lsb-core wget rpmdevtools rpm-build createrepo yum-utils gcc
 perl-constant-1.33-396.el8.noarch            perl-interpreter-4:5.26.3-420.el8.x86_64                        perl-libnet-3.11-3.el8.noarch                                  
  perl-libs-4:5.26.3-420.el8.x86_64            perl-macros-4:5.26.3-420.el8.x86_64                             perl-parent-1:0.237-1.el8.noarch                               
  perl-podlators-4.11-1.el8.noarch             perl-threads-1:2.21-2.el8.x86_64                                perl-threads-shared-1.58-2.el8.x86_64                          
  rpm-build-4.14.3-19.el8.x86_64               rpmdevtools-8.10-8.el8.noarch                                   yum-utils-4.0.21-3.el8.noarch                                  
  zstd-1.4.4-1.el8.x86_64                     

Complete!
```

## Написать сервис, который будет раз в 30 секунд мониторить лог на предмет наличия ключевого слова. Файл и слово должны задаваться в /etc/sysconfig

- Cоздаём файл с конфигурацией для сервиса в директории /etc/sysconfig - из неё сервис будет брать необходимые переменные.
```
[root@test ~]# vi /etc/sysconfig/watchlog
---
# Configuration file for my watchlog service
# Place it to /etc/sysconfig

# File and word in that file that we will be monit
WORD="ALERT"
LOG=/var/log/watchlog.log

```

- создаем /var/log/watchlog.log и пишем туда строки на своё усмотрение, ключевое слово ‘ALERT’
- Создадим скрипт
```
[root@test ~]# vi /opt/watchlog.sh
WORD=$1
LOG=$2
DATE=`date`

if grep $WORD $LOG &> /dev/null
then
logger "$DATE: I found word, Master!"
else
exit 0
fi
```

- Добавим права на запуск файла
```
[root@test ~]# chmod +x /opt/watchlog.sh
```

- Создадим юнит для сервиса
```
[root@test ~]# vi /etc/systemd/system/watchlog.service
---
[Unit]
Description=My watchlog service

[Service]
Type=oneshot
EnvironmentFile=/etc/sysconfig/watchlog
ExecStart=/opt/watchlog.sh $WORD $LOG
```

- Cоздадим юнит для таймера
```
[Unit]
Description=Run watchlog script every 30 second

[Timer]
# Run every 30 second
OnUnitActiveSec=30
Unit=watchlog.service

[Install]
WantedBy=multi-user.target
```
- Стартуем и проверяем результат
```
[root@test ~]# systemctl start watchlog.timer
[root@test ~]# systemctl status watchlog.timer
● watchlog.timer - Run watchlog script every 30 second
   Loaded: loaded (/etc/systemd/system/watchlog.timer; disabled; vendor preset: disabled)
   Active: active (elapsed) since Sat 2024-04-13 18:37:07 UTC; 26min ago
  Trigger: n/a

Apr 13 18:37:07 test.novalocal systemd[1]: Started Run watchlog script every 30 second.
Apr 13 18:37:37 test.novalocal systemd[1]: Started Run watchlog script every 30 second.
Apr 13 18:38:07 test.novalocal systemd[1]: Started Run watchlog script every 30 second.
Apr 13 18:38:37 test.novalocal systemd[1]: Started Run watchlog script every 30 second.
```

 ## Из epel установить spawn-fcgi и переписать init-скрипт на unit-файл. Имя сервиса должно также называться.

 - Устанавливаем spawn-fcgi и необходимые для него пакеты
```
[root@test ~]# yum install epel-release -y && yum install spawn-fcgi php php-cli

Last metadata expiration check: 1:38:44 ago on Sat 13 Apr 2024 03:44:44 PM UTC.
Dependencies resolved.
================================================================================================================================================================================
 Package                                       Architecture                            Version                                    Repository                               Size
================================================================================================================================================================================
Installing:
 epel-release                                  noarch                                  8-11.el8                                   extras                                   24 k

Transaction Summary
================================================================================================================================================================================
Install  1 Package

Total download size: 24 k
Installed size: 35 k
Downloading Packages:
epel-release-8-11.el8.noarch.rpm                                                                                                                4.7 kB/s |  24 kB     00:05    
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                           2.2 kB/s |  24 kB     00:10
---
Installed:
  apr-1.6.3-12.el8.x86_64                                                                   apr-util-1.6.1-6.el8.x86_64                                                         
  apr-util-bdb-1.6.1-6.el8.x86_64                                                           apr-util-openssl-1.6.1-6.el8.x86_64                                                 
  centos-logos-httpd-85.8-2.el8.noarch                                                      httpd-2.4.37-43.module_el8.5.0+1022+b541f3b1.x86_64                                 
  httpd-filesystem-2.4.37-43.module_el8.5.0+1022+b541f3b1.noarch                            httpd-tools-2.4.37-43.module_el8.5.0+1022+b541f3b1.x86_64                           
  mailcap-2.1.48-3.el8.noarch                                                               mod_http2-1.15.7-3.module_el8.4.0+778+c970deab.x86_64                               
  nginx-filesystem-1:1.14.1-9.module_el8.0.0+184+e34fea82.noarch                            php-7.2.24-1.module_el8.2.0+313+b04d0a66.x86_64                                     
  php-cli-7.2.24-1.module_el8.2.0+313+b04d0a66.x86_64                                       php-common-7.2.24-1.module_el8.2.0+313+b04d0a66.x86_64                              
  php-fpm-7.2.24-1.module_el8.2.0+313+b04d0a66.x86_64                                       spawn-fcgi-1.6.3-17.el8.x86_64                                                      

Complete!
```

- Необходимо раскомментировать строки с переменными в /etc/sysconfig/spawn-fcgi
```
[root@test ~]# vi /etc/sysconfig/spawn-fcgi
---
# You must set some working options before the "spawn-fcgi" service will work.
# If SOCKET points to a file, then this file is cleaned up by the init script.
#
# See spawn-fcgi(1) for all possible options.
#
# Example :
SOCKET=/var/run/php-fcgi.sock
OPTIONS="-u apache -g apache -s $SOCKET -S -M 0600 -C 32 -F 1 -- /usr/bin/php-cgi"
```

- Cам юнит файл будет следующего вида
```
[root@test ~]# vi /etc/systemd/system/spawn-fcgi.service
---
[Unit]
Description=Spawn-fcgi startup service by Otus
After=network.target

[Service]
Type=simple
PIDFile=/var/run/spawn-fcgi.pid
EnvironmentFile=/etc/sysconfig/spawn-fcgi
ExecStart=/usr/bin/spawn-fcgi -n $OPTIONS
KillMode=process

[Install]
WantedBy=multi-user.target
```

- Запускаем и проверяем, что все успешно работает
```
[root@test ~]# systemctl start spawn-fcgi
[root@test ~]# systemctl status spawn-fcgi
● spawn-fcgi.service - Spawn-fcgi startup service by Otus
   Loaded: loaded (/etc/systemd/system/spawn-fcgi.service; disabled; vendor preset: disabled)
   Active: active (running) since Sat 2024-04-13 17:28:07 UTC; 10s ago
 Main PID: 54260 (php-cgi)
    Tasks: 33 (limit: 12360)
   Memory: 19.0M
   CGroup: /system.slice/spawn-fcgi.service
           ├─54260 /usr/bin/php-cgi
           ├─54261 /usr/bin/php-cgi
           ├─54262 /usr/bin/php-cgi
           ├─54263 /usr/bin/php-cgi
           ├─54264 /usr/bin/php-cgi
           ├─54265 /usr/bin/php-cgi
           ├─54266 /usr/bin/php-cgi
           ├─54267 /usr/bin/php-cgi
           ├─54268 /usr/bin/php-cgi
```

## Дополнить юнит-файл apache httpd возможностью запустить несколько инстансов сервера с разными конфигами

- Для запуска нескольких экземпляров сервиса будем использовать шаблон в конфигурации файла окружения (/usr/lib/systemd/system/httpd.service )
```
vi /usr/lib/systemd/system/httpd.service
---
[Unit]
Description=The Apache HTTP Server
Wants=httpd-init.service

After=network.target remote-fs.target nss-lookup.target httpd-
init.service

Documentation=man:httpd.service(8)

[Service]
Type=notify
Environment=LANG=C
EnvironmentFile=/etc/sysconfig/httpd-%I
ExecStart=/usr/sbin/httpd $OPTIONS -DFOREGROUND
ExecReload=/usr/sbin/httpd $OPTIONS -k graceful
# Send SIGWINCH for graceful stop
KillSignal=SIGWINCH
KillMode=mixed
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```

- В самом файле окружения (которых будет два) задается опция для запуска веб-сервера с необходимым конфигурационным файлом
```
[root@test ~]# vi /etc/sysconfig/httpd-first
---
OPTIONS=-f conf/first.conf

[root@test ~]# vi /etc/sysconfig/httpd-second
---
OPTIONS=-f conf/second.conf
```

- В директории с конфигами httpd (/etc/httpd/conf) должны лежать два конфига, в нашем случае это будут first.conf и second.conf
Для удачного запуска, в конфигурационных файлах должны быть указаны уникальные для каждого экземпляра опции Listen и PidFile. Конфиги можно скопировать и поправить только второй, в нем должны быть след. опции:
```
PidFile /var/run/httpd-second.pid
Listen 8080
```

- Запускаем и проверяем
```
[root@test ~]# systemctl start httpd@first
[root@test ~]# systemctl start httpd@second
```
