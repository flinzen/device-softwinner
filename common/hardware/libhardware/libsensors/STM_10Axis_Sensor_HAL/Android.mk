# Copyright (C) 2012 STMicroelectronics
# Matteo Dameno, Denis Ciocca - Motion MEMS Product Div.
# Copyright (C) 2008 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


ifneq ($(TARGET_SIMULATOR),true)

ifeq ($(SW_BOARD_USES_SENSORS_TYPE),lsm9ds0) 

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_ARM_MODE := arm

LOCAL_PRELINK_MODULE := false

LOCAL_MODULE := sensors.exdroid

#LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE_RELATIVE_PATH := hw

LOCAL_C_INCLUDES :=l	$(KERNEL_HEADERS)				\
			$(LOCAL_PATH)/lib/iNemoEngine_gBias/	 	\
			$(LOCAL_PATH)/lib/iNemoEngine_SensorFusion/	\
			$(LOCAL_PATH)/lib/iNemoEngine_GeoMag_Fusion/	\
			$(LOCAL_PATH)/lib/NewCompass_API/		\
			$(LOCAL_PATH)/include/				\
			$(LOCAL_PATH)/conf/

LOCAL_STATIC_LIBRARIES := 	iNemoEngine_SensorFusion.$(TARGET_ARCH) \
				libNewCompass.$(TARGET_ARCH) \
				iNemoEngine_gBias.$(TARGET_ARCH) \
				iNemoEngine_GeoMag_Fusion.$(TARGET_ARCH) \
				iNemoEngine_gBias_API

LOCAL_CFLAGS := -DLOG_TAG=\"Sensors\" -DANDROID_VERSION=$(PLATFORM_SDK_VERSION)

LOCAL_SRC_FILES := 		sensors.cpp 			\
				insmodDevice.cpp		\
				SensorBase.cpp			\
				AccelSensor.cpp			\
				GyroSensor.cpp			\
				MagnSensor.cpp			\
				iNemoEngineSensor.cpp		\
				InputEventReader.cpp		\
				LightSensor.cpp                 

LOCAL_SHARED_LIBRARIES := liblog libcutils libutils libdl libc

LOCAL_MODULE_TAGS := optional
include $(BUILD_SHARED_LIBRARY)

include $(call all-makefiles-under,$(LOCAL_PATH))

endif
endif # !TARGET_SIMULATOR
