# SELinux

Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, так при выполнении лабораторной работы необходим vagrantbox Centos 7, а данной версии с архтектурой ARM на app.vagrantup.com нет, данное дз сделал на образе Centos 9 ARM

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

<img width="1314" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/141b732b-7b8b-4239-aaa1-89fdc4f0b82e">

- Удалить нестандартный порт из имеющегося типа можно с помощью команды:
```
[root@SELinux ~]# semanage port -d -t http_port_t -p tcp 4881
[root@SELinux ~]# semanage port -l | grep  http_port_t
http_port_t                    tcp      80, 81, 443, 488, 8008, 8009, 8443, 9000
pegasus_http_port_t            tcp      5988
[root@SELinux ~]# systemctl restart nginx
Job for nginx.service failed because the control process exited with error code.
See "systemctl status nginx.service" and "journalctl -xeu nginx.service" for details.
[root@SELinux ~]# systemctl status nginx
× nginx.service - The nginx HTTP and reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; preset: disabled)
    Drop-In: /usr/lib/systemd/system/nginx.service.d
             └─php-fpm.conf
     Active: failed (Result: exit-code) since Tue 2024-05-28 17:01:52 CEST; 38s ago
   Duration: 3min 31.799s
    Process: 6540 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
    Process: 6541 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=1/FAILURE)
        CPU: 17ms

May 28 17:01:52 SELinux systemd[1]: Starting The nginx HTTP and reverse proxy server...
May 28 17:01:52 SELinux nginx[6541]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
May 28 17:01:52 SELinux nginx[6541]: nginx: [emerg] bind() to 0.0.0.0:4881 failed (13: Permission denied)
May 28 17:01:52 SELinux nginx[6541]: nginx: configuration file /etc/nginx/nginx.conf test failed
May 28 17:01:52 SELinux systemd[1]: nginx.service: Control process exited, code=exited, status=1/FAILURE
May 28 17:01:52 SELinux systemd[1]: nginx.service: Failed with result 'exit-code'.
May 28 17:01:52 SELinux systemd[1]: Failed to start The nginx HTTP and reverse proxy server.
```

### Разрешим в SELinux работу nginx на порту TCP 4881 c помощью формирования и установки модуля SELinux:

- Попробуем снова запустить nginx:
```
[root@SELinux ~]# systemctl start nginx
Job for nginx.service failed because the control process exited with error code.
See "systemctl status nginx.service" and "journalctl -xeu nginx.service" for details.
```

- Nginx не запуститься, так как SELinux продолжает его блокировать. Смотрим логи SELinux, которые относятся к nginx: 
```
[root@SELinux ~]# grep nginx /var/log/audit/audit.log
...
type=SYSCALL msg=audit(1716908659.747:1024): arch=c00000b7 syscall=200 success=no exit=-13 a0=6 a1=aaaaf56835a0 a2=10 a3=1 items=0 ppid=1 pid=6551 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="nginx" exe="/usr/sbin/nginx" subj=system_u:system_r:httpd_t:s0 key=(null)ARCH=aarch64 SYSCALL=bind AUID="unset" UID="root" GID="root" EUID="root" SUID="root" FSUID="root" EGID="root" SGID="root" FSGID="root"
type=SERVICE_START msg=audit(1716908659.747:1025): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=nginx comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'UID="root" AUID="unset"
```

- Воспользуемся утилитой audit2allow для того, чтобы на основе логов SELinux сделать модуль, разрешающий работу nginx на нестандартном порту: 
```
[root@SELinux ~]# grep nginx /var/log/audit/audit.log | audit2allow -M nginx
******************** IMPORTANT ***********************
To make this policy package active, execute:

semodule -i nginx.pp
```

