LOCAL_PATH := $(call my-dir)

ifeq ($(shell if [ "$(TARGET_BOARD_PLATFORM)$(TARGET_BOARD_SUFFIX)" = bengal_32 -o \
                   "$(TARGET_BOARD_PLATFORM)$(TARGET_BOARD_SUFFIX)" = bengal_32go ] ; \
                    then printf "true" ; else printf "false" ; fi),true)
  DISPLAY_CONFIG_VERSION := DISPLAY_CONFIG_VERSION_OPTIMAL
endif

include $(LOCAL_PATH)/../common.mk
include $(CLEAR_VARS)

LOCAL_MODULE                  := vendor.qti.hardware.display.composer-service
LOCAL_SANITIZE                := integer_overflow
LOCAL_VENDOR_MODULE           := true
LOCAL_MODULE_RELATIVE_PATH    := hw
LOCAL_MODULE_TAGS             := optional
LOCAL_C_INCLUDES              := $(common_includes)
LOCAL_C_INCLUDES              += $(kernel_includes)
LOCAL_ADDITIONAL_DEPENDENCIES := $(common_deps)
LOCAL_HEADER_LIBRARIES        := display_headers libThermal_headers

LOCAL_CFLAGS                  := -Wno-missing-field-initializers -Wno-unused-parameter \
                                 -DLOG_TAG=\"SDM\" $(common_flags) -fcolor-diagnostics
LOCAL_CLANG                   := true

LOCAL_SHARED_LIBRARIES        := libhistogram libbinder libhardware libutils libcutils libsync \
                                 libc++ liblog libhidlbase libhidltransport \
                                 liblog libfmq libhardware_legacy \
                                 libsdmcore libqservice libqdutils libqdMetaData \
                                 libdisplaydebug libsdmutils libgrallocutils libui \
                                 libgpu_tonemapper libEGL libGLESv2 libGLESv3 \
                                 vendor.qti.hardware.display.composer@1.0 \
                                 vendor.qti.hardware.display.composer@2.0 \
                                 vendor.qti.hardware.display.composer@2.1 \
                                 android.hardware.graphics.composer@2.1 \
                                 android.hardware.graphics.composer@2.2 \
                                 android.hardware.graphics.composer@2.3 \
                                 android.hardware.graphics.mapper@2.0 \
                                 android.hardware.graphics.mapper@2.1 \
                                 android.hardware.graphics.mapper@3.0 \
                                 android.hardware.graphics.allocator@2.0 \
                                 android.hardware.graphics.allocator@3.0 \
                                 libdrm libthermalclient

LOCAL_SHARED_LIBRARIES        += vendor.display.config@1.0
LOCAL_SHARED_LIBRARIES        += vendor.display.config@1.1
LOCAL_SHARED_LIBRARIES        += vendor.display.config@1.2
LOCAL_SHARED_LIBRARIES        += vendor.display.config@1.3
LOCAL_SHARED_LIBRARIES        += vendor.display.config@1.4
LOCAL_SHARED_LIBRARIES        += vendor.display.config@1.5
LOCAL_SHARED_LIBRARIES        += vendor.display.config@1.6
LOCAL_SHARED_LIBRARIES        += vendor.display.config@1.7
LOCAL_SHARED_LIBRARIES        += vendor.display.config@1.8
LOCAL_SHARED_LIBRARIES        += vendor.display.config@1.9

ifneq ($(DISPLAY_CONFIG_VERSION), DISPLAY_CONFIG_VERSION_OPTIMAL)
LOCAL_SHARED_LIBRARIES        += vendor.display.config@1.10
LOCAL_SHARED_LIBRARIES        += vendor.display.config@1.11
LOCAL_SHARED_LIBRARIES        += vendor.display.config@1.12
LOCAL_SHARED_LIBRARIES        += vendor.display.config@1.13
LOCAL_SHARED_LIBRARIES        += vendor.display.config@1.14
LOCAL_SHARED_LIBRARIES        += vendor.display.config@1.15
LOCAL_SHARED_LIBRARIES        += vendor.display.config@1.16
endif

ifeq ($(TARGET_USES_FOD_ZPOS), true)
LOCAL_CFLAGS                  += -DFOD_ZPOS
endif

LOCAL_SRC_FILES               := QtiComposer.cpp QtiComposerClient.cpp service.cpp \
                                 QtiComposerHandleImporter.cpp \
                                 hwc_session.cpp \
                                 hwc_session_services.cpp \
                                 hwc_display.cpp \
                                 hwc_display_builtin.cpp \
                                 hwc_display_pluggable.cpp \
                                 hwc_display_dummy.cpp \
                                 hwc_display_pluggable_test.cpp \
                                 hwc_display_virtual.cpp \
                                 hwc_debugger.cpp \
                                 hwc_buffer_sync_handler.cpp \
                                 hwc_color_manager.cpp \
                                 hwc_layers.cpp \
                                 hwc_callbacks.cpp \
                                 cpuhint.cpp \
                                 hwc_tonemapper.cpp \
                                 display_null.cpp \
                                 hwc_socket_handler.cpp \
                                 hwc_buffer_allocator.cpp \
                                 hwc_display_virtual_factory.cpp \
                                 hwc_display_virtual_dpu.cpp \
                                 hwc_display_virtual_gpu.cpp \
                                 gl_common.cpp \
                                 gl_color_convert.cpp \
                                 gl_color_convert_impl.cpp \
                                 gl_layer_stitch.cpp \
                                 gl_layer_stitch_impl.cpp

LOCAL_INIT_RC                 := vendor.qti.hardware.display.composer-service.rc
ifneq ($(TARGET_HAS_LOW_RAM),true)
  ifeq ($(TARGET_BOARD_PLATFORM)$(TARGET_BOARD_SUFFIX),bengal_32)
    LOCAL_VINTF_FRAGMENTS         := vendor.qti.hardware.display.composer-service-32bit.xml
  else
    LOCAL_VINTF_FRAGMENTS         := vendor.qti.hardware.display.composer-service.xml
  endif
else
LOCAL_VINTF_FRAGMENTS         := vendor.qti.hardware.display.composer-service-low-ram.xml
endif

include $(BUILD_EXECUTABLE)
