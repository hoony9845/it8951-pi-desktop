obj-m += it8951.o

KDIR ?= /lib/modules/`uname -r`/build

default:
	$(MAKE) -C $(KDIR) M=$$PWD

install:
	$(MAKE) -C $(KDIR) M=$$PWD modules_install

clean:
	$(MAKE) -C $(KDIR) M=$$PWD clean

rpi_overlay:
	dtc -I dts -O dtb -o /boot/overlays/it8951.dtbo rpi-overlays/it8951-overlay.dts
