#!/bin/bash

set -eo pipefail

ROOT="$PWD"
TMP="$ROOT/tmp"
DIST="$ROOT/dist"
SRC="$TMP/src"

fetch()
{
    local url="$1"
    local dst="$2"
    shift 2
    
    local archive="$PWD/${url##*/}"
    local ext=${archive##*.}

    curl -LO "$url"
    mkdir -p "$dst"
    cd "$dst"
    local absolute_dst="$PWD"
    if [ "$ext" = "zip" ]; then
        unzip "$archive"
    else
        tar -xf "$archive"
    fi
    if [ $(ls -1 | wc -l) = 1 ]; then
        mv "$absolute_dst" "$absolute_dst.orig"
        mv * "$absolute_dst"
        rm -r "$absolute_dst.orig"
    fi
}
