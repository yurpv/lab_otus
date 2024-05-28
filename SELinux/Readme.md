# SELinux

Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, так при выполнении лабораторной работы необходим vagrantbox Centosn 7, а данной версии с архтектурой ARM на app.vagrantup.com нет, данное дз сделал в на образе Centos 9 ARM

### Домашнее задание
1. Запустить nginx на нестандартном порту 3-мя разными способами:

Командой vagrant up станет созданная виртуальная машина с установленным nginx, который работает на порту TCP 4881. Порт TCP 4881 уже проброшен до хоста. SELinux включен.
```
SELinux % vagrant up    
Bringing machine 'SELinux' up with 'vmware_desktop' provider...
==> SELinux: Checking if box 'gyptazy/centos9-arm64' version '1.0.0' is up to date...
==> SELinux: Verifying vmnet devices are healthy...
==> SELinux: Preparing network adapters...
==> SELinux: Starting the VMware VM...
==> SELinux: Waiting for the VM to receive an address...
==> SELinux: Forwarding ports...
    SELinux: -- 22 => 2222
==> SELinux: Waiting for machine to boot. This may take a few minutes...
    SELinux: SSH address: 192.168.65.187:22
```

- Во время развёртывания стенда попытка запустить nginx завершится с ошибкой:
```
 SELinux: Complete!
    SELinux: Job for nginx.service failed because the control process exited with error code.
    SELinux: See "systemctl status nginx.service" and "journalctl -xeu nginx.service" for details.
    SELinux: × nginx.service - The nginx HTTP and reverse proxy server
    SELinux:      Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; preset: disabled)
    SELinux:     Drop-In: /usr/lib/systemd/system/nginx.service.d
    SELinux:              └─php-fpm.conf
    SELinux:      Active: failed (Result: exit-code) since Tue 2024-05-28 16:25:20 CEST; 5ms ago
    SELinux:     Process: 6313 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
    SELinux:     Process: 6315 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=1/FAILURE)
    SELinux:         CPU: 5ms
    SELinux: 
    SELinux: May 28 16:25:20 SELinux systemd[1]: Starting The nginx HTTP and reverse proxy server...
    SELinux: May 28 16:25:20 SELinux nginx[6315]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
    SELinux: May 28 16:25:20 SELinux nginx[6315]: nginx: [emerg] bind() to 0.0.0.0:4881 failed (13: Permission denied)
    SELinux: May 28 16:25:20 SELinux nginx[6315]: nginx: configuration file /etc/nginx/nginx.conf test failed
    SELinux: May 28 16:25:20 SELinux systemd[1]: nginx.service: Control process exited, code=exited, status=1/FAILURE
    SELinux: May 28 16:25:20 SELinux systemd[1]: nginx.service: Failed with result 'exit-code'.
    SELinux: May 28 16:25:20 SELinux systemd[1]: Failed to start The nginx HTTP and reverse proxy server.
```

- Заходим на сервер: vagrant ssh. Переходим в root пользователя: sudo -i
```
SELinux % vagrant ssh   
Last login: Tue May 28 16:21:38 2024 from 192.168.65.1
[vagrant@SELinux ~]$ sudo -i
[root@SELinux ~]#
```

### Запуск nginx на нестандартном порту 3-мя разными способами 

- Проверим, что в ОС отключен файервол:
```
[root@SELinux ~]# systemctl status firewalld
○ firewalld.service - firewalld - dynamic firewall daemon
     Loaded: loaded (/usr/lib/systemd/system/firewalld.service; enabled; preset: enabled)
     Active: inactive (dead) since Tue 2024-05-28 16:32:36 CEST; 3s ago
       Docs: man:firewalld(1)
    Process: 774 ExecStart=/usr/sbin/firewalld --nofork --nopid $FIREWALLD_ARGS (code=exited, status=0/SUCCESS)
   Main PID: 774 (code=exited, status=0/SUCCESS)
        CPU: 209ms

May 28 19:23:17 gyp-centos01 systemd[1]: Starting firewalld - dynamic firewall daemon...
May 28 19:23:17 gyp-centos01 systemd[1]: Started firewalld - dynamic firewall daemon.
May 28 16:32:36 SELinux systemd[1]: Stopping firewalld - dynamic firewall daemon...
May 28 16:32:36 SELinux systemd[1]: firewalld.service: Deactivated successfully.
May 28 16:32:36 SELinux systemd[1]: Stopped firewalld - dynamic firewall daemon.
```

