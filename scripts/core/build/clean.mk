##--------------------------------------------------------------------------
##
#        文件：clean.mk
#        描述：清理文件
#        修改：2013-5-31
#
##--------------------------------------------------------------------------

$(call assert-not-null, $(LOCAL_PATH), LOCAL_PATH is null)

TARGET.CLEAN.$(MODULE.$(curr_module_id).MODULE_ID):
	$(call target-clean)

LOCAL_TARGET_CLEAN += TARGET.CLEAN.$(MODULE.$(curr_module_id).MODULE_ID)

$(LOCAL_TARGET_CLEAN) : PRIVATE.ALL_FILE_NEED_CLEAN :=$(MODULE.$(curr_module_id).MODULE_FILE.OBJ_FILES) $(MODULE.$(curr_module_id).MODULE_PATH.INTERMEDIATE_PATH)/$(MODULE.$(curr_module_id).MODULE_NAME) $(MODULE.$(curr_module_id).MODULE_PATH.INSTALL_PATH)/$(MODULE.$(curr_module_id).MODULE_NAME)

