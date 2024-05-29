Стенд Vagrant с NFS 
Цель домашнего задания
Научиться самостоятельно разворачивать сервис NFS и подключать к нему клиентов.
Описание домашнего задания 
Основная часть: 
vagrant up должен поднимать 2 настроенных виртуальных машины (сервер NFS и клиента) без дополнительных ручных действий;
на сервере NFS должна быть подготовлена и экспортирована директория; 
в экспортированной директории должна быть поддиректория с именем upload с правами на запись в неё; 
экспортированная директория должна автоматически монтироваться на клиенте при старте виртуальной машины (systemd, autofs или fstab — любым способом);
монтирование и работа NFS на клиенте должна быть организована с использованием NFSv3.
Для самостоятельной реализации: 
настроить аутентификацию через KERBEROS с использованием NFSv4.
Инструкция по выполнению домашнего задания
Требуется предварительно установленный и работоспособный Hashicorp Vagrant и Oracle VirtualBox.
Все дальнейшие действия были проверены при использовании Ubuntu 24.04 в качестве хостовой ОС, Vagrant 2.4.1, VirtualBox v7.0.18  и образа Ubuntu 22.04 v20240426.0.0 из Vagrant Cloud. Серьёзные отступления от этой конфигурации могут потребовать адаптации с вашей стороны.
Создаём тестовые виртуальные машины 
Для начала, предлагается использовать этот шаблон для создания виртуальных машин (код также доступен в репозитории): 
Vagrant.configure(2) do |config|
 config.vm.box = "ubuntu/jammy64"
 config.vm.provider "virtualbox" do |v|
   v.memory = 1024
   v.cpus = 1
 end


 config.vm.define "nfss" do |nfss|
   nfss.vm.network "private_network", ip: "192.168.50.10", virtualbox__intnet: "net1"
   nfss.vm.hostname = "nfss"
 end


 config.vm.define "nfsc" do |nfsc|
   nfsc.vm.network "private_network", ip: "192.168.50.11", virtualbox__intnet: "net1"
   nfsc.vm.hostname = "nfsc"
 end


end

Результатом выполнения команды `vagrant up` станут 2 виртуальных машины: nfss для сервера NFS и nfsc для клиента. 
Настраиваем сервер NFS 
Заходим на сервер:
vagrant ssh nfss

Дальнейшие действия выполняются от имени пользователя имеющего повышенные привилегии, разрешающие описанные действия. 
Установим сервер NFS:
root@nfss:/etc# apt install nfs-kernel-server

Настройки сервера находятся в файле /etc/nfs.conf 

Проверяем наличие слушающих портов 2049/udp, 2049/tcp,111/udp, 111/tcp (не все они будут использоваться далее,  но их наличие сигнализирует о том, что необходимые сервисы готовы принимать внешние подключения):
root@nfss:/etc# ss -tnplu 

Создаём и настраиваем директорию, которая будет экспортирована в будущем 
root@nfss:/etc# mkdir -p /srv/share/upload 
root@nfss:/etc# chown -R nobody:nogroup /srv/share 
root@nfss:/etc# chmod 0777 /srv/share/upload 

Cоздаём в файле /etc/exports структуру, которая позволит экспортировать ранее созданную директорию:
root@nfss:/etc# cat << EOF > /etc/exports 
/srv/share 192.168.50.11/32(rw,sync,root_squash)
EOF

Экспортируем ранее созданную директорию:
root@nfss:/etc# exportfs -r 

Проверяем экспортированную директорию следующей командой
root@nfss:/etc# exportfs -s 

Вывод должен быть аналогичен этому: 

root@nfss:/etc# exportfs -s 
/srv/share  192.168.50.11/32(sync,wdelay,hide,no_subtree_check,sec=sys,rw,secure,root_squash,no_all_squash)
Настраиваем клиент NFS 
Заходим на сервер 
vagrant ssh nfsc 

Дальнейшие действия выполняются от имени пользователя имеющего повышенные привилегии, разрешающие описанные действия. 
Установим пакет с NFS-клиентом
root@nfsc:~# sudo apt install nfs-common

Добавляем в /etc/fstab строку 
root@nfsc:~# echo "192.168.50.10:/srv/share/ /mnt nfs vers=3,noauto,x-systemd.automount 0 0" >> /etc/fstab

и выполняем команды:
root@nfsc:~# systemctl daemon-reload 
root@nfsc:~# systemctl restart remote-fs.target 

Отметим, что в данном случае происходит автоматическая генерация systemd units в каталоге /run/systemd/generator/, которые производят монтирование при первом обращении к каталогу /mnt/.
Заходим в директорию /mnt/ и проверяем успешность монтирования:
root@nfsc:~# mount | grep mnt 

При успехе вывод должен примерно соответствовать этому:
[root@nfsc mnt]# mount | grep mnt 
systemd-1 on /mnt type autofs (rw,relatime,fd=46,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=46033)
192.168.50.10:/srv/share/ on /mnt type nfs (rw,relatime,vers=3,rsize=131072,wsize=131072,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=192.168.50.10,mountvers=3,mountport=50749,mountproto=udp,local_lock=none,addr=192.168.50.10)

Обратите внимание на `vers=3`, что соответствует NFSv3, как того требует задание.
Проверка работоспособности 
Заходим на сервер. 
Заходим в каталог /srv/share/upload.
Создаём тестовый файл touch check_file.
Заходим на клиент.
Заходим в каталог /mnt/upload. 
Проверяем наличие ранее созданного файла.
Создаём тестовый файл touch client_file. 
Проверяем, что файл успешно создан.

Если вышеуказанные проверки прошли успешно, это значит, что проблем с правами нет. 

Предварительно проверяем клиент: 
перезагружаем клиент;
заходим на клиент;
заходим в каталог /mnt/upload;
проверяем наличие ранее созданных файлов.

Проверяем сервер: 
заходим на сервер в отдельном окне терминала;
перезагружаем сервер;
заходим на сервер;
проверяем наличие файлов в каталоге /srv/share/upload/;
проверяем экспорты exportfs -s;
