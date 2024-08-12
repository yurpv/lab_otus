# VPN
Для лабораторных работ использую Dell amd64, система виртуализации Virtualbox, при выполнении лабораторной работы использовал скаченый образ vagrantbox bento/ubuntu-22.04.

## Цели домашнего задания

Создать домашнюю сетевую лабораторию. Научится настраивать VPN-сервер в Linux-based системах.

## Описание домашнего задания
- Настроить VPN между двумя ВМ в tun/tap режимах, замерить скорость в туннелях, сделать вывод об отличающихся показателях
- Поднять RAS на базе OpenVPN с клиентскими сертификатами, подключиться с локальной машины на ВМ
- (*) Самостоятельно изучить и настроить ocserv, подключиться с хоста к ВМ

## TUN/TAP режимы VPN

### Для выполнения первого пункта необходимо написать Vagrantfile, который будет поднимать 2 виртуальные машины server и client

Типовой Vagrantfile для данной задачи:

```
Vagrant.configure("2") do |config|
config.vm.box = "bento/ubuntu-22.04"
config.vm.define "server" do |server|
server.vm.hostname = "server.loc"
  	server.vm.network "private_network", ip: "192.168.56.10"
end
config.vm.define "client" do |client|
client.vm.hostname = "client.loc"
client.vm.network "private_network", ip: "192.168.56.20"
end
end
```

> Можно использовать готовый playbook, который раскатает сервер и клиент OpenVPN дополнив наш Vagrantfile

```bash
    config.vm.provision "ansible" do |ansible|
        ansible.playbook = "playbook.yml"
        ansible.become = true
        ansible.limit = "all"
        ansible.host_key_checking = "false"
    end  
```

### После запуска машин из Vagrantfile выполняем следующие действия на server и client машинах

- Устанавливаем нужные пакеты и отключаем SELinux
```
apt update
apt install openvpn iperf3 selinux-utils
setenforce 0
```

### Настройка openvpn сервера

- Cоздаем файл-ключ 
```
openvpn --genkey secret /etc/openvpn/static.key
```

- Cоздаем конфигурационный файл OpenVPN 
```
vim /etc/openvpn/server.conf
```

- Содержимое файла server.conf
```
dev tap 
ifconfig 10.10.10.1 255.255.255.0 
topology subnet 
secret /etc/openvpn/static.key 
comp-lzo 
status /var/log/openvpn-status.log 
log /var/log/openvpn.log  
verb 3 
```
 
- Создаем service unit для запуска OpenVPN
 ```
vim /etc/systemd/system/openvpn@.service
```

- Содержимое файла-юнита
```
[Unit] 
Description=OpenVPN Tunneling Application On %I 
After=network.target 
[Service] 
Type=notify 
PrivateTmp=true 
ExecStart=/usr/sbin/openvpn --cd /etc/openvpn/ --config %i.conf 
[Install] 
WantedBy=multi-user.target
```

- Запускаем сервис 
```
systemctl start openvpn@server 
systemctl enable openvpn@server
```
### Настройка openvpn клиента

- Cоздаем конфигурационный файл OpenVPN 
```
vim /etc/openvpn/server.conf
```

- Содержимое конфигурационного файла  
```
dev tap 
remote 192.168.56.10 
ifconfig 10.10.10.2 255.255.255.0 
topology subnet 
route 192.168.56.0 255.255.255.0 
secret /etc/openvpn/static.key
comp-lzo
status /var/log/openvpn-status.log 
log /var/log/openvpn.log 
verb 3 
```

- На хост 2 в директорию /etc/openvpn необходимо скопировать файл-ключ static.key, который был создан на хосте 1.  

- Создаем service unit для запуска OpenVPN
```
vim /etc/systemd/system/openvpn@.service
```
- Содержимое файла-юнита
```
[Unit] 
Description=OpenVPN Tunneling Application On %I 
After=network.target 
[Service] 
Type=notify 
PrivateTmp=true 
ExecStart=/usr/sbin/openvpn --cd /etc/openvpn/ --config %i.conf 
[Install] 
WantedBy=multi-user.target
```
- Запускаем сервис
```
systemctl start openvpn@server 
systemctl enable openvpn@server
```

