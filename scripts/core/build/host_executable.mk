#
#   file : build_host_executable.mk
#   description: build host executable
#
#

$(call AssertNotNull, $(LOCAL_PATH), LOCAL_PATH is null)

LOCAL_MODULE_CLASS  :=HOST_EXECUTABLE
LOCAL_IS_HOST_MODULE:=TRUE
LOCAL_MODULE_SUFFIX :=


include $(BUILD_SYSTEM_TOP_DIR)/module_object.mk
include $(BUILD_SYSTEM_TOP_DIR)/build/binary.mk


_ut:=$(call MOD_GetUltimateTarget, $(MODULE))
_it:=$(call MOD_GetInterTarget, $(MODULE))
_objs:=$(call MOD_GetObjFiles, $(MODULE))
_libs:=$(call MOD_GetStaticLibs, $(MODULE)) $(call MOD_GetSharedLibs, $(MODULE))


$(_it): $(_libs)


$(_it): $(_objs)
	$(call MOD_TransObj2Exe)


$(_ut): $(_it)
	$(call MOD_Install)


$(_it): $(curr_mid)_force


FORCE:$(curr_mid)_force


$(curr_mid)_force:
	$(eval _l:=$(foreach m, $(call MOD_GetDepends, $(PRIVATE.ID)), \
		$(call MOD_GetLDLibs, $(m))))
	$(eval _l:=$(sort $(_l) $(call MOD_GetLDLibs, $(PRIVATE.ID))))
	$(call MOD_SetLDLibs, $(PRIVATE.ID), $(_l))


___TARGETS +=$(_it) $(_ut) $(curr_mid)_force


include $(BUILD_SYSTEM_TOP_DIR)/_rules.mk
include $(CLEAR_VARS)
