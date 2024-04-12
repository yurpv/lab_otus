# GRUB

*Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, тестовая vm Ubuntu 22.04 ARM LVM, Vagrantfile и все остальные конфигурационные файл добавлен в репозитроий lab_otus/ZFS*

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

- Проверяем загрузчик
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
