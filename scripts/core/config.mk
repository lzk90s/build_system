##--------------------------------------------------------------------------
##
#        文件：config.mk
#        描述：Makefile变量配置
#        修改：2013-5-31
#        注意：
#            1. 本文件里的配置信息，最好不要修改，如果想修改，请添加到自己的config.mk中
##--------------------------------------------------------------------------

##    global build ways
CLEAR_VARS                    :=$(BUILD_SYSTEM_TOP_DIR)/build/clear_vars.mk
BUILD_HOST_STATIC_LIBRARY     :=$(BUILD_SYSTEM_TOP_DIR)/build/build_host_static_library.mk
BUILD_HOST_SHARED_LIBRARY     :=$(BUILD_SYSTEM_TOP_DIR)/build/build_host_shared_library.mk
BUILD_HOST_EXECUTABLE         :=$(BUILD_SYSTEM_TOP_DIR)/build/build_host_executable.mk
BUILD_TARGET_STATIC_LIBRARY   :=$(BUILD_SYSTEM_TOP_DIR)/build/build_target_static_library.mk
BUILD_TARGET_SHARED_LIBRARY   :=$(BUILD_SYSTEM_TOP_DIR)/build/build_target_shared_library.mk
BUILD_TARGET_EXECUTABLE       :=$(BUILD_SYSTEM_TOP_DIR)/build/build_target_executable.mk


##    directory configuration
PROJECT_DEFAULT_OUT           :=$(PROJECT_TOP_DIR)/out
PROJECT_DEFAULT_VERSION       :=0.0.0
PROJECT_DEFAULT_BUILD_ID      :=0000
PROJECT_DEFAULT_BUILD_TYPE    :=debug
PROJECT_DEFAULT_COMPANY       :=none
PROJECT_DEFAULT_MODULE_OWNER  :=none 

##    import user's own config.mk
##
#    PROJECT_OUT    
#    PROJECT_VERSION    
#    PROJECT_BUILD_ID        
#    PROJECT_BUILD_TYPE            
#    PROJECT_COMPANY        
#    PROJECT_MODULE_OWNER
sinclude $(PROJECT_TOP_DIR)/config.mk


##    tools
DOXYGEN                    :=doxygen
AR                         :=$(CROSS_COMPILE)ar
CC                         :=$(CROSS_COMPILE)gcc
CPP                        :=$(CROSS_COMPILE)gcc -E
CXX                        :=$(CROSS_COMPILE)g++
LD                         :=$(CXX)
SIZE                       :=$(CROSS_COMPILE)size
OBJDUMP                    :=$(CROSS_COMPILE)objdump
NM                         :=$(CROSS_COMPILE)nm
READELF                    :=$(CROSS_COMPILE)readelf
RM                         :=rm -rf
MKDIR                      :=mkdir -p
CP                         :=cp -r
LINT                       :=lint


ifeq (x$(strip $(PROJECT_OUT)), x)
$(info Use default PROJECT_OUT: $(PROJECT_DEFAULT_OUT))
PROJECT_OUT            :=$(PROJECT_DEFAULT_OUT)
endif
PROJECT_OUT            :=$(PROJECT_OUT)

ifeq (x$(strip $(PROJECT_VERSION)), x)
$(info Use default PROJECT_VERSION: $(PROJECT_DEFAULT_VERSION))
PROJECT_VERSION        :=$(PROJECT_DEFAULT_VERSION)
endif
PROJECT_VERSION        :=$(PROJECT_VERSION)

ifeq (x$(strip $(PROJECT_BUILD_ID)), x)
$(info Use default PROJECT_BUILD_ID: $(PROJECT_DEFAULT_BUILD_ID))
PROJECT_BUILD_ID       :=$(PROJECT_DEFAULT_BUILD_ID)
endif
PROJECT_BUILD_ID       :=$(PROJECT_BUILD_ID)

