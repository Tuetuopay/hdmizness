BRMAKE = $(MAKE) -C buildroot BR2_EXTERNAL

buildroot/output/images/flash.bin: buildroot/.config
	$(BRMAKE)
buildroot/.config:
	$(BRMAKE) hdmizness_defconfig
