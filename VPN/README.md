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

## RAS на базе OpenVPN

- Для выполнения данного задания можно восполязоваться Vagrantfile из 1 задания, только убрать 1 ВМ.

- После запуска ВМ отключаем SELinux или создаём правило для него

### Настройка сервера: 

- Устанавливаем необходимые пакеты 
```
apt update
apt install openvpn easy-rsa
```

-  Переходим в директорию /etc/openvpn и инициализируем PKI
```
root@server:~# cd /etc/openvpn
/usr/share/easy-rsa/easyrsa init-pki

init-pki complete; you may now create a CA or requests.
Your newly created PKI dir is: /etc/openvpn/pki
```

- Генерируем необходимые ключи и сертификаты для сервера 
```
root@server:/etc/openvpn# echo 'rasvpn' | /usr/share/easy-rsa/easyrsa build-ca nopass
Using SSL: openssl OpenSSL 3.0.2 15 Mar 2022 (Library: OpenSSL 3.0.2 15 Mar 2022)
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Common Name (eg: your user, host, or server name) [Easy-RSA CA]:
CA creation complete and you may now import and sign cert requests.
Your new CA certificate file for publishing is at:
/etc/openvpn/pki/ca.crt
```
```
root@server:/etc/openvpn# echo 'rasvpn' | /usr/share/easy-rsa/easyrsa gen-req server nopass
Using SSL: openssl OpenSSL 3.0.2 15 Mar 2022 (Library: OpenSSL 3.0.2 15 Mar 2022)
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Common Name (eg: your user, host, or server name) [server]:
Keypair and certificate request completed. Your files are:
req: /etc/openvpn/pki/reqs/server.req
key: /etc/openvpn/pki/private/server.key
```
```
root@server:/etc/openvpn# echo 'yes' | /usr/share/easy-rsa/easyrsa sign-req server server 
Using SSL: openssl OpenSSL 3.0.2 15 Mar 2022 (Library: OpenSSL 3.0.2 15 Mar 2022)


You are about to sign the following certificate.
Please check over the details shown below for accuracy. Note that this request
has not been cryptographically verified. Please be sure it came from a trusted
source or that you have verified the request checksum with the sender.

Request subject, to be signed as a server certificate for 825 days:

subject=
    commonName                = rasvpn


Type the word 'yes' to continue, or any other input to abort.
  Confirm request details: Using configuration from /etc/openvpn/pki/easy-rsa-2534.ZvxrYm/tmp.fwSbGd
4047D073407F0000:error:0700006C:configuration file routines:NCONF_get_string:no value:../crypto/conf/conf_lib.c:315:group=<NULL> name=unique_subject
Check that the request matches the signature
Signature ok
The Subject's Distinguished Name is as follows
commonName            :ASN.1 12:'rasvpn'
Certificate is to be certified until Nov 15 09:19:21 2026 GMT (825 days)

Write out database with 1 new entries
Data Base Updated

Certificate created at: /etc/openvpn/pki/issued/server.crt
```
```
root@server:/etc/openvpn# /usr/share/easy-rsa/easyrsa gen-dh/usr/share/easy-rsa/easyrsa gen-dh^C
root@server:/etc/openvpn# /usr/share/easy-rsa/easyrsa gen-dh
Using SSL: openssl OpenSSL 3.0.2 15 Mar 2022 (Library: OpenSSL 3.0.2 15 Mar 2022)
Generating DH parameters, 2048 bit long safe prime
...............................................+.......+......................................................................................................................................................
+*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*++*

DH parameters of size 2048 created at /etc/openvpn/pki/dh.pem
```
```
root@server:/etc/openvpn# openvpn --genkey secret ca.key
```
# Генерируем необходимые ключи и сертификаты для клиента
echo 'client' | /usr/share/easy-rsa/easyrsa gen-req client nopass
echo 'yes' | /usr/share/easy-rsa/easyrsa sign-req client client

# Создаем конфигурационный файл сервера 
vim /etc/openvpn/server.conf

# Зададим параметр iroute для клиента
echo 'iroute 10.10.10.0 255.255.255.0' > /etc/openvpn/client/client

# Содержимое файла server.conf
port 1207 
proto udp 
dev tun 
ca /etc/openvpn/pki/ca.crt 
cert /etc/openvpn/pki/issued/server.crt 
key /etc/openvpn/pki/private/server.key 
dh /etc/openvpn/pki/dh.pem 
server 10.10.10.0 255.255.255.0 
ifconfig-pool-persist ipp.txt 
client-to-client 
client-config-dir /etc/openvpn/client 
keepalive 10 120 
comp-lzo 
persist-key 
persist-tun 
status /var/log/openvpn-status.log 
log /var/log/openvpn.log 
verb 3


# Запускаем сервис (при необходимости создать файл юнита как в задании 1) 
systemctl start openvpn@server
systemctl enable openvpn@server


На хост-машине: 

1) Необходимо создать файл client.conf со следующим содержимым: 
	dev tun 
proto udp 
remote 192.168.56.10 1207 
client 
resolv-retry infinite 
remote-cert-tls server 
ca ./ca.crt 
cert ./client.crt 
key ./client.key 
route 192.168.56.0 255.255.255.0 
persist-key 
persist-tun 
comp-lzo 
verb 3 
2) Скопировать в одну директорию с client.conf файлы с сервера:     	   
/etc/openvpn/pki/ca.crt 
/etc/openvpn/pki/issued/client.crt 
/etc/openvpn/pki/private/client.key

Далее можно проверить подключение с помощью: openvpn --config client.conf

При успешном подключении проверяем пинг по внутреннему IP адресу  сервера в туннеле: ping -c 4 10.10.10.1 

Также проверяем командой ip r (netstat -rn) на хостовой машине что сеть туннеля импортирована в таблицу маршрутизации. 
