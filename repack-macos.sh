#!/bin/bash

. common.sh

VERSION="1.0.14"

rm -fr "$TMP"
mkdir -p "$TMP" "$DIST"

fetch "https://ftdichip.com/wp-content/uploads/2023/06/d3xx-osx.$VERSION.tgz" "$SRC"

mkdir -p "$TMP/libftd3xx-static"
cd "$TMP/libftd3xx-static"

repack()
{
    local arch="$1"
    shift

    lipo -thin "$arch" "$SRC/libftd3xx-static.a" -output "$TMP/libftd3xx-static/$arch.a"

    mkdir -p "$TMP/libftd3xx-static/$arch"
    cd "$TMP/libftd3xx-static/$arch"
    ar -x "$TMP/libftd3xx-static/$arch.a"
    rm core.o io.o sync.o descriptor.o events_posix.o strerror.o darwin_usb.o "$TMP/libftd3xx-static/$arch.a"
    ar -r "$TMP/libftd3xx-static/$arch.a" *
}

repack arm64
repack x86_64

lipo -create -output "$TMP/libftd3xx.a" "$TMP/libftd3xx-static/"{arm64.a,x86_64.a}

mkdir "$TMP/libftd3xx-$VERSION-macos-universal2"
cp "$TMP/src/"{ftd3xx.h,Types.h} "$TMP/libftd3xx.a" "$TMP/libftd3xx-$VERSION-macos-universal2"

cd "$TMP"
zip -r -9 "$DIST/libftd3xx-$VERSION-macos-universal2.zip" "libftd3xx-$VERSION-macos-universal2"

