Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, так при выполнении лабораторной работы постоянно стали возникать проблемы с созданием пакета и было потрачено очень много времени на выяснения причин 
пришлось данное дз сделать в cloud.vk.com, на тестовой vm Centos 8.
P.S. как будет больше времени, обязательно вернусь к этой теме
<img width="1431" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/7f6bf1ba-9ca7-4858-9c3d-7117aa422c9d">

# Создать свой RPM пакет

- Перед тем как начинать, обновил систему и доставил необходимые компоненты
```
[centos@test yum.repos.d]$ sudo dnf update
CentOS Linux 8 - AppStream                                                                                                                      329 kB/s | 8.4 MB     00:26    
CentOS Linux 8 - BaseOS                                                                                                                         181 kB/s | 4.6 MB     00:25    
CentOS Linux 8 - Extras                                                                                                                         711  B/s |  11 kB     00:15    
Dependencies resolved.
================================================================================================================================================================================
 Package                                           Architecture              Version                                                         Repository                    Size
================================================================================================================================================================================
Installing:
 kernel                                            x86_64                    4.18.0-348.7.1.el8_5                                            baseos                       7.0 M
 kernel-core                                       x86_64                    4.18.0-348.7.1.el8_5                                            baseos                        38 M
 kernel-modules                                    x86_64                    4.18.0-348.7.1.el8_5                                            baseos                        30 M
```
```
[centos@test yum.repos.d]$ yum install -y redhat-lsb-core wget rpmdevtools rpm-build createrepo yum-utils gcc
 perl-constant-1.33-396.el8.noarch            perl-interpreter-4:5.26.3-420.el8.x86_64                        perl-libnet-3.11-3.el8.noarch                                  
  perl-libs-4:5.26.3-420.el8.x86_64            perl-macros-4:5.26.3-420.el8.x86_64                             perl-parent-1:0.237-1.el8.noarch                               
  perl-podlators-4.11-1.el8.noarch             perl-threads-1:2.21-2.el8.x86_64                                perl-threads-shared-1.58-2.el8.x86_64                          
  rpm-build-4.14.3-19.el8.x86_64               rpmdevtools-8.10-8.el8.noarch                                   yum-utils-4.0.21-3.el8.noarch                                  
  zstd-1.4.4-1.el8.x86_64                     

Complete!
```

- Для примера возьмем пакет NGINX и соберем его с поддержкой openssl
- Загрузим SRPM пакет NGINX для дальнейшей работы над ним
```
[root@test ~]# wget https://github.com/openssl/openssl/archive/refs/heads/
--2024-04-13 12:28:37--  https://github.com/openssl/openssl/archive/refs/heads/
Resolving github.com (github.com)... ^C
[root@test ~]# wget https://github.com/openssl/openssl/archive/refs/heads/OpenSSL_1_1_1-stable.zip
--2024-04-13 12:28:50--  https://github.com/openssl/openssl/archive/refs/heads/OpenSSL_1_1_1-stable.zip
Resolving github.com (github.com)... 140.82.121.3
Connecting to github.com (github.com)|140.82.121.3|:443... connected.
HTTP request sent, awaiting response... 302 Found
Location: https://codeload.github.com/openssl/openssl/zip/refs/heads/OpenSSL_1_1_1-stable [following]
--2024-04-13 12:28:55--  https://codeload.github.com/openssl/openssl/zip/refs/heads/OpenSSL_1_1_1-stable
Resolving codeload.github.com (codeload.github.com)... 140.82.121.9
Connecting to codeload.github.com (codeload.github.com)|140.82.121.9|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: unspecified [application/zip]
Saving to: ‘OpenSSL_1_1_1-stable.zip’

OpenSSL_1_1_1-stable.zip                        [      <=>                                                                                   ]  11.37M  6.94MB/s    in 1.6s    

2024-04-13 12:29:02 (6.94 MB/s) - ‘OpenSSL_1_1_1-stable.zip’ saved [11924330]
```

