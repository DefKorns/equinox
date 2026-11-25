# Equinox

The Linux kernel of the Sega Mega Drive Mini, built from source and kept up to date.

It is Sega's official 3.4.113 tree (the Allwinner R16 BSP) with a set of security fixes on top.
It is the kernel the Unbound installer boots into the console's RAM, and the one `unbound moon install` runs from.
Nothing here is written to the console's flash by default.

## Branches

| Branch | What it is |
| --- | --- |
| `main` | Sega's official open-source kernel for the Mega Drive Mini (`linux-z7213.tar.gz` from the console's source archive), exactly as published. |
| `unbound` | `main` plus our commits. This is the branch to build. |

## What `unbound` changes

1. **Line endings.** The few text files that use CRLF are converted to LF.
2. **36 security fixes** from the upstream stable releases (USB, HID, ALSA, ext4, futex, perf, packet sockets, Bluetooth, cfg80211, block, net and others), one commit each with its original author and message. Fixes that do not apply to this code are left out on purpose.
3. **`arch/arm/configs/equinox_moon_defconfig`**, the configuration of the console's own kernel (read back from the firmware, so the same drivers) with nothing added.
4. This README and a build script.

The release string stays `3.4.113`, so the console's own modules (Mali and the others) still load.

## Building

You need Docker and the cross toolchain image `ghcr.io/defkorns/classicmini-cross-toolchain:jessie-armhf` (GCC 4.9, hard float).
The tree has file names that differ only in case (`xt_DSCP.h` and `xt_dscp.h`), so clone and build it on a case-sensitive file system (Linux, WSL, or a Docker volume), not on a default Windows or macOS folder.

```sh
./build-equinox.sh
```

The result is `out/zImage`. Wrapping it for U-Boot (`mkimage` with load and entry address `0x40008000`) is done by the installer.

## Licence

GPL-2.0 only, as the Linux kernel. See `COPYING`.
