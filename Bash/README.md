# BASH

*Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, тестовая vm Ubuntu 22.04 ARM LVM, Vagrantfile и все остальные конфигурационные файл добавлен в репозитроий lab_otus/BASH*

- ДЗ выполнил с помощью Vagrant и Ansible, конфигурационные файлы прилагаю.

- C помощью команды vagrant ssh-config посмотрел необходимые информацию:
```
% vagrant ssh-config
Host bash
  HostName 192.168.65.172
  User vagrant
  Port 22
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile /Users/ypushkarev/BASH/.vagrant/machines/bash/vmware_desktop/private_key
  IdentitiesOnly yes
  LogLevel FATAL
  PubkeyAcceptedKeyTypes +ssh-rsa
  HostKeyAlgorithms +ssh-rsa
```

- Проверил соединение с помощью Ansible
```
% ansible Bash -m ping -v  
Using /Users/ypushkarev/BASH/ansible.cfg as config file
Bash | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```

- Перед запуском ansible-playbook, необходимо предоставать права пользвоателю vagrant и выполняем команду vagrant reload:
```
sudo printf "vagrant ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
```

- После того как vm загрузится можно запускать наш playbook bash.yml:
```
% ansible-playbook bash.yml

PLAY [Bash | configure Bash] ***************************************************************************************************************************************************

TASK [update] ******************************************************************************************************************************************************************
changed: [Bash]

TASK [Install the package "mailutils"] *****************************************************************************************************************************************
ok: [Bash]

TASK [create folder] ***********************************************************************************************************************************************************
changed: [Bash]

TASK [Copy files in Ansible with different permissions] ************************************************************************************************************************
changed: [Bash] => (item={'src': 'templates/script.sh', 'dest': '/home/vagrant/scripts/script.sh'})
changed: [Bash] => (item={'src': 'templates/access.log', 'dest': '/home/vagrant/scripts/access.log'})

TASK [replace in spawn-fcgi files] *********************************************************************************************************************************************
changed: [Bash]

TASK [Run script the Cron Job] *************************************************************************************************************************************************
ok: [Bash]

PLAY RECAP *********************************************************************************************************************************************************************
Bash                       : ok=6    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 
```

- Выполним удаленную команду через ansible, проверим наличие задания в планировщике:
```
% ansible Bash -m shell -a 'sudo crontab -l'
Bash | CHANGED | rc=0 >>
#Ansible: Run script
* */30 * * * /home/vagrant/scripts/script.sh
```

- Через 30 минут сотрим почту, к нам должно прийти письмо от пользователя vagrant:
<img width="1234" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/a2f8dfe0-b299-46cb-bb30-7699738f8109">
<img width="514" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/439edb4f-ef7c-4d10-82bd-08dfd4ce62e0">
<img width="763" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/ff777be1-ece2-4250-8f74-fe6cde06f93e">


