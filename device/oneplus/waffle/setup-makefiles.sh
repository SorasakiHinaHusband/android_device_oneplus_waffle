#!/bin/bash
#
# Copyright (C) 2024 MikuUI Project
#
# Auto-generate Android.mk and Makefile for Extracted Proprietary Blobs
#

set -e

DEVICE=waffle
VENDOR=oneplus

INITIAL_DIR=$(pwd)
if [ -z "$ANDROID_BUILD_TOP" ]; then
    ANDROID_BUILD_TOP="$INITIAL_DIR"
fi

HELPER="$ANDROID_BUILD_TOP/tools/extract-utils/extract_utils.sh"
if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"
    exit 1
fi
source "$HELPER"

# Initialize the vendor makefile generation
write_headers "waffle"

# Write the vendor makefiles from proprietary-files.txt
write_makefiles "$ANDROID_BUILD_TOP/device/$VENDOR/$DEVICE/proprietary-files.txt" true

write_footers