- Проверим, что конфигурация nginx настроена без ошибок:
```
[root@SELinux ~]# nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```

- Проверим режим работы SELinux:
```
[root@SELinux ~]# getenforce
Enforcing
[root@SELinux ~]# 
```
Отображается режим Enforcing. Данный режим означает, что SELinux будет блокировать запрещенную активность.

### Разрешим в SELinux работу nginx на порту TCP 4881 c помощью переключателей setsebool

- Находим в логах (/var/log/audit/audit.log) информацию о блокировании порта denied:
```
[root@SELinux ~]# grep nginx /var/log/audit/audit.log | audit2why
type=AVC msg=audit(1716906320.453:948): avc:  denied  { name_bind } for  pid=6315 comm="nginx" src=4881 scontext=system_u:system_r:httpd_t:s0 tcontext=system_u:object_r:unreserved_port_t:s0 tclass=tcp_socket permissive=0

        Was caused by:
        The boolean nis_enabled was set incorrectly. 
        Description:
        Allow nis to enabled

        Allow access by executing:
        # setsebool -P nis_enabled 1
```

- Утилита audit2why покажет почему трафик блокируется. Исходя из вывода утилиты, мы видим, что нам нужно поменять параметр nis_enabled. 
Включим параметр nis_enabled и перезапустим nginx: setsebool -P nis_enabled on
```
[root@SELinux ~]# setsebool -P nis_enabled on
[root@SELinux ~]# systemctl restart nginx
[root@SELinux ~]# systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; preset: disabled)
    Drop-In: /usr/lib/systemd/system/nginx.service.d
             └─php-fpm.conf
     Active: active (running) since Tue 2024-05-28 16:49:38 CEST; 7s ago
    Process: 6431 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
    Process: 6432 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
    Process: 6433 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
   Main PID: 6434 (nginx)
      Tasks: 3 (limit: 5880)
     Memory: 2.8M
        CPU: 19ms
     CGroup: /system.slice/nginx.service
             ├─6434 "nginx: master process /usr/sbin/nginx"
             ├─6435 "nginx: worker process"
             └─6436 "nginx: worker process"

May 28 16:49:38 SELinux systemd[1]: Starting The nginx HTTP and reverse proxy server...
May 28 16:49:38 SELinux nginx[6432]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
May 28 16:49:38 SELinux nginx[6432]: nginx: configuration file /etc/nginx/nginx.conf test is successful
May 28 16:49:38 SELinux systemd[1]: Started The nginx HTTP and reverse proxy server.
```

- Проверим работу nginx из браузера. Заходим в любой браузер и переходим по адресу http://192.168.65.187:4881

<img width="1278" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/67e8d907-6206-4339-b934-fe8975f9b653">

- Проверить статус параметра можно с помощью команды: getsebool -a | grep nis_enabled
```
[root@SELinux ~]# getsebool -a | grep nis_enabled
nis_enabled --> on
```

- Вернём запрет работы nginx на порту 4881 обратно. Для этого отключим nis_enabled:
```
[root@SELinux ~]# setsebool -P nis_enabled off
[root@SELinux ~]# getsebool -a | grep nis_enabled
nis_enabled --> off
[root@SELinux ~]# systemctl restart nginx
Job for nginx.service failed because the control process exited with error code.
See "systemctl status nginx.service" and "journalctl -xeu nginx.service" for details.
```
- После отключения nis_enabled служба nginx снова не запустится.

### Разрешим в SELinux работу nginx на порту TCP 4881 c помощью добавления нестандартного порта в имеющийся тип:

