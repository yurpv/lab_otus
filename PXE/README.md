# Отработать навыки установки и настройки DHCP, TFTP, PXE загрузчика и автоматической загрузки
Для лабораторных работ использую Dell amd64, система виртуализации Virtualbox, при выполнении лабораторной работы использовал скаченый образ vagrantbox generic/ubuntu2204.
## Цель домашнего задания
Отработать навыки установки и настройки DHCP, TFTP, PXE загрузчика и автоматической загрузки

### Описание домашнего задания

- Настроить загрузку по сети дистрибутива Ubuntu 24
-  Установка должна проходить из HTTP-репозитория.
-  Настроить автоматическую установку c помощью файла user-data
-  Настроить автоматическую загрузку по сети дистрибутива Ubuntu 24 c использованием UEFI
-  Задания со звёздочкой выполняются по желанию
Формат сдачи ДЗ: vagrant + ansible

### Домашняя работа  

### 1. Разворот хостов и настройка загрузки по сети

Подготовим Vagrantfile в котором будут описаны 2 виртуальные машины:
- pxeserver (хост к которому будут обращаться клиенты для установки ОС)
- pxeclient (хост, на котором будет проводиться установка)
```
Vagrant.configure("2") do |config|

  config.vm.define "pxeserver" do |server|
    server.vm.box = 'bento/ubuntu-22.04'
    server.vm.host_name = 'pxeserver'
    server.vm.network "forwarded_port", guest: 80, host: 8080
    server.vm.network :private_network, ip: "10.0.0.20", virtualbox__intnet: 'pxenet'
    server.vm.network :private_network, ip: "192.168.56.10", adapter: 3
    server.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.customize ["modifyvm", :id,"--natdnshostresolver1", "on"]
    end
    #server.vm.provision "ansible" do |ansible|
    #ansible.playbook = "ansible/provision.yml"
    #ansible.inventory_path = "ansible/hosts"
    #ansible.host_key_checking = "false"
    #ansible.limit = "all"
    #end
  end
  config.vm.define "pxeclient" do |pxeclient|
    pxeclient.vm.box = 'bento/ubuntu-22.04'
    #pxeclient.vm.box = 'seskion/ubuntu-20.04-efi'
      pxeclient.vm.host_name = 'pxeclient'
    pxeclient.vm.network :private_network, ip: "192.168.56.20"
    pxeclient.vm.provider :virtualbox do |vb|
      vb.memory = "4096"
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize [
          'modifyvm', :id,
          '--nic1', 'intnet',
          '--intnet1', 'pxenet',
          '--nic2', 'nat',
          '--boot1', 'net',
          '--boot2', 'none',
          '--boot3', 'none',
          '--boot4', 'none'
        ]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end
  end
end
```

> В методичке будет указано только как настроить PXE Server через терминал, настройка с помощью Ansible выполняется студентом самостоятельно. </br>
После внесения всех изменений запускаем наш стенд с помощью команды vagrant up. </br>
Вся настройка будет происходить от root пользователя. Для того, чтобы зайти в root пользователя используем команду sudo -i

1. Настройка DHCP и TFTP-сервера
Для того, чтобы наш клиент мог получить ip-адрес нам требуется DHCP-сервер, чтобы можно было получить
файл pxelinux.0 нам потребуется TFTP-сервер. Утилита dnsmasq совмещает в себе сразу и DHCP и TFTP-
сервер:
1. Отключаем firewall:
```
root@pxeserver:~# systemctl stop ufw
root@pxeserver:~# systemctl disable ufw
Synchronizing state of ufw.service with SysV service script with /lib/systemd/systemd-sysv-install.
Executing: /lib/systemd/systemd-sysv-install disable ufw
```

2. Обновляем кэш и устанавливаем утилиту dnsmasq
```
root@pxeserver:~# sudo apt update
root@pxeserver:~# sudo apt install dnsmasq
```
3. Создаём файл /etc/dnsmasq.d/pxe.conf и добавляем в него следующее содержимое vim /etc/dnsmasq.d/pxe.conf

> Указываем интерфейс в на котором будет работать DHCP/TFTP
```
interface=eth1
bind-interfaces
```

> Также указаваем интерфейс и range адресов которые будут выдаваться по DHCP
```
dhcp-range=eth1,10.0.0.100,10.0.0.120
```

> Имя файла, с которого надо начинать загрузку для Legacy boot (этот пример рассматривается в методичке)
```
dhcp-boot=pxelinux.0
```

> Имена файлов, для UEFI-загрузки (не обязательно добавлять)
```
dhcp-match=set:efi-x86_64,option:client-arch,7
dhcp-boot=tag:efi-x86_64,bootx64.efi
#Включаем TFTP-сервер
enable-tftp
```

