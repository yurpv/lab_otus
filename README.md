Create Debian12.1-arm64 VM
Для лабораторных работ использую Mac OS (m1), система виртуализации vmware Fusion, тестовая vm Debian 12 ARM
Vagrantfile добавлен в репозитроий lab_otus
Обновление ядра:

Зашел на vm по ssh:
vagrant ssh

залогинился под root
su -

проврели версию ядра 
uname -r
6.1.0-12-arm64

проврелил наличие последней версии
apt-cache search linux-image
linux-image-6.1.0-18-arm64 - Linux 6.1 for 64-bit ARMv8 machines (signed)
linux-image-6.1.0-18-cloud-arm64 - Linux 6.1 for arm64 cloud (signed)
linux-image-6.1.0-18-rt-arm64 - Linux 6.1 for 64-bit ARMv8 machines, PREEMPT_RT (signed)
linux-image-arm64 - Linux for 64-bit ARMv8 machines (meta-package)

or

dpkg --list | grep linux-image
ii  linux-image-6.1.0-10-arm64   6.1.38-1                       arm64        Linux 6.1 for 64-bit ARMv8 machines (signed)
ii  linux-image-6.1.0-12-arm64   6.1.52-1                       arm64        Linux 6.1 for 64-bit ARMv8 machines (signed)
ii  linux-image-6.1.0-18-arm64   6.1.76-1                       arm64        Linux 6.1 for 64-bit ARMv8 machines (signed)
ii  linux-image-arm64            6.1.76-1                       arm64        Linux for 64-bit ARMv8 machines (meta-package)

запустил установку
apt install linux-image-6.1.0-18-arm64

установил GRUB по умолчанию
grub-set-default 6.1.0-18-arm64

перезпустил  vm
reboot

ещё раз проверил версию ядра
uname -r
6.1.0-18-arm64
