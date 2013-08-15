#
#   file : list.mk
#   description: list
#

# name: LIST
$(CLASS) $(LIST)

$(PUBLIC)

# initialize list
define list-init
	$(eval this:=$(strip $(1))) \
	$(eval $(this).itr_set:= ) \
	$(eval $(this).list:= )
endef

# finalize list
define list-fini
endef

# append element to list
#	p2: values
define list-append
	$(eval this:=$(strip $(1))) \
	$(eval _new:=$(strip $(shell expr $(call list-count, $(this)) + 1))) \
	$(eval $(this).itr_set:=$($(this).itr_set) $(_new)) \
	$(eval $(this).list.$(_new):=$(strip $(2)))
endef


# count the size of list
#	r: size of list
define list-count
$(strip \
	$(eval this:=$(strip $(1))) \
	$(words $(strip $($(this).itr_set))) \
)
endef

# clear list
define list-clear
	$(eval this:=$(strip $(1))) \
	$(eval $(this).itr_set:= )
endef

# element remove
#	p2: element index
define list-remove
	$(eval this:=$(strip $(1))) \
	$(eval _idx:=$(strip $(2))) \
	$(eval _tmp:=$(filter-out $(_idx), $($(this).itr_set))) \
	$(eval $(this).itr_set:=$(_tmp))
endef

# get element by index, index=[0,...,list-count-1]
#	p2: index
define list-get-val-by-itr
$(strip \
	$(eval this:=$(strip $(1))) \
	$(eval _itr:=$(strip $(2))) \
	$($(this).list.$(_itr))
)
endef

define list-get-itr-set
$(strip \
	$(eval this:=$(strip $(1))) \
	$($(this).itr_set) \
)
endef


$(PRIVATE)
# itr_set
# list