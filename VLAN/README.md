# VPN
Для лабораторных работ использую Dell amd64, система виртуализации Virtualbox, при выполнении лабораторной работы использовал скаченый образ vagrantbox generic/centos8 и bento/ubuntu-22.04,</br>
загруженны с app.vagrantup.com и добавлены vagrant box add generic/centos8 centos-vagrant-8.box и vagrant box add bento/ubuntu-22.04 vagrant.box

## Цели домашнего задания
Научиться настраивать VLAN и LACP. 

## Описание домашнего задания
в Office1 в тестовой подсети появляется сервера с доп интерфейсами и адресами
в internal сети testLAN: 
- testClient1 - 10.10.10.254
- testClient2 - 10.10.10.254
- testServer1- 10.10.10.1 
- testServer2- 10.10.10.1

Равести вланами:
testClient1 <-> testServer1
testClient2 <-> testServer2

Между centralRouter и inetRouter "пробросить" 2 линка (общая inernal сеть) и объединить их в бонд, проверить работу c отключением интерфейсов

Формат сдачи ДЗ - vagrant + ansible

### Предварительная настройка хостов

- Перед настройкой VLAN и LACP рекомендуется установить на хосты следующие утилиты:
```
vim
traceroute
tcpdump
net-tools
```

- Установка пакетов на CentOS 8 Stream: 
```
yum install -y vim traceroute tcpdump net-tools 
```

- Установка пакетов на Ubuntu 22.04:
```
apt install -y vim traceroute tcpdump net-tools 
```

## Настройка VLAN на хостах

### Настройка VLAN на RHEL-based системах:

- На хосте testClient1 требуется создать файл /etc/sysconfig/network-scripts/ifcfg-vlan1 со следующим параметрами:

[root@testClient1 /]# vi /etc/sysconfig/network-scripts/ifcfg-vlan1
[root@testClient1 /]# systemctl restart NetworkManager
[root@testClient1 /]# ip a 
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:7a:b7:00 brd ff:ff:ff:ff:ff:ff
    altname enp0s3
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic noprefixroute eth0
       valid_lft 86386sec preferred_lft 86386sec
    inet6 fe80::5054:ff:fe7a:b700/64 scope link 
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:88:e4:ae brd ff:ff:ff:ff:ff:ff
    altname enp0s8
    inet6 fe80::d32b:306f:f281:6120/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:3b:8b:4a brd ff:ff:ff:ff:ff:ff
    altname enp0s19
    inet 192.168.56.21/24 brd 192.168.56.255 scope global noprefixroute eth2
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe3b:8b4a/64 scope link 
       valid_lft forever preferred_lft forever
5: eth1.1@eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 08:00:27:88:e4:ae brd ff:ff:ff:ff:ff:ff
    inet 10.10.10.254/24 brd 10.10.10.255 scope global noprefixroute eth1.1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe88:e4ae/64 scope link 
       valid_lft forever preferred_lft forever
[root@testClient1 /]#  ping 10.10.10.254
PING 10.10.10.254 (10.10.10.254) 56(84) bytes of data.
64 bytes from 10.10.10.254: icmp_seq=1 ttl=64 time=0.021 ms
64 bytes from 10.10.10.254: icmp_seq=2 ttl=64 time=0.052 ms
64 bytes from 10.10.10.254: icmp_seq=3 ttl=64 time=0.027 ms
^C
--- 10.10.10.254 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2047ms
rtt min/avg/max/mdev = 0.021/0.033/0.052/0.014 ms
