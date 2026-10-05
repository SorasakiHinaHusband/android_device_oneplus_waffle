#
# Copyright (C) 2024 MikuUI Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from common device configuration
$(call inherit-product, device/oneplus/waffle/device.mk)

# Inherit from MikuUI product configuration
$(call inherit-product, vendor/miku/config/common_full_phone.mk)

# MikuUI Specific Customization Flags
MIKU_BUILD_TYPE := UNOFFICIAL
TARGET_BOOT_ANIMATION_RES := 1440
TARGET_SUPPORTS_QUICK_TAP := true
TARGET_FACE_UNLOCK_SUPPORTED := true

# Product Specifications
PRODUCT_NAME := miku_waffle
PRODUCT_DEVICE := waffle
PRODUCT_MANUFACTURER := OnePlus
PRODUCT_BRAND := OnePlus
PRODUCT_MODEL := OnePlus 12

PRODUCT_GMS_CLIENTID_BASE := android-oneplus

# Build Fingerprint (使用一加 12 官方指纹以通过 Play Integrity)
BUILD_FINGERPRINT := OnePlus/OP594DL/OP594DL:14/UKQ1.230924.001/R.15b1393-1-240105:user/release-keys
PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE="waffle" \
    PRODUCT_NAME="waffle" \
    PRIVATE_BUILD_DESC="OP594DL-user 14 UKQ1.230924.001 R.15b1393-1-240105 release-keys"
