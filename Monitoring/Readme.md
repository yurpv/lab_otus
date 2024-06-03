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

