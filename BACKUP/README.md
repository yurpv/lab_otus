# Домашнее задание Резервное копирование

## Цели домашнего задания

- Научиться настраивать резервное копирование с помощью утилиты Borg.

 > Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, при выполнении лабораторной работы использовал образ vagrantbox bento/ubuntu-24.04.

## Описание домашнего задания

- Настроить стенд Vagrant с двумя виртуальными машинами: backup_server и client.
- Настроить удаленный бэкап каталога /etc c сервера client при помощи borgbackup.
- Резервные копии должны соответствовать следующим критериям:
> Директория для резервных копий /var/backup. Это должна быть отдельная точка монтирования. В данном случае для демонстрации размер не принципиален, достаточно будет и 2GB.</br> 
Репозиторий для резервных копий должен быть зашифрован ключом или паролем - на усмотрение студента;
имя бэкапа должно содержать информацию о времени снятия бекапа.</br>
Глубина бекапа должна быть год, хранить можно по последней копии на конец месяца, кроме последних трех.</br>
Последние три месяца должны содержать копии на каждый день.</br>
Резервная копия снимается каждые 5 минут. Такой частый запуск в целях демонстрации;
Написан скрипт для снятия резервных копий. Скрипт запускается из соответствующей Cron джобы, либо systemd timer-а - на усмотрение студента.
Настроено логирование процесса бекапа. Для упрощения можно весь вывод перенаправлять в logger с соответствующим тегом. Если настроите не в syslog, то обязательна ротация логов.

Формат сдачи ДЗ - vagrant + ansible

## Пошаговая инструкция выполнения домашнего задания

### Создаём виртуальные машины

- Создаём каталог, в котором будут храниться настройки виртуальной машины. В каталоге создаём файл с именем [Vagrantfile](./Vagrantfile)
- Результатом выполнения команды vagrant up станут 2 созданные виртуальные машины backup и client.
- Заходим на сервере backup, проверяем как правильно отработал playbook.
> Нужно проверить создания lv и монтирование ее к разделу /var/backup, создания пользователя и группы borg, а так же католог .ssh
```
vagrant ssh backup
vagrant@backup:~$ sudo -i
root@backup:~# lsblk 
NAME                      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda                         8:0    0   64G  0 disk 
├─sda1                      8:1    0    1G  0 part /boot/efi
├─sda2                      8:2    0    2G  0 part /boot
└─sda3                      8:3    0 60.9G  0 part 
  ├─ubuntu--vg-ubuntu--lv 252:0    0 30.5G  0 lvm  /
  └─ubuntu--vg-backup     252:1    0    2G  0 lvm  /var/backup
sr0                        11:0    1 1024M  0 rom
...
root@backup:~# ll /var/ | grep backup
drwxr-xr-x  3 borg borg   4096 Jun 19 12:02 backup/
...
root@backup:~# cat /etc/passwd | grep borg
borg:x:1001:100::/home/borg:/bin/bash
root@backup:~# cat /etc/group | grep borg
borg:x:1001:borg
root@backup:~# ll /home/borg/.ssh/
total 12
drwx------ 2 borg borg  4096 Jun 19 10:14 ./
drwxr-x--- 4 borg users 4096 Jun 19 10:24 ../
-rw-r----- 1 borg borg   123 Jun 19 11:12 authorized_keys
```

- Перходим на client, проверяем как правильно отработал playbook.
> Нужно проверить создания пользователя и группы borg, католог .ssh, создания файлов для systemd
```
root@client:~# cat /etc/passwd | grep borg
borg:x:1001:100::/home/borg:/bin/bash
root@client:~# cat /etc/group | grep borg
borg:x:1001:borg
root@client:~# ll /home/borg/.ssh/
total 16
drwx------ 2 borg borg  4096 Jun 19 10:51 ./
drwxr-x--- 3 borg users 4096 Jun 19 10:52 ../
root@client:~# ll /etc/systemd/system | grep borg
-rw-r--r--  1 root root  653 Jun 19 11:14 borg-backup.service
-rw-r--r--  1 root root   96 Jun 19 11:15 borg-backup.timer
```

- После того как убедились что все в порядке, приступаем к работе с borgbackup.
- Инициализируем репозиторий borg на backup сервере с client сервера.
```
root@client:~# borg init --encryption=repokey borg@192.168.65.160:/var/backup/
The authenticity of host '192.168.65.160 (192.168.65.160)' can't be established.
ED25519 key fingerprint is SHA256:DH6Cb/kTMDCyLGC6GLSea+1fBhkpoHN6NPHDyFasVYc.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Remote: Warning: Permanently added '192.168.65.160' (ED25519) to the list of known hosts.
```

- Запускаем для проверки создания бэкапа.
```
root@client:~# borg create --stats --list borg@192.168.65.160:/var/backup/::"etc-{now:%Y-%m-%d_%H:%M:%S}" /etc
borg@192.168.65.160's password: 
A /etc/subuid
s /etc/mtab
s /etc/os-release
s /etc/resolv.conf
s /etc/rmt
s /etc/vconsole.conf
s /etc/vtrgb
...
------------------------------------------------------------------------------
Repository: ssh://borg@192.168.65.160/var/backup
Archive name: etc-2024-06-19_10:53:54
Archive fingerprint: 8548919ad1b341bc63d007343d36d3f96101eaf9b0fee7dbeafb2ee5e1e9a5b9
Time (start): Wed, 2024-06-19 10:53:59
Time (end):   Wed, 2024-06-19 10:53:59
Duration: 0.26 seconds
Number of files: 819
Utilization of max. archive size: 0%
------------------------------------------------------------------------------
                       Original size      Compressed size    Deduplicated size
This archive:                2.28 MB              1.01 MB            980.05 kB
All archives:                2.28 MB              1.01 MB              1.05 MB

                       Unique chunks         Total chunks
Chunk index:                     783                  811
```

- Смотрим, что у нас получилось.
```
root@client:~# borg list borg@192.168.65.160:/var/backup/
borg@192.168.65.160's password: 
etc-2024-06-19_10:53:54              Wed, 2024-06-19 10:53:59 [8548919ad1b341bc63d007343d36d3f96101eaf9b0fee7dbeafb2ee5e1e9a5b9]
```

- Смотрим список файлов
```
root@client:~# borg list borg@192.168.65.160:/var/backup/::etc-2024-06-19_10:53:54
borg@192.168.65.160's password: 
drwxr-xr-x root   root          0 Wed, 2024-06-19 10:51:24 etc
-rw-r--r-- root   root         39 Wed, 2024-06-19 10:51:24 etc/subuid
lrwxrwxrwx root   root         19 Tue, 2024-04-23 12:46:02 etc/mtab -> ../proc/self/mounts
lrwxrwxrwx root   root         21 Mon, 2024-04-22 16:08:03 etc/os-release -> ../usr/lib/os-release
lrwxrwxrwx root   root         39 Tue, 2024-04-23 12:46:24 etc/resolv.conf -> ../run/systemd/resolve/stub-resolv.conf
lrwxrwxrwx root   root         13 Mon, 2024-04-08 19:20:47 etc/rmt -> /usr/sbin/rmt
lrwxrwxrwx root   root         16 Tue, 2024-04-23 12:46:02 etc/vconsole.conf -> default/keyboard
```
