#
# Copyright (C) 2024 MikuUI Project
#
# Common BoardConfig for Qualcomm SM8650 Platform
#

TARGET_BOARD_PLATFORM := sm8650
BOARD_USES_QCOM_HARDWARE := true

# Qualcomm AIDL Hardware Features
TARGET_USES_QCOM_AIDL_AUDIO := true
TARGET_USES_QCOM_AIDL_DISPLAY := true

# Security / SELinux
BOARD_SEPOLICY_DIRS += device/oneplus/sm8650-common/sepolicy/vendor
