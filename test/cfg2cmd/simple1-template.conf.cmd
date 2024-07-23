/usr/bin/kvm \
  -id 8006 \
  -name 'simple,debug-threads=on' \
  -no-shutdown \
  -chardev 'socket,id=qmp,path=/var/run/qemu-server/8006.qmp,server=on,wait=off' \
  -mon 'chardev=qmp,mode=control' \
  -chardev 'socket,id=qmp-event,path=/var/run/qmeventd.sock,reconnect=5' \
  -mon 'chardev=qmp-event,mode=control' \
  -pidfile /var/run/qemu-server/8006.pid \
  -daemonize \
  -smp '1,sockets=1,cores=1,maxcpus=1' \
  -nodefaults \
  -boot 'menu=on,strict=on,reboot-timeout=1000,splash=/usr/share/qemu-server/bootsplash.jpg' \
  -vga none \
  -nographic \
  -cpu qemu64 \
  -m 512 \
  -device 'pci-bridge,id=pci.1,chassis_nr=1,bus=pci.0,addr=0x1e' \
  -device 'pci-bridge,id=pci.2,chassis_nr=2,bus=pci.0,addr=0x1f' \
  -device 'piix3-usb-uhci,id=uhci,bus=pci.0,addr=0x1.0x2' \
  -device 'usb-tablet,id=tablet,bus=uhci.0,port=1' \
  -device 'virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x3,free-page-reporting=on' \
  -iscsi 'initiator-name=iqn.1993-08.org.debian:01:aabbccddeeff' \
  -drive 'if=none,id=drive-ide2,media=cdrom,aio=io_uring' \
  -device 'ide-cd,bus=ide.1,unit=0,drive=drive-ide2,id=ide2,bootindex=200' \
  -device 'virtio-scsi-pci,id=scsihw0,bus=pci.0,addr=0x5' \
  -drive 'file=/var/lib/vz/images/8006/base-8006-disk-1.qcow2,if=none,id=drive-scsi0,discard=on,format=qcow2,cache=none,aio=io_uring,detect-zeroes=unmap,readonly=on' \
  -device 'scsi-hd,bus=scsihw0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0,id=scsi0' \
  -device 'ahci,id=ahci0,multifunction=on,bus=pci.0,addr=0x7' \
  -drive 'file=/var/lib/vz/images/8006/base-8006-disk-0.qcow2,if=none,id=drive-sata0,discard=on,format=qcow2,cache=none,aio=io_uring,detect-zeroes=unmap' \
  -device 'ide-hd,bus=ahci0.0,drive=drive-sata0,id=sata0' \
  -machine 'accel=tcg,smm=off,type=pc+pve0' \
  -snapshot
