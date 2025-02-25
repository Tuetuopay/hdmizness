BRMAKE = $(MAKE) -C buildroot BR2_EXTERNAL=../
BR_OUT = buildroot/output

$(BR_OUT)/images/flash.bin: buildroot/.config
	$(BRMAKE)
buildroot/.config:
	$(BRMAKE) hdmizness_defconfig
flash: $(BR_OUT)/images/flash.bin
	$(BR_OUT)/host/bin/sunxi-fel -v -p spiflash-write 0 $(BR_OUT)/images/flash.bin
