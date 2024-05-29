# Стенд Vagrant с NFS 

### Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, так при выполнении лабораторной работы необходим vagrantbox bento/ubuntu-24.04 v202404.26.0 

### Цель домашнего задания
### Научиться самостоятельно разворачивать сервис NFS и подключать к нему клиентов.
### Описание домашнего задания 
 - Основная часть: </br>
Запускаем тестовые vm, из созданого Vagrantfile:
```
 vagrant up                                  
Bringing machine 'nfss' up with 'vmware_desktop' provider...
Bringing machine 'nfsc' up with 'vmware_desktop' provider...
```

Результатом выполнения команды `vagrant up` станут 2 виртуальных машины: nfss для сервера NFS и nfsc для клиента. 

Настраиваем сервер NFS, заходим на сервер:
```
vagrant ssh nfss
```

Дальнейшие действия выполняются от имени пользователя имеющего повышенные привилегии, разрешающие описанные действия. </br>
Установим сервер NFS:
```
root@nfss:/home/vagrant# apt install nfs-kernel-server
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  keyutils libnfsidmap1 nfs-common rpcbind
...
```

Проверяем наличие слушающих портов 2049,111 tcp/udp 
root@nfss:/etc# ss -tnplu 
```
vagrant# ss -tnplu
Netid      State       Recv-Q      Send-Q                 Local Address:Port            Peer Address:Port      Process                                                          
udp        UNCONN      0           0                            0.0.0.0:53202                0.0.0.0:*                                                                          
udp        UNCONN      0           0                            0.0.0.0:42988                0.0.0.0:*          users:(("rpc.mountd",pid=3162,fd=4))                            
udp        UNCONN      0           0                         127.0.0.54:53                   0.0.0.0:*          users:(("systemd-resolve",pid=658,fd=16))                       
udp        UNCONN      0           0                      127.0.0.53%lo:53                   0.0.0.0:*          users:(("systemd-resolve",pid=658,fd=14))                       
udp        UNCONN      0           0                192.168.65.202%eth0:68                   0.0.0.0:*          users:(("systemd-network",pid=1765,fd=24))                      
udp        UNCONN      0           0                            0.0.0.0:49246                0.0.0.0:*          users:(("rpc.mountd",pid=3162,fd=8))                            
udp        UNCONN      0           0                            0.0.0.0:111                  0.0.0.0:*          users:(("rpcbind",pid=2644,fd=5),("systemd",pid=1,fd=152))      
udp        UNCONN      0           0                          127.0.0.1:784                  0.0.0.0:*          users:(("rpc.statd",pid=3152,fd=5))                             
udp        UNCONN      0           0                            0.0.0.0:37706                0.0.0.0:*          users:(("rpc.mountd",pid=3162,fd=12))                           
udp        UNCONN      0           0                            0.0.0.0:38262                0.0.0.0:*          users:(("rpc.statd",pid=3152,fd=8))                             
udp        UNCONN      0           0                               [::]:111                     [::]:*          users:(("rpcbind",pid=2644,fd=7),("systemd",pid=1,fd=154))      
udp        UNCONN      0           0                               [::]:52880                   [::]:*          users:(("rpc.statd",pid=3152,fd=10))                            
udp        UNCONN      0           0                               [::]:39058                   [::]:*          users:(("rpc.mountd",pid=3162,fd=14))                           
udp        UNCONN      0           0                               [::]:59586                   [::]:*          users:(("rpc.mountd",pid=3162,fd=6))                            
udp        UNCONN      0           0                               [::]:41274                   [::]:*                                                                          
udp        UNCONN      0           0                               [::]:48048                   [::]:*          users:(("rpc.mountd",pid=3162,fd=10))                           
tcp        LISTEN      0           4096                         0.0.0.0:44341                0.0.0.0:*          users:(("rpc.mountd",pid=3162,fd=13))                           
tcp        LISTEN      0           4096                         0.0.0.0:53613                0.0.0.0:*          users:(("rpc.statd",pid=3152,fd=9))                             
tcp        LISTEN      0           4096                      127.0.0.54:53                   0.0.0.0:*          users:(("systemd-resolve",pid=658,fd=17))                       
tcp        LISTEN      0           4096                         0.0.0.0:40435                0.0.0.0:*          users:(("rpc.mountd",pid=3162,fd=9))                            
tcp        LISTEN      0           4096                   127.0.0.53%lo:53                   0.0.0.0:*          users:(("systemd-resolve",pid=658,fd=15))                       
tcp        LISTEN      0           64                           0.0.0.0:2049                 0.0.0.0:*                                                                          
tcp        LISTEN      0           4096                         0.0.0.0:111                  0.0.0.0:*          users:(("rpcbind",pid=2644,fd=4),("systemd",pid=1,fd=151))      
tcp        LISTEN      0           4096                         0.0.0.0:44735                0.0.0.0:*          users:(("rpc.mountd",pid=3162,fd=5))                            
tcp        LISTEN      0           64                           0.0.0.0:42171                0.0.0.0:*                                                                          
tcp        LISTEN      0           64                              [::]:46355                   [::]:*                                                                          
tcp        LISTEN      0           4096                            [::]:56137                   [::]:*          users:(("rpc.mountd",pid=3162,fd=7))                            
tcp        LISTEN      0           4096                            [::]:54593                   [::]:*          users:(("rpc.mountd",pid=3162,fd=15))                           
tcp        LISTEN      0           64                              [::]:2049                    [::]:*                                                                          
tcp        LISTEN      0           4096                               *:22                         *:*          users:(("sshd",pid=1270,fd=3),("systemd",pid=1,fd=233))         
tcp        LISTEN      0           4096                            [::]:111                     [::]:*          users:(("rpcbind",pid=2644,fd=6),("systemd",pid=1,fd=153))      
tcp        LISTEN      0           4096                            [::]:38579                   [::]:*          users:(("rpc.statd",pid=3152,fd=11))                            
tcp        LISTEN      0           4096                            [::]:46793                   [::]:*          users:(("rpc.mountd",pid=3162,fd=11))  
```

