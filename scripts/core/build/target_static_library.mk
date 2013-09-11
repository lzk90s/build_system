#
#	file : build_target_static_library.mk
#	description: target static library
#


$(call AssertNotNull, $(LOCAL_PATH), LOCAL_PATH is null)


LOCAL_MODULE_CLASS  :=TARGET_STATIC_LIBRARY
LOCAL_IS_HOST_MODULE:=FALSE
LOCAL_MODULE_SUFFIX :=.a


include $(BUILD_SYSTEM_TOP_DIR)/module_object.mk
include $(BUILD_SYSTEM_TOP_DIR)/build/binary.mk


_ut:=$(call MOD_GetUltimateTarget, $(MODULE))
_it:=$(call MOD_GetInterTarget, $(MODULE))
_objs:=$(call MOD_GetObjFiles, $(MODULE))
_libs:=$(call MOD_GetStaticLibs, $(MODULE)) $(call MOD_GetSharedLibs, $(MODULE))


$(_it): $(_libs)


$(_it): $(_objs)
	$(call MOD_TransObj2StaticLib)


$(_ut): $(_it)
	$(call MOD_Install)


___TARGETS += $(_ut) $(_it)


include $(BUILD_SYSTEM_TOP_DIR)/_rules.mk
include $(CLEAR_VARS)
