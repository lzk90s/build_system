##--------------------------------------------------------------------------
##
#        文件：build_host_shared_library.mk
#        描述：
#        修改：2013-5-31
#
##--------------------------------------------------------------------------

$(call assert-not-null, $(LOCAL_PATH), LOCAL_PATH is null)

LOCAL_MODULE_CLASS  :=HOST_SHARED_LIBRARY
LOCAL_IS_HOST_MODULE:=TRUE
LOCAL_MODULE_SUFFIX :=.so

LOCAL_INTERMEDIATE_TARGETS +=  $(MODULE.$(curr_module_id).MODULE_PATH.INTERMEDIATE_PATH)/$(MODULE.$(curr_module_id).MODULE_NAME)

include $(BUILD_SYSTEM_TOP_DIR)/module_class.mk
include $(BUILD_SYSTEM_TOP_DIR)/build/binary.mk

##    intermediate target  : module objs
$(MODULE.$(curr_module_id).MODULE_PATH.INTERMEDIATE_PATH)/$(MODULE.$(curr_module_id).MODULE_NAME): $(MODULE.$(curr_module_id).MODULE_FILE.OBJ_FILES)
	$(call transform-o-to-shared-library)

##--安装动作
$(MODULE.$(curr_module_id).MODULE_PATH.INSTALL_PATH)/$(MODULE.$(curr_module_id).MODULE_NAME): $(MODULE.$(curr_module_id).MODULE_PATH.INTERMEDIATE_PATH)/$(MODULE.$(curr_module_id).MODULE_NAME)
	$(call copy-one-file)


include $(BUILD_SYSTEM_TOP_DIR)/build/clean.mk


include $(CLEAR_VARS)
