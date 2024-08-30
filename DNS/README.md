# DNS
Для лабораторных работ использую Dell amd64, OS Manjaro, система виртуализации Virtualbox, при выполнении лабораторной работы использовал скаченый образ vagrantbox centos/7.

## Цель домашнего задания
- Создать домашнюю сетевую лабораторию. Изучить основы DNS, научиться работать с технологией Split-DNS в Linux-based системах

### Введение

DNS(Domain Name System, Служба доменных имён) - это распределенная система, для получения информации о доменах. DNS используется для сопоставления
IP-адресов и доменных имён.

Сопостовления IP-адресов и DNS-имён бывают двух видов:

- Прямое (DNS-имя в IP-адрес)
- Обратное (IP-адрес в DNS-имя)

Доменная структура DNS представляет собой древовидную иерархию, состоящую из узлов, зон, доменов, поддоменов и т.д. «Вершиной» доменной структуры является корневая зона. Корневая (root) зона обозначается точкой. Далее следуют домены первого уровня (.com, ,ru, .org и т. д.) и т д.

В DNS встречаются понятия зон и доменов:

- Зона — это любая часть дерева системы доменных имён, размещаемая как единое целое на некотором DNS-сервере.
- Домен – определенный узел, включающий в себя все подчинённые узлы.

Давайте разберем основное отличие зоны от домена. Возьмём для примера ресурс otus.ru — это может быть сразу и зона и домен, однако, при использовании зоны otus.ru мы можем сделать отдельную зону mail.otus.ru, которая будет управляться не нами. В случае домена так сделать нельзя...

FQDN (Fully Qualified Domain Name) - полностью указанное доменное имя, т.е. от корневого домена. Ключевой идентификатор FQDN - точка в конце имени. Максимальный размер FQDN — 255 байт, с ограничением в 63 байта на каждое имя домена. Пример FQDN: mail.otus.ru.

Вся информация о DNS-ресурсах хранится в ресурсных записях. Записи хранят следующие атрибуты:

- Имя (NAME) - доменное имя, к которому привязана или которому принадлежит данная ресурсная область, либо IP-адрес. При отсутствии данного поля, запись ресурса наследуется от предыдущей записи.
- TTL (время жизни в кэше) - после указанного времени запись удаляется, данное поле может не указываться в индивидуальных записях ресурсов, но тогда оно должно быть указано в начале файла зоны и будет наследоваться всеми записями.
- Класс (CLASS) - определяет тип сети (в 99% используется IN - интернет)
- Тип (TYPE) - тип записи, синтаксис и назначение записи
- Значение (DATA)

Типы рекурсивных записей:

- А (Address record) - отображают имя хоста (доменное имя) на адрес IPv4
- AAAA - отображает доменное имя на адрес IPv6
- CNAME (Canonical name reord/псевдоним) - привязка алиаса к существующему доменному имени
- MX (mail exchange) - указывает хосты для отправки почты, адресованной домену. При этом поле NAME указывает домен назначения, а поле DATA приоритет и доменное имя хоста, отвественного за приём почты. Данные вводятся через пробел
- NS (name server) - указывает на DNS-сервер, обслуживающий данный домен.
- PTR (pointer) - Отображает IP-адрес в доменное имя
- SOA (Start of Authority/начальная запись зоны) - описывает основные начальные настройки зоны.
- SRV (server selection) — указывает на сервера, обеспечивающие работу тех или иных служб в данном домене (например Jabber и Active Directory).

Для работы с DNS (как клиенту) в linux используют утилиты dig, host и nslookup

Также в Linux есть следующие реализации DNS-серверов:

- bind
- powerdns (умеет хранить зоны в БД)
- unbound (реализация bind)
- dnsmasq
- и т д.

Split DNS (split-horizon или split-brain) — это конфигурация, позволяющая отдавать разные записи зон DNS в зависимости от подсети источника запроса. Данную функцию можно реализовать как с помощью одного DNS-сервера, так и с помощью нескольких DNS-серверов…

### Описание домашнего задания

## Работа со стендом и настройка DNS

# 1. Развернуть стенд

