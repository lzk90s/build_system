#
#	file : pre-built
#

include $(BUILD_SYSTEM_TOP_DIR)/version.mk
include $(BUILD_SYSTEM_TOP_DIR)/assert.mk
include $(BUILD_SYSTEM_TOP_DIR)/definitions.mk
include $(BUILD_SYSTEM_TOP_DIR)/module_class.mk
include $(BUILD_SYSTEM_TOP_DIR)/map_class.mk
include $(BUILD_SYSTEM_TOP_DIR)/list_class.mk

MAKE_VERSION:=$(shell make -v | grep "GNU Make" | sed "s/[^0-9\.]*//g")
## GNU Make最小需要版本，3.80以下版本有可能出现莫名其妙问题
MAKE_MIN_NEED_VERSION:=3.81

result:=$(shell expr $(MAKE_VERSION) \< $(MAKE_MIN_NEED_VERSION))

$(call assert-equal, $(result), 0, The minimum version for GNU Make is [$(MAKE_MIN_NEED_VERSION)])