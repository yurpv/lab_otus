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


### Описание проекта
Для разворачивания подготовлен Vagrantfile, для запуска стенда выполняем `vagrant up`. </br> 
а так же Ansible playbook project.yaml, с ролями и тегами. При необходимости можно установить определенную роль или нужный сервис для роли.

![image](https://github.com/user-attachments/assets/5d662d89-c2d0-4383-8f11-b1f0abd82c8f)

### Описание хостов.

Server| Назначение 
------|-------------
Route | сервер для выхода в интернет, так же на нем развнут Dnsmasq
Nginx | сервер для балансировки web приложения
Web, Web2 | сервера Web приложения nexcloud
NFS | сревре хранания данных с nextcloud
PSQLMaster | основной сервер базы данных Posgresql для nextcloud
PsqlSlave| резервный сервер база данных Posgresql для nextcloud
Buckup | сервер бекапа db и фалов с сервреа NES
Srvlog | сервер сбора логов, настроен с помощью Rsyslog
Srvmon | сервер мониторига Prometheus + Alertmanager, для оповещения используется telegam, за визуализацию отвечает Grafana

Сервис | Адрес
------| ---------
Nextcloud (Nginx+PHP-FPM) | https://nextcloud.home.local
Prometheus | https://prometheus.home.local
Alertmanager | https://alertmanager.home.local
Grafana | https://grafana.home.local

<img width="1646" alt="image" src="https://github.com/user-attachments/assets/7d687ee6-6f4b-490f-969b-af30e191dab4">


<img width="1662" alt="image" src="https://github.com/user-attachments/assets/5b162f90-5b85-41e2-a97e-03cb45f2187f">



<img width="519" alt="image" src="https://github.com/user-attachments/assets/e4513e50-581e-4fab-957e-eb6c9d1b759e">




<img width="1320" alt="image" src="https://github.com/user-attachments/assets/eab70a74-7b1f-4af0-a4ba-aac14ac026d9">



![image](https://github.com/user-attachments/assets/7151f708-a0fe-47ef-83ad-12e18929756c)

