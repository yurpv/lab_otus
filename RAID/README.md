#Дисковая подсистема 
```
**Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, тестовая vm Debian 12 ARM, Vagrantfile и все остальные конфигурационные файл добавлен в репозитроий lab_otus/RAID**

Поднял хост с помощью Vagrantfile и проверил доступ по ssh #vagrant up
C помощью команды vagrant ssh-config посмотрел необходимые параметры
% vagrant ssh-config 
Host otuslinux
  HostName 192.168.65.140
  User vagrant
  Port 22
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile /Users/ypushkarev/LabRAID/.vagrant/machines/otuslinux/vmware_desktop/private_key
  IdentitiesOnly yes
  LogLevel FATAL
  PubkeyAcceptedKeyTypes +ssh-rsa
  HostKeyAlgorithms +ssh-rsa

  Далее зашел по ssh на vm, установил sudo и добавил в файл /etc/sudoers доп параметры

 % printf "vagrant ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

 Так как не нашел решения для добавления дисков через Vagrantfile для VMware Fusion, пришлось сделал это руками.
 ![image](https://github.com/yurpv/lab_otus/assets/162872411/02646b0e-c385-480d-a553-498dd58aac0e)

Сделал vagrant reload и vm запустилась с установленными компанентами
Следующим шагом, подключился по ssh на удаленную машину
 % vagrant ssh
 vagrant@otuslinux:~$ su -
Password:vagrant 

Проверил какие диски есть в системе
root@otuslinux:~# fdisk -l
Disk /dev/nvme0n1: 20 GiB, 21474836480 bytes, 41943040 sectors
Disk model: VMware Virtual NVMe Disk
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 3E2ABD7D-28E7-44C9-97F6-FDDA3BA0436D

Device            Start      End  Sectors  Size Type
/dev/nvme0n1p1     2048  1050623  1048576  512M EFI System
/dev/nvme0n1p2  1050624 39942143 38891520 18.5G Linux filesystem
/dev/nvme0n1p3 39942144 41940991  1998848  976M Linux swap


Disk /dev/sdc: 256 MiB, 268435456 bytes, 524288 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/sdd: 256 MiB, 268435456 bytes, 524288 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/sdb: 256 MiB, 268435456 bytes, 524288 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/sda: 256 MiB, 268435456 bytes, 524288 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

root@otuslinux:~# lshw -short | grep disk
/0/100/11/3/0      /dev/sda        disk        268MB VMware Virtual S
/0/100/11/3/1      /dev/cdrom      disk        VMware SATA CD01
/0/100/11/3/2      /dev/sdb        disk        268MB VMware Virtual S
/0/100/11/3/3      /dev/sdc        disk        268MB VMware Virtual S
/0/100/11/3/0.0.0  /dev/sdd        disk        268MB VMware Virtual S
/0/100/17/0/0      hwmon0          disk        NVMe disk
/0/100/17/0/2      /dev/ng0n1      disk        NVMe disk
/0/100/17/0/1      /dev/nvme0n1    disk        21GB NVMe disk

Создал RAID 1
root@otuslinux:~# mdadm --create --verbose /dev/md0 -l 1 -n 4 /dev/sd{a,b,c,d}

Проверим как собрался RAID
root@otuslinux:~# cat /proc/mdstat
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10] 
md0 : active raid1 sdd[3] sdc[2] sdb[1] sda[0]
      261120 blocks super 1.2 [4/4] [UUUU]

root@otuslinux:~# mdadm -D /dev/md0
/dev/md0:
           Version : 1.2
     Creation Time : Sat Mar 23 14:08:01 2024
        Raid Level : raid1
        Array Size : 261120 (255.00 MiB 267.39 MB)
     Used Dev Size : 261120 (255.00 MiB 267.39 MB)
      Raid Devices : 4
     Total Devices : 4
       Persistence : Superblock is persistent

       Update Time : Sat Mar 23 14:08:02 2024
             State : clean 
    Active Devices : 4
   Working Devices : 4
    Failed Devices : 0
     Spare Devices : 0

Consistency Policy : resync

              Name : otuslinux:0  (local to host otuslinux)
              UUID : 299f424c:757f2eea:1da06523:89f297bc
            Events : 18

    Number   Major   Minor   RaidDevice State
       0       8        0        0      active sync   /dev/sda
       1       8       16        1      active sync   /dev/sdb
       2       8       32        2      active sync   /dev/sdc
       3       8       48        3      active sync   /dev/sdd

mdadm --detail --scan --verbose

Создал конфигурационный файла mdadm.conf

Чтобы ОС запомнила, какой RAID массив требуется создать и какие компоненты в него входят, создадим файл mdadm.conf

Убедимся, что информация верна:
root@otuslinux:~# mdadm --detail --scan --verbose
ARRAY /dev/md0 level=raid1 num-devices=4 metadata=1.2 name=otuslinux:0 UUID=299f424c:757f2eea:1da06523:89f297bc
   devices=/dev/sda,/dev/sdb,/dev/sdc,/dev/sdd


Выполнил две команды:
root@otuslinux:~# echo "DEVICE partitions" > /etc/mdadm/mdadm.conf
root@otuslinux:~# mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm/mdadm.conf

Для того чтобы сломать RAID, выполнил команду:
root@otuslinux:~# mdadm /dev/md0 --fail /dev/sdd
mdadm: set /dev/sdd faulty in /dev/md0

Проверяем состояние RAID:
root@otuslinux:~# cat /proc/mdstat
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10] 
md0 : active raid1 sdd[3](F) sdc[2] sdb[1] sda[0]
      261120 blocks super 1.2 [4/3] [UUU_]
      
unused devices: <none>
root@otuslinux:~# mdadm -D /dev/md0
/dev/md0:
           Version : 1.2
     Creation Time : Sat Mar 23 14:08:01 2024
        Raid Level : raid1
        Array Size : 261120 (255.00 MiB 267.39 MB)
     Used Dev Size : 261120 (255.00 MiB 267.39 MB)
      Raid Devices : 4
     Total Devices : 4
       Persistence : Superblock is persistent

       Update Time : Sat Mar 23 14:15:27 2024
             State : clean, degraded 
    Active Devices : 3
   Working Devices : 3
    Failed Devices : 1
     Spare Devices : 0

Consistency Policy : resync

              Name : otuslinux:0  (local to host otuslinux)
              UUID : 299f424c:757f2eea:1da06523:89f297bc
            Events : 20

    Number   Major   Minor   RaidDevice State
       0       8        0        0      active sync   /dev/sda
       1       8       16        1      active sync   /dev/sdb
       2       8       32        2      active sync   /dev/sdc
       -       0        0        3      removed

       3       8       48        -      faulty   /dev/sdd

Удалим “сломанный” диск из массива:
root@otuslinux:~# mdadm /dev/md0 --remove /dev/sdd
mdadm: hot removed /dev/sdd from /dev/md0

Добавляем диск обратно в RAID, будто заменили на новый:
root@otuslinux:~# mdadm /dev/md0 --add /dev/sdd
mdadm: added /dev/sdd

Проверяем состояние RAID:
root@otuslinux:~# cat /proc/mdstat
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10] 
md0 : active raid1 sdd[4] sdc[2] sdb[1] sda[0]
      261120 blocks super 1.2 [4/4] [UUUU]
      
unused devices: <none>
root@otuslinux:~# mdadm -D /dev/md0
/dev/md0:
           Version : 1.2
     Creation Time : Sat Mar 23 14:08:01 2024
        Raid Level : raid1
        Array Size : 261120 (255.00 MiB 267.39 MB)
     Used Dev Size : 261120 (255.00 MiB 267.39 MB)
      Raid Devices : 4
     Total Devices : 4
       Persistence : Superblock is persistent

       Update Time : Sat Mar 23 14:17:17 2024
             State : clean 
    Active Devices : 4
   Working Devices : 4
    Failed Devices : 0
     Spare Devices : 0

Consistency Policy : resync

              Name : otuslinux:0  (local to host otuslinux)
              UUID : 299f424c:757f2eea:1da06523:89f297bc
            Events : 40

    Number   Major   Minor   RaidDevice State
       0       8        0        0      active sync   /dev/sda
       1       8       16        1      active sync   /dev/sdb
       2       8       32        2      active sync   /dev/sdc
       4       8       48        3      active sync   /dev/sdd


Создать GPT раздел, пять партиций и смонтировать их на диск

Создаем раздел GPT на RAID:
root@otuslinux:~# parted -s /dev/md0 mklabel gpt

Создаем партиции:
root@otuslinux:~# parted /dev/md0 mkpart primary ext4 0% 25%
root@otuslinux:~# parted /dev/md0 mkpart primary ext4 25% 50%           
root@otuslinux:~# parted /dev/md0 mkpart primary ext4 50% 75%           
root@otuslinux:~# parted /dev/md0 mkpart primary ext4 75% 100%          

Cоздаем на партициях ФС:
for i in $(seq 1 4); do sudo mkfs.ext4 /dev/md0p$i; done

И монтируем их по каталогам
root@otuslinux:~# mkdir -p /raid/part{1,2,3,4}
root@otuslinux:~# for i in $(seq 1 4); do mount /dev/md0p$i /raid/part$i; done

Смотрим что получилось:

root@otuslinux:~# lsblk 
NAME        MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINTS
sda           8:0    0  256M  0 disk  
└─md0         9:0    0  255M  0 raid1 
  ├─md0p1   259:6    0   63M  0 part  /raid/part1
  ├─md0p2   259:7    0   63M  0 part  /raid/part2
  ├─md0p3   259:10   0   64M  0 part  /raid/part3
  └─md0p4   259:11   0   63M  0 part  /raid/part4
sdb           8:16   0  256M  0 disk  
└─md0         9:0    0  255M  0 raid1 
  ├─md0p1   259:6    0   63M  0 part  /raid/part1
  ├─md0p2   259:7    0   63M  0 part  /raid/part2
  ├─md0p3   259:10   0   64M  0 part  /raid/part3
  └─md0p4   259:11   0   63M  0 part  /raid/part4
sdc           8:32   0  256M  0 disk  
└─md0         9:0    0  255M  0 raid1 
  ├─md0p1   259:6    0   63M  0 part  /raid/part1
  ├─md0p2   259:7    0   63M  0 part  /raid/part2
  ├─md0p3   259:10   0   64M  0 part  /raid/part3
  └─md0p4   259:11   0   63M  0 part  /raid/part4
sdd           8:48   0  256M  0 disk  
└─md0         9:0    0  255M  0 raid1 
  ├─md0p1   259:6    0   63M  0 part  /raid/part1
  ├─md0p2   259:7    0   63M  0 part  /raid/part2
  ├─md0p3   259:10   0   64M  0 part  /raid/part3
  └─md0p4   259:11   0   63M  0 part  /raid/part4
nvme0n1     259:0    0   20G  0 disk  
├─nvme0n1p1 259:1    0  512M  0 part  /boot/efi
├─nvme0n1p2 259:2    0 18.5G  0 part  /
└─nvme0n1p3 259:3    0  976M  0 part  [SWAP]

root@otuslinux:~# fdisk -l
Disk /dev/nvme0n1: 20 GiB, 21474836480 bytes, 41943040 sectors
Disk model: VMware Virtual NVMe Disk
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 3E2ABD7D-28E7-44C9-97F6-FDDA3BA0436D

Device            Start      End  Sectors  Size Type
/dev/nvme0n1p1     2048  1050623  1048576  512M EFI System
/dev/nvme0n1p2  1050624 39942143 38891520 18.5G Linux filesystem
/dev/nvme0n1p3 39942144 41940991  1998848  976M Linux swap


Disk /dev/sda: 256 MiB, 268435456 bytes, 524288 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/sdb: 256 MiB, 268435456 bytes, 524288 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/sdd: 256 MiB, 268435456 bytes, 524288 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/sdc: 256 MiB, 268435456 bytes, 524288 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/md0: 255 MiB, 267386880 bytes, 522240 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 42574D95-FCBC-4A29-9C61-26B403D876A5

Device      Start    End Sectors Size Type
/dev/md0p1   2048 131071  129024  63M Linux filesystem
/dev/md0p2 131072 260095  129024  63M Linux filesystem
/dev/md0p3 260096 391167  131072  64M Linux filesystem
/dev/md0p4 391168 520191  129024  63M Linux filesystem


