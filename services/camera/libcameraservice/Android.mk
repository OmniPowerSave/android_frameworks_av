# Copyright 2010 The Android Open Source Project
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

LOCAL_PATH:= $(call my-dir)

#
# libcameraservice
#

include $(CLEAR_VARS)

# Camera service source

LOCAL_SRC_FILES :=  \
    CameraService.cpp \
    CameraFlashlight.cpp \
    common/Camera2ClientBase.cpp \
    common/CameraDeviceBase.cpp \
    common/CameraProviderManager.cpp \
    common/FrameProcessorBase.cpp \
    api1/CameraClient.cpp \
    api1/Camera2Client.cpp \
    api2/CameraDeviceClient.cpp \
    device1/CameraHardwareInterface.cpp \
    device3/Camera3Device.cpp \
    device3/Camera3Stream.cpp \
    device3/Camera3IOStreamBase.cpp \
    device3/Camera3InputStream.cpp \
    device3/Camera3OutputStream.cpp \
    device3/Camera3DummyStream.cpp \
    device3/Camera3SharedOutputStream.cpp \
    device3/StatusTracker.cpp \
    device3/Camera3BufferManager.cpp \
    device3/Camera3StreamSplitter.cpp \
    gui/RingBufferConsumer.cpp \
    utils/CameraTraces.cpp \
    utils/AutoConditionLock.cpp \
    utils/TagMonitor.cpp \
    utils/LatencyHistogram.cpp

#use QTI Camera2Client layer, if TARGET_USES_QTI_CAMERA2CLIENT is enabled.
ifeq ($(TARGET_USES_QTI_CAMERA2CLIENT),true)
LOCAL_SRC_FILES +=  \
    api1/QTICamera2Client.cpp \
    api1/qticlient2/Parameters.cpp \
    api1/qticlient2/QTIParameters.cpp \
    api1/qticlient2/FrameProcessor.cpp \
    api1/qticlient2/QTIFrameProcessor.cpp \
    api1/qticlient2/StreamingProcessor.cpp \
    api1/qticlient2/JpegProcessor.cpp \
    api1/qticlient2/RawProcessor.cpp \
    api1/qticlient2/CallbackProcessor.cpp \
    api1/qticlient2/JpegCompressor.cpp \
    api1/qticlient2/CaptureSequencer.cpp \
    api1/qticlient2/QTICaptureSequencer.cpp \
    api1/qticlient2/ZslProcessor.cpp
else
LOCAL_SRC_FILES +=  \
    api1/client2/Parameters.cpp \
    api1/client2/FrameProcessor.cpp \
    api1/client2/StreamingProcessor.cpp \
    api1/client2/JpegProcessor.cpp \
    api1/client2/CallbackProcessor.cpp \
    api1/client2/JpegCompressor.cpp \
    api1/client2/CaptureSequencer.cpp \
    api1/client2/ZslProcessor.cpp
endif

LOCAL_SHARED_LIBRARIES:= \
    libui \
    liblog \
    libutils \
    libbinder \
    libcutils \
    libmedia \
    libmediautils \
    libcamera_client \
    libcamera_metadata \
    libfmq \
    libgui \
    libhardware \
    libhidlbase \
    libhidltransport \
    libjpeg \
    libmemunreachable \
    android.hardware.camera.common@1.0 \
    android.hardware.camera.provider@2.4 \
    android.hardware.camera.device@1.0 \
    android.hardware.camera.device@3.2 \
    android.hidl.manager@1.0

ifeq ($(TARGET_USES_QCOM_BSP),true)
LOCAL_SHARED_LIBRARIES += \
    vendor.qti.hardware.camera.device@1.0
endif
ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
    LOCAL_CFLAGS += -DQCOM_HARDWARE
endif

LOCAL_EXPORT_SHARED_LIBRARY_HEADERS := libbinder libcamera_client libfmq

LOCAL_C_INCLUDES += \
    system/media/private/camera/include \
    frameworks/native/include/media/openmax

LOCAL_EXPORT_C_INCLUDE_DIRS := \
    frameworks/av/services/camera/libcameraservice

LOCAL_CFLAGS += -Wall -Wextra -Werror

ifeq ($(TARGET_USES_QTI_CAMERA2CLIENT),true)
LOCAL_CFLAGS += -DUSE_QTI_CAMERA2CLIENT
endif

ifeq ($(TARGET_HAS_LEGACY_CAMERA_HAL1),true)
    LOCAL_CFLAGS += -DNO_CAMERA_SERVER
endif

LOCAL_MODULE:= libcameraservice

include $(BUILD_SHARED_LIBRARY)
