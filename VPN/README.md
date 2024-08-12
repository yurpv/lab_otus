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

### Далее необходимо замерить скорость в туннеле:

- на openvpn сервере запускаем iperf3 в режиме сервера

```
root@server:~# iperf3 -s &
[1] 3062
root@server:~# -----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.10.10.2, port 34568
[  5] local 10.10.10.1 port 5201 connected to 10.10.10.2 port 34584
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  30.8 MBytes   258 Mbits/sec                  
[  5]   1.00-2.00   sec  34.7 MBytes   291 Mbits/sec                  
[  5]   2.00-3.00   sec  34.7 MBytes   291 Mbits/sec                  
[  5]   3.00-4.00   sec  33.2 MBytes   278 Mbits/sec                  
[  5]   4.00-5.00   sec  30.8 MBytes   258 Mbits/sec                  
[  5]   5.00-6.00   sec  32.8 MBytes   275 Mbits/sec                  
[  5]   6.00-7.00   sec  34.3 MBytes   287 Mbits/sec                  
[  5]   7.00-8.00   sec  34.9 MBytes   293 Mbits/sec                  
[  5]   8.00-9.00   sec  34.9 MBytes   293 Mbits/sec                  
[  5]   9.00-10.00  sec  32.2 MBytes   270 Mbits/sec                  
[  5]  10.00-11.00  sec  33.0 MBytes   277 Mbits/sec                  
[  5]  11.00-12.00  sec  34.3 MBytes   288 Mbits/sec                  
[  5]  13.00-14.00  sec  32.3 MBytes   271 Mbits/sec                  
[  5]  14.00-15.00  sec  30.7 MBytes   257 Mbits/sec                  
[  5]  14.00-15.00  sec  30.7 MBytes   257 Mbits/sec                  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-15.00  sec   521 MBytes   292 Mbits/sec                  receiver
iperf3: the client has terminated
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
```

- на openvpn клиенте запускаем iperf3 в режиме клиента и замеряем скорость в туннеле

```
root@client:~# iperf3 -c 10.10.10.1 -t 40 -i 5
Connecting to host 10.10.10.1, port 5201
[  5] local 10.10.10.2 port 34584 connected to 10.10.10.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-5.00   sec   169 MBytes   283 Mbits/sec  194    264 KBytes       
[  5]   5.00-10.00  sec   169 MBytes   283 Mbits/sec   21    448 KBytes       
[  5]  10.00-15.00  sec   165 MBytes   277 Mbits/sec   55    276 KBytes       
[  5]  15.00-15.66  sec  22.5 MBytes   285 Mbits/sec    0    281 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-15.66  sec   525 MBytes   281 Mbits/sec  270             sender
[  5]   0.00-15.66  sec  0.00 Bytes  0.00 bits/sec                  receiver
iperf3: interrupt - the client has terminated
```