- Скачать стенд <https://github.com/erlong15/vagrant-bind> и изучить содержимое файлов:
```
[yurpv@precision3561 DNS]$ git clone https://github.com/erlong15/vagrant-bind
Cloning into 'vagrant-bind'...
remote: Enumerating objects: 27, done.
remote: Total 27 (delta 0), reused 0 (delta 0), pack-reused 27 (from 1)
Receiving objects: 100% (27/27), 4.40 KiB | 4.40 MiB/s, done.
Resolving deltas: 100% (9/9), done.
[yurpv@precision3561 DNS]$ cd vagrant-bind/
[yurpv@precision3561 vagrant-bind]$ ls -l
total 12
drwxr-xr-x 2 yurpv yurpv 4096 авг 30 12:45 provisioning
-rw-r--r-- 1 yurpv yurpv  414 авг 30 12:45 README.md
-rw-r--r-- 1 yurpv yurpv  820 авг 30 12:45 Vagrantfile
```

- В файл Vagrantfile добавить еще один сервер client2 - [Vagrantfile]

>- Vagranfile описывает создание 4 виртуальных машин на CentOS 7, каждой машине будет выделено по 256 МБ ОЗУ. В начале файла есть модуль, который отвечает за настройку ВМ с помощью Ansible.

 - [playbook.yml] — это Ansible-playbook, в котором содержатся инструкции по настройке стенда
 - client-motd — файл, содержимое которого будет появляться перед пользователем, который подключился по SSH
 - named.ddns.lab и named.dns.lab — файлы описания зон ddns.lab и dns.lab соответсвенно
 - master-named.conf и slave-named.conf — конфигурационные файлы, в которых хранятся настройки DNS-сервера
 - client-resolv.conf и servers-resolv.conf — файлы, в которых содержатся IP-адреса DNS-серверов

>- **Для нормальной работы DNS-серверов, на них должно быть настроено одинаковое время.** Для того, чтобы на всех серверах было одинаковое время, необходимо настроить NTP. В CentOS по умолчанию уже есть NTP-клиент Chrony. Обычно он всегда включен и добавлен в автозагрузку. Проверить работу службы можно командой: systemctl status chronyd

>- **При варианте установки утилиты ntp, после установки необходимо:**
>-  - Остановить службу chronyd: systemctl stop chronyd
>-  - Удалить службу chronyd из автозагрузки: systemctl disable chronyd
>-  - Включить службу ntpd: systemctl start ntpd
>-  - Добавить службу ntpd в автозагрузку: systemctl enable ntpd

>- Пример данной настройки в Ansible (YAML-формат):
```
- name: stop and disable chronyd
  service:
    name: chronyd
    state: stopped
    enabled: false
- name: start and enable ntpd
  service:
    name: ntpd
    state: started
    enabled: true
```
>- **Альтернативный вариант — не устанавливать ntp и просто запустить службу chronyd: systemctl start chronyd**
>- Пример данной настройки в Ansible (YAML формат):

```
- name: install packages
  yum:
    name:
    - bind
    - bind-utils
    - vim
    state: latest
    update_cache: true

- name: start chronyd
  service:
    name: chronyd
    state: restarted
    enabled: true
```
- В данном развертывании будет установлена утилита ntp
>- **vagrant up --provision** - это команда, которая используется для настройки внутреннего окружения имеющейся виртуальной машины. Например, она позволяет добавить новые инструкции (скрипты) в ранее созданную виртуальную машину.

- Перед выполнением следующих заданий, нужно обратить внимание, на каком адресе и порту работают наши DNS-сервера. 

