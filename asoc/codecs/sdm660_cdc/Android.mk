# Android makefile for audio kernel modules

# Assume no targets will be supported

<<<<<<<< HEAD:asoc/codecs/sdm660_cdc/Android.mk
AUDIO_CHIPSET := audio
# Build/Package only in case of supported target
ifeq ($(call is-board-platform-in-list, sdm660),true)
========
# Check if this driver needs be built for current target
ifeq ($(call is-board-platform-in-list,msmnile sdmshrike),true)
AUDIO_SELECT  := CONFIG_SND_SOC_SM8150=m
endif

ifeq ($(call is-board-platform,$(MSMSTEPPE) $(TRINKET)),true)
AUDIO_SELECT  := CONFIG_SND_SOC_SM6150=m
endif

ifeq ($(call is-board-platform,kona),true)
AUDIO_SELECT  := CONFIG_SND_SOC_KONA=m
endif

ifeq ($(call is-board-platform,lito),true)
AUDIO_SELECT  := CONFIG_SND_SOC_LITO=m
endif

ifeq ($(call is-board-platform,bengal),true)
AUDIO_SELECT  := CONFIG_SND_SOC_BENGAL=m
endif

ifeq ($(call is-board-platform,sdm660),true)
AUDIO_SELECT  := CONFIG_SND_SOC_SDM660=m
endif

AUDIO_CHIPSET := audio
# Build/Package only in case of supported target
ifeq ($(call is-board-platform-in-list,msmnile $(MSMSTEPPE) $(TRINKET) kona lito bengal sdmshrike sdm660),true)
>>>>>>>> LA.UM.9.12.1.r1-01500-SMxx50.QSSI12.0:dsp/codecs/Android.mk

LOCAL_PATH := $(call my-dir)

# This makefile is only for DLKM
ifneq ($(findstring vendor,$(LOCAL_PATH)),)

ifneq ($(findstring opensource,$(LOCAL_PATH)),)
	AUDIO_BLD_DIR := $(shell pwd)/vendor/qcom/opensource/audio-kernel
endif # opensource

DLKM_DIR := $(TOP)/device/qcom/common/dlkm

# Build audio.ko as $(AUDIO_CHIPSET)_audio.ko
###########################################################
# This is set once per LOCAL_PATH, not per (kernel) module
KBUILD_OPTIONS := AUDIO_ROOT=$(AUDIO_BLD_DIR)

# We are actually building audio.ko here, as per the
# requirement we are specifying <chipset>_audio.ko as LOCAL_MODULE.
# This means we need to rename the module to <chipset>_audio.ko
# after audio.ko is built.
KBUILD_OPTIONS += MODNAME=analog_cdc_dlkm
KBUILD_OPTIONS += BOARD_PLATFORM=$(TARGET_BOARD_PLATFORM)
KBUILD_OPTIONS += $(AUDIO_SELECT)

###########################################################
include $(CLEAR_VARS)
LOCAL_MODULE              := $(AUDIO_CHIPSET)_analog_cdc.ko
LOCAL_MODULE_KBUILD_NAME  := analog_cdc_dlkm.ko
LOCAL_MODULE_TAGS         := optional
LOCAL_MODULE_DEBUG_ENABLE := true
LOCAL_MODULE_PATH         := $(KERNEL_MODULES_OUT)
include $(DLKM_DIR)/AndroidKernelModule.mk
###########################################################
include $(CLEAR_VARS)
LOCAL_MODULE              := $(AUDIO_CHIPSET)_digital_cdc.ko
LOCAL_MODULE_KBUILD_NAME  := digital_cdc_dlkm.ko
LOCAL_MODULE_TAGS         := optional
LOCAL_MODULE_DEBUG_ENABLE := true
LOCAL_MODULE_PATH         := $(KERNEL_MODULES_OUT)
include $(DLKM_DIR)/AndroidKernelModule.mk
###########################################################
###########################################################

endif # DLKM check
endif # supported target check