- Поиск имеющегося типа, для http трафика:
```
[root@SELinux ~]# semanage port -l | grep http
http_cache_port_t              tcp      8080, 8118, 8123, 10001-10010
http_cache_port_t              udp      3130
http_port_t                    tcp      80, 81, 443, 488, 8008, 8009, 8443, 9000
pegasus_http_port_t            tcp      5988
pegasus_https_port_t           tcp      5989
```

- Добавим порт в тип http_port_t:
```
[root@SELinux ~]# semanage port -a -t http_port_t -p tcp 4881
[root@SELinux ~]# semanage port -l | grep  http_port_t
http_port_t                    tcp      4881, 80, 81, 443, 488, 8008, 8009, 8443, 9000
pegasus_http_port_t            tcp      5988
```

- Перезапустим службу nginx и проверим её работу:
```
[root@SELinux ~]# systemctl restart nginx
[root@SELinux ~]# systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; preset: disabled)
    Drop-In: /usr/lib/systemd/system/nginx.service.d
             └─php-fpm.conf
     Active: active (running) since Tue 2024-05-28 16:58:20 CEST; 5s ago
    Process: 6496 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
    Process: 6497 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
    Process: 6498 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
   Main PID: 6499 (nginx)
      Tasks: 3 (limit: 5880)
     Memory: 2.8M
        CPU: 20ms
     CGroup: /system.slice/nginx.service
             ├─6499 "nginx: master process /usr/sbin/nginx"
             ├─6500 "nginx: worker process"
             └─6501 "nginx: worker process"

May 28 16:58:20 SELinux systemd[1]: Starting The nginx HTTP and reverse proxy server...
May 28 16:58:20 SELinux nginx[6497]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
May 28 16:58:20 SELinux nginx[6497]: nginx: configuration file /etc/nginx/nginx.conf test is successful
May 28 16:58:20 SELinux systemd[1]: Started The nginx HTTP and reverse proxy server.
```


- Проверить работу nginx из браузера. Заходим в любой браузер и переходим по адресу http://192.168.65.187:4881



Удалить нестандартный порт из имеющегося типа можно с помощью команды: semanage port -d -t http_port_t -p tcp 4881
[root@selinux ~]# semanage port -d -t http_port_t -p tcp 4881
[root@selinux ~]# semanage port -l | grep  http_port_t
http_port_t                    tcp      80, 81, 443, 488, 8008, 8009, 8443, 9000
pegasus_http_port_t            tcp      5988
[root@selinux ~]# systemctl restart nginx
Job for nginx.service failed because the control process exited with error code. See "systemctl status nginx.service" and "journalctl -xe" for details.


[root@selinux ~]# systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; vendor preset: disabled)
   Active: failed (Result: exit-code) since Sun 2021-11-07 03:00:42 UTC; 3s ago
...
Nov 07 03:00:42 selinux nginx[3008]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
Nov 07 03:00:42 selinux nginx[3008]: nginx: [emerg] bind() to 0.0.0.0:4881 failed (13: Permission denied)
...
Nov 07 03:00:42 selinux systemd[1]: nginx.service failed.
[root@selinux ~]#


Разрешим в SELinux работу nginx на порту TCP 4881 c помощью формирования и установки модуля SELinux:
Попробуем снова запустить nginx: systemctl start nginx
[root@selinux ~]# systemctl start nginx
Job for nginx.service failed because the control process exited with error code. See "systemctl status nginx.service" and "journalctl -xe" for details.
[root@selinux ~]#

Nginx не запуститься, так как SELinux продолжает его блокировать. Посмотрим логи SELinux, которые относятся к nginx: 
[root@selinux ~]# grep nginx /var/log/audit/audit.log
...
type=SYSCALL msg=audit(1637045467.417:510): arch=c000003e syscall=49 success=no exit=-13 a0=6 a1=558922a5a7b8 a2=10 a3=7ffe62da3900 items=0 ppid=1 pid=2133 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="nginx" exe="/usr/sbin/nginx" subj=system_u:system_r:httpd_t:s0 key=(null)
type=SERVICE_START msg=audit(1637045467.419:511): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=nginx comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[root@selinux ~]#

