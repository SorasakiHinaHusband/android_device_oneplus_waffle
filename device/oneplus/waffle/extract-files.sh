#!/bin/bash
#
# Copyright (C) 2024 MikuUI Project
#
# Proprietary Files Extractor for OnePlus 12 (waffle) - MikuUI
#

set -e

DEVICE=waffle
VENDOR=oneplus

# Load Extract Utils
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

# Default to extracting from a dumped stock payload directory or ADB device
if [ -z "$1" ]; then
    SRC="adb"
else
    SRC="$1"
fi

echo "Extracting proprietary files for $DEVICE ($VENDOR) for MikuUI from $SRC..."

# Initialize the vendor tree directory
setup_vendor "$DEVICE" "$VENDOR" "$ANDROID_BUILD_TOP"

# Extract files using proprietary-files.txt
extract "$ANDROID_BUILD_TOP/device/$VENDOR/$DEVICE/proprietary-files.txt" "$SRC"

# Run setup-makefiles to auto-generate vendor/oneplus/waffle/waffle-vendor.mk
"$ANDROID_BUILD_TOP/device/$VENDOR/$DEVICE/setup-makefiles.sh"

echo "MikuUI Vendor extraction finished successfully!"
