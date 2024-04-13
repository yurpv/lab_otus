Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, так при выполнении лабораторной работы постоянно стали возникать проблемы с созданием пакета и было потрачено очень много времени на выяснения причин 
пришлось данное дз сделать в cloud.vk.com, на тестовой vm Centos 8
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
