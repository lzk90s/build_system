#    
#    file : version.mk
#    description: version for makefile
#
#

BUILD_SYSTEM_VERSION:=0.0.2

define get-system-version
$(strip \
    $(BUILD_SYSTEM_VERSION) \
)
endef
