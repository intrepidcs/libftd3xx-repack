#!/bin/bash

. common.sh

VERSION="1.0.16"

rm -fr "$TMP"
mkdir -p "$TMP" "$DIST"

repack_linux()
{
    local url="$1"
    local ics_arch="$2"
    shift 2

    rm -fr "$TMP"
    mkdir -p "$TMP"
    cd "$TMP"

    fetch "$url" "$TMP/src"

    mkdir "$TMP/libftd3xx-static"
    cd "$TMP/libftd3xx-static"
    ar -x "$TMP/src/libftd3xx-static.a"
    rm core.o io.o linux_netlink.o sync.o descriptor.o events_posix.o linux_usbfs.o strerror.o threads_posix.o
    mkdir -p "$TMP/libftd3xx-$VERSION-linux-$ics_arch"
    ar -r "$TMP/libftd3xx-$VERSION-linux-$ics_arch/libftd3xx.a" *.o
    cp "$TMP/src/"{ftd3xx.h,Types.h} "$TMP/libftd3xx-$VERSION-linux-$ics_arch"
    
    cd "$TMP"
    zip -r -9 "$DIST/libftd3xx-$VERSION-linux-$ics_arch.zip" "libftd3xx-$VERSION-linux-$ics_arch"
}

repack_linux "https://ftdichip.com/wp-content/uploads/2024/07/libftd3xx-linux-x86_64-$VERSION.tgz" "x64"
repack_linux "https://ftdichip.com/wp-content/uploads/2024/07/libftd3xx-linux-arm-v7_32-$VERSION.tgz" "armhf"
repack_linux "https://ftdichip.com/wp-content/uploads/2024/07/libftd3xx-linux-arm-v8-$VERSION.tgz" "aarch64"