- При установке такого пакета в домашней директории создается древо каталогов для
сборки
```
[root@test ~]# rpm -i nginx-1.*
warning: nginx-1.20.2-1.el8.ngx.src.rpm: Header V4 RSA/SHA1 Signature, key ID 7bd9bf62: NOKEY
```

- Cкачаем и разархивируем исходник для openssl, который потребуется при сборке
```
[root@test ~]# wget https://github.com/openssl/openssl/archive/refs/heads/
--2024-04-13 12:28:37--  https://github.com/openssl/openssl/archive/refs/heads/
Resolving github.com (github.com)... ^C
[root@test ~]# wget https://github.com/openssl/openssl/archive/refs/heads/OpenSSL_1_1_1-stable.zip
--2024-04-13 12:28:50--  https://github.com/openssl/openssl/archive/refs/heads/OpenSSL_1_1_1-stable.zip
Resolving github.com (github.com)... 140.82.121.3
Connecting to github.com (github.com)|140.82.121.3|:443... connected.
HTTP request sent, awaiting response... 302 Found
Location: https://codeload.github.com/openssl/openssl/zip/refs/heads/OpenSSL_1_1_1-stable [following]
--2024-04-13 12:28:55--  https://codeload.github.com/openssl/openssl/zip/refs/heads/OpenSSL_1_1_1-stable
Resolving codeload.github.com (codeload.github.com)... 140.82.121.9
Connecting to codeload.github.com (codeload.github.com)|140.82.121.9|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: unspecified [application/zip]
Saving to: ‘OpenSSL_1_1_1-stable.zip’

OpenSSL_1_1_1-stable.zip                        [      <=>

root@test ~]# unzip ./OpenSSL_1_1_1-stable.zip 
Archive:  ./OpenSSL_1_1_1-stable.zip
b372b1f76450acdfed1e2301a39810146e28b02c
   creating: openssl-OpenSSL_1_1_1-stable/
  inflating: openssl-OpenSSL_1_1_1-stable/ACKNOWLEDGEMENTS  
  inflating: openssl-OpenSSL_1_1_1-stable/AUTHORS  
  inflating: openssl-OpenSSL_1_1_1-stable/CHANGES  
  inflating: openssl-OpenSSL_1_1_1-stable/CONTRIBUTING  
  creating: openssl-OpenSSL_1_1_1-stable/Configurations/
  inflating: openssl-OpenSSL_1_1_1-stable/Configurations/00-base-templates.conf
  inflating: openssl-OpenSSL_1_1_1-stable/util/perl/with_fallback.pm  
  inflating: openssl-OpenSSL_1_1_1-stable/util/private.num  
  inflating: openssl-OpenSSL_1_1_1-stable/util/process_docs.pl  
  inflating: openssl-OpenSSL_1_1_1-stable/util/shlib_wrap.sh.in  
  inflating: openssl-OpenSSL_1_1_1-stable/util/su-filter.pl  
  inflating: openssl-OpenSSL_1_1_1-stable/util/unlocal_shlib.com.in  
   creating: openssl-OpenSSL_1_1_1-stable/wycheproof/
[root@test ~]# yum-builddep rpmbuild/SPECS/nginx.spec
```

