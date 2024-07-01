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


![image](https://github.com/yurpv/lab_otus/assets/162872411/b8ec47cd-1ee9-4282-b340-2ba037b01d31)

![image](https://github.com/yurpv/lab_otus/assets/162872411/3c0ab7fe-ca4a-48c3-a592-83ac752a49a3)

![image](https://github.com/yurpv/lab_otus/assets/162872411/118b24f4-9940-45e4-82b7-b7d2f14a4c0f)

