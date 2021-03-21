################################################################################
#
# fbDOOM
#
################################################################################

FBDOOM_VERSION = master
FBDOOM_SITE = $(call github,maximevince,fbDOOM,$(FBDOOM_VERSION))
FBDOOM_LICENSE = Unknown

define FBDOOM_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/fbdoom
endef

define FBDOOM_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/fbdoom/fbdoom $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