- Проверим на каком адресе и порту работают DNS-сервера:
- - Посмотреть с помощью команды SS: ss -tulpn
```
[root@ns01 ~]# ss -tunlp
Netid  State      Recv-Q Send-Q                                                         Local Address:Port                                                                        Peer Address:Port              
udp    UNCONN     0      0                                                              192.168.50.10:53                                                                                     *:*                   users:(("named",pid=16689,fd=512))
udp    UNCONN     0      0                                                                          *:68                                                                                     *:*                   users:(("dhclient",pid=2512,fd=6))
udp    UNCONN     0      0                                                                          *:111                                                                                    *:*                   users:(("rpcbind",pid=344,fd=6))
udp    UNCONN     0      0                                                              192.168.50.10:123                                                                                    *:*                   users:(("ntpd",pid=14804,fd=20))
udp    UNCONN     0      0                                                                  10.0.2.15:123                                                                                    *:*                   users:(("ntpd",pid=14804,fd=19))
udp    UNCONN     0      0                                                                  127.0.0.1:123                                                                                    *:*                   users:(("ntpd",pid=14804,fd=18))
udp    UNCONN     0      0                                                                          *:123                                                                                    *:*                   users:(("ntpd",pid=14804,fd=16))
udp    UNCONN     0      0                                                                          *:930                                                                                    *:*                   users:(("rpcbind",pid=344,fd=7))
udp    UNCONN     0      0                                                                      [::1]:53                                                                                  [::]:*                   users:(("named",pid=16689,fd=513))
udp    UNCONN     0      0                                                                       [::]:111                                                                                 [::]:*                   users:(("rpcbind",pid=344,fd=9))
udp    UNCONN     0      0                                            [fe80::a00:27ff:fe69:44b0]%eth1:123                                                                                 [::]:*                   users:(("ntpd",pid=14804,fd=23))
udp    UNCONN     0      0                                             [fe80::5054:ff:fe4d:77d3]%eth0:123                                                                                 [::]:*                   users:(("ntpd",pid=14804,fd=22))
udp    UNCONN     0      0                                                                      [::1]:123                                                                                 [::]:*                   users:(("ntpd",pid=14804,fd=21))
udp    UNCONN     0      0                                                                       [::]:123                                                                                 [::]:*                   users:(("ntpd",pid=14804,fd=17))
udp    UNCONN     0      0                                                                       [::]:930                                                                                 [::]:*                   users:(("rpcbind",pid=344,fd=10))
tcp    LISTEN     0      128                                                                        *:111                                                                                    *:*                   users:(("rpcbind",pid=344,fd=8))
tcp    LISTEN     0      10                                                             192.168.50.10:53                                                                                     *:*                   users:(("named",pid=16689,fd=21))
tcp    LISTEN     0      128                                                                        *:22                                                                                     *:*                   users:(("sshd",pid=5058,fd=3))
tcp    LISTEN     0      128                                                            192.168.50.10:953                                                                                    *:*                   users:(("named",pid=16689,fd=23))
tcp    LISTEN     0      100                                                                127.0.0.1:25                                                                                     *:*                   users:(("master",pid=811,fd=13))
tcp    LISTEN     0      128                                                                     [::]:111                                                                                 [::]:*                   users:(("rpcbind",pid=344,fd=11))
tcp    LISTEN     0      10                                                                     [::1]:53                                                                                  [::]:*                   users:(("named",pid=16689,fd=22))
tcp    LISTEN     0      128                                                                     [::]:22                                                                                  [::]:*                   users:(("sshd",pid=5058,fd=4))
tcp    LISTEN     0      100                                                                    [::1]:25                                                                                  [::]:*                   users:(("master",pid=811,fd=14))
```

- Посмотреть информацию в настройках DNS-сервера (**/etc/named.conf**)
```
[root@ns01 ~]# cat /etc/named.conf
options {

    // network
        listen-on port 53 { 192.168.50.10; };
        listen-on-v6 port 53 { ::1; };
```
```
[root@ns02 ~]# cat /etc/named.conf
options {

    // network
        listen-on port 53 { 192.168.50.11; };
        listen-on-v6 port 53 { ::1; };
```

- На основе данной информации, нужно внести корректировки в файл /etc/resolv.conf для DNS-серверов:на хосте ns01 указать nameserver 192.168.50.21, а на хосте ns02 — 192.168.50.11

>- В Ansible для этого можно воспользоваться шаблоном с Jinja. Изменим имя файла servers-resolv.conf на servers-resolv.conf.j2 и укажем там следующие условия:

```bash
domain dns.lab
search dns.lab
#Если имя сервера ns02, то указываем nameserver 192.168.50.11
{% if ansible_hostname == 'ns02' %}
nameserver 192.168.50.11
{% endif %}
#Если имя сервера ns01, то указываем nameserver 192.168.50.10
{% if ansible_hostname == 'ns01' %}
nameserver 192.168.50.10
{% endif %}
```
>- После внесения измений в файл, нужно изменить ansible-playbook - вместо модуля copy модуль template:

