#
#	file : map_class.mk
#	description: map
#

# name: LIST
$(CLASS) $(MAP)

$(PUBLIC)

# initialize map
define map-init
	$(eval this:=$(strip $(1))) \
	$(eval $(this).key:= ) \
	$(eval $(this).value:= )
endef

# finalize map
define map-fini
endef

# append key-value to map
#	p2: key
#	p3: value
define map-append
	$(eval this:=$(strip $(1))) \
	$(eval _key:=$(strip $(2))) \
	$(eval _val:=$(strip $(3))) \
	$(eval $(this).map_list:=$($(this).map_list) $(_key)) \
	$(eval $(this).map.$(_key):=$(sort $($(this).map.$(_key)) $(_key))) \
	$(eval $(this).map.$(_key).val:=$(_val))
endef

define map-count
$(strip \
	$(eval this:=$(strip $(1))) \
	$(words $($(this).map_list)) \
)
endef

define map-clear
	$(eval this:=$(strip $(1))) \
	$(eval $(this).map_list:= )
endef

define map-remove
	$(eval this:=$(strip $(1))) \
	$(eval _tmp:=$(filter-out $(strip $(2)), $($(this).map_list))) \
	$(eval $(this).map_list:=$(_tmp))
endef

define map-get-val-by-key
$(strip \
	$(eval this:=$(strip $(1))) \
	$(eval _key:=$(strip $(2))) \
	$($(this).map.$(_key).val) \
)
endef


$(PRIVATE)
# key
# value