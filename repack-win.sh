#!/bin/bash

. common.sh

VERSION="1.3.0.4"

rm -fr "$TMP"
mkdir -p "$TMP" "$DIST"

fetch "https://www.ftdichip.com/Drivers/D3XX/FTD3XXLibrary_v$VERSION.zip" "$SRC"

repack()
{
    local ftdi_arch="$1"
    local ics_arch="$2"
    shift 2

    mkdir "$TMP/libftd3xx-$VERSION-win-$ics_arch"
    cp "$SRC/$ftdi_arch/Static/FTD3XX.lib" "$SRC/FTD3XX.h" "$TMP/libftd3xx-$VERSION-win-$ics_arch"

    cd "$TMP"
    zip -r -9 "$DIST/libftd3xx-$VERSION-win-$ics_arch.zip" "libftd3xx-$VERSION-win-$ics_arch"
}

repack "Win32" "i686"
repack "x64" "x64"