Воспользуемся утилитой audit2allow для того, чтобы на основе логов SELinux сделать модуль, разрешающий работу nginx на нестандартном порту: 
grep nginx /var/log/audit/audit.log | audit2allow -M nginx
[root@selinux ~]# grep nginx /var/log/audit/audit.log | audit2allow -M nginx
******************** IMPORTANT ***********************
To make this policy package active, execute:


semodule -i nginx.pp


[root@selinux ~]#


Audit2allow сформировал модуль, и сообщил нам команду, с помощью которой можно применить данный модуль: semodule -i nginx.pp


[root@selinux ~]# semodule -i nginx.pp
[root@selinux ~]#

Попробуем снова запустить nginx: systemctl start nginx
[root@selinux ~]# systemctl start nginx
[root@selinux ~]# systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; vendor preset: disabled)
   Active: active (running) since Tue 2021-11-16 06:59:56 UTC; 16s ago
  Process: 2163 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
  Process: 2161 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
  Process: 2160 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
 Main PID: 2165 (nginx)
   CGroup: /system.slice/nginx.service
           ├─2165 nginx: master process /usr/sbin/nginx
           └─2167 nginx: worker process


Nov 16 06:59:55 selinux systemd[1]: Starting The nginx HTTP and reverse proxy server...
Nov 16 06:59:56 selinux nginx[2161]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
Nov 16 06:59:56 selinux nginx[2161]: nginx: configuration file /etc/nginx/nginx.conf test is successful
Nov 16 06:59:56 selinux systemd[1]: Started The nginx HTTP and reverse proxy server.
[root@selinux ~]#


После добавления модуля nginx запустился без ошибок. При использовании модуля изменения сохранятся после перезагрузки. 

Просмотр всех установленных модулей: semodule -l
Для удаления модуля воспользуемся командой: semodule -r nginx
[root@selinux ~]# semodule -r nginx
libsemanage.semanage_direct_remove_key: Removing last nginx module (no other nginx module exists at another priority).
[root@selinux ~]#


Результатом выполнения данного задания будет подготовленная документация. 


Документация
Создайте файл README.md и снабдите его следующей информацией:
- название выполняемого задания;
- текст задания;
- полное описание всех команд;
- скриншоты (если потребуется);
- заметки, если считаете, что имеет смысл их зафиксировать в репозитории.



Обеспечение работоспособности приложения при включенном SELinux
Для того, чтобы развернуть стенд потребуется хост, с установленным git и ansible.
Инструкция по установке Ansible - https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
Инструкция по установке Git - https://git-scm.com/book/ru/v2/%D0%92%D0%B2%D0%B5%D0%B4%D0%B5%D0%BD%D0%B8%D0%B5-%D0%A3%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0-Git

Выполним клонирование репозитория: git clone https://github.com/mbfx/otus-linux-adm.git
➜ ~ с
Cloning into 'otus-linux-adm'...
remote: Enumerating objects: 542, done.
remote: Counting objects: 100% (440/440), done.
remote: Compressing objects: 100% (295/295), done.
remote: Total 542 (delta 118), reused 381 (delta 69), pack-reused 102
Receiving objects: 100% (542/542), 1.38 MiB | 3.65 MiB/s, done.
Resolving deltas: 100% (133/133), done.

Перейдём в каталог со стендом: cd otus-linux-adm/selinux_dns_problems
Развернём 2 ВМ с помощью vagrant: vagrant up
После того, как стенд развернется, проверим ВМ с помощью команды: vagrant status
➜ selinux_dns_problems (master) ✔ vagrant status 
Current machine states:


ns01                      running (virtualbox)
client                    running (virtualbox)


This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.
➜ selinux_dns_problems (master) ✔ 


Подключимся к клиенту: vagrant ssh client


