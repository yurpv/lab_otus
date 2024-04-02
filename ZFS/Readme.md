# ZFS

*Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, тестовая vm Ubuntu 22.04 ARM LVM, Vagrantfile и все остальные конфигурационные файл добавлен в репозитроий lab_otus/ZFS*

- Поднял хост с помощью Vagrantfile:

```
% vagrant up
```

- C помощью команды vagrant ssh-config посмотрел необходимые информацию:

```
% vagrant ssh-config
```
```
Host zfs
  HostName 192.168.65.147
  User vagrant
  Port 22
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile /Users/ypushkarev/ZFS/.vagrant/machines/zfs/vmware_desktop/private_key
  IdentitiesOnly yes
  LogLevel FATAL
  PubkeyAcceptedKeyTypes +ssh-rsa
  HostKeyAlgorithms +ssh-rsa
```

- Определение алгоритма с наилучшим сжатием.
```
root@zfs:~# lsblk 
NAME                      MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0                       7:0    0  59.7M  1 loop /snap/core20/2186
loop1                       7:1    0  59.2M  1 loop /snap/core20/1977
loop2                       7:2    0 109.6M  1 loop /snap/lxd/24326
loop3                       7:3    0  77.4M  1 loop /snap/lxd/27950
loop4                       7:4    0  46.4M  1 loop /snap/snapd/19459
sda                         8:0    0   512M  0 disk 
sdb                         8:16   0   512M  0 disk 
sdc                         8:32   0   512M  0 disk 
sdd                         8:48   0   512M  0 disk 
sde                         8:64   0   512M  0 disk 
sdf                         8:80   0   512M  0 disk 
sdg                         8:96   0   512M  0 disk 
sdh                         8:112  0   512M  0 disk
```

- Создаём пул из двух дисков в режиме RAID 1:
```
root@zfs:~# zpool create otus1 mirror /dev/sda /dev/sdb
```

- Создадим ещё 3 пула:
```
root@zfs:~# zpool create otus2 mirror /dev/sdc /dev/sdd
root@zfs:~# zpool create otus3 mirror /dev/sde /dev/sdf
root@zfs:~# zpool create otus4 mirror /dev/sdg /dev/sdh
```

- Смотрим информацию о пулах: zpool list
```
root@zfs:~# zpool list
NAME    SIZE  ALLOC   FREE  CKPOINT  EXPANDSZ   FRAG    CAP  DEDUP    HEALTH  ALTROOT
otus1   480M   100K   480M        -         -     0%     0%  1.00x    ONLINE  -
otus2   480M   104K   480M        -         -     0%     0%  1.00x    ONLINE  -
otus3   480M   100K   480M        -         -     0%     0%  1.00x    ONLINE  -
otus4   480M   100K   480M        -         -     0%     0%  1.00x    ONLINE  -
```

- Добавим разные алгоритмы сжатия в каждую файловую систему:
  < Алгоритм lzjb: zfs set compression=lzjb otus1
  < Алгоритм lz4:  zfs set compression=lz4 otus2
  < Алгоритм gzip: zfs set compression=gzip-9 otus3
  < Алгоритм zle:  zfs set compression=zle otus4