Создаём и настраиваем директорию, которая будет экспортирована в будущем 
```
root@nfss:/home/vagrant# mkdir -p /srv/share/upload
root@nfss:/home/vagrant# chown -R nobody:nogroup /srv/share
root@nfss:/home/vagrant# chmod 0777 /srv/share/upload
```

Cоздаём в файле /etc/exports структуру, которая позволит экспортировать ранее созданную директорию:
```
root@nfss:/home/vagrant# cat << EOF > /etc/exports 
/srv/share 192.168.65.11/32(rw,sync,root_squash)
EOF
```

Экспортируем ранее созданную директорию:
```
root@nfss:/home/vagrant# exportfs -r
exportfs: /etc/exports [1]: Neither 'subtree_check' or 'no_subtree_check' specified for export "192.168.65.11/32:/srv/share".
  Assuming default behaviour ('no_subtree_check').
  NOTE: this default has changed since nfs-utils version 1.0.x
```

Проверяем экспортированную директорию следующей командой
```
root@nfss:/home/vagrant# exportfs -s
/srv/share  192.168.65.11/32(sync,wdelay,hide,no_subtree_check,sec=sys,rw,secure,root_squash,no_all_squash)
```

- Настраиваем клиент NFS </br>
Заходим на сервер 
```
NFS % vagrant ssh nfsc                            
Welcome to Ubuntu 24.04 LTS (GNU/Linux 6.8.0-31-generic aarch64) 
```

Дальнейшие действия выполняются от имени пользователя имеющего повышенные привилегии, разрешающие описанные действия. </br>
Установим пакет с NFS-клиентом
```
vagrant@nfsc:~$ sudo -i
root@nfsc:/home/vagrant# apt install nfs-common
eading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  keyutils libnfsidmap1 rpcbind
...
```

