# Docker

*Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, тестовая vm alpine-standard-v3.19 ARM, Vagrantfile и все остальные конфигурационные файл добавлен в репозитроий lab_otus/Docker*

- ДЗ выполнил с помощью Vagrant и Docker, конфигурационные файлы прилагаю.

### Цель домашнего задания
Разобраться с основами docker, с образом, эко системой docker в целом:

- Docker и Docker Compose был установлен при запуске vm

- Создайте свой кастомный образ nginx на базе alpine. После запуска nginx должен отдавать кастомную страницу (достаточно изменить дефолтную страницу nginx):
  Для выполнения этого пункта6 необходимо запустить команду на тестовой вм:
```
docker run -d -p 80:80 -t -i yurpv/otus_lab:1.0
```
проверяем образ и запущеный контейнер:
```
/home/vagrant # docker images
REPOSITORY       TAG       IMAGE ID       CREATED             SIZE
yurpv/otus_lab   1.0       83c6a60b4af1   About an hour ago   10.4MB

/home/vagrant # docker ps
CONTAINER ID   IMAGE                COMMAND                  CREATED         STATUS         PORTS                               NAMES
839bebcaf0c5   yurpv/otus_lab:1.0   "nginx -g 'daemon of…"   2 minutes ago   Up 2 minutes   0.0.0.0:80->80/tcp, :::80->80/tcp   vigilant_edison
```

проверяем измененную стартовую стринцу Nginx
<img width="941" alt="image" src="https://github.com/yurpv/lab_otus/assets/162872411/32e762dd-b6c3-4f72-b4f6-7c97ae7da080">

- Определите разницу между контейнером и образом

Образ - это шаблон приложения, из которого создаются контейнеры. С помощью образа можно запустить несколько контейнров.
Контейнер — это инстанс, служащие для запуска приложений. Каждый контейнер представляет собой пакет ПО, который содержит код.

-Ответьте на вопрос: Можно ли в контейнере собрать ядро?

Да возможно, не буду переписывать решение, оставил ссылки на первоисточник:
https://github.com/0xor0ne/docker-linux-kernel-builder
https://hub.docker.com/r/tomzo/buildkernel/#!&_escaped_fragment_=
