# SELinux

Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, так при выполнении лабораторной работы необходим vagrantbox Centosn 7, а данной версии с архтектурой ARM на app.vagrantup.com нет, данное дз сделал в на образе Centos 9 ARM

### Домашнее задание
1. Запустить nginx на нестандартном порту 3-мя разными способами:

Командой vagrant up станет созданная виртуальная машина с установленным nginx, который работает на порту TCP 4881. Порт TCP 4881 уже проброшен до хоста. SELinux включен.
```
SELinux % vagrant up    
Bringing machine 'SELinux' up with 'vmware_desktop' provider...
==> SELinux: Cloning VMware VM: 'bento/centos-stream-9'. This can take some time...
==> SELinux: Checking if box 'bento/centos-stream-9' version '202404.23.0' is up to date...
==> SELinux: Verifying vmnet devices are healthy...
==> SELinux: Preparing network adapters...
==> SELinux: Starting the VMware VM...
==> SELinux: Waiting for the VM to receive an address...
==> SELinux: Forwarding ports...
    SELinux: -- 22 => 2222
==> SELinux: Waiting for machine to boot. This may take a few minutes...
    SELinux: SSH address: 192.168.65.185:22
...
SELinux: Complete!
    SELinux: ● nginx.service - The nginx HTTP and reverse proxy server
    SELinux:      Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; preset: disabled)
    SELinux:     Drop-In: /usr/lib/systemd/system/nginx.service.d
    SELinux:              └─php-fpm.conf
    SELinux:      Active: active (running) since Tue 2024-05-28 13:41:07 UTC; 4ms ago
    SELinux:     Process: 5930 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
    SELinux:     Process: 5932 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
    SELinux:     Process: 5933 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
    SELinux:    Main PID: 5934 (nginx)
    SELinux:       Tasks: 3 (limit: 3836)
    SELinux:      Memory: 3.2M
    SELinux:         CPU: 10ms
    SELinux:      CGroup: /system.slice/nginx.service
    SELinux:              ├─5934 "nginx: master process /usr/sbin/nginx"
    SELinux:              ├─5935 "nginx: worker process"
    SELinux:              └─5936 "nginx: worker process"
    SELinux: 
    SELinux: May 28 13:41:07 SELinux systemd[1]: Starting The nginx HTTP and reverse proxy server...
    SELinux: May 28 13:41:07 SELinux nginx[5932]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
    SELinux: May 28 13:41:07 SELinux nginx[5932]: nginx: configuration file /etc/nginx/nginx.conf test is successful
    SELinux: May 28 13:41:07 SELinux systemd[1]: Started The nginx HTTP and reverse proxy server.
    SELinux: LISTEN 0      511          0.0.0.0:4881      0.0.0.0:*    users:(("nginx",pid=5936,fd=6),("nginx",pid=5935,fd=6),("nginx",pid=5934,fd=6))
    SELinux: LISTEN 0      511             [::]:4881         [::]:*    users:(("nginx",pid=5936,fd=7),("nginx",pid=5935,fd=7),("nginx",pid=5934,fd=7))
```

- Проверяем через браузер работу Nginx:
<img width="1263" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/ee152328-ee7b-4061-b403-51a0f13ec9e3">