Попробуем внести изменения в зону: nsupdate -k /etc/named.zonetransfer.key
[vagrant@client ~]$ nsupdate -k /etc/named.zonetransfer.key
> server 192.168.50.10
> zone ddns.lab
> update add www.ddns.lab. 60 A 192.168.50.15
> send
update failed: SERVFAIL
> quit
[vagrant@client ~]$
Изменения внести не получилось. Давайте посмотрим логи SELinux, чтобы понять в чём может быть проблема.
Для этого воспользуемся утилитой audit2why: 	
[vagrant@client ~]$ sudo -i
[root@client ~]# cat /var/log/audit/audit.log | audit2why
[root@client ~]# 
Тут мы видим, что на клиенте отсутствуют ошибки. 
Не закрывая сессию на клиенте, подключимся к серверу ns01 и проверим логи SELinux:
➜ selinux_dns_problems (master) ✔ vagrant ssh ns01 
Last login: Tue Nov 16 09:58:37 2021 from 10.0.2.2
[vagrant@ns01 ~]$ sudo -i 
[root@ns01 ~]# 
[root@ns01 ~]# 
[root@ns01 ~]# cat /var/log/audit/audit.log | audit2why
type=AVC msg=audit(1637070345.890:1972): avc:  denied  { create } for  pid=5192 comm="isc-worker0000" name="named.ddns.lab.view1.jnl" scontext=system_u:system_r:named_t:s0 tcontext=system_u:object_r:etc_t:s0 tclass=file permissive=0


    Was caused by:
        Missing type enforcement (TE) allow rule.


        You can use audit2allow to generate a loadable module to allow this access.


