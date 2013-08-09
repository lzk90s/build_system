##--------------------------------------------------------------------------
##
#        文件：copy_headers.mk
#        描述：头文件拷贝
#        修改：2013-6-10
#
##--------------------------------------------------------------------------

ifeq ($(strip $(curr_module_is_host)), TRUE)
my_prefix:=HOST_
else
my_prefix:=TARGET_
endif

$(foreach header, $(MODULE.$(curr_module_id).MODULE_FILE.COPY_HEADERS), \
    $(eval _from:=$(header)) \
    $(eval _to:= $(strip \
        $($(my_prefix)OUT_HEADERS)/$(LOCAL_COPY_HEADERS_TO)/$(notdir $(header)))) \
    $(shell mkdir -p $(dir $(_to)) && cp -uf $(_from) $(_to)) \
)

