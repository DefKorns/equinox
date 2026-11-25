#!/bin/sh
set -eu

image=${EQUINOX_TOOLCHAIN:-ghcr.io/defkorns/classicmini-cross-toolchain:jessie-armhf}
src=$(cd "$(dirname "$0")" && pwd)
out=${1:-$src/out}
mkdir -p "$out"

docker run --rm -v "$src:/src:ro" -v "$out:/out" "$image" sh -c '
set -eu
export PATH="/opt/toolchain/bin:$PATH" ARCH=arm CROSS_COMPILE=arm-cortex_a7-linux-gnueabihf-
rm -rf /build && mkdir /build && cp -r /src/. /build/ && cd /build
rm -rf .git
make equinox_moon_defconfig
make -j"$(nproc)" zImage
cp arch/arm/boot/zImage /out/zImage
cp .config /out/config
ls -l /out/zImage
'
