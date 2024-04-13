# GRUB

*Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, тестовая vm Ubuntu 22.04 ARM LVM, Vagrantfile и все остальные конфигурационные файл добавлен в репозитроий lab_otus/GRUB*

- C помощью команды vagrant ssh-config посмотрел необходимые информацию:

```
GRUB % vagrant ssh-config
```
```
Host GRUB
  HostName 192.168.65.147
  User vagrant
  Port 22
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile .vagrant/machines/GRUB/vmware_desktop/private_key
  IdentitiesOnly yes
  LogLevel FATAL
  PubkeyAcceptedKeyTypes +ssh-rsa
  HostKeyAlgorithms +ssh-rsa
```

- Поднял хост с помощью Vagrantfile:
```
GRUB % vagrant up
```

- Далее зашел по ssh на vm под sudo -i и добавил в файл /etc/sudoers доп параметры
```
 % printf "vagrant ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
```

- Проверяем тайм-аута GRUB
```
vagrant@GRUB:~$ cat /etc/default/grub
```
```
# If you change this file, run 'update-grub' afterwards to update
# /boot/grub/grub.cfg.
# For full documentation of the options in this file, see:
#   info -f grub -n 'Simple configuration'

GRUB_DEFAULT=0
GRUB_TIMEOUT_STYLE=menu
GRUB_TIMEOUT=10
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT=""
GRUB_CMDLINE_LINUX=""
```

- Перезагружаем vm и ждем меню GRUB

  <img width="1022" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/ea79baed-e9d1-4329-90f6-e674ddff3344">

- Выбираем нужную OS и наживаем E

- Далее ищем строку похожую на linux - linux16, это зависит от дистрибутива и прописываем в конце следующие строки
```
rw init=/bin/bas
```

- Нажимаем ctrl+X или F10, тут как удобно.

<img width="1021" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/0c7057fd-1665-49e5-8adb-452dd39fe6e1">

- Меняем пароль от пользователя vagrant

<img width="301" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/61fbefc8-c473-4118-a5e5-af2da067057f">

- Можно было загрузится в систему с параметром ro, догда бы пришлось монтироват рутовую файловую систему и после тогда можно было поменять пароль
```
mount -o remount,rw /
```

- На Ubuntu команда rd.break не заработала, но зато хорошо отработала в Almalinux

<img width="703" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/6b98a3c8-ddb1-468d-b37c-488831ed7c63">
<img width="703" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/6493105e-eb1c-4f66-8355-91c0a840dad3">

- Монтируем sysroot и меняем пароль
<img width="511" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/e8d114fb-270c-467e-a8e6-5854a2196291">

##Установить систему с LVM, после чего переименовать VG

- Проверим текущее состояние системы
```
root@GRUB:~# df -h
Filesystem                         Size  Used Avail Use% Mounted on
tmpfs                              391M  1.3M  390M   1% /run
/dev/mapper/ubuntu--vg-ubuntu--lv  9.8G  2.9G  6.4G  32% /
tmpfs                              2.0G     0  2.0G   0% /dev/shm
tmpfs                              5.0M     0  5.0M   0% /run/lock
/dev/nvme0n1p2                     1.7G  129M  1.5G   8% /boot
/dev/nvme0n1p1                     952M  6.4M  945M   1% /boot/efi
tmpfs                              391M  4.0K  391M   1% /run/user/1000
root@GRUB:~# vgs
  VG        #PV #LV #SN Attr   VSize   VFree 
  ubuntu-vg   1   1   0 wz--n- <17.32g <7.32g
```

- Нас интересует вторая строка с именем Volume Group
```
root@GRUB:~# vgrename ubuntu-vg OtusRoot
  Volume group "ubuntu-vg" successfully renamed to "OtusRoot"
```

- Далее правим /etc/fstab добавляем строку "/dev/mapper/OtusRoot-ubuntu--lv / ext4 defaults 0 1", в /boot/grub2/grub.cfg. везде заменяем старое
название на новое.
```
sed -i 's/ubuntu--vg-ubuntu--lv/OtusRoot-ubuntu--lv/g' /boot/grub/grub.cfg
```

- Перезагружаем систему и проверяем
```
root@GRUB:~# lsblk 
NAME                    MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0                     7:0    0  46.4M  1 loop /snap/snapd/19459
loop1                     7:1    0  59.8M  1 loop /snap/core20/2267
loop2                     7:2    0 109.6M  1 loop /snap/lxd/24326
loop3                     7:3    0  59.2M  1 loop /snap/core20/1977
nvme0n1                 259:0    0    20G  0 disk 
├─nvme0n1p1             259:1    0   953M  0 part /boot/efi
├─nvme0n1p2             259:2    0   1.8G  0 part /boot
└─nvme0n1p3             259:3    0  17.3G  0 part 
  └─OtusRoot-ubuntu--lv 253:0    0    10G  0 lvm  /
root@GRUB:~# df -h
Filesystem                       Size  Used Avail Use% Mounted on
tmpfs                             97M  1.3M   95M   2% /run
/dev/mapper/OtusRoot-ubuntu--lv  9.8G  3.9G  5.4G  42% /
tmpfs                            482M     0  482M   0% /dev/shm
tmpfs                            5.0M     0  5.0M   0% /run/lock
/dev/nvme0n1p2                   1.7G  265M  1.4G  17% /boot
/dev/nvme0n1p1                   952M  6.4M  945M   1% /boot/efi
tmpfs                             97M  4.0K   97M   1% /run/user/1000
```
