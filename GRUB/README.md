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

##






