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


Для разворачивания подготовлен Vagrantfile, для запуска стенда выполняем `vagrant up`. </br> 
а так же Ansible playbook project.yaml, с ролями и тегами. При необходимости можно установить определенную роль или нужный сервис для это роди.
![image](https://github.com/user-attachments/assets/5d662d89-c2d0-4383-8f11-b1f0abd82c8f)

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

