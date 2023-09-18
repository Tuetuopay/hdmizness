# HDMIzness software

The business card runs a plain Buildroot build, with proper patches.

## Compiling

You need a working C compiler, a working Rust compiler with Cargo, along with the required deps for
a buildroot build. On Debian 11 this would be:

- build-essentials
- rsync

The following commands assume you are in the current directory (`software/` from the root of the
repo):

```
# Download buildroot
git submodule update --init

# Create config (ignore warnings about the Doom WAD)
make -C buildroot BR2_EXTERNAL=.. hdmizness_defconfig

# Build
make -C buildroot BR2_EXTERNAL=.. -j$(nproc)
```

A full build takes 30 minutes on a Xeon E-2246G.

Build artifacts are now present in `buildroot/output/images`, with a full image ready to be flashed
on the card as `buildroot/output/images/flash.bin`.

## Flashing

Programming the card is done over USB with Allwinner's FEL mode. The tool to flash has been built
by buildroot, and is present in the host tool directory (`buildroot/output/host/bin`) as
`sunxi-fel`.

First, the card needs to be put in FEL mode.

- If it has not been programmed before, it will boot to FEL mode once powered up.
- If it already has a working image, it needs to "fail" to boot. The easiest way is to short one of
  the SPI pins of the flash to ground (a simple DuPont jumper works fine), and to press the onboard
  Reset button. The SoC will fail to read the flash, and fallback to FEL mode.

FEL can be confirmed by listing the USB devices:

```
$ lsusb -d 1f3a:efe8
Bus 001 Device 018: ID 1f3a:efe8 Allwinner Technology sunxi SoC OTG connector in FEL/flashing mode
```

With FEL found, the card can be flashed using `sunxi-fel` (note that it needs to be run as root,
unless udev rules have been setup):

```
# buildroot/output/host/bin/sunxi-fel -v -p spiflash-write 0 buildroot/output/images/flash.bin
```

Once finished, reset the card with the onboard button. After a few seconds, the onboard LED should
switch from a solid red to a solid blue (v1 with NXP TDA HDMI transmitter) or green (v2 with Lattice
SiI HDMI transmitter). Then, it should turn white to indicate a successful Linux boot.
