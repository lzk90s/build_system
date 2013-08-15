#
#   file : config.mk
#   description: configuration for makefile
#

DISABLE_DEBUG:=FALSE

##    build template
CLEAR_VARS                    :=$(BUILD_SYSTEM_TOP_DIR)/build/clear_vars.mk
BUILD_HOST_STATIC_LIBRARY     :=$(BUILD_SYSTEM_TOP_DIR)/build/host_static_library.mk
BUILD_HOST_SHARED_LIBRARY     :=$(BUILD_SYSTEM_TOP_DIR)/build/host_shared_library.mk
BUILD_HOST_EXECUTABLE         :=$(BUILD_SYSTEM_TOP_DIR)/build/host_executable.mk
BUILD_TARGET_STATIC_LIBRARY   :=$(BUILD_SYSTEM_TOP_DIR)/build/target_static_library.mk
BUILD_TARGET_SHARED_LIBRARY   :=$(BUILD_SYSTEM_TOP_DIR)/build/target_shared_library.mk
BUILD_TARGET_EXECUTABLE       :=$(BUILD_SYSTEM_TOP_DIR)/build/target_executable.mk


##    directory configuration
DEFAULT_PROJECT_OUT           :=$(PROJECT_TOP_DIR)/out
DEFAULT_PROJECT_VERSION       :=0.0.0
DEFAULT_PROJECT_BUILD_ID      :=0000
DEFAULT_PROJECT_BUILD_TYPE    :=debug
DEFAULT_PROJECT_MODULE_OWNER  :=none 

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
SHELL					   :=/bin/bash

##    import user's own config.mk
##
#    PROJECT_OUT    
#    PROJECT_VERSION    
#    PROJECT_BUILD_ID        
#    PROJECT_BUILD_TYPE            
#    PROJECT_COMPANY        
#    PROJECT_MODULE_OWNER
sinclude $(PROJECT_TOP_DIR)/config.mk

PROJECT_OUT:=$(if $(strip $(PROJECT_OUT)),$(PROJECT_OUT),$(DEFAULT_PROJECT_OUT))
PROJECT_VERSION:=$(if $(strip $(PROJECT_VERSION)),$(PROJECT_VERSION),$(DEFAULT_PROJECT_VERSION))
PROJECT_BUILD_ID:=$(if $(strip $(PROJECT_BUILD_ID)),$(PROJECT_BUILD_ID),$(DEFAULT_PROJECT_BUILD_ID))
PROJECT_BUILD_TYPE:=$(if $(strip $(PROJECT_BUILD_TYPE)),$(PROJECT_BUILD_TYPE),$(DEFAULT_PROJECT_BUILD_TYPE))
PROJECT_MODULE_OWNER:=$(if $(strip $(PROJECT_MODULE_OWNER)),$(PROJECT_MODULE_OWNER),$(DEFAULT_PROJECT_MODULE_OWNER))
HEADER_EXPORT_FILE:=$(strip $(PROJECT_OUT))/header.list

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


##
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
