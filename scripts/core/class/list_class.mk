#
#   file : list.mk
#   description: list
#

# name: LIST
$(PUBLIC)

# initialize list
define LIST_Init
    $(eval this:=$(strip $(1))) \
    $(eval $(this).itr_set:= ) \
    $(eval $(this).list:= )
endef


# append element to list
#    p2: values
define LIST_Append
    $(eval this:=$(strip $(1))) \
    $(eval _new:=$(strip $(shell expr $(call LIST_Count, $(this)) + 1))) \
    $(eval $(this).itr_set:=$($(this).itr_set) $(_new)) \
    $(eval $(this).list.$(_new):=$(strip $(2)))
endef


# count the size of list
#    r: size of list
define LIST_Count
$(strip \
    $(eval this:=$(strip $(1))) \
    $(words $(strip $($(this).itr_set))) \
)
endef


# clear list
define LIST_Clear
    $(eval this:=$(strip $(1))) \
    $(eval $(this).itr_set:= )
endef


# element remove
#    p2: element index
define LIST_Remove
    $(eval this:=$(strip $(1))) \
    $(eval _idx:=$(strip $(2))) \
    $(eval _tmp:=$(filter-out $(_idx), $($(this).itr_set))) \
    $(eval $(this).itr_set:=$(_tmp))
endef


# get element by index, index=[0,...,list-count-1]
#    p2: index
define LIST_GetValByItr
$(strip \
    $(eval this:=$(strip $(1))) \
    $(eval _itr:=$(strip $(2))) \
    $($(this).list.$(_itr))
)
endef


define LIST_GetItrSet
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).itr_set) \
)
endef


$(PRIVATE)
# itr_set
# list