- Audit2allow сформировал модуль, и сообщил нам команду, с помощью которой можно применить данный модуль и пробуем снова запустить nginx:
```
[root@SELinux ~]# semodule -i nginx.pp
[root@SELinux ~]# systemctl start nginx
[root@SELinux ~]# systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; preset: disabled)
    Drop-In: /usr/lib/systemd/system/nginx.service.d
             └─php-fpm.conf
     Active: active (running) since Tue 2024-05-28 17:09:19 CEST; 6s ago
    Process: 6577 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
    Process: 6578 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
    Process: 6579 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
   Main PID: 6580 (nginx)
      Tasks: 3 (limit: 5880)
     Memory: 3.0M
        CPU: 19ms
     CGroup: /system.slice/nginx.service
             ├─6580 "nginx: master process /usr/sbin/nginx"
             ├─6581 "nginx: worker process"
             └─6582 "nginx: worker process"

May 28 17:09:19 SELinux systemd[1]: Starting The nginx HTTP and reverse proxy server...
May 28 17:09:19 SELinux nginx[6578]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
May 28 17:09:19 SELinux nginx[6578]: nginx: configuration file /etc/nginx/nginx.conf test is successful
May 28 17:09:19 SELinux systemd[1]: Started The nginx HTTP and reverse proxy server.
```

- После добавления модуля nginx запустился без ошибок. При использовании модуля изменения сохранятся после перезагрузки. 

- Просмотр всех установленных модулей: semodule -l
- Для удаления модуля воспользуемся командой:
```
[root@SELinux ~]# semodule -r nginx
libsemanage.semanage_direct_remove_key: Removing last nginx module (no other nginx module exists at another priority).
```

2. Обеспечение работоспособности приложения при включенном SELinux

- Выполним клонирование репозитория: 
```
git clone https://github.com/mbfx/otus-linux-adm.git
Cloning into 'otus-linux-adm'...
remote: Enumerating objects: 558, done.
remote: Counting objects: 100% (456/456), done.
remote: Compressing objects: 100% (303/303), done.
remote: Total 558 (delta 125), reused 396 (delta 74), pack-reused 102
Receiving objects: 100% (558/558), 1.38 MiB | 685.00 KiB/s, done.
Resolving deltas: 100% (140/140), done.
```

- Перейдём в каталог со стендом: cd otus-linux-adm/selinux_dns_problems
- Развернём 2 ВМ с помощью vagrant: vagrant up
- После того, как стенд развернется, проверим ВМ с помощью команды:
```
selinux_dns_problems % vagrant status                              
Current machine states:

ns01                      running (vmware_desktop)
client                    running (vmware_desktop)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.
```

- Подключимся к клиенту: vagrant ssh client
- Попробуем внести изменения в зону: 
```
Last login: Tue May 28 15:22:30 2024 from 192.168.50.1
[vagrant@client ~]$ nsupdate -k /etc/named.zonetransfer.key
> server 192.168.50.10
> zone ddns.lab 
> update add www.ddns.lab. 60 A 192.168.50.15
> send
> quit
```

- Изменения внеслись, проблем не обнаружено.
```
[vagrant@client ~]$ dig www.ddns.lab

; <<>> DiG 9.16.23-RH <<>> www.ddns.lab
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 10355
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 640fcf3c51f6a640010000006655f7ea689be7db926dffb4 (good)
;; QUESTION SECTION:
;www.ddns.lab.                  IN      A

;; ANSWER SECTION:
www.ddns.lab.           60      IN      A       192.168.50.15

;; Query time: 0 msec
;; SERVER: 192.168.50.10#53(192.168.50.10)
;; WHEN: Tue May 28 15:27:38 UTC 2024
;; MSG SIZE  rcvd: 85
```
- Видим, что изменения применились. Попробуем перезагрузить хосты и ещё раз сделать запрос с помощью dig:
- После перезагрузки настройки сохранились. 
```
Last login: Tue May 28 15:24:43 2024 from 192.168.65.1
[vagrant@client ~]$ dig @192.168.50.10 www.ddns.lab

; <<>> DiG 9.16.23-RH <<>> @192.168.50.10 www.ddns.lab
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 42470
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: f9dc7395c5f3fc92010000006655f8b0c60fefb3c6794bbb (good)
;; QUESTION SECTION:
;www.ddns.lab.                  IN      A

;; ANSWER SECTION:
www.ddns.lab.           60      IN      A       192.168.50.15

;; Query time: 0 msec
;; SERVER: 192.168.50.10#53(192.168.50.10)
;; WHEN: Tue May 28 15:30:56 UTC 2024
;; MSG SIZE  rcvd: 85
```


