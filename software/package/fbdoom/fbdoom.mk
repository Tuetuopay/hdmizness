################################################################################
#
# fbDOOM
#
################################################################################

FBDOOM_VERSION = b9aada4
FBDOOM_SITE = $(call github,Tuetuopay,fbDOOM,$(FBDOOM_VERSION))
FBDOOM_LICENSE = Unknown

define FBDOOM_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) NOSDL=1 ARCH=arm -C $(@D)/fbdoom
endef

define FBDOOM_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/fbdoom/fbdoom $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