- Поставим все зависимости, чтобы в процессе сборки не было ошибок
```
[root@test ~]# yum-builddep rpmbuild/SPECS/nginx.spec
Last metadata expiration check: 0:01:56 ago on Sat 13 Apr 2024 12:27:48 PM UTC.
Package systemd-239-51.el8_5.2.x86_64 is already installed.
Dependencies resolved.
================================================================================================================================================================================
 Package                                          Architecture                        Version                                         Repository                           Size
================================================================================================================================================================================
Installing:
 openssl-devel                                    x86_64                              1:1.1.1k-5.el8_5                                baseos                              2.3 M
 pcre-devel                                       x86_64                              8.42-6.el8                                      baseos                              551 k
 zlib-devel                                       x86_64                              1.2.11-17.el8                                   baseos                               58 k
Installing dependencies:
 keyutils-libs-devel                              x86_64                              1.5.10-9.el8                                    baseos                               48 k
 krb5-devel                                       x86_64                              1.18.2-14.el8                                   baseos                              560 k
 libcom_err-devel                                 x86_64                              1.45.6-2.el8                                    baseos                               38 k
 libkadm5                                         x86_64                              1.18.2-14.el8                                   baseos                              187 k
 libselinux-devel                                 x86_64                              2.9-5.el8                                       baseos                              200 k
 libsepol-devel                                   x86_64                              2.9-3.el8                                       baseos                               87 k
 libverto-devel                                   x86_64                              0.3.0-5.el8                                     baseos                               18 k
 pcre-cpp                                         x86_64                              8.42-6.el8                                      baseos                               47 k
 pcre-utf16                                       x86_64                              8.42-6.el8                                      baseos                              195 k
 pcre-utf32                                       x86_64                              8.42-6.el8                                      baseos                              186 k
 pcre2-devel                                      x86_64                              10.32-2.el8                                     baseos                              605 k
 pcre2-utf16                                      x86_64                              10.32-2.el8                                     baseos                              229 k
 pcre2-utf32                                      x86_64                              10.32-2.el8                                     baseos                              220 k

Transaction Summary
================================================================================================================================================================================
Install  16 Packages
---

Installed:
  keyutils-libs-devel-1.5.10-9.el8.x86_64        krb5-devel-1.18.2-14.el8.x86_64        libcom_err-devel-1.45.6-2.el8.x86_64        libkadm5-1.18.2-14.el8.x86_64               
  libselinux-devel-2.9-5.el8.x86_64              libsepol-devel-2.9-3.el8.x86_64        libverto-devel-0.3.0-5.el8.x86_64           openssl-devel-1:1.1.1k-5.el8_5.x86_64       
  pcre-cpp-8.42-6.el8.x86_64                     pcre-devel-8.42-6.el8.x86_64           pcre-utf16-8.42-6.el8.x86_64                pcre-utf32-8.42-6.el8.x86_64                
  pcre2-devel-10.32-2.el8.x86_64                 pcre2-utf16-10.32-2.el8.x86_64         pcre2-utf32-10.32-2.el8.x86_64              zlib-devel-1.2.11-17.el8.x86_64             

Complete!
```

- Поправить сам nginx.spec файл, чтобы NGINX собирался с необходимыми нам опциями:
```
[root@test ~]# vi /root/rpmbuild/SPECS/nginx.spec 
---
%build
./configure %{BASE_CONFIGURE_ARGS} \
    --with-cc-opt="%{WITH_CC_OPT}" \
    --with-ld-opt="%{WITH_LD_OPT}" \
    --with-debug \
    --with-openssl=/root/openssl-OpenSSL_1_1_1-stable
make %{?_smp_mflags}
%{__mv} %{bdir}/objs/nginx \
    %{bdir}/objs/nginx-debug
./configure %{BASE_CONFIGURE_ARGS} \
    --with-cc-opt="%{WITH_CC_OPT}" \
    --with-ld-opt="%{WITH_LD_OPT}"
make %{?_smp_mflags}
```

- Приступаем к сборке RPM пакета:
```
[root@test ~]# rpmbuild -bb rpmbuild/SPECS/nginx.spec
---
Executing(%check): /bin/sh -e /var/tmp/rpm-tmp.bNjG46
+ umask 022
+ cd /root/rpmbuild/BUILD
+ cd nginx-1.20.2
+ /usr/bin/rm -rf /root/rpmbuild/BUILDROOT/nginx-1.20.2-1.el8.ngx.x86_64/usr/src
+ cd /root/rpmbuild/BUILD/nginx-1.20.2
+ grep -v usr/src debugfiles.list
+ mv debugfiles.list.new debugfiles.list
+ cat /dev/null
+ exit 0
Processing files: nginx-1.20.2-1.el8.ngx.x86_64
Provides: config(nginx) = 1:1.20.2-1.el8.ngx nginx = 1:1.20.2-1.el8.ngx nginx(x86-64) = 1:1.20.2-1.el8.ngx nginx-r1.20.2 webserver
```