> Указываем каталог для TFTP-сервера
```
tftp-root=/srv/tftp/amd64
```

4. Создаём каталоги для файлов TFTP-сервера
```
mkdir -p /srv/tftp
```

5. Скачиваем файлы для сетевой установки Ubuntu 24.04 и распаковываем их в каталог /srv/tftp
> С Официальной директории у меня не получилось полностью загрузить данные, использоваел зеркало яндекса </br>
wget https://mirror.yandex.ru/ubuntu-releases/noble/ubuntu-24.04-netboot-amd64.tar.gz
tar -xzvf ubuntu-24.04-netboot-amd64.tar.gz -C /srv/tftp


по итогу, в каталоге /srv/tftp/amd64 мы увидем вот такие файлы:
root@pxeserver:~# ls -la /srv/tftp/amd64
```
total 85268
drwxr-xr-x 4 root root     4096 Apr 23 09:46 .
drwxr-xr-x 3 root root     4096 Apr 23 09:46 ..
-rw-r--r-- 1 root root   966664 Apr  4 12:39 bootx64.efi
drwxr-xr-x 2 root root     4096 Apr 23 09:46 grub
-rw-r--r-- 1 root root  2340744 Apr  4 10:24 grubx64.efi
-rw-r--r-- 1 root root 68889068 Apr 23 09:46 initrd
-rw-r--r-- 1 root root   118676 Apr  8 16:20 ldlinux.c32
-rw-r--r-- 1 root root 14928264 Apr 23 09:46 linux
-rw-r--r-- 1 root root    42392 Apr  8 16:20 pxelinux.0
drwxr-xr-x 2 root root     4096 Apr 23 09:46 pxelinux.cfg
2 directories, 8 files
```

6. Перезапускаем службу dnsmasq
root@pxeserver:~# systemctl restart dnsmasq

### Настройка Web-сервера

Для того, чтобы отдавать файлы по HTTP нам потребуется настроенный веб-сервер.
1. Устанавливаем Web-сервер apache2
```
root@pxeserver:~# apt install apache2
root@pxeserver:~# systemctl status apache2
● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2024-07-01 22:19:37 UTC; 8h ago
       Docs: https://httpd.apache.org/docs/2.4/
   Main PID: 13229 (apache2)
      Tasks: 55 (limit: 1011)
     Memory: 4.9M
        CPU: 1.469s
     CGroup: /system.slice/apache2.service
             ├─13229 /usr/sbin/apache2 -k start
             ├─13230 /usr/sbin/apache2 -k start
             └─13231 /usr/sbin/apache2 -k start
```

2. Создаём каталог /srv/images в котором будут храниться iso-образы для установки по сети:
```
root@pxeserver:~# mkdir /srv/images
```

3. Переходим в каталог /srv/images и скачиваем iso-образ ubuntu 24.04
```
root@pxeserver:~# cd /srv/images
root@pxeserver:~# wget https://mirror.yandex.ru/ubuntu-releases/noble/ubuntu-24.04-live-server-amd64.iso
```

4. Создаём файл /etc/apache2/sites-available/ks-server.conf и добавлем в него следующее содержимое
```
root@pxeserver:~# vi /etc/apache2/sites-available/ks-server.conf
```

> Указываем IP-адрес хоста и порт на котором будет работать Web-сервер
```
<VirtualHost 10.0.0.20:80>
DocumentRoot /
```

> Указываем директорию /srv/images из которой будет загружаться iso-образ
```
<Directory /srv/images>
Options Indexes MultiViews
AllowOverride All
Require all granted
</Directory>
</VirtualHost>
```

5. Активируем конфигурацию ks-server в apache
```
root@pxeserver:~# a2ensite ks-server.conf
```

6. Вносим изменения в файл /srv/tftp/amd64/pxelinux.cfg/default
```
root@pxeserver:~# vi /srv/tftp/amd64/pxelinux.cfg/default
DEFAULT install
LABEL install
KERNEL linux
INITRD initrd
APPEND root=/dev/ram0 ramdisk_size=3000000 ip=dhcp iso-url=http://10.0.0.20/srv/images/ubuntu-24.04-live-server-amd64.iso autoinstall
```
> В данном файле мы указываем что файлы linux и initrd будут забираться по tftp, а сам iso-образ ubuntu 24.04
будет скачиваться из нашего веб-сервера http://10.0.0.20/srv/images/ubuntu-24.04-live-server-amd64.iso
Из-за того, что образ достаточно большой (2.6G) и он сначала загружается в ОЗУ, необходимо указать
размер ОЗУ до 3 гигабайт (root=/dev/ram0 ramdisk_size=3000000)

