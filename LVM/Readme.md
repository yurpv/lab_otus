# Файловые системы и LVM

*Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, тестовая vm Ubuntu 22.04 ARM LVM, Vagrantfile и все остальные конфигурационные файл добавлен в репозитроий lab_otus/LVM*

- Поднял хост с помощью Vagrantfile:

```
% vagrant up
```

- C помощью команды vagrant ssh-config посмотрел необходимые информацию:

```
% vagrant ssh-config
```
```
Host lvm
  HostName 192.168.65.147
  User vagrant
  Port 22
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile .vagrant/machines/lvm/vmware_desktop/private_key
  IdentitiesOnly yes
  LogLevel FATAL
  PubkeyAcceptedKeyTypes +ssh-rsa
  HostKeyAlgorithms +ssh-rsa
```

- Далее зашел по ssh на vm, авторизировался sudo su, добавил в файл /etc/sudoers доп параметры:
```
sudo su
printf "vagrant ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
```

- После выключил vm:
```
% vagrant halt

 и запустил с командой

% vagrant reload

vm запустилась с установленными компанентами
```

***Так как не нашел решения для добавления дисков через Vagrantfile для VMware Fusion, пришлось сделал это руками.
 ![image](https://github.com/yurpv/lab_otus/assets/162872411/02646b0e-c385-480d-a553-498dd58aac0e)***

- Определяем какие устройства хотим использовать в качестве Physical Volumes для наших будущих Volume Groups:
```
root@lvm:/home/vagrant# lsblk
```
```
NAME                      MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0                       7:0    0  59.2M  1 loop /snap/core20/1977
loop1                       7:1    0 109.6M  1 loop /snap/lxd/24326
loop2                       7:2    0  77.4M  1 loop /snap/lxd/27437
loop3                       7:3    0  46.4M  1 loop /snap/snapd/19459
sda                         8:0    0    10G  0 disk 
sdb                         8:16   0     2G  0 disk 
sdc                         8:32   0     1G  0 disk 
sdd                         8:48   0     1G  0 disk 
nvme0n1                   259:0    0    20G  0 disk 
├─nvme0n1p1               259:1    0   953M  0 part /boot/efi
├─nvme0n1p2               259:2    0   1.8G  0 part /boot
└─nvme0n1p3               259:3    0  17.3G  0 part 
  └─ubuntu--vg-ubuntu--lv 253:0    0    10G  0 lvm  /
```

- Диски sda, sdb будем использовать для базовых вещей и снапшотов:

```
root@lvm:/home/vagrant# lvmdiskscan
  /dev/nvme0n1   [      20.00 GiB] 
  /dev/loop0     [     <59.25 MiB] 
  /dev/sda       [      10.00 GiB] 
  /dev/nvme0n1p1 [     953.00 MiB] 
  /dev/loop1     [    <109.61 MiB] 
  /dev/nvme0n1p2 [       1.75 GiB] 
  /dev/loop2     [     <77.36 MiB] 
  /dev/nvme0n1p3 [     <17.32 GiB] LVM physical volume
  /dev/loop3     [      46.41 MiB] 
  /dev/sdb       [       2.00 GiB] 
  /dev/sdc       [       1.00 GiB] 
  /dev/sdd       [       1.00 GiB] 
  4 disks
  7 partitions
  0 LVM physical volume whole disks
  1 LVM physical volume
```

- Разметим диск для будущего использования LVM - создадим PV

```
root@lvm:/home/vagrant# pvcreate /dev/sda
  Physical volume "/dev/sda" successfully created.
```

- Cоздаем первый уровень абстракции - VG:

```
root@lvm:/home/vagrant# vgcreate otus /dev/sda
  Volume group "otus" successfully created
```

-  Cоздать Logical Volume

```
root@lvm:/home/vagrant# lvcreate -l+80%FREE -n test otus
  Logical volume "test" created.
```

- Посмотрим информацию о только что созданном Volume Group:

```
root@lvm:/home/vagrant# vgdisplay otus
  --- Volume group ---
  VG Name               otus
  System ID             
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  2
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                1
  Open LV               0
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               <10.00 GiB
  PE Size               4.00 MiB
  Total PE              2559
  Alloc PE / Size       2047 / <8.00 GiB
  Free  PE / Size       512 / 2.00 GiB
  VG UUID               gnK8d3-8Qda-snn0-IPRf-yBpH-HA7Q-54RKCc
```

- Выведем детальную информацию о LV:

```
root@lvm:/home/vagrant# lvdisplay /dev/otus/test
  --- Logical volume ---
  LV Path                /dev/otus/test
  LV Name                test
  VG Name                otus
  LV UUID                X534dr-SIiG-Iu8A-Tdx0-u96i-vClE-5xOy2y
  LV Write Access        read/write
  LV Creation host, time lvm, 2024-03-25 14:28:12 +0000
  LV Status              available
  # open                 0
  LV Size                <8.00 GiB
  Current LE             2047
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:1
```

- Можно вывести краткую информацию:

```
root@lvm:/home/vagrant# vgs
  VG        #PV #LV #SN Attr   VSize   VFree 
  otus        1   1   0 wz--n- <10.00g  2.00g
  ubuntu-vg   1   1   0 wz--n- <17.32g <7.32g
root@lvm:/home/vagrant# lvs
  LV        VG        Attr       LSize  Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  test      otus      -wi-a----- <8.00g                                                    
  ubuntu-lv ubuntu-vg -wi-ao---- 10.00g  
```

- Cоздаем еще один LV из свободного места. На этот раз создадим не экстентами, а абсолютным значением в мегабайтах:

```
root@lvm:/home/vagrant# lvcreate -L 100M -n small otus
  Logical volume "small" created.
root@lvm:/home/vagrant# lvs
  LV        VG        Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  small     otus      -wi-a----- 100.00m                                                    
  test      otus      -wi-a-----  <8.00g                                                    
  ubuntu-lv ubuntu-vg -wi-ao----  10.00g   
```

- На LV создаем файловую систему и смонтируем:

```
root@lvm:/home/vagrant# mkfs.ext4 /dev/otus/test 
mke2fs 1.46.5 (30-Dec-2021)
Creating filesystem with 2096128 4k blocks and 524288 inodes
Filesystem UUID: 59949164-7cf7-4eec-9505-dc6369c8ca9f
Superblock backups stored on blocks: 
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done

root@lvm:~# mkdir /data
root@lvm:~# mount | grep /data
/dev/mapper/otus-test on /data type ext4 (rw,relatime)
```

# Расширение LVM

* Нам необходимо добавить свободного места в директории /data. Мы можем расширить файловую систему на LV /dev/otus/test за счет нового блочного устройства /dev/sdb.*

- Для начала так же необходимо создать PV:

```
root@lvm:~# pvcreate /dev/sdb 
  Physical volume "/dev/sdb" successfully created.
```

- Необходимо расширить VG добавив в него этот диск:

```
root@lvm:~# vgextend otus /dev/sdb
  Volume group "otus" successfully extended
```

- Проверяем, что новый диск присутствует в новой VG и прибавилось место:

```
root@lvm:~# vgdisplay -v otus | grep 'PV Name'
  PV Name               /dev/sda     
  PV Name               /dev/sdb

root@lvm:~# vgs
  VG        #PV #LV #SN Attr   VSize   VFree 
  otus        2   2   0 wz--n-  11.99g <3.90g
  ubuntu-vg   1   1   0 wz--n- <17.32g <7.32g
```
- Сымитируем занятое место с помощью команды dd:

```
root@lvm:~# dd if=/dev/zero of=/data/test.log bs=1M \
 count=8000 status=progress
7596933120 bytes (7.6 GB, 7.1 GiB) copied, 2 s, 3.8 GB/s
dd: error writing '/data/test.log': No space left on device
7944+0 records in
7943+0 records out
8329297920 bytes (8.3 GB, 7.8 GiB) copied, 2.19879 s, 3.8 GB/s

  Теперь у нас занято 100% дискового пространства:

root@lvm:~# df -Th /data/
Filesystem            Type  Size  Used Avail Use% Mounted on
/dev/mapper/otus-test ext4  7.8G  7.8G     0 100% /data
```
