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
  - Алгоритм lzjb: zfs set compression=lzjb otus1
  - Алгоритм lz4:  zfs set compression=lz4 otus2
  -  Алгоритм gzip: zfs set compression=gzip-9 otus3
  -  Алгоритм zle:  zfs set compression=zle otus4
 
- Проверим, что все файловые системы имеют разные методы сжатия:
```
root@zfs:~# zfs get all | grep compression
otus1  compression           lzjb                   local
otus2  compression           lz4                    local
otus3  compression           gzip-9                 local
otus4  compression           zle                    local
```

- Скачаем один и тот же текстовый файл во все пулы:
```
root@zfs:~# for i in {1..4}; do wget -P /otus$i https://gutenberg.org/cache/epub/2600/pg2600.converter.log; done
```

- Проверим, что файл был скачан во все пулы:
```
root@zfs:~# ls -l /otus*
/otus1:
total 22075
-rw-r--r-- 1 root root 41034307 Apr  2 07:54 pg2600.converter.log

/otus2:
total 17997
-rw-r--r-- 1 root root 41034307 Apr  2 07:54 pg2600.converter.log

/otus3:
total 10961
-rw-r--r-- 1 root root 41034307 Apr  2 07:54 pg2600.converter.log

/otus4:
total 40100
-rw-r--r-- 1 root root 41034307 Apr  2 07:54 pg2600.converter.log
root@zfs:~# 
```

- Проверим, сколько места занимает один и тот же файл в разных пулах и проверим степень сжатия файлов:
```
root@zfs:~# zfs list
NAME    USED  AVAIL     REFER  MOUNTPOINT
otus1  21.7M   330M     21.6M  /otus1
otus2  17.7M   334M     17.6M  /otus2
otus3  10.8M   341M     10.7M  /otus3
otus4  39.3M   313M     39.2M  /otus4

root@zfs:~# zfs get all | grep compressratio | grep -v ref
otus1  compressratio         1.82x                  -
otus2  compressratio         2.23x                  -
otus3  compressratio         3.66x                  -
otus4  compressratio         1.00x                  -
```

## Определение настроек пула

- Скачиваем архив в домашний каталог:
```
root@zfs:~# wget -O archive.tar.gz --no-check-certificate 'https://drive.usercontent.google.com/download?id=1MvrcEp-WgAQe57aDEzxSRalPAwbNN1Bb&export=download'
--2024-04-02 11:59:08--  https://drive.usercontent.google.com/download?id=1MvrcEp-WgAQe57aDEzxSRalPAwbNN1Bb&export=download
Resolving drive.usercontent.google.com (drive.usercontent.google.com)... 216.58.211.225, 2a00:1450:4026:808::2001
Connecting to drive.usercontent.google.com (drive.usercontent.google.com)|216.58.211.225|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 7275140 (6.9M) [application/octet-stream]
Saving to: ‘archive.tar.gz’

archive.tar.gz                              100%[===========================================================================================>]   6.94M  2.63MB/s    in 2.6s    

2024-04-02 11:59:18 (2.63 MB/s) - ‘archive.tar.gz’ saved [7275140/7275140]
```

- Распакуем его:
```
root@zfs:~# tar -xzvf archive.tar.gz
zpoolexport/
zpoolexport/filea
zpoolexport/fileb
```

- Проверим, возможно ли импортировать данный каталог в пул:
```
root@zfs:~# zpool import -d zpoolexport/
   pool: otus
     id: 6554193320433390805
  state: ONLINE
status: Some supported features are not enabled on the pool.
        (Note that they may be intentionally disabled if the
        'compatibility' property is set.)
 action: The pool can be imported using its name or numeric identifier, though
        some features will not be available without an explicit 'zpool upgrade'.
 config:

        otus                         ONLINE
          mirror-0                   ONLINE
            /root/zpoolexport/filea  ONLINE
            /root/zpoolexport/fileb  ONLINE
```

- Сделаем импорт данного пула к нам в ОС:
```

```
