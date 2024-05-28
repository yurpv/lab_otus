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
