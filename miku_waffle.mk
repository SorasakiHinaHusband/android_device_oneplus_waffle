#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#
# MikuUI product configuration for OnePlus 12 (waffle)
#

# 构建者名称（显示为「维护者」）
MIKU_MASTER := SakuraMio

# 构建类型：在通过官方审核前保持 UNOFFICIAL
# 审核通过后改为 OFFICIAL（ro.miku.buildtype 会随之变化）
TARGET_MIKU_BUILD_VARIANT := UNOFFICIAL

# 使用自建密钥签名，替代 AOSP 的 testkey
# 生成的 releasekey/platform/shared/media/networkstack/sdk_sandbox/bluetooth/verity
# 均位于 vendor/miku-priv/keys/
PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/miku-priv/keys/releasekey

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from waffle device
$(call inherit-product, device/oneplus/waffle/device.mk)

# Inherit some common Miku UI stuff.
$(call inherit-product, vendor/miku/build/product/miku_product_phone.mk)

PRODUCT_NAME := miku_waffle
PRODUCT_DEVICE := waffle
PRODUCT_MANUFACTURER := OnePlus
PRODUCT_BRAND := OnePlus
PRODUCT_MODEL := CPH2573

PRODUCT_GMS_CLIENTID_BASE := android-oneplus

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="qssi_64-user 16 BP2A.250605.015 1790588045632 release-keys" \
    BuildFingerprint=OnePlus/CPH2573IN/OP595DL1:16/BP2A.250605.015/U.R4T3.4f93090-29426eb-296fc63:user/release-keys \
    DeviceName=OP595DL1 \
    DeviceProduct=CPH2573 \
    SystemDevice=OP595DL1 \
    SystemName=CPH2573

# 预装 Via 浏览器（第三方 APK，位于 prebuilt/app/Via）
PRODUCT_PACKAGES += \
    Via

# 补充 TheMuppets blob 缺失的 QTI 蓝牙音频 HAL（LE Audio / A2DP 数据泵）
PRODUCT_PACKAGES += \
    audio.bluetooth_qti.default
