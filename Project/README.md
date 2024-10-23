# Проектная работа
## Инфраструктура для проекта на Nextcloud

Для лабораторных работ использую Macbook Air M2 чипсет amr64, OS Sonoma 14.6.1, система виртуализации VMware Fusion, при выполнении лабораторной работы использовал образ vagrantbox bento/ubuntu-22.04.

## Требования:

Веб проект с развертыванием нескольких виртуальных машин должен отвечать следующим требованиям:
* включен https;
* основная инфраструктура в DMZ зоне;
* файрвалл на входе;
* сбор метрик и настроенный алертинг;
* везде включен selinux;
* организован централизованный сбор логов.


## Проект

Схема стенда

![Project work Diagram drawio (6)](https://github.com/user-attachments/assets/2d2a81a4-2d75-4bf7-87b2-54f78847af09)


### Состав проекта

- Всего: 7 хостов. 
- Метод разворачивания: Vagrant, Ansible.
- На хостах включен файрвол (UFW):
	- Настроены необходимые службы и порты.
- На хостах выключен SELinux:
	- Настроены необходимые контексты.
- Все хосты выходят из локальной сети через хост Router.
- Для мониторинга используется Prometheus + Alertmanager, для оповещения используется telegam
- За визуалтзацию отвечает grafana

<img width="1014" alt="image" src="https://github.com/user-attachments/assets/12b19fcd-300d-4e73-9e63-1729dd045d51">

<img width="498" alt="image" src="https://github.com/user-attachments/assets/0d49d125-29ef-4c83-bc91-d893ae4601e1">

<img width="1356" alt="image" src="https://github.com/user-attachments/assets/2d41b5e6-4236-417e-a07a-bca31840e48a">



### Хосты

Name | IP адрес
------| ---------
Router | 192.168.255.10
WEB | 192.168.255.20
Postgresql (MASTER) | 192.168.255.30
Postgresql (SLAVE) | 192.168.255.31
Barman  | 192.168.255.40
Server log (Syslog) | 192.168.255.50
Monitoring (Srvmon) | 192.168.255.60


Для разворачивания стенда выполняем `vagrant up`. Для разворачивания хостов подготовлен Ansible playbook. В playbook ипортируются роли, каждая роль разворачивает определенную службу.


### Доступ к службам

> Для доступа к веб-проекту на Nextcloud, Prometheus, Alertmanager, Grafana необходимо на хост машине прописать адреса роутера:
> `192.168.255.20 nextcloud.home.ru`.
> `192.168.255.60 prometheus.home.ru`.
> `192.168.255.60 alertmanager.home.ru`.
> `192.168.255.60 grafana.home.ru`.

Сервис | Адрес
------| ---------
Nextcloud (Nginx+PHP-FPM) | https://nextcloud.home.ru
Prometheus | prometheus.home.ru
Alertmanager | http://alertmanager.home.ru
Grafana | http://grafana.home.ru`

<img width="1662" alt="image" src="https://github.com/user-attachments/assets/55c98575-a3a8-49a6-919c-756260867123">

<img width="1014" alt="image" src="https://github.com/user-attachments/assets/12b19fcd-300d-4e73-9e63-1729dd045d51">

<img width="498" alt="image" src="https://github.com/user-attachments/assets/0d49d125-29ef-4c83-bc91-d893ae4601e1">

<img width="1356" alt="image" src="https://github.com/user-attachments/assets/2d41b5e6-4236-417e-a07a-bca31840e48a">
