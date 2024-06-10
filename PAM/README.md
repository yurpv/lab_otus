# PAM

### Цели домашнего задания

- Запретить всем пользователям кроме группы admin логин в выходные (суббота и воскресенье), без учета праздников

Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, при выполнении лабораторной работы использовал образ vagrantbox bento/ubuntu-24.04.

### Домашнее задание:

- Подключаемся к нашей созданной ВМ: vagrant ssh
- Переходим в root-пользователя: sudo -i
```
vagrant ssh       
Welcome to Ubuntu 24.04 LTS (GNU/Linux 6.8.0-31-generic aarch64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Mon Jun 10 04:52:24 PM UTC 2024

  System load:  0.0                Processes:             236
  Usage of /:   10.7% of 29.82GB   Users logged in:       0
  Memory usage: 20%                IPv4 address for eth0: 192.168.65.210
  Swap usage:   0%

vagrant@PAM:~$ sudo -i
root@PAM:~#
```

- Создаём пользователя otusadm и otus, установим для них пароль
```
root@PAM:~# sudo useradd otusadm && sudo useradd otus
root@PAM:~# echo "otusadm:Otus2024!" | chpasswd && echo "otus:Otus2024!" | chpasswd
```

- Создим группу admin и добавим в нее пользователей:
```
root@PAM:~# sudo groupadd -f admin
root@PAM:~# usermod otusadm -a -G admin && usermod root -a -G admin && usermod vagrant -a -G admin
```

- Проверим, пользователей что они есть в группе admin:
```
root@PAM:~# cat /etc/group | grep admin
admin:x:1003:otusadm,root,vagrant
```

- Создадим файл-скрипт /usr/local/bin/login.sh:
```
#!/bin/bash
#Первое условие: если день недели суббота или воскресенье
if [ $(date +%a) = "Sat" ] || [ $(date +%a) = "Sun" ]; then
 #Второе условие: входит ли пользователь в группу admin
 if getent group admin | grep -qw "$PAM_USER"; then
        #Если пользователь входит в группу admin, то он может подключиться
        exit 0
      else
        #Иначе ошибка (не сможет подключиться)
        exit 1
    fi
  #Если день не выходной, то подключиться может любой пользователь
  else
    exit 0
fi
```

- Добавим права на исполнение файла
```
root@PAM:~# chmod +x /usr/local/bin/login.sh
```

- Меняем /etc/pam.d/sshd для прохождения дополнительной аутентификации через модуль pam_exec:
```
root@PAM:~# sudo sed  -i -E "s/account.+required.+pam_nologin.so/account    required     pam_nologin.so\naccount    required    pam_exec.so    \/usr\/local\/bin\/login.sh/" /etc/pam.d/sshd
```
- Меняем дату на локальном ОС и тестовом стенде
```
root@PAM:~# timedatectl set-ntp no
root@PAM:~# sudo date -s '2024/06/09 18:00'
Sun Jun  9 08:00:00 PM UTC 2024
...
@MacBook-Air-Yurii ~ % sudo date 060918022024.00 
Sun Jun  9 18:02:00 MSK 2024
```

- Пробуем подключиться
```
@MacBook-Air-Yurii ~ % date                      
Sun Jun  9 18:12:01 MSK 2024
ypushkarev@MacBook-Air-Yurii ~ % ssh otus@192.168.65.210
otus@192.168.65.210's password: 
/usr/local/bin/login.sh failed: exit code 1
Connection closed by 192.168.65.210 port 22
ypushkarev@MacBook-Air-Yurii ~ % ssh otusadm@192.168.65.210
otusadm@192.168.65.210's password: 
Welcome to Ubuntu 24.04 LTS (GNU/Linux 6.8.0-31-generic aarch64)
...

- Поменяем дату на будний день и проверим доступ
```
root@PAM:~# sudo date -s '2024/06/10 18:15'
Mon Jun 10 06:15:00 PM UTC 2024
...
@MacBook-Air-Yurii ~ % sudo date 061018152024.00
Password:
Mon Jun 10 18:15:00 MSK 2024
ypushkarev@MacBook-Air-Yurii ~ % ssh otus@192.168.65.210   
otus@192.168.65.210's password: 
Welcome to Ubuntu 24.04 LTS (GNU/Linux 6.8.0-31-generic aarch64)

```