ifeq (x$(strip $(PROJECT_BUILD_TYPE)), x)
$(info Use default PROJECT_BUILD_TYPE: $(PROJECT_DEFAULT_BUILD_TYPE))
PROJECT_BUILD_TYPE     :=$(PROJECT_DEFAULT_BUILD_TYPE)
endif
ifneq ($(strip $(PROJECT_BUILD_TYPE)), debug)
ifneq ($(strip $(PROJECT_BUILD_TYPE)), release)
$(error PROJECT_BUILD_TYPE wrong, it must be [debug] or [release])
endif
endif
PROJECT_BUILD_TYPE     :=$(PROJECT_BUILD_TYPE)

ifeq (x$(strip $(PROJECT_COMPANY)), x)
$(info Use default PROJECT_COMPANY: $(PROJECT_DEFAULT_COMPANY))
PROJECT_COMPANY        :=$(PROJECT_DEFAULT_COMPANY)
endif
PROJECT_COMPANY        :=$(PROJECT_COMPANY)

ifeq (x$(strip $(PROJECT_MODULE_OWNER)), x)
$(info Use default PROJECT_MODULE_OWNER: $(PROJECT_DEFAULT_MODULE_OWNER))
PROJECT_MODULE_OWNER   :=$(PROJECT_DEFAULT_MODULE_OWNER)
endif
PROJECT_MODULE_OWNER   :=$(PROJECT_MODULE_OWNER)

## output directory
PROJECT_OUTPUT_TOP_DIR :=$(PROJECT_OUT)/$(PROJECT_VERSION)-$(PROJECT_BUILD_ID)-$(PROJECT_BUILD_TYPE)
HOST_OUTPUT_TOP_DIR    :=$(PROJECT_OUTPUT_TOP_DIR)/host
TARGET_OUTPUT_TOP_DIR  :=$(PROJECT_OUTPUT_TOP_DIR)/target

##    host
HOST_OUT_EXECUTABLES            :=$(HOST_OUTPUT_TOP_DIR)/bin
HOST_OUT_SHARED_LIBRARIES       :=$(HOST_OUTPUT_TOP_DIR)/lib
HOST_OUT_STATIC_LIBRARIES       :=$(HOST_OUTPUT_TOP_DIR)/ar
HOST_OUT_INTERMEDIATES          :=$(HOST_OUTPUT_TOP_DIR)/obj
HOST_OUT_HEADERS                :=$(HOST_OUT_INTERMEDIATES)/include
HOST_OUT_INTERMEDIATE_LIBRARIES :=$(HOST_OUT_INTERMEDIATES)/lib

##    target
TARGET_OUT_EXECUTABLES          :=$(TARGET_OUTPUT_TOP_DIR)/bin
TARGET_OUT_SHARED_LIBRARIES     :=$(TARGET_OUTPUT_TOP_DIR)/lib
TARGET_OUT_STATIC_LIBRARIES     :=$(TARGET_OUTPUT_TOP_DIR)/ar
TARGET_OUT_INTERMEDIATES        :=$(TARGET_OUTPUT_TOP_DIR)/obj
TARGET_OUT_HEADERS              :=$(TARGET_OUT_INTERMEDIATES)/include
TARGET_OUT_INTERMEDIATE_LIBRARIES :=$(TARGET_OUT_INTERMEDIATES)/lib


##    global common cflags
ifeq ($(PROJECT_BUILD_TYPE), debug)
GLOBAL_CFLAGS                :=-DDEBUG -D__DEBUG__ -g
GLOBAL_CXXFLAGS              :=-DDEBUG -D__DEBUG__ -g
endif
GLOBAL_CFLAGS                :=$(GLOBAL_CFLAGS) $(CFLAGS)
GLOBAL_CXXFLAGS              :=$(GLOBAL_CFLAGS) $(CFLAGS)
GLOBAL_ARFLAGS               :=rcs

##    file suffix
GLOBAL_C_FILE_SUFFIX         :=.c
GLOBAL_CXX_FILE_SUFFIX       :=.cpp .cxx .cc
GLOBAL_HEADER_FILE_SUFFIX    :=.h .hpp .hxx
GLOBAL_EXECUTABLE_SUFFIX     :=
GLOBAL_STATIC_LIBRARY_SUFFIX :=.a
GLOBAL_SHARED_LIBRARY_SUFFIX :=.so
