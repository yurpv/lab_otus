# Файловые системы и LVM

*Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, тестовая vm Ubuntu 22.04 ARM LVM, Vagrantfile и все остальные конфигурационные файл добавлен в репозитроий lab_otus/LVM*

- Поднял хост с помощью Vagrantfile:

```
% vagrant up
```

- C помощью команды vagrant ssh-config посмотрел необходимые информацию:

```
% vagrant ssh-config
Host lvm
  HostName 192.168.65.147
  User vagrant
  Port 22
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile .vagrant/machines/lvm/vmware_desktop/private_key
  IdentitiesOnly yes
  LogLevel FATAL
  PubkeyAcceptedKeyTypes +ssh-rsa
  HostKeyAlgorithms +ssh-rsa
```

- Далее зашел по ssh на vm, авторизировался sudo su, добавил в файл /etc/sudoers доп параметры:
```
sudo su
printf "vagrant ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
```

- После выключил vm:
```
% vagrant halt
 и запустил с командой 
% vagrant reload
 vm запустилась с установленными компанентами
```

***Так как не нашел решения для добавления дисков через Vagrantfile для VMware Fusion, пришлось сделал это руками.
 ![image](https://github.com/yurpv/lab_otus/assets/162872411/02646b0e-c385-480d-a553-498dd58aac0e)***


