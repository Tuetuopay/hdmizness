################################################################################
#
# kbdsrv
#
################################################################################

KBDSRV_VERSION = master
KBDSRV_SITE = $(call github,Tuetuopay,kbdsrv,$(KBDSRV_VERSION))
KBDSRV_LICENSE = MIT
KBDSRV_CARGO_ENV = RUSTFLAGS="-Clink-arg=-Wl,--allow-multiple-definition -Copt-level=s -Clto=fat -Ccodegen-units=1 -Cembed-bitcode=yes"

$(eval $(cargo-package))
