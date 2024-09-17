# Postgresql
Для лабораторных работ использую Macbook Air M2 чипсет amr64, OS Sonoma 14.6.1, система виртуализации VMware Fusion, при выполнении лабораторной работы использовал образ vagrantbox bento/ubuntu-22.04.

## Цель домашнего задания
Научиться настраивать репликацию и создавать резервные копии в СУБД PostgreSQL

- Цель
1) Настроить hot_standby репликацию с использованием слотов
2) Настроить правильное резервное копирование

## Выполнение

- Разворачиваем виртуалки в Vagrant (master,slave,barman) с помощью Ansible устанавливаем postgresql 16 и barman 3.* версии и донастроиваем сервера.

```
Postrgresql % vagrant up
Bringing machine 'master' up with 'vmware_desktop' provider...
Bringing machine 'slave' up with 'vmware_desktop' provider...
Bringing machine 'barman' up with 'vmware_desktop' provider...
==> master: Checking if box 'bento/ubuntu-22.04' version '202401.31.0' is up to date...
==> master: Verifying vmnet devices are healthy...
==> master: Starting the VMware VM...
==> master: Waiting for the VM to receive an address...
==> master: Forwarding ports...
    master: -- 22 => 2222
==> master: Waiting for machine to boot. This may take a few minutes...
    master: SSH address: 172.16.203.171:22
    master: SSH username: vagrant
    master: SSH auth method: password
==> master: Machine booted and ready!
==> slave: Checking if box 'bento/ubuntu-22.04' version '202401.31.0' is up to date...
==> slave: Verifying vmnet devices are healthy...
==> slave: Fixed port collision for 22 => 2222. Now on port 2200.
==> slave: Starting the VMware VM...
==> slave: Waiting for the VM to receive an address...
==> slave: Forwarding ports...
    slave: -- 22 => 2200
==> slave: Waiting for machine to boot. This may take a few minutes...
    slave: SSH address: 172.16.203.172:22
    slave: SSH username: vagrant
    slave: SSH auth method: password
==> slave: Machine booted and ready!
==> barman: Checking if box 'bento/ubuntu-22.04' version '202401.31.0' is up to date...
==> barman: Verifying vmnet devices are healthy...
==> barman: Fixed port collision for 22 => 2222. Now on port 2201.
==> barman: Starting the VMware VM...
==> barman: Waiting for the VM to receive an address...
==> barman: Forwarding ports...
    barman: -- 22 => 2201
==> barman: Waiting for machine to boot. This may take a few minutes...
    barman: SSH address: 172.16.203.173:22
    barman: SSH username: vagrant
    barman: SSH auth method: password
==> barman: Machine booted and ready!
```

<details><summary>ansible-playbook postgresql.yaml</summary>
    
