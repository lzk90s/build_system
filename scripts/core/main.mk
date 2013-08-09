##--------------------------------------------------------------------------
##
#        文件：main.mk
#        描述：makefile主文件
#        修改：2013-5-31
#
##--------------------------------------------------------------------------

##    the default target
.PHONY: main
main: 


##    get the top directory of build system.
BUILD_SYSTEM_TOP_DIR=$(PROJECT_TOP_DIR)/scripts/core

##    bring in help information
include $(BUILD_SYSTEM_TOP_DIR)/help.mk

##    bring in global configuration information
include $(BUILD_SYSTEM_TOP_DIR)/config.mk

##    bring in the prebuilt information 
include $(BUILD_SYSTEM_TOP_DIR)/prebuilt.mk


##    get all [module.mk] and include them.
ALL_MODULE.MODULE_LIST    :=$(call find-all-module-in-dir, $(PROJECT_TOP_DIR))
ALL_MODULE.MODULE_AMOUNT:=$(words $(ALL_MODULE.MODULE_LIST))
sinclude $(ALL_MODULE.MODULE_LIST)

##    bring in other target
include $(BUILD_SYSTEM_TOP_DIR)/Makefile

##    bring in the postbuilt information
include $(BUILD_SYSTEM_TOP_DIR)/postbuilt.mk