```
- name: copy resolv.conf to the servers
  template: src=servers-resolv.conf.j2 dest=/etc/resolv.conf owner=root group=root mode=0644
```
 YAML-формат:

```
- name: copy resolv.conf to the servers
  template:
    src: servers-resolv.conf.j2
    dest: /etc/resolv.conf
    owner: root
    group: root
    mode: 0644
```

### 2. Настройка  DNS

- **Добавление имён в зону dns.lab**
- Проверить, что зона dns.lab уже существует на DNS-серверах:

```
// Имя зоны
zone "dns.lab" {
    type master;
    // Тем, у кого есть ключ zonetransfer.key можно получать копию файла зоны
    allow-transfer { key "zonetransfer.key"; };
    // Файл с настройками зоны
    file "/etc/named/named.dns.lab";
};
```
- Фрагмент файла /etc/named.conf на сервере ns01:
```
// lab's zone
zone "dns.lab" {
    type master;
    allow-transfer { key "zonetransfer.key"; };
    file "/etc/named/named.dns.lab";
};
```

- Похожий фрагмент файла /etc/named.conf находится на slave-сервере ns02:
```
// lab's zone
zone "dns.lab" {
    type slave;
    masters { 192.168.50.10; };
    file "/etc/named/named.dns.lab";
};
```

- На хосте ns01 мы видим файл /etc/named/named.dns.lab с настройкой зоны:

```
[root@ns01 ~]# cat /etc/named/named.dns.lab
$TTL 3600
$ORIGIN dns.lab.
@               IN      SOA     ns01.dns.lab. root.dns.lab. (
                            2711201407 ; serial
                            3600       ; refresh (1 hour)
                            600        ; retry (10 minutes)
                            86400      ; expire (1 day)
                            600        ; minimum (10 minutes)
                        )

                IN      NS      ns01.dns.lab.
                IN      NS      ns02.dns.lab.

; DNS Servers
ns01            IN      A       192.168.56.20
ns02            IN      A       192.168.56.21
```
- В этот файл добавить имена:

```bash
;Web
web1            IN      A       192.168.56.25
web2            IN      A       192.168.56.26
```
```
[root@ns01 ~]# vi /etc/named/named.dns.lab
[root@ns01 ~]# cat /etc/named/named.dns.lab
$TTL 3600
$ORIGIN dns.lab.
@               IN      SOA     ns01.dns.lab. root.dns.lab. (
                            2711201407 ; serial
                            3600       ; refresh (1 hour)
                            600        ; retry (10 minutes)
                            86400      ; expire (1 day)
                            600        ; minimum (10 minutes)
                        )

                IN      NS      ns01.dns.lab.
                IN      NS      ns02.dns.lab.

; DNS Servers
ns01            IN      A       192.168.50.10
ns02            IN      A       192.168.50.11
; WWW
web1            IN      A       192.168.50.15
web2            IN      A       192.168.50.16
```

>- Если изменения внесены вручную, то для применения настроек нужно:
-  Перезапустить службу named: systemctl restart named
-  Изменить значение Serial (добавить +1 к числу 2711201407), изменение значения serial укажет slave-серверам на то, что были внесены изменения и что им надо обновить свои файлы с зонами.

