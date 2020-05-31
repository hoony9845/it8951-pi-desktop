obj-m += it8951.o

KDIR ?= /lib/modules/`uname -r`/build
MODULEDIR := kernel/drivers/gpu/drm/tinydrm

PICONFIG=/boot/config.txt
MODULECONFIG=/etc/modules

default:
	$(MAKE) -C $(KDIR) M=$$PWD

install: install_module set_config set_modules set_layout rpi_overlay
	depmod -A

clean:
	$(MAKE) -C $(KDIR) M=$$PWD clean

install_module:
	$(MAKE) -C $(KDIR) M=$$PWD INSTALL_MOD_DIR=$(MODULEDIR) modules_install

set_config:
	printf "\ndtoverlay=it8951\n" >> $(PICONFIG)

set_modules:
	printf "\ntinydrm\nit8951\n" >> $(MODULECONFIG)

set_layout:
	cp 990-dualmonitor.conf /usr/share/X11/xorg.conf.d/

rpi_overlay:
	dtc -I dts -O dtb -o /boot/overlays/it8951.dtbo rpi-it8951-overlay.dts