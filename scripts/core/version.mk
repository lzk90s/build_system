#    
#    file : version.mk
#    description: version for makefile
#
#

BUILD_SYSTEM_VERSION:=0.0.2

define GetSystemVersion
$(strip \
    $(BUILD_SYSTEM_VERSION) \
)
endef
