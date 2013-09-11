#
#    file : pre-built
#

include $(BUILD_SYSTEM_TOP_DIR)/version.mk
include $(BUILD_SYSTEM_TOP_DIR)/Assert.mk
include $(BUILD_SYSTEM_TOP_DIR)/definitions.mk
include $(BUILD_SYSTEM_TOP_DIR)/class/module_class.mk
include $(BUILD_SYSTEM_TOP_DIR)/class/map_class.mk
include $(BUILD_SYSTEM_TOP_DIR)/class/list_class.mk
include $(BUILD_SYSTEM_TOP_DIR)/class/set_class.mk



MAKE_VERSION:=$(shell make -v | grep "GNU Make" | sed "s/[^0-9\.]*//g")
## the minimum version of GNU Make
MAKE_MIN_NEED_VERSION:=3.81

result:=$(shell expr $(MAKE_VERSION) \< $(MAKE_MIN_NEED_VERSION))

$(call AssertEqual, $(result), 0, The minimum needed version for GNU Make is [$(MAKE_MIN_NEED_VERSION)])
