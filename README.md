# My proxmox

Скачиваем базовый образ для установки. https://cloud-images.ubuntu.com/focal/current/
Заходим в консоль proxmox.
Переходим в каталог для хранения iso образов 
cd /var/lib/vz/template/iso/
скачиваем нужный образ
wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img

Устанавливаем в proxmox дополнительные средства 
apt update -y && apt install libguestfs-tools -y

Добавляем в скачанный образ агента
virt-customize -a focal-server-cloudimg-amd64.img --install qemu-guest-agent

Дополнительно можно настроить дополнительные параметры

virt-customize -a focal-server-cloudimg-amd64.img --run-command 'useradd username'
virt-customize -a focal-server-cloudimg-amd64.img --run-command 'mkdir -p /home/username/.ssh'

virt-customize -a focal-server-cloudimg-amd64.img --ssh-inject username:file:~/.ssh/id_rsa.pub
virt-customize -a focal-server-cloudimg-amd64.img --run-command 'chown -R username:username /home/username'

Создаём темплейт
qm create 9000 --name "ubuntu-2004-cloudinit-template" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
Импортируем в него настроенный образ
qm importdisk 9000 focal-server-cloudimg-amd64.img local-lvm
Настраиваем параметры машины
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0
qm set 9000 --boot c --bootdisk scsi0
qm set 9000 --ide2 local-lvm:cloudinit
qm set 9000 --serial0 socket --vga serial0
qm set 9000 --agent enabled=1

Проверяем работоспособность темплейта. Создаём из него виртуальную машину.
qm clone 9000 999 --name test-clone-cloud-init
Устанавливаем публичный ключ своего текущего аккаунта.
qm set 999 --sshkey ~/.ssh/id_rsa.pub
Устанавливаем IP адрес
qm set 999 --ipconfig0 ip=192.168.1.99/24,gw=192.168.1.254
Запускаем
qm start 999
Наблюдаем процесс клонирования в админском интерфейсе proxmox.\
Если машина появилась и перешла в состояние running, проверяем что всё ок
ssh ubuntu@192.168.1.99
Если удалось соединиться, то всё ок и можно использовать темплейт для создания виртуальных машин.
Удаляем тестовую машину
 qm stop 999 && qm destroy 999
 Можно удалить скачанный образ.
 rm focal-server-cloudimg-amd64.img

 Настраиваем terraform
 Ключевые файлы
 provider.tf
 vars.tf
 proxmox.tf
 
