#
#    file : map_class.mk
#    description: map
#

# name: LIST

$(PUBLIC)


# initialize map
define MAP_Init
    $(eval this:=$(strip $(1))) \
    $(eval $(this).key:= ) \
    $(eval $(this).value:= )
endef


# append key-value to map
#    p2: key
#    p3: value
define MAP_Append
    $(eval this:=$(strip $(1))) \
    $(eval _key:=$(strip $(2))) \
    $(eval _val:=$(strip $(3))) \
    $(eval $(this).map_list:=$($(this).map_list) $(_key)) \
    $(eval $(this).map.$(_key):=$(sort $($(this).map.$(_key)) $(_key))) \
    $(eval $(this).map.$(_key).val:=$(_val))
endef


define MAP_Count
$(strip \
    $(eval this:=$(strip $(1))) \
    $(words $($(this).map_list)) \
)
endef


define MAP_Clear
    $(eval this:=$(strip $(1))) \
    $(eval $(this).map_list:= )
endef


define MAP_Remove
    $(eval this:=$(strip $(1))) \
    $(eval _tmp:=$(filter-out $(strip $(2)), $($(this).map_list))) \
    $(eval $(this).map_list:=$(_tmp))
endef


define MAP_GetValByKey
$(strip \
    $(eval this:=$(strip $(1))) \
    $(eval _key:=$(strip $(2))) \
    $($(this).map.$(_key).val) \
)
endef



$(PRIVATE)
# key
# value