[root@ns01 ~]# 
```
В логах мы видим, что ошибка в контексте безопасности. Вместо типа named_t используется тип etc_t.
Проверим данную проблему в каталоге /etc/named:
```
[root@ns01 ~]# ls -laZ /etc/named
drw-rwx---. root named system_u:object_r:etc_t:s0       .
drwxr-xr-x. root root  system_u:object_r:etc_t:s0       ..
drw-rwx---. root named unconfined_u:object_r:etc_t:s0   dynamic
-rw-rw----. root named system_u:object_r:etc_t:s0       named.50.168.192.rev
-rw-rw----. root named system_u:object_r:etc_t:s0       named.dns.lab
-rw-rw----. root named system_u:object_r:etc_t:s0       named.dns.lab.view1
-rw-rw----. root named system_u:object_r:etc_t:s0       named.newdns.lab
[root@ns01 ~]# 
```
Тут мы также видим, что контекст безопасности неправильный. Проблема заключается в том, что конфигурационные файлы лежат в другом каталоге. Посмотреть в каком каталоги должны лежать, файлы, чтобы на них распространялись правильные политики SELinux можно с помощью команды: sudo semanage fcontext -l | grep named
[root@ns01 ~]# sudo semanage fcontext -l | grep named
/etc/rndc.*              regular file       system_u:object_r:named_conf_t:s0 
/var/named(/.*)?         all files          system_u:object_r:named_zone_t:s0 
...
[root@ns01 ~]#

Изменим тип контекста безопасности для каталога /etc/named: sudo chcon -R -t named_zone_t /etc/named
[root@ns01 ~]# sudo chcon -R -t named_zone_t /etc/named
[root@ns01 ~]# 
[root@ns01 ~]# ls -laZ /etc/named
drw-rwx---. root named system_u:object_r:named_zone_t:s0 .
drwxr-xr-x. root root  system_u:object_r:etc_t:s0       ..
drw-rwx---. root named unconfined_u:object_r:named_zone_t:s0 dynamic
-rw-rw----. root named system_u:object_r:named_zone_t:s0 named.50.168.192.rev
-rw-rw----. root named system_u:object_r:named_zone_t:s0 named.dns.lab
-rw-rw----. root named system_u:object_r:named_zone_t:s0 named.dns.lab.view1
-rw-rw----. root named system_u:object_r:named_zone_t:s0 named.newdns.lab
[root@ns01 ~]# 

Попробуем снова внести изменения с клиента: 
[vagrant@client ~]$ nsupdate -k /etc/named.zonetransfer.key
> server 192.168.50.10
> zone ddns.lab
> update add www.ddns.lab. 60 A 192.168.50.15
> send
> quit 
[vagrant@client ~]$ 
[vagrant@client ~]$ dig www.ddns.lab


; <<>> DiG 9.11.4-P2-RedHat-9.11.4-26.P2.el7_9.7 <<>> www.ddns.lab
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 52762
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 2


;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;www.ddns.lab.          IN  A


;; ANSWER SECTION:
www.ddns.lab.       60  IN  A   192.168.50.15


;; AUTHORITY SECTION:
ddns.lab.       3600    IN  NS  ns01.dns.lab.


;; ADDITIONAL SECTION:
ns01.dns.lab.       3600    IN  A   192.168.50.10


;; Query time: 1 msec
;; SERVER: 192.168.50.10#53(192.168.50.10)
;; WHEN: Thu Nov 18 10:34:41 UTC 2021
;; MSG SIZE  rcvd: 96


[vagrant@client ~]$ 

Видим, что изменения применились. Попробуем перезагрузить хосты и ещё раз сделать запрос с помощью dig: 
[vagrant@client ~]$ dig @192.168.50.10 www.ddns.lab


; <<>> DiG 9.11.4-P2-RedHat-9.11.4-26.P2.el7_9.7 <<>> @192.168.50.10 www.ddns.lab
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 52392
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 2


;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;www.ddns.lab.          IN  A


;; ANSWER SECTION:
www.ddns.lab.       60  IN  A   192.168.50.15


;; AUTHORITY SECTION:
ddns.lab.       3600    IN  NS  ns01.dns.lab.


;; ADDITIONAL SECTION:
ns01.dns.lab.       3600    IN  A   192.168.50.10


;; Query time: 2 msec
;; SERVER: 192.168.50.10#53(192.168.50.10)
;; WHEN: Thu Nov 18 15:49:07 UTC 2021
;; MSG SIZE  rcvd: 96


[vagrant@client ~]$ 

Всё правильно. После перезагрузки настройки сохранились. 
Для того, чтобы вернуть правила обратно, можно ввести команду: restorecon -v -R /etc/named


[root@ns01 ~]# 23232323232323232323232323232323232323232323232323232323
restorecon reset /etc/named context system_u:object_r:named_zone_t:s0->system_u:object_r:etc_t:s0
restorecon reset /etc/named/named.dns.lab.view1 context system_u:object_r:named_zone_t:s0->system_u:object_r:etc_t:s0
restorecon reset /etc/named/named.dns.lab context system_u:object_r:named_zone_t:s0->system_u:object_r:etc_t:s0
restorecon reset /etc/named/dynamic context unconfined_u:object_r:named_zone_t:s0->unconfined_u:object_r:etc_t:s0
restorecon reset /etc/named/dynamic/named.ddns.lab context system_u:object_r:named_zone_t:s0->system_u:object_r:etc_t:s0
restorecon reset /etc/named/dynamic/named.ddns.lab.view1 context system_u:object_r:named_zone_t:s0->system_u:object_r:etc_t:s0
restorecon reset /etc/named/dynamic/named.ddns.lab.view1.jnl context system_u:object_r:named_zone_t:s0->system_u:object_r:etc_t:s0
restorecon reset /etc/named/named.newdns.lab context system_u:object_r:named_zone_t:s0->system_u:object_r:etc_t:s0
restorecon reset /etc/named/named.50.168.192.rev context system_u:object_r:named_zone_t:s0->system_u:object_r:etc_t:s0
[root@ns01 ~]#

Результатом выполнения данного задания будет:
README с анализом причины неработоспособности, возможными способами решения и обоснованием выбора одного из них;
исправленный стенд или демонстрация работоспособной системы скриншотами и описанием.




