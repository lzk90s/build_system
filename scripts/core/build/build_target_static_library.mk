##--------------------------------------------------------------------------
##
#        文件：build_static_library.mk
#        描述：构建静态库规则
#        修改：2013-5-31
#
##--------------------------------------------------------------------------

$(call assert-not-null, $(LOCAL_PATH), LOCAL_PATH is null)

LOCAL_MODULE_CLASS  :=TARGET_STATIC_LIBRARY
LOCAL_IS_HOST_MODULE:=FALSE
LOCAL_MODULE_SUFFIX :=.a

LOCAL_INTERMEDIATE_TARGETS +=  $(MODULE.$(curr_module_id).MODULE_PATH.INTERMEDIATE_PATH)/$(MODULE.$(curr_module_id).MODULE_NAME)

include $(BUILD_SYSTEM_TOP_DIR)/module_class.mk
include $(BUILD_SYSTEM_TOP_DIR)/build/binary.mk

##--中间目标：目标文件
$(MODULE.$(curr_module_id).MODULE_PATH.INTERMEDIATE_PATH)/$(MODULE.$(curr_module_id).MODULE_NAME): $(MODULE.$(curr_module_id).MODULE_FILE.OBJ_FILES)
	$(call transform-o-to-static-library)

##--安装
$(MODULE.$(curr_module_id).MODULE_PATH.INSTALL_PATH)/$(MODULE.$(curr_module_id).MODULE_NAME): $(MODULE.$(curr_module_id).MODULE_PATH.INTERMEDIATE_PATH)/$(MODULE.$(curr_module_id).MODULE_NAME)
	$(call copy-one-file)

include $(BUILD_SYSTEM_TOP_DIR)/build/clean.mk


include $(CLEAR_VARS)
