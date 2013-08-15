#    
#    file : assert.mk
#    description: assert macro
#


# assert
# @param $(1) condition
define assert
    $(if $(strip $(1)),, $(error Assert Failed : $(strip $(2))))
endef

# not null assert
# @param $(1) condition
define assert-not-null
    $(call assert,$(1), $(if $(strip $(2)), $(2), The variable is null!))
endef

# equal assert
# @param $(1) first condition
# @param $(2) second condition
define assert-equal
    $(call assert, $(filter $(1), $(2)), $(if $(strip $(3)), $(3), not equal))
endef