7. Перезагружаем web-сервер apache
```
root@pxeserver:~# systemctl restart apache2
```

На этом настройка Web-сервера завершена и на данный момент, если мы запустим ВМ pxeclient, то увидим
загрузку по PXE
и далее увидим загрузку iso-образа
и откроется мастер установки ubuntuТак как на хосте pxeclient используется 2 сетевых карты, загрузка может начаться с неправильного
адреса, тогда мы получим вот такое сообщение
В данной ситуации поможет перезапуск виртуальной машины с помощью VirtualBox, либо её удаление и
повторная инициализация с помощью команды vagrant up

### Настройка автоматической установки Ubuntu 24.04

Осталось автоматизировать установку ubuntu 24 (чтобы не пользоваться мастером установки вручную)
1. Создаём каталог для файлов с автоматической установкой
```
root@pxeserver:~# mkdir /srv/ks
```

2. Создаём файл /srv/ks/user-data и добавляем в него следующее содержимоеvim /srv/ks/user-data
```
root@pxeserver:~# vi /srv/ks/user-data
#cloud-config
autoinstall:
apt:
disable_components: []
geoip: true
preserve_sources_list: false
primary:
- arches:
- amd64
- i386
uri: http://us.archive.ubuntu.com/ubuntu
- arches:
- default
uri: http://ports.ubuntu.com/ubuntu-ports
drivers:
install: false
identity:
hostname: linux
password: $6$sJgo6Hg5zXBwkkI8$btrEoWAb5FxKhajagWR49XM4EAOfO/
Dr5bMrLOkGe3KkMYdsh7T3MU5mYwY2TIMJpVKckAwnZFs2ltUJ1abOZ.
realname: otus
username: otus
kernel:
package: linux-generic
keyboard:
layout: us
toggle: null
variant: ''
locale: en_US.UTF-8
network:
ethernets:
enp0s3:
dhcp4: true
enp0s8:
dhcp4: true
version: 2
ssh:
allow-pw: true
authorized-keys: []
install-server: true
updates: security
version: 1
```

> В данном файле указываются следующие настройки:</br>
• устанавливается apt-репозиторий http://us.archive.ubuntu.com/ubuntu</br>
• отключена автоматическая загрузка драйверов</br>
• задаётся hostname linux</br>
• создаётся пользователь otus c паролем 123 (пароль зашифрован в SHA512)</br>
• использование английской раскладки</br>
• добавлена настройка получения адресов по DHCP (для обоих портов)</br>
• устанавливается openssh-сервер с доступом по логину и паролю</br>
• и т д.

3. создаём файл с метаданными /srv/ks/meta-data</br>
```
root@pxeserver:~#  touch /srv/ks/meta-data
```
> Файл с метаданными хранит дополнительную информацию о хосте, в нашей методичке мы не будем
добавлять дополнительную информацю

4. В конфигурации веб-сервера добавим каталог /srv/ks идёнтично каталогу /srv/images
```
root@pxeserver:~# vi /etc/apache2/sites-available/ks-server.conf
<VirtualHost 10.0.0.20:80>
DocumentRoot /
<Directory /srv/ks>
Options Indexes MultiViews
AllowOverride All
Require all granted
</Directory>
<Directory /srv/images>
Options Indexes MultiViews
AllowOverride All
Require all granted
</Directory>
```

5. В файле /srv/tftp/amd64/pxelinux.cfg/default добавляем параметры автоматической установки
```
vim /srv/tftp/amd64/pxelinux.cfg/default
DEFAULT install
LABEL install
KERNEL linux
INITRD initrd
APPEND root=/dev/ram0 ramdisk_size=3000000 ip=dhcp iso-url=http://10.0.0.20/srv/images/ubuntu-24.04-live-server-amd64.iso autoinstall ds=nocloud-net;s=http://10.0.0.20/srv/ks/
```

6. Перезапускаем службы dnsmasq и apache2
```
root@pxeserver:~#  systemctl restart dnsmasq
root@pxeserver:~#  systemctl restart apache2
```

На этом настройка автоматической установки завершена. Теперь можно перезапустить ВМ pxeclient
```
root@pxeserver:~# vagrant up pxeclient
```
и мы должны увидеть автоматическую установку
После успешной установки выключаем ВМ и в её настройках ставим запуск ВМ из диска Далее, после запуска нашей ВМ мы сможем залогиниться под пользователем otus
На этом настройка автоматической установки завершена

![image](https://github.com/yurpv/lab_otus/assets/162872411/b8ec47cd-1ee9-4282-b340-2ba037b01d31)

![image](https://github.com/yurpv/lab_otus/assets/162872411/118b24f4-9940-45e4-82b7-b7d2f14a4c0f)

