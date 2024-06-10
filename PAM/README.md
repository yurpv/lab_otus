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