Добавляем в /etc/fstab строку и выполняем команды:
```
echo "192.168.65.10:/srv/share/ /mnt nfs vers=3,noauto,x-systemd.automount 0 0" >> /etc/fstab
root@nfsc:~# systemctl daemon-reload 
root@nfsc:~# systemctl restart remote-fs.target
```

Отметим, что в данном случае происходит автоматическая генерация systemd units в каталоге /run/systemd/generator/, которые производят монтирование при первом обращении к каталогу /mnt/. </br>
Заходим в директорию /mnt/ и проверяем успешность монтирования:
```
root@nfsc:/home/vagrant# mount | grep mnt
vmhgfs-fuse on /mnt/vagrant-mounts/1000-1000 type fuse.vmhgfs-fuse (rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions,allow_other)
systemd-1 on /mnt type autofs (rw,relatime,fd=68,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=19000)
```

### Проверка работоспособности 

Заходим на сервер. </br>
Заходим в каталог /srv/share/upload.</br>
Создаём тестовый файл touch check_file.</br>
```
root@nfss:/home/vagrant# cd /srv/share/upload
root@nfss:/srv/share/upload# touch check_file
root@nfss:/srv/share/upload# ls
check_file
```
Заходим на клиент.
Заходим в каталог /mnt/upload. 
Проверяем наличие ранее созданного файла.
```
root@nfsc:/home/vagrant# cd /mnt/upload
root@nfsc:/mnt/upload# ls
check_file
```

Создаём тестовый файл touch client_file. 
Проверяем, что файл успешно создан.
```
root@nfsc:/mnt/upload# touch client_file
root@nfsc:/mnt/upload# ls
client_file
```

Если вышеуказанные проверки прошли успешно, это значит, что проблем с правами нет. 

Предварительно проверяем клиент: 
перезагружаем клиент;
заходим на клиент;
заходим в каталог /mnt/upload;
проверяем наличие ранее созданных файлов.
```
root@nfsc:/mnt/upload# reboot 

Broadcast message from root@vagrant on pts/1 (Wed 2024-05-29 08:56:44 UTC):

The system will reboot now!

NFS % vagrant ssh nfsc
Welcome to Ubuntu 24.04 LTS (GNU/Linux 6.8.0-31-generic aarch64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Wed May 29 11:45:12 AM UTC 2024
...
Last login: Wed May 29 08:46:33 2024 from 192.168.65.1
vagrant@nfsc:~$ cd /mnt/upload
vagrant@nfsc:/mnt/upload$ ls
check_file  client_file
```

Проверяем сервер: 
заходим на сервер в отдельном окне терминала;
перезагружаем сервер;
заходим на сервер;
проверяем наличие файлов в каталоге /srv/share/upload/;
проверяем экспорты exportfs -s;
```
root@nfss:/srv/share/upload# reboot 

Broadcast message from root@vagrant on pts/1 (Wed 2024-05-29 08:57:34 UTC):

The system will reboot now!

root@nfss:/srv/share/upload# Connection to 192.168.65.202 closed by remote host.
ypushkarev@MacBook-Air-Yurii NFS % vagrant ssh nfss
Welcome to Ubuntu 24.04 LTS (GNU/Linux 6.8.0-31-generic aarch64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Wed May 29 11:44:39 AM UTC 2024

  System load:  0.0                Processes:             246
  Usage of /:   10.7% of 29.82GB   Users logged in:       0
  Memory usage: 20%                IPv4 address for eth0: 192.168.65.202
  Swap usage:   0%

Last login: Wed May 29 08:46:14 2024 from 192.168.65.1
vagrant@nfss:~$ cd /srv/share/upload/
vagrant@nfss:/srv/share/upload$ ls
check_file  client_file
vagrant@nfss:/srv/share/upload$ exportfs -s
exportfs: could not open /var/lib/nfs/.etab.lock for locking: errno 13 (Permission denied)
vagrant@nfss:/srv/share/upload$ sudo exportfs -s
/srv/share  192.168.65.11/32(sync,wdelay,hide,no_subtree_check,sec=sys,rw,secure,root_squash,no_all_squash)
```
