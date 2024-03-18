#Автоматизация администрирования. Ansible
Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, тестовая vm Debian 12 ARM Vagrantfile и все остальные конфигурационные файл добавлен в репозитроий lab_otus/Ansible
- Поднял хост с помощью Vagrantfile и проверил доступ по ssh
#vagrant up
- C помощью команды vagrant ssh-config посмотрел необходимые параметры
#Ansible % vagrant ssh-config
Host nginx
  HostName 127.0.0.1
  User vagrant
  Port 2222
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile .vagrant/machines/nginx/vmware_desktop/private_key
  IdentitiesOnly yes
  LogLevel FATAL
  PubkeyAcceptedKeyTypes +ssh-rsa
  HostKeyAlgorithms +ssh-rsa

- Создал inventory файл ./staging/hosts
  Ansible %cat ./staging/hosts и  ./ansible.cfg со следующим содержимым
nginx ansible_host=127.0.0.1 ansible_port=2222 ansible_private_key_file=.vagrant/machines/nginx/vmware_desktop/private_key
