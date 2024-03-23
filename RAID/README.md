#Дисковая подсистема 
Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, тестовая vm Debian 12 ARM, Vagrantfile и все остальные конфигурационные файл добавлен в репозитроий lab_otus/RAID

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