```
Postrgresql % ansible-playbook postgresql.yaml                        

PLAY [all] *******************************************************************************************************************************************************************************************************

TASK [update] ****************************************************************************************************************************************************************************************************
ok: [slave]
ok: [master]
ok: [barman]

TASK [Upgrade all packages] **************************************************************************************************************************************************************************************
changed: [slave]
changed: [master]
changed: [barman]

TASK [Set timezone to Europe/Moscow] *****************************************************************************************************************************************************************************
ok: [slave]
ok: [barman]
ok: [master]

TASK [Install required packages] *********************************************************************************************************************************************************************************
ok: [master]
ok: [barman]
ok: [slave]

TASK [Set up Postgres repo] **************************************************************************************************************************************************************************************
changed: [barman]
changed: [master]
changed: [slave]

TASK [Download PostgreSQL key and add it to system keyring] ******************************************************************************************************************************************************
ok: [barman]
ok: [master]
ok: [slave]

PLAY [DB] ********************************************************************************************************************************************************************************************************

TASK [Update apt cache] ******************************************************************************************************************************************************************************************
ok: [master]
ok: [slave]

TASK [Install PostgreSQL] ****************************************************************************************************************************************************************************************
ok: [master]
ok: [slave]

PLAY [barman] ****************************************************************************************************************************************************************************************************

TASK [Update apt cache] ******************************************************************************************************************************************************************************************
ok: [barman]

TASK [Install PostgreSQL] ****************************************************************************************************************************************************************************************
ok: [barman]

PLAY [install postgres 16 and set up replication] ****************************************************************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************************************************************************************
ok: [master]
ok: [slave]

TASK [postgres_master : Create a Superuser PostgreSQL database user] *********************************************************************************************************************************************
skipping: [slave]
ok: [master]

TASK [postgres_master : copy postgresql.conf] ********************************************************************************************************************************************************************
skipping: [slave]
ok: [master]

TASK [postgres_master : copy pg_hba.conf] ************************************************************************************************************************************************************************
skipping: [slave]
ok: [master]

TASK [postgres_master : Restart Postgresql] **********************************************************************************************************************************************************************
skipping: [slave]
changed: [master]

TASK [postgres_replication : stop postgresql-server on slave] ****************************************************************************************************************************************************
skipping: [master]
changed: [slave]

TASK [postgres_replication : Remove files from data catalog] *****************************************************************************************************************************************************
skipping: [master]
changed: [slave]

TASK [postgres_replication : copy files from master to slave] ****************************************************************************************************************************************************
skipping: [master]
changed: [slave]

TASK [postgres_replication : Ensure PostgreSQL is listening] *****************************************************************************************************************************************************
skipping: [master]
ok: [slave]

TASK [postgres_replication : Restart Postgresql] *****************************************************************************************************************************************************************
skipping: [master]
changed: [slave]

PLAY [install and setting barman] ********************************************************************************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************************************************************************************
ok: [barman]
ok: [master]
ok: [slave]

TASK [barman : install base tools] *******************************************************************************************************************************************************************************
skipping: [master]
skipping: [slave]
ok: [barman]

TASK [barman : install barman and postgresql packages on barman] *************************************************************************************************************************************************
skipping: [master]
skipping: [slave]
ok: [barman]

TASK [barman : install barman-cli and postgresql packages on nodes] **********************************************************************************************************************************************
skipping: [master]
ok: [slave]
ok: [barman]

TASK [barman : generate SSH key for postgres] ********************************************************************************************************************************************************************
skipping: [slave]
skipping: [barman]
ok: [master]

TASK [barman : generate SSH key for barman] **********************************************************************************************************************************************************************
skipping: [master]
skipping: [slave]
ok: [barman]

TASK [barman : fetch all public ssh keys master] *****************************************************************************************************************************************************************
skipping: [slave]
skipping: [barman]
changed: [master]

TASK [barman : transfer public key to barman] ********************************************************************************************************************************************************************
skipping: [slave]
skipping: [barman]
ok: [master -> barman(192.168.57.13)]

TASK [barman : fetch all public ssh keys barman] *****************************************************************************************************************************************************************
skipping: [master]
skipping: [slave]
changed: [barman]

TASK [barman : transfer public key to barman] ********************************************************************************************************************************************************************
skipping: [master]
skipping: [slave]
ok: [barman -> master(192.168.57.11)]

TASK [barman : Create barman user] *******************************************************************************************************************************************************************************
skipping: [slave]
skipping: [barman]
ok: [master]

TASK [barman : restart postgresql-server on master] **************************************************************************************************************************************************************
skipping: [slave]
skipping: [barman]
changed: [master]

TASK [barman : Create DB for backup] *****************************************************************************************************************************************************************************
skipping: [slave]
skipping: [barman]
ok: [master]

TASK [barman : Add tables to otus_backup] ************************************************************************************************************************************************************************
skipping: [slave]
skipping: [barman]
ok: [master]

TASK [barman : copy .pgpass] *************************************************************************************************************************************************************************************
skipping: [master]
skipping: [slave]
ok: [barman]

TASK [barman : copy barman.conf] *********************************************************************************************************************************************************************************
skipping: [master]
skipping: [slave]
ok: [barman]

TASK [barman : copy master.conf] *********************************************************************************************************************************************************************************
skipping: [master]
skipping: [slave]
changed: [barman]

TASK [barman : barman switch-wal master] *************************************************************************************************************************************************************************
skipping: [master]
skipping: [slave]
changed: [barman]

TASK [barman : barman cron] **************************************************************************************************************************************************************************************
skipping: [master]
skipping: [slave]
changed: [barman]

PLAY RECAP *******************************************************************************************************************************************************************************************************
barman                     : ok=20   changed=6    unreachable=0    failed=0    skipped=7    rescued=0    ignored=0   
master                     : ok=21   changed=5    unreachable=0    failed=0    skipped=16   rescued=0    ignored=0   
slave                      : ok=16   changed=6    unreachable=0    failed=0    skipped=21   rescued=0    ignored=0   

```
