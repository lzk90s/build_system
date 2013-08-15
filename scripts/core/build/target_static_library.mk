#
#	file : build_target_static_library.mk
#	description: target static library
#


$(call assert-not-null, $(LOCAL_PATH), LOCAL_PATH is null)

LOCAL_MODULE_CLASS  :=TARGET_STATIC_LIBRARY
LOCAL_IS_HOST_MODULE:=FALSE
LOCAL_MODULE_SUFFIX :=.a

include $(BUILD_SYSTEM_TOP_DIR)/module_object.mk
include $(BUILD_SYSTEM_TOP_DIR)/build/binary.mk

_ut:=$(call mod-get-ultimate-target, $(MOBJ))
_it:=$(call mod-get-intermediate-target,$(MOBJ))
_objs:=$(call mod-get-objs, $(MOBJ))

$(_it): $(_objs)
	$(call mod-trans-o-to-static-lib)

$(_ut): $(_it)
	$(call copy-one-file)

___TARGETS += $(_ut) $(_it)
include $(BUILD_SYSTEM_TOP_DIR)/_rules.mk

include $(CLEAR_VARS)
