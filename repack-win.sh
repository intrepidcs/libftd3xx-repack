#!/bin/bash

. common.sh

VERSION="1.3.0.10"

rm -fr "$TMP"
mkdir -p "$TMP" "$DIST"

fetch "https://ftdichip.com/wp-content/uploads/2024/06/FTD3XXLibrary_$VERSION.zip" "$SRC"

repack()
{
    local ftdi_arch="$1"
    local ics_arch="$2"
    shift 2

    mkdir "$TMP/libftd3xx-$VERSION-win-$ics_arch"
    cp "$SRC/$ftdi_arch/Static_Lib/FTD3XX.lib" "$SRC/FTD3XX.h" "$TMP/libftd3xx-$VERSION-win-$ics_arch"

    cd "$TMP"
    zip -r -9 "$DIST/libftd3xx-$VERSION-win-$ics_arch.zip" "libftd3xx-$VERSION-win-$ics_arch"
}

repack "Win32" "i686"
repack "x64" "x64"

