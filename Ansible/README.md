**Автоматизация администрирования. Ansible**
# Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, тестовая vm Debian 12 ARM, Vagrantfile и все остальные конфигурационные файл добавлен в репозитроий lab_otus/Ansible

- Поднял хост с помощью Vagrantfile и проверил доступ по ssh
```
#vagrant up
```

- C помощью команды vagrant ssh-config посмотрел необходимые параметры
```
vagrant ssh-config
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
```

- Создал inventory файл ./staging/hosts ./ansible.cfg со следующим содержимым
```
cat ./staging/hosts 
nginx ansible_host=127.0.0.1 ansible_port=2222 ansible_private_key_file=.vagrant/machines/nginx/vmware_desktop/private_key
и
cat ./ansible.cfg
[defaults]
inventory = ./staging/hosts
remote_user = vagrant
host_key_checking = False
retry_files_enabled = False
```

- Проверяем, что можем управлять хостом
```
ansible nginx -m ping      
nginx | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```

- Смотрим какое ядро установлено на хосте
```
ansible nginx -m command -a "uname -r"
nginx | CHANGED | rc=0 >>
6.1.0-18-arm64
```

- Проверим статус сервиса firewalld
```
ansible nginx -m systemd -a name=firewalld
nginx | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "name": "firewalld",
    "status": {
        "ActiveEnterTimestampMonotonic": "0",
        "ActiveExitTimestampMonotonic": "0",
        "ActiveState": "inactive",
```

- Запускаем созданный нами файл nginx.yml
```
ansible-playbook nginx.yml

PLAY [NGINX | Install and configure NGINX] *************************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************************************
ok: [nginx]

TASK [update] ******************************************************************************************************************************************************************
changed: [nginx]

TASK [NGINX | Install NGINX] ***************************************************************************************************************************************************
ok: [nginx]

TASK [NGINX | Create NGINX config file from template] **************************************************************************************************************************
ok: [nginx]

PLAY RECAP *********************************************************************************************************************************************************************
nginx                      : ok=4    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

- Проверяем проверяем как прошла установка
```
curl http://192.168.227.136:8080
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```
