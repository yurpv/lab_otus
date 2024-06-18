# Prometheus

### Цели домашнего задания

- Настроить дашборд с 4-мя графиками</br>
память;</br>
процессор;</br>
диск;</br>
сеть.</br>

- Настроить на одной из систем:
zabbix (использовать screen (комплексный экран);
prometheus - grafana.</br>

Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, при выполнении лабораторной работы использовал образ vagrantbox bento/ubuntu-24.04.


### Домашнее задание

- Запускаем две тестовые вм командой:
```
Monitoring % vagrant up                 
Bringing machine 'prometheus' up with 'vmware_desktop' provider...
Bringing machine 'grafana' up with 'vmware_desktop' provider...
==> prometheus: Cloning VMware VM: 'bento/ubuntu-24.04'. This can take some time...
==> prometheus: Checking if box 'bento/ubuntu-24.04' version '202404.26.0' is up to date...
==> prometheus: Verifying vmnet devices are healthy...
==> prometheus: Preparing network adapters...
==> prometheus: Starting the VMware VM...
==> prometheus: Waiting for the VM to receive an address...
==> prometheus: Forwarding ports...
...
```
- Заходим по ssh на первую vm и на ней настраиваем prometheus
- Для начала создаем каталоги, в которые скопируем файлы для prometheus:
```
root@prometheus:/home/vagrant# mkdir -p /var/lib/prometheus /var/lib/prometheus/alertmanger
root@prometheus:/home/vagrant# mkdir /etc/prometheus/
```

- Скачаем prometheus и распакуем архив:

```
root@prometheus:/etc/prometheus# wget https://github.com/prometheus/prometheus/releases/download/v2.51.2/prometheus-2.51.2.linux-arm64.tar.gz
--2024-06-03 08:57:09--  https://github.com/prometheus/prometheus/releases/download/v2.51.2/prometheus-2.51.2.linux-arm64.tar.gz
Resolving github.com (github.com)... 140.82.121.3
Connecting to github.com (github.com)|140.82.121.3|:443... connected.
...
root@prometheus:/home/vagrant# tar xzf prometheus-2.51.2.linux-arm64.tar.gz
mv prometheus-2.51.2.linux-arm64 /etc/prometheus
```

- Распределяем файлы по каталогам:
```
root@prometheus:/home/vagrant# cd /etc/prometheus
root@prometheus:/etc/prometheus# mv prometheus promtool /usr/local/bin/
root@prometheus:/etc/prometheus# prometheus --version
prometheus, version 2.51.2 (branch: HEAD, revision: b4c0ab52c3e9b940ab803581ddae9b3d9a452337)
  build user:       root@b63f02a423d9
  build date:       20240410-14:08:09
  go version:       go1.22.2
  platform:         linux/arm64
  tags:             netgo,builtinassets,stringlabels
```

- Создаем пользователя, от которого будем запускать систему мониторинга, даем права на папки и файлы, проверяем:
```
root@prometheus:/etc/prometheus# groupadd prometheus
root@prometheus:/etc/prometheus# useradd -s /sbin/nologin --system -g prometheus prometheus
root@prometheus:/etc/prometheus# chown -R prometheus:prometheus /etc/prometheus
root@prometheus:/etc/prometheus# chmod -R 775 /etc/prometheus
root@prometheus:/etc/prometheus# chown -R prometheus:prometheus /var/lib/prometheus/
root@prometheus:/etc/prometheus# systemctl start prometheus
root@prometheus:/etc/prometheus# systemctl status prometheus
● prometheus.service - Prometheus
     Loaded: loaded (/etc/systemd/system/prometheus.service; disabled; preset: enabled)
     Active: active (running) since Mon 2024-06-03 09:06:15 UTC; 2s ago
   Main PID: 2584 (prometheus)
      Tasks: 8 (limit: 4549)
     Memory: 16.1M (peak: 16.4M)
        CPU: 44ms
     CGroup: /system.slice/prometheus.service
             └─2584 /usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus --web.console.templates=/etc/prometheus/cons>

Jun 03 09:06:15 prometheus prometheus[2584]: ts=2024-06-03T09:06:15.162Z caller=head.go:698 level=info component=tsdb msg="On-disk memory mappable chunks replay completed" dur>
Jun 03 09:06:15 prometheus prometheus[2584]: ts=2024-06-03T09:06:15.162Z caller=head.go:706 level=info component=tsdb msg="Replaying WAL, this may take a while"
Jun 03 09:06:15 prometheus prometheus[2584]: ts=2024-06-03T09:06:15.162Z caller=head.go:778 level=info component=tsdb msg="WAL segment loaded" segment=0 maxSegment=0
Jun 03 09:06:15 prometheus prometheus[2584]: ts=2024-06-03T09:06:15.163Z caller=head.go:815 level=info component=tsdb msg="WAL replay completed" checkpoint_replay_duration=14.>
Jun 03 09:06:15 prometheus prometheus[2584]: ts=2024-06-03T09:06:15.169Z caller=main.go:1150 level=info fs_type=EXT4_SUPER_MAGIC
Jun 03 09:06:15 prometheus prometheus[2584]: ts=2024-06-03T09:06:15.169Z caller=main.go:1153 level=info msg="TSDB started"
Jun 03 09:06:15 prometheus prometheus[2584]: ts=2024-06-03T09:06:15.169Z caller=main.go:1335 level=info msg="Loading configuration file" filename=/etc/prometheus/prometheus.yml
Jun 03 09:06:15 prometheus prometheus[2584]: ts=2024-06-03T09:06:15.170Z caller=main.go:1372 level=info msg="Completed loading of configuration file" filename=/etc/prometheus/>
Jun 03 09:06:15 prometheus prometheus[2584]: ts=2024-06-03T09:06:15.170Z caller=main.go:1114 level=info msg="Server is ready to receive web requests."
Jun 03 09:06:15 prometheus prometheus[2584]: ts=2024-06-03T09:06:15.170Z caller=manager.go:163 level=info component="rule manager" msg="Starting rule manager..."
```
- Заходим через браузер на веб страницу нашего prometheus:
<img width="1663" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/3b348978-bec7-4bc8-bbee-ddeae294922a">

- Теперь необходимо настроить Alertmanager, он необходим для группировки событий и отправки уведомлений об инцидентах

- Скачаем Alertmanager и распакуем архив:

```
root@prometheus:/home/vagrant# wget https://github.com/prometheus/alertmanager/releases/download/v0.26.0/alertmanager-0.26.0.linux-arm64.tar.gz
--2024-06-03 09:01:34--  https://github.com/prometheus/alertmanager/releases/download/v0.26.0/alertmanager-0.26.0.linux-arm64.tar.gz
Resolving github.com (github.com)... 140.82.121.4
Connecting to github.com (github.com)|140.82.121.4|:443... connected.
...

root@prometheus:/home/vagrant# tar xzf alertmanager-0.26.0.linux-arm64.tar.gz 
```

- Распределяем файлы по каталогам:
```
root@prometheus:/home/vagrant# mv alertmanager-0.26.0.linux-arm64 /etc/alertmanager
root@prometheus:/home/vagrant# cd /etc/alertmanager
root@prometheus:/etc/alertmanager# mv alertmanager amtool /usr/local/bin/
root@prometheus:/etc/alertmanager# alertmanager --version
alertmanager, version 0.26.0 (branch: HEAD, revision: d7b4f0c7322e7151d6e3b1e31cbc15361e295d8d)
  build user:       root@520df6c16a84
  build date:       20230824-11:09:02
  go version:       go1.20.7
  platform:         linux/arm64
  tags:             netgo
```

- Создаем пользователя, от которого будем запускать систему мониторинга, даем права на папки и файлы, проверяем:
```
root@prometheus:/etc/alertmanager# groupadd alertmanager
root@prometheus:/etc/alertmanager# useradd -s /sbin/nologin --system -g alertmanager alertmanager
root@prometheus:/etc/prometheus# chown -R prometheus:prometheus /etc/prometheus
root@prometheus:/etc/prometheus# chmod -R 775 /etc/alertmanager
root@prometheus:/etc/prometheus# chown -R alertmanager:alertmanager /var/lib/prometheus/alertmanager
root@prometheus:/etc/prometheus# systemctl start alertmanager
root@prometheus:/etc/prometheus# systemctl status alertmanager
● alertmanager.service - Alertmanager Service
     Loaded: loaded (/etc/systemd/system/alertmanager.service; disabled; preset: enabled)
     Active: active (running) since Mon 2024-06-03 09:16:59 UTC; 2s ago
   Main PID: 2737 (alertmanager)
      Tasks: 7 (limit: 4549)
     Memory: 13.1M (peak: 13.4M)
        CPU: 81ms
     CGroup: /system.slice/alertmanager.service
             └─2737 /usr/local/bin/alertmanager --config.file=/etc/alertmanager/alertmanager.yml --storage.path=/var/lib/prometheus/alertmanager --cluster.advertise-address=0.>

Jun 03 09:16:59 prometheus systemd[1]: Started alertmanager.service - Alertmanager Service.
Jun 03 09:16:59 prometheus (tmanager)[2737]: alertmanager.service: Referenced but unset environment variable evaluates to an empty string: ALERTMANAGER_OPTS
Jun 03 09:16:59 prometheus alertmanager[2737]: ts=2024-06-03T09:16:59.175Z caller=main.go:245 level=info msg="Starting Alertmanager" version="(version=0.26.0, branch=HEAD, rev>
Jun 03 09:16:59 prometheus alertmanager[2737]: ts=2024-06-03T09:16:59.175Z caller=main.go:246 level=info build_context="(go=go1.20.7, platform=linux/arm64, user=root@520df6c16>
Jun 03 09:16:59 prometheus alertmanager[2737]: ts=2024-06-03T09:16:59.177Z caller=cluster.go:683 level=info component=cluster msg="Waiting for gossip to settle..." interval=2s
Jun 03 09:16:59 prometheus alertmanager[2737]: ts=2024-06-03T09:16:59.210Z caller=coordinator.go:113 level=info component=configuration msg="Loading configuration file" file=/>
Jun 03 09:16:59 prometheus alertmanager[2737]: ts=2024-06-03T09:16:59.211Z caller=coordinator.go:126 level=info component=configuration msg="Completed loading of configuration>
Jun 03 09:16:59 prometheus alertmanager[2737]: ts=2024-06-03T09:16:59.218Z caller=tls_config.go:274 level=info msg="Listening on" address=[::]:9093
Jun 03 09:16:59 prometheus alertmanager[2737]: ts=2024-06-03T09:16:59.218Z caller=tls_config.go:277 level=info msg="TLS is disabled." http2=false address=[::]:9093
Jun 03 09:17:01 prometheus alertmanager[2737]: ts=2024-06-03T09:17:01.177Z caller=cluster.go:708 level=info component=cluster msg="gossip not settled" polls=0 before=0 now=1 e>
lines 1-20/20 (END)
```
- Заходим через браузер на веб страницу нашего alertmanager:
<img width="1072" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/d5e385c8-ffd8-4d22-8205-4aa7fe60dde8">

- Для полужения метрик необходимо настроить установить node_exporter, делаем все тоже самое, что и до этого:
```
root@prometheus:/home/vagrant# wget https://github.com/prometheus/node_exporter/releases/download/v1.8.1/node_exporter-1.8.1.linux-arm64.tar.gz
--2024-06-03 09:28:12--  https://github.com/prometheus/node_exporter/releases/download/v1.8.1/node_exporter-1.8.1.linux-arm64.tar.gz
Resolving github.com (github.com)... 140.82.121.3
Connecting to github.com (github.com)|140.82.121.3|:443... connected.
root@prometheus:/home/vagrant# tar xzf node_exporter-1.8.1.linux-arm64.tar.gz 
root@prometheus:/home/vagrant# cd node_exporter-1.8.1.linux-arm64
root@prometheus:/home/vagrant/node_exporter-1.8.1.linux-arm64# mv node_exporter /usr/local/bin/
root@prometheus:/home/vagrant/node_exporter-1.8.1.linux-arm64# cd ..
root@prometheus:/home/vagrant# useradd --no-create-home --shell /bin/false node_exporter
root@prometheus:/home/vagrant# chown -R node_exporter:node_exporter /usr/local/bin/node_exporter
root@prometheus:/home/vagrant# systemctl start node_exporter
root@prometheus:/home/vagrant# systemctl status node_exporter

● node_exporter.service - Node Exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; disabled; preset: enabled)
     Active: active (running) since Mon 2024-06-03 09:56:45 UTC; 2s ago
   Main PID: 3035 (node_exporter)
      Tasks: 5 (limit: 4549)
     Memory: 2.6M (peak: 2.7M)
        CPU: 14ms
     CGroup: /system.slice/node_exporter.service
             └─3035 /usr/local/bin/node_exporter
```

- Заходим через браузер на веб страницу нашего node_exporter:
<img width="855" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/b887b166-c914-4870-90d4-4d683d6cc365">

- Настроим отбражение метрик в prometheus:
- Открываем конфигурационный файл prometheus:
```
vi /etc/prometheus/prometheus.yml
```

- Созданим новый job с определенными значениями:
```
#Node_exporter
  - job_name: 'node_exporter'
    scrape_interval: 5s
    static_configs:
      - targets:
          - 192.168.65.208:9100
          - 192.168.65.209:9100
    relabel_configs:
    - source_labels: [__address__]
      regex: '.*'
      target_label: instance
```

- Перезапускаем prometheus и проверяем:
<img width="870" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/aa4534ed-7689-443b-a270-c111f4f6191b">

- Для красивого отображения метрик, настроим grafana, заходим на второй поднятый сервер и вводим следующие команды:
```
vagrant ssh garfana
vagrant@grafana:~$ sudo su
root@grafana:/home/vagrant# wget sudo apt-get install -y adduser libfontconfig1 musl^C
root@grafana:/home/vagrant# sudo apt-get install -y adduser libfontconfig1 musl
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
adduser is already the newest version (3.137ubuntu1).
adduser set to manually installed.
...
root@grafana:/home/vagrant# wget https://dl.grafana.com/oss/release/grafana_11.0.0_arm64.deb
--2024-06-03 09:19:36--  https://dl.grafana.com/oss/release/grafana_11.0.0_arm64.deb
Resolving dl.grafana.com (dl.grafana.com)... 146.75.118.217, 2a04:4e42:14::729
Connecting to dl.grafana.com (dl.grafana.com)|146.75.118.217|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 110611380 (105M) [application/octet-stream]
Saving to: ‘grafana_11.0.0_arm64.deb’

grafana_11.0.0_arm64.deb                    100%[===========================================================================================>] 105.49M  18.7MB/s    in 6.5s    

2024-06-03 09:19:48 (16.3 MB/s) - ‘grafana_11.0.0_arm64.deb’ saved [110611380/110611380]

root@grafana:/home/vagrant# dpkg -i grafana_11.0.0_arm64.deb
Selecting previously unselected package grafana.
(Reading database ... 48742 files and directories currently installed.)
Preparing to unpack grafana_11.0.0_arm64.deb ...
Unpacking grafana (11.0.0) ...
Setting up grafana (11.0.0) ...
info: Selecting UID from range 100 to 999 ...
root@grafana:/home/vagrant# systemctl start grafana-server
root@grafana:/home/vagrant# systemctl status grafana-server
● grafana-server.service - Grafana instance
     Loaded: loaded (/usr/lib/systemd/system/grafana-server.service; disabled; preset: enabled)
     Active: active (running) since Mon 2024-06-03 09:21:11 UTC; 7s ago
       Docs: http://docs.grafana.org
   Main PID: 3073 (grafana)
      Tasks: 8 (limit: 4549)
     Memory: 48.5M (peak: 49.0M)
        CPU: 1.018s
     CGroup: /system.slice/grafana-server.service
             └─3073 /usr/share/grafana/bin/grafana server --config=/etc/grafana/grafana.ini --pidfile=/run/grafana/grafana-server.pid --packaging=deb cfg:default.paths.logs=/v>

Jun 03 09:21:12 grafana grafana[3073]: logger=provisioning.dashboard t=2024-06-03T09:21:12.359384311Z level=info msg="starting to provision dashboards"
Jun 03 09:21:12 grafana grafana[3073]: logger=provisioning.dashboard t=2024-06-03T09:21:12.359392727Z level=info msg="finished to provision dashboards"
```

- Поставим node_exporter
```
root@grafana:/home/vagrant# tar xzf node_exporter-1.8.1.linux-arm64.tar.gz 
root@grafana:/home/vagrant# mv ./node_exporter-1.8.1.linux-arm64/node_exporter /usr/local/bin/
root@grafana:/home/vagrant# rm -rf ./node_exporter-*
root@grafana:/home/vagrant# sudo useradd --no-create-home --shell /bin/false node_exporter
root@grafana:/home/vagrant# chown node_exporter:node_exporter /usr/local/bin/node_exporter
root@grafana:/home/vagrant# systemctl start node_exporter
root@grafana:/home/vagrant# systemctl status node_exporter
● node_exporter.service - Node Exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; disabled; preset: enabled)
     Active: active (running) since Mon 2024-06-03 09:59:13 UTC; 6s ago
   Main PID: 3135 (node_exporter)
      Tasks: 5 (limit: 4549)
     Memory: 2.5M (peak: 2.7M)
        CPU: 10ms
     CGroup: /system.slice/node_exporter.service
             └─3135 /usr/local/bin/node_exporter

Jun 03 09:59:13 grafana node_exporter[3135]: ts=2024-06-03T09:59:13.849Z caller=node_exporter.go:118 level=info collector=time
Jun 03 09:59:13 grafana node_exporter[3135]: ts=2024-06-03T09:59:13.849Z caller=node_exporter.go:118 level=info collector=timex
```

- Заходим на графану через веб и продалжаем настройку;

<img width="1209" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/79ce3130-ae50-4ce5-bfe9-921f0b43ae69">

- Для настройки дашбодов необходимо подружить grafana и prometheus, заходим в datasource вводим url нашего сервера и нажимаем сохранить:
<img width="1201" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/bbce5aed-30eb-44fb-851b-fe9911a6badc">
<img width="1158" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/c2ceecc5-be27-4bf2-8bdc-a36282ad2913">
<img width="1330" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/1688d7a9-6089-4897-991f-cf4a0fd3ca50">

- Перейдем в раздел дашборд, тут мы сможешм создать свои даш или импортровать из сайта grafana, нажимаем new и import
<img width="1358" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/6f4ccb59-5932-497b-a700-75795cef3dd2">
<img width="701" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/ec553f41-e6a8-40ea-b42a-280caf4f0398">

- Зайдем на сайт https://grafana.com/grafana/dashboards, ищем нужный дашборд, копируем его id и вставляем его при импорте:
<img width="1360" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/9715fd7b-1c37-45fe-a216-329c2c7ad0ea">
<img width="290" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/01ec9f5a-5b8c-4d53-b7a5-9fc3ca0a7b05">
<img width="678" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/3c7b2941-d141-4cac-8a12-9155e78c7abe">
<img width="759" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/263f0aad-7c13-4c6f-9841-0ccd3c6a38e5">

- После загрузки дашборда, мы увидим увидим метрики в графическом отображении
- <img width="1513" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/db72ab8c-e226-4dcb-a4b1-64e2da392dc7">


