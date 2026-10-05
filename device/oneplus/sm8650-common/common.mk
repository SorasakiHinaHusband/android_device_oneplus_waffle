#
# Copyright (C) 2024 MikuUI Project
#
# Common Device Makefile for Qualcomm SM8650 Platform
#

# Common Properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.soc.manufacturer=Qualcomm \
    ro.soc.model=SM8650 \
    ro.telephony.default_network=33,33 \
    telephony.lteOnCdmaDevice=1 \
    persist.vendor.dpm.feature=11 \
    persist.sys.sf.color_saturation=1.0

# Base Android Generic Packages
PRODUCT_PACKAGES += \
    android.hardware.health-service.qti \
    android.hardware.power-service.qti \
    android.hardware.vibrator-service.qti
