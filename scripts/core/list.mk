##--------------------------------------------------------------------------
##
#        文件：list.mk
#        描述：系统中链表
#        修改：2013-6-4
#
##--------------------------------------------------------------------------

LIST.TARGET_ALL :=$(LIST.TARGET_ALL)  TARGET.ALL.$(strip $(MODULE.$(curr_module_id).MODULE_ID))
LIST.TARGET_INSTALL :=$(LIST.TARGET_INSTALL) TARGET.INSTALL.$(strip $(MODULE.$(curr_module_id).MODULE_ID))
LIST.TARGET_INTERMEDIATE :=$(LIST.TARGET_INTERMEDIATE) TARGET.INTERMEDIATE.$(strip $(MODULE.$(curr_module_id).MODULE_ID))
LIST.MODULE_FOR_OWNER.$(strip $(MODULE.$(curr_module_id).MODULE_INFO.OWNER)) :=$(LIST.MODULE_FOR_OWNER.$(strip $(MODULE.$(curr_module_id).MODULE_INFO.OWNER))) $(MODULE.$(curr_module_id).MODULE_ID)
LIST.OWNER_ALL :=$(LIST.OWNER_ALL) $(if $(filter $(MODULE.$(curr_module_id).MODULE_INFO.OWNER), $(LIST.OWNER_ALL)),, $(MODULE.$(curr_module_id).MODULE_INFO.OWNER))
LIST.MODULE_ID :=$(LIST.MODULE_ID) $(MODULE.$(curr_module_id).MODULE_ID)
LIST.TARGET_CLEAN    :=$(LIST.TARGET_CLEAN)  TARGET.CLEAN.$(MODULE.$(curr_module_id).MODULE_ID)
