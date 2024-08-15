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


