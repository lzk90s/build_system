#   集合

# name: LIST
$(PUBLIC)


define SET_Init
    $(eval this:=$(strip $(1))) \
    $(eval $(this).set:= )
endef


define SET_Append
    $(eval this:=$(strip $(1))) \
    $(eval $(this).set:=$(sort $($(this).set) $(2)))
endef


define SET_Count
$(strip \
    $(eval this:=$(strip $(1))) \
    $(words $($(this).set)) \
)
endef


define SET_Clear
    $(eval this:=$(strip $(1))) \
    $(eval $(this).set:= )
endef


define SET_Remove
    $(eval this:=$(strip $(1))) \
    $(eval ele:=$(strip $(2))) \
    $(eval _tmp:=$(filter-out $(ele), $($(this).set))) \
    $(eval $(this).set:=$(_tmp))
endef


define SET_GetValSet
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).set)
)
endef