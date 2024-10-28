# Проектная работа
## Инфраструктура для проекта на Nextcloud

Для лабораторных работ использую Macbook Air M2 чипсет amr64, OS Sonoma 14.6.1, система виртуализации VMware Fusion, при выполнении лабораторной работы использовал образ vagrantbox bento/ubuntu-22.04.

## Требования:

Web-проект с развертыванием нескольких виртуальных машин отвечает следующим требованиям:
* включен https;
* основная инфраструктура в DMZ зоне;
* Firewall на входе;
* настроен сбор метрик и алертинг;
* везде выключен selinux;
* организован централизованный сбор логов.


## Проект

Схема стенда

![image](https://github.com/user-attachments/assets/0438cabf-12c8-438a-ad95-a148d620db4d)



### Состав проекта

- 10 хостов. 
- Метод развертывания: Vagrant, Ansible.
- На хостах включен Firewall (UFW).
- Настроены необходимые службы и порты.
- На хостах выключен SELinux:
- Настроены необходимые контексты.
- Все хосты выходят из локальной сети через хост Router.
- Для мониторинга настроен Prometheus + Alertmanager, для оповещения используется telegam
- За визуализацию отвечает Grafana
- Централизованный сбор логов настроен с помощью Rsyslog



### Хосты

Name | IP адрес
------| ---------
Router | 192.168.255.10
Ngix| 192.168.255.11
WEB | 192.168.255.20
WEB2 | 192.168.255.21
NFS | 192.168.255.22
Postgresql (MASTER) | 192.168.255.30
Postgresql (SLAVE) | 192.168.255.31
Backup  | 192.168.255.40
Server log (Syslog) | 192.168.255.50
Monitoring (Srvmon) | 192.168.255.60


Для разворачивания стенда выполняем `vagrant up`. Для разворачивания хостов подготовлен Ansible playbook. В playbook ипортируются роли, каждая роль разворачивает определенный сервис.
├── Vagrantfile
├── ansible-role-confluence
│   ├── CHANGELOG.md
│   ├── LICENSE
│   ├── README.md
│   ├── defaults
│   │   └── main.yml
│   ├── handlers
│   │   └── main.yml
│   ├── meta
│   │   ├── argument_specs.yml
│   │   └── main.yml
│   ├── molecule
│   │   └── default
│   │       ├── converge-with-postgresql.yml
│   │       ├── converge.yml
│   │       ├── molecule.yml
│   │       └── verify.yml
│   ├── requirements.yml
│   ├── tasks
│   │   ├── configure.yml
│   │   ├── install.yml
│   │   ├── main.yml
│   │   └── pre-install.yml
│   ├── templates
│   │   ├── confluence-init.properties.j2
│   │   ├── confluence.service.j2
│   │   ├── server.xml.j2
│   │   └── setenv.sh.j2
│   ├── tox-requirements.txt
│   ├── tox.ini
│   └── vars
│       └── main.yml
├── ansible.cfg
├── project.yaml
├── roles
│   ├── barman
│   │   ├── README.md
│   │   ├── defaults
│   │   │   └── main.yml
│   │   ├── files
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── meta
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   ├── install_nfscl.yml
│   │   │   ├── install_node_exporter.yml
│   │   │   ├── main.yml
│   │   │   ├── prepare.yml
│   │   │   ├── setting_barman.yml
│   │   │   ├── setting_crontab.yml
│   │   │   └── setting_ufw.yml
│   │   ├── templates
│   │   │   ├── 00-installer-config.yaml.j2
│   │   │   ├── 50-vagrant.yaml.j2
│   │   │   ├── all_log.conf
│   │   │   ├── barman.conf.j2
│   │   │   ├── copy_backup.sh.j2
│   │   │   ├── node_exporter.service.j2
│   │   │   └── psqlmaster.conf.j2
│   │   ├── tests
│   │   │   ├── inventory
│   │   │   └── test.yml
│   │   └── vars
│   │       └── main.yml
│   ├── nfs
│   │   ├── README.md
│   │   ├── defaults
│   │   │   └── main.yml
│   │   ├── files
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── meta
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   ├── install_nfssrv.yml
│   │   │   ├── install_node_exporter.yml
│   │   │   ├── main.yml
│   │   │   ├── prepare.yml
│   │   │   ├── setting_crontab.yml
│   │   │   └── setting_ufw.yml
│   │   ├── templates
│   │   │   ├── all_log.conf
│   │   │   ├── nfs_exports.j2
│   │   │   └── rsync_nextcloud_data.sh.j2
│   │   ├── tests
│   │   │   ├── inventory
│   │   │   └── test.yml
│   │   └── vars
│   │       └── main.yml
│   ├── nginx
│   │   ├── README.md
│   │   ├── defaults
│   │   │   └── main.yml
│   │   ├── files
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── meta
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   ├── install_nginx.yml
│   │   │   ├── install_node_exporter.yml
│   │   │   ├── install_ssl.yml
│   │   │   ├── main.yml
│   │   │   ├── prepare.yml
│   │   │   └── setting_ufw.yml
│   │   ├── templates
│   │   │   ├── 50-vagrant.yaml.j2
│   │   │   ├── all_log.conf
│   │   │   ├── backend.j2
│   │   │   ├── nginx.conf.j2
│   │   │   ├── node_exporter.service.j2
│   │   │   └── sysctl.conf.j2
│   │   ├── tests
│   │   │   ├── inventory
│   │   │   └── test.yml
│   │   └── vars
│   │       └── main.yml
│   ├── psqlmaster
│   │   ├── README.md
│   │   ├── defaults
│   │   │   └── main.yml
│   │   ├── files
│   │   │   └── postgres_exporter
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── meta
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   ├── install_node_exporter.yml
│   │   │   ├── install_pgsql_exporter.yml
│   │   │   ├── main.yml
│   │   │   ├── prepare.yml
│   │   │   ├── setting_posgresql.yml
│   │   │   └── setting_ufw.yml
│   │   ├── templates
│   │   │   ├── 00-installer-config.yaml.j2
│   │   │   ├── 50-vagrant.yaml.j2
│   │   │   ├── all_log.conf
│   │   │   ├── node_exporter.service.j2
│   │   │   ├── pg_hba_master.conf.j2
│   │   │   ├── pg_hba_master_temp.conf.j2
│   │   │   ├── postgres_exporter.conf.j2
│   │   │   ├── postgres_exporter.service.j2
│   │   │   └── postgresql_master.conf.j2
│   │   ├── tests
│   │   │   ├── inventory
│   │   │   └── test.yml
│   │   └── vars
│   │       └── main.yml
│   ├── psqlslave
│   │   ├── README.md
│   │   ├── defaults
│   │   │   └── main.yml
│   │   ├── files
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── meta
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   ├── install_node_exporter.yml
│   │   │   ├── install_pgsql_exporter.yml
│   │   │   ├── main.yml
│   │   │   ├── prepare.yml
│   │   │   ├── setting_posgresql.yml
│   │   │   └── setting_ufw.yml
│   │   ├── templates
│   │   │   ├── 00-installer-config.yaml.j2
│   │   │   ├── 50-vagrant.yaml.j2
│   │   │   ├── all_log.conf
│   │   │   ├── node_exporter.service.j2
│   │   │   ├── pg_hba_slave.conf.j2
│   │   │   ├── pg_hba_slave_temp.conf.j2
│   │   │   ├── postgres_exporter.j2
│   │   │   ├── postgres_exporter.service.j2
│   │   │   └── postgresql_slave.conf.j2
│   │   ├── tests
│   │   │   ├── inventory
│   │   │   └── test.yml
│   │   └── vars
│   │       └── main.yml
│   ├── router
│   │   ├── README.md
│   │   ├── defaults
│   │   │   └── main.yml
│   │   ├── files
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── meta
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   ├── install_dnsmasq.yml
│   │   │   ├── install_nginx.yml
│   │   │   ├── install_node_exporter.yml
│   │   │   ├── main.yml
│   │   │   ├── prepare.yml
│   │   │   └── setting_ufw.yml
│   │   ├── templates
│   │   │   ├── 50-vagrant.yaml.j2
│   │   │   ├── all_log.conf
│   │   │   ├── backend.j2
│   │   │   ├── dnsmasq_addresses.j2
│   │   │   ├── dnsmasq_cache.j2
│   │   │   ├── dnsmasq_forwards.j2
│   │   │   ├── dnsmasq_hosts.j2
│   │   │   ├── dnsmasq_logs.j2
│   │   │   ├── nginx.conf.j2
│   │   │   ├── node_exporter.service.j2
│   │   │   └── sysctl.conf.j2
│   │   ├── tests
│   │   │   ├── inventory
│   │   │   └── test.yml
│   │   └── vars
│   │       └── main.yml
│   ├── srvlog
│   │   ├── README.md
│   │   ├── defaults
│   │   │   └── main.yml
│   │   ├── files
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── meta
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   ├── install_node_exporter.yml
│   │   │   ├── main.yml
│   │   │   ├── prepare.yml
│   │   │   └── setting_ufw.yml
│   │   ├── templates
│   │   │   ├── 00-installer-config.yaml.j2
│   │   │   ├── 50-vagrant.yaml.j2
│   │   │   └── node_exporter.service.j2
│   │   ├── tests
│   │   │   ├── inventory
│   │   │   └── test.yml
│   │   └── vars
│   │       └── main.yml
│   ├── srvmon
│   │   ├── README.md
│   │   ├── defaults
│   │   │   └── main.yml
│   │   ├── files
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── meta
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   ├── install_alertmanager.yml
│   │   │   ├── install_grafana.yml
│   │   │   ├── install_nginx.yml
│   │   │   ├── install_node_exporter.yml
│   │   │   ├── install_prometheus.yml
│   │   │   ├── install_ssl.yml
│   │   │   ├── main.yml
│   │   │   ├── prepare.yml
│   │   │   └── setting_ufw.yml
│   │   ├── templates
│   │   │   ├── 00-installer-config.yaml.j2
│   │   │   ├── 1860_rev37.json.j2
│   │   │   ├── 50-vagrant.yaml.j2
│   │   │   ├── alertmanager.service.j2
│   │   │   ├── alertmanager.yml.j2
│   │   │   ├── all_log.conf
│   │   │   ├── linux_host_rules.yml.j2
│   │   │   ├── nginx.conf.j2
│   │   │   ├── node_exporter.service.j2
│   │   │   ├── prometheus.j2
│   │   │   ├── prometheus.service.j2
│   │   │   ├── prometheus.yml.j2
│   │   │   └── telegram.tmpl.j2
│   │   ├── tests
│   │   │   ├── inventory
│   │   │   └── test.yml
│   │   └── vars
│   │       └── main.yml
│   ├── web
│   │   ├── README.md
│   │   ├── defaults
│   │   │   └── main.yml
│   │   ├── files
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── meta
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   ├── download_nc.yml
│   │   │   ├── install_nfscl.yml
│   │   │   ├── install_nginx.yml
│   │   │   ├── install_node_exporter.yml
│   │   │   ├── install_php.yml
│   │   │   ├── install_ssl.yml
│   │   │   ├── main.yml
│   │   │   ├── prepare.yml
│   │   │   ├── redis_server.yml
│   │   │   └── setting_ufw.yml
│   │   ├── templates
│   │   │   ├── 00-installer-config.yaml.j2
│   │   │   ├── 50-vagrant.yaml.j2
│   │   │   ├── all_log.conf
│   │   │   ├── concatenate.j2
│   │   │   ├── config.php.j2
│   │   │   ├── http.conf.j2
│   │   │   ├── nextcloud.conf.j2
│   │   │   ├── nginx.conf.j2
│   │   │   ├── node_exporter.service.j2
│   │   │   └── redis.conf.j2
│   │   ├── tests
│   │   │   ├── inventory
│   │   │   └── test.yml
│   │   └── vars
│   │       └── main.yml
│   ├── web2
│       ├── README.md
│       ├── defaults
│       │   └── main.yml
│       ├── files
│       ├── handlers
│       │   └── main.yml
│       ├── meta
│       │   └── main.yml
│       ├── tasks
│       │   ├── download_nc.yml
│       │   ├── install_nfscl.yml
│       │   ├── install_nginx.yml
│       │   ├── install_node_exporter.yml
│       │   ├── install_php.yml
│       │   ├── install_ssl.yml
│       │   ├── main.yml
│       │   ├── prepare.yml
│       │   ├── redis_server.yml
│       │   └── setting_ufw.yml
│       ├── templates
│       │   ├── 00-installer-config.yaml.j2
│       │   ├── 50-vagrant.yaml.j2
│       │   ├── all_log.conf
│       │   ├── concatenate.j2
│       │   ├── config.php.j2
│       │   ├── http.conf.j2
│       │   ├── nextcloud.conf.j2
│       │   ├── nginx.conf.j2
│       │   ├── node_exporter.service.j2
│       │   └── redis.conf.j2
│       ├── tests
│       │   └── test.yml
│       │   ├── inventory
│       └── vars
│           └── main.yml
│           └── main.yml
└── staging
    └── hosts


### Описание хостов.
- Route - Используется для выхода в интернет, так же на нем развнут Dnsmasq для 


Сервис | Адрес
------| ---------
Nextcloud (Nginx+PHP-FPM) | https://nextcloud.home.ru
Prometheus | https://prometheus.home.ru
Alertmanager | https://alertmanager.home.ru
Grafana | https://grafana.home.ru`

<img width="1657" alt="image" src="https://github.com/user-attachments/assets/f85e7327-ae0f-465d-a6ea-52267262e123">

<img width="1014" alt="image" src="https://github.com/user-attachments/assets/12b19fcd-300d-4e73-9e63-1729dd045d51">

<img width="498" alt="image" src="https://github.com/user-attachments/assets/0d49d125-29ef-4c83-bc91-d893ae4601e1">

<img width="1356" alt="image" src="https://github.com/user-attachments/assets/2d41b5e6-4236-417e-a07a-bca31840e48a">

![image](https://github.com/user-attachments/assets/7151f708-a0fe-47ef-83ad-12e18929756c)

