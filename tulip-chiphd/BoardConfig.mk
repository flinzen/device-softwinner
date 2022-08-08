# BoardConfig.mk
#
# Product-specific compile-time definitions.
#

include device/softwinner/tulip-common/BoardConfigCommon.mk

# image related
TARGET_NO_BOOTLOADER := true
TARGET_NO_RECOVERY := false
TARGET_NO_KERNEL := false

# disable CPUSETS which is not supported by Tulip kernel currently
# ENABLE_CPUSETS := true
# ENABLE_SCHED_BOOST := true

POLICYVERS := 28

INSTALLED_KERNEL_TARGET := kernel
BOARD_KERNEL_CMDLINE :=
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true
BOARD_FLASH_BLOCK_SIZE := 4096

BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2147483648

BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 805306368

BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1073741824

# Enable dex-preoptimization to speed up first boot sequence
ifeq ($(HOST_OS),linux)
  ifneq ($(filter user userdebug,$(TARGET_BUILD_VARIANT)),)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
    endif
  endif
endif

# recovery stuff
TARGET_RECOVERY_UI_LIB := librecovery_ui_tulip_chiphd
TW_THEME := landscape_hdpi
TW_NO_REBOOT_BOOTLOADER := true
TW_NO_SCREEN_TIMEOUT := true
TW_HAS_NO_RECOVERY_PARTITION := true
TW_HAS_NO_BOOT_PARTITION := true
SW_BOARD_TOUCH_RECOVERY := true

# busybox related
WITH_BUSYBOX_LINKS := true

# wifi and bt configuration
# 1. Wifi Configuration
# 1.1 realtek wifi support
# 1.1  realtek wifi configuration
BOARD_WIFI_VENDOR := realtek
ifeq ($(BOARD_WIFI_VENDOR), realtek)
    WPA_SUPPLICANT_VERSION := VER_0_8_X
    BOARD_WPA_SUPPLICANT_DRIVER := NL80211
    BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_rtl
    BOARD_HOSTAPD_DRIVER        := NL80211
    BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_rtl

    WIFI_DRIVER_MODULE_PATH := "/system/vendor/modules/8723ds.ko"
    WIFI_DRIVER_MODULE_NAME := "8723ds"
    WIFI_DRIVER_MODULE_ARG := "ifname=wlan0 if2name=p2p0 rtw_power_mgnt=0"
    WIFI_FIRMWARE_LOADER := "rtw_fwloader"
    WIFI_DRIVER_FW_PATH_STA := "STA"
    WIFI_DRIVER_FW_PATH_AP := "AP"
    WIFI_DRIVER_FW_PATH_P2P := "P2P"
    WIFI_DRIVER_FW_PATH_PARAM := "/dev/null"

    BOARD_USR_WIFI := rtl8723ds
endif

# 1.2 broadcom wifi support
#BOARD_WIFI_VENDOR := broadcom
ifeq ($(BOARD_WIFI_VENDOR), broadcom)
    BOARD_WPA_SUPPLICANT_DRIVER := NL80211
    WPA_SUPPLICANT_VERSION      := VER_0_8_X
    BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
    BOARD_HOSTAPD_DRIVER        := NL80211
    BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd
    BOARD_WLAN_DEVICE           := bcmdhd
    WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/bcmdhd/parameters/firmware_path"

    BOARD_USR_WIFI := ap6330
    include hardware/broadcom/wlan/bcmdhd/firmware/$(BOARD_USR_WIFI)/device-bcm.mk
endif

#1.3 eag wifi config
#BOARD_WIFI_VENDOR := eagle
ifeq ($(BOARD_WIFI_VENDOR), eagle)
    WPA_SUPPLICANT_VERSION := VER_0_8_X
    BOARD_WPA_SUPPLICANT_DRIVER := NL80211
    BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_eagle
    BOARD_HOSTAPD_DRIVER        := NL80211
    BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_eagle

    BOARD_USR_WIFI := esp8089
    BOARD_WLAN_DEVICE := esp8089

endif

# 2. Bluetooth Configuration
# make sure BOARD_HAVE_BLUETOOTH is true for every bt vendor
BOARD_HAVE_BLUETOOTH := true
#BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_HAVE_BLUETOOTH_NAME := rtl8723ds
BOARD_HAVE_BLUETOOTH_RTK_COEX := true
BOARD_HAVE_BLUETOOTH_RTK := true
BLUETOOTH_HCI_USE_RTK_H5 := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/softwinner/tulip-chiphd/bluetooth
TARGET_USE_BOOSTUP_OPZ := true