- Выполнить проверку с клиента - обращениек  разным DNS-серверам с разными запросами:
```
[root@client ~]# dig @192.168.50.10 web1.dns.lab

; <<>> DiG 9.11.4-P2-RedHat-9.11.4-26.P2.el7_9.16 <<>> @192.168.50.10 web1.dns.lab
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 55430
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 2, ADDITIONAL: 3

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;web1.dns.lab.                  IN      A

;; ANSWER SECTION:
web1.dns.lab.           3600    IN      A       192.168.50.15

;; AUTHORITY SECTION:
dns.lab.                3600    IN      NS      ns02.dns.lab.
dns.lab.                3600    IN      NS      ns01.dns.lab.

;; ADDITIONAL SECTION:
ns01.dns.lab.           3600    IN      A       192.168.50.10
ns02.dns.lab.           3600    IN      A       192.168.50.11

;; Query time: 0 msec
;; SERVER: 192.168.50.10#53(192.168.50.10)
;; WHEN: Fri Aug 30 13:23:28 MSK 2024
;; MSG SIZE  rcvd: 127
```
```
[root@client2 ~]# dig @192.168.50.11 web2.dns.lab

; <<>> DiG 9.11.4-P2-RedHat-9.11.4-26.P2.el7_9.16 <<>> @192.168.50.11 web2.dns.lab
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 21687
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 2, ADDITIONAL: 3

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;web2.dns.lab.                  IN      A

;; ANSWER SECTION:
web2.dns.lab.           3600    IN      A       192.168.50.16

;; AUTHORITY SECTION:
dns.lab.                3600    IN      NS      ns02.dns.lab.
dns.lab.                3600    IN      NS      ns01.dns.lab.

;; ADDITIONAL SECTION:
ns01.dns.lab.           3600    IN      A       192.168.50.10
ns02.dns.lab.           3600    IN      A       192.168.50.11

;; Query time: 0 msec
;; SERVER: 192.168.50.11#53(192.168.50.11)
;; WHEN: Fri Aug 30 13:25:01 MSK 2024
;; MSG SIZE  rcvd: 127
```

- Добавление имён в зону dns.lab с помощью Ansible

>- В существующем Ansible-playbook менять ничего не потребуется, нужно добавить строки с новыми именами в файл [named.dns.lab] и снова запустить Ansible.

- **Создание новой зоны и добавление в неё записей**

- Для того, чтобы прописать на DNS-серверах новую зону необходимо:

- На хосте ns01 добавить зону в файл /etc/named.conf:

```bash
// lab's newdns zone
zone "newdns.lab" {
     type master;
     allow-transfer { key "zonetransfer.key"; };
     allow-update { key "zonetransfer.key"; };
     file "/etc/named/named.newdns.lab";
};
```

- На хосте ns02 также добавить зону и указать с какого сервера запрашивать информацию об этой зоне (фрагмент файла /etc/named.conf):

```bash
// lab's newdns zone
zone "newdns.lab" {
    type slave;
    masters { 192.168.50.10; };
    file "/etc/named/named.newdns.lab";
};
```
- На хосте ns01 создадим файл /etc/named/named.newdns.lab
```
[root@ns01 ~]# vi /etc/named/named.newdns.lab
$TTL 3600
$ORIGIN newdns.lab.
@               IN      SOA     ns01.dns.lab. root.dns.lab. (
                            2711201407 ; serial
                            3600       ; refresh (1 hour)
                            600        ; retry (10 minutes)
                            86400      ; expire (1 day)
                            600        ; minimum (10 minutes)
                        )

                IN      NS      ns01.dns.lab.
                IN      NS      ns02.dns.lab.

; DNS Servers
ns01            IN      A       192.168.50.10
ns02            IN      A       192.168.50.11
; WWW
www            IN      A       192.168.50.15
www            IN      A       192.168.50.16
```

В конце этого файла добавим записи "www". У файла должны быть права 660, владелец — root, группа — named.
```
[root@ns01 ~]# ls -l /etc/named/named.newdns.lab
-rw-rw----. 1 root named 698 Aug 30 12:08 /etc/named/named.newdns.lab
```
- После внесения данных изменений, изменяем значение serial (добавлем +1 к значению 2711201007) и перезапускаем named: systemctl restart named

- Создание новой зоны и добавление в неё записей **с помощью Ansible**. Для создания зоны и добавления в неё записей, нужно добавить зону в файл /etc/named.conf на хостах ns01 [master-named.conf] и ns02 [slave-named.conf ], а также создать файл [named.newdns.lab](named.dns.lab), которые будут копироваться на сервер ns01 и ns02 через playbook.
- Добавить в модуль copy файл named.newdns.lab [playbook]

```yml
- name: copy zones
    copy: src={{ item }} dest=/etc/named/ owner=root group=named mode=0660
    with_fileglob:
      - named.d*
      - named.newdns.lab
```
>- Соответственно файл named.newdns.lab будет скопирован на хост ns01 по адресу /etc/named/named.newdns.lab

