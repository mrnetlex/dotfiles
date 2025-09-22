#!/usr/bin/env bash

# Check if any argument contains HDR (case-insensitive)
if [[ "$*" =~ [Hh][Dd][Rr] ]]; then
    echo "Launching MPV with HDR environment variable"
    env ENABLE_HDR_WSI=1 mpv "$@"
else
    echo "Launching MPV normally"
    mpv "$@"
fi
