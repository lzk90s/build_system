##--------------------------------------------------------------------------
##
#        文件：prebuilt.mk
#        描述：make早期处理
#        修改：2013-5-31
#
##--------------------------------------------------------------------------

include $(BUILD_SYSTEM_TOP_DIR)/definitations.mk


MAKE_VERSION:=$(shell make -v | grep "GNU Make" | sed "s/[^0-9\.]*//g")
## GNU Make最小需要版本，3.80以下版本有可能出现莫名其妙问题
MAKE_MIN_NEED_VERSION:=3.81

result:=$(shell expr $(MAKE_VERSION) \< $(MAKE_MIN_NEED_VERSION))

$(call assert-equal, $(result), 0, The minimum version for GNU Make is [$(MAKE_MIN_NEED_VERSION)])