- Убедимся, в создании пакета:
```
[root@test ~]# ll rpmbuild/RPMS/x86_64/
total 4676
-rw-r--r--. 1 root root 2250096 Apr 13 12:35 nginx-1.20.2-1.el8.ngx.x86_64.rpm
-rw-r--r--. 1 root root 2533120 Apr 13 12:36 nginx-debuginfo-1.20.2-1.el8.ngx.x86_64.rpm
```

- Установим наш пакет и проверим, что nginx работает
```
[root@test ~]# yum localinstall -y /root/rpmbuild/RPMS/x86_64/nginx-1.20.2-1.el8.ngx.x86_64.rpm
Last metadata expiration check: 0:21:40 ago on Sat 13 Apr 2024 12:27:48 PM UTC.
Dependencies resolved.
================================================================================================================================================================================
 Package                              Architecture                          Version                                           Repository                                   Size
================================================================================================================================================================================
Installing:
 nginx                                x86_64                                1:1.20.2-1.el8.ngx                                @commandline                                2.1 M

Transaction Summary
================================================================================================================================================================================
Install  1 Package

----------------------------------------------------------------------

  Verifying        : nginx-1:1.20.2-1.el8.ngx.x86_64                                                                                                                        1/1 

Installed:
  nginx-1:1.20.2-1.el8.ngx.x86_64                                                                                                                                               

Complete!
[root@test ~]# systemctl start nginx
[root@test ~]# systemctl status nginx
● nginx.service - nginx - high performance web server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; vendor preset: disabled)
   Active: active (running) since Sat 2024-04-13 12:49:42 UTC; 4s ago
     Docs: http://nginx.org/en/docs/
  Process: 52879 ExecStart=/usr/sbin/nginx -c /etc/nginx/nginx.conf (code=exited, status=0/SUCCESS)
 Main PID: 52880 (nginx)
    Tasks: 2 (limit: 12360)
   Memory: 1.9M
   CGroup: /system.slice/nginx.service
           ├─52880 nginx: master process /usr/sbin/nginx -c /etc/nginx/nginx.conf
           └─52881 nginx: worker process

Apr 13 12:49:42 test.novalocal systemd[1]: Starting nginx - high performance web server...
Apr 13 12:49:42 test.novalocal systemd[1]: Started nginx - high performance web server.
```

## Создать свой репозиторий и разместить там ранее собранный RPM

- Директория для статики у NGINX по умолчанию /usr/share/nginx/html. Создадим там каталог repo
```
[root@test ~]# mkdir /usr/share/nginx/html/repo
``` 

