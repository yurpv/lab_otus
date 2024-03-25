# Файловые системы и LVM

*Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, тестовая vm Ubuntu 22.04 ARM LVM, Vagrantfile и все остальные конфигурационные файл добавлен в репозитроий lab_otus/LVM*

- Поднял хост с помощью Vagrantfile:

```
% vagrant up
```

- C помощью команды vagrant ssh-config посмотрел необходимые информацию:

```
% vagrant ssh-config
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

Диски sda, sdb будем использовать для базовых вещей и снапшотов:

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




