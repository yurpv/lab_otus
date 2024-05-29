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

Добавляем в /etc/fstab строку 
root@nfsc:~# echo "192.168.50.10:/srv/share/ /mnt nfs vers=3,noauto,x-systemd.automount 0 0" >> /etc/fstab

и выполняем команды:
root@nfsc:~# systemctl daemon-reload 
root@nfsc:~# systemctl restart remote-fs.target 

Отметим, что в данном случае происходит автоматическая генерация systemd units в каталоге /run/systemd/generator/, которые производят монтирование при первом обращении к каталогу /mnt/.
Заходим в директорию /mnt/ и проверяем успешность монтирования:
root@nfsc:~# mount | grep mnt 

При успехе вывод должен примерно соответствовать этому:
[root@nfsc mnt]# mount | grep mnt 
systemd-1 on /mnt type autofs (rw,relatime,fd=46,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=46033)
192.168.50.10:/srv/share/ on /mnt type nfs (rw,relatime,vers=3,rsize=131072,wsize=131072,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=192.168.50.10,mountvers=3,mountport=50749,mountproto=udp,local_lock=none,addr=192.168.50.10)

Обратите внимание на `vers=3`, что соответствует NFSv3, как того требует задание.
Проверка работоспособности 
Заходим на сервер. 
Заходим в каталог /srv/share/upload.
Создаём тестовый файл touch check_file.
Заходим на клиент.
Заходим в каталог /mnt/upload. 
Проверяем наличие ранее созданного файла.
Создаём тестовый файл touch client_file. 
Проверяем, что файл успешно создан.

Если вышеуказанные проверки прошли успешно, это значит, что проблем с правами нет. 

Предварительно проверяем клиент: 
перезагружаем клиент;
заходим на клиент;
заходим в каталог /mnt/upload;
проверяем наличие ранее созданных файлов.

Проверяем сервер: 
заходим на сервер в отдельном окне терминала;
перезагружаем сервер;
заходим на сервер;
проверяем наличие файлов в каталоге /srv/share/upload/;
проверяем экспорты exportfs -s;