- Скопируем туда наш собранный RPM и RPM для установки репозитория Percona-Server:
```
cp ./rpmbuild/RPMS/x86_64/nginx-1.20.2-1.el8.ngx.x86_64.rpm /usr/share/nginx/html/repo/

[root@test ~]# wget https://downloads.percona.com/downloads/percona-distribution-mysql-ps/percona-distribution-mysql-ps-8.0.28/binary/redhat/8/x86_64/percona-orchestrator-3.2.6-2.el8.x86_64.rpm -O /usr/share/nginx/html/repo/percona-orchestrator-3.2.6-2.el8.x86_64.rpm
--2024-04-13 12:52:13--  https://downloads.percona.com/downloads/percona-distribution-mysql-ps/percona-distribution-mysql-ps-8.0.28/binary/redhat/8/x86_64/percona-orchestrator-3.2.6-2.el8.x86_64.rpm
Resolving downloads.percona.com (downloads.percona.com)... 49.12.125.205, 2a01:4f8:242:5792::2
Connecting to downloads.percona.com (downloads.percona.com)|49.12.125.205|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 5222976 (5.0M) [application/x-redhat-package-manager]
Saving to: ‘/usr/share/nginx/html/repo/percona-orchestrator-3.2.6-2.el8.x86_64.rpm’

/usr/share/nginx/html/repo/percona-orchestr 100%[===========================================================================================>]   4.98M  14.4MB/s    in 0.3s    

2024-04-13 12:52:19 (14.4 MB/s) - ‘/usr/share/nginx/html/repo/percona-orchestrator-3.2.6-2.el8.x86_64.rpm’ saved [5222976/5222976]
```

- Инициализируем репозиторий
```
[root@test ~]# createrepo /usr/share/nginx/html/repo/
Directory walk started
Directory walk done - 2 packages
Temporary output repo path: /usr/share/nginx/html/repo/.repodata/
Preparing sqlite DBs
Pool started (with 5 workers)
Pool finished
```

- настроим в NGINX доступ к листингу каталога. В location / в файле /etc/nginx/conf.d/default.conf добавим директиву autoindex on.
```
server {
    listen       80;
    server_name  localhost;

    #access_log  /var/log/nginx/host.access.log  main;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
        autoindex on;
    }
```

- Проверяем синтаксис и перезапускаем NGINX
```
[root@test ~]# nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
[root@test ~]# nginx -s reload
```

- Теперь можно через curl посмотреть результат
```
[root@test ~]# curl -a http://localhost/repo/
<html>
<head><title>Index of /repo/</title></head>
<body>
<h1>Index of /repo/</h1><hr><pre><a href="../">../</a>
<a href="repodata/">repodata/</a>                                          13-Apr-2024 12:52                   -
<a href="nginx-1.20.2-1.el8.ngx.x86_64.rpm">nginx-1.20.2-1.el8.ngx.x86_64.rpm</a>                  13-Apr-2024 12:51             2250096
<a href="percona-orchestrator-3.2.6-2.el8.x86_64.rpm">percona-orchestrator-3.2.6-2.el8.x86_64.rpm</a>        16-Feb-2022 15:57             5222976
</pre><hr></body>
</html>
```

- Добавим репозиторий в /etc/yum.repos.d
```
[root@test ~]# cat >> /etc/yum.repos.d/otus.repo << EOF
> [otus]
> name=otus-linux
> baseurl=http://localhost/repo
> gpgcheck=0
> enabled=1
> EOF
```

- Убедимся, что репозиторий подключился и посмотрим, что в нем есть
```
[root@test ~]#  yum repolist enabled | grep otus
otus                            otus-linux
[root@test ~]#  yum list | grep otus
otus-linux                                      197 kB/s | 2.8 kB     00:00    
percona-orchestrator.x86_64                            2:3.2.6-2.el8                                          otus         
```

- Установим репозиторий percona-release
```
[root@test ~]# yum install percona-orchestrator.x86_64 -y
Last metadata expiration check: 0:00:25 ago on Sat 13 Apr 2024 12:55:22 PM UTC.
Dependencies resolved.
================================================================================================================================================================================
 Package                                           Architecture                        Version                                     Repository                              Size
================================================================================================================================================================================
Installing:
 percona-orchestrator                              x86_64                              2:3.2.6-2.el8                               otus                                   5.0 M
Installing dependencies:
 jq                                                x86_64                              1.5-12.el8                                  appstream                              161 k
 oniguruma                                         x86_64                              6.8.2-2.el8                                 appstream                              187 k

Transaction Summary
================================================================================================================================================================================
Install  3 Packages

```
<img width="866" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/a984798d-b708-405c-8273-e785a670ab21">
