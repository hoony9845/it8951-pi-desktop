obj-m += it8951.o

KDIR ?= /lib/modules/`uname -r`/build

PICONFIG = /boot/config.txt
MODULECONFIG = /etc/modules
XCONFIG = /usr/share/X11/xorg.conf.d

default:
	$(MAKE) -C $(KDIR) M=$$PWD

install: install_module set_config set_modules set_layout rpi_overlay

uninstall: unset_config unset_modules unset_layout

clean:
	$(MAKE) -C $(KDIR) M=$$PWD clean

install_module:
	$(MAKE) -C $(KDIR) M=$$PWD modules_install
	depmod -A

set_config:
	printf "dtoverlay=it8951\n" >> $(PICONFIG)

unset_config:
	sed $(PICONFIG) -i -e "/^dtoverlay=it8951/d"

set_modules:
	printf "tinydrm\nit8951\n" >> $(MODULECONFIG)

unset_modules:
	sed $(MODULECONFIG) -i -e "/^tinydrm/d"
	sed $(MODULECONFIG) -i -e "/^it8951/d"

set_layout:
	cp 990-dualmonitor.conf $(XCONFIG)

unset_layout:
	rm $(XCONFIG)/990-dualmonitor.conf

rpi_overlay:
	dtc -I dts -O dtb -o /boot/overlays/it8951.dtbo rpi-it8951-overlay.dts