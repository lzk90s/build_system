#    
#    file : postbuilt.mk
#    description: post built
#

include $(BUILD_SYSTEM_TOP_DIR)/clean.mk

ifneq (xTRUE, x$(strip $(DISABLE_DEBUG)))
include $(BUILD_SYSTEM_TOP_DIR)/query.mk
endif


# if build all module, save the header information exported before
ifeq (x, x$(strip $(ONE_SHOT_MAKEFILE)))
$(shell $(RM) $(HEADER_EXPORT_FILE))
$(shell $(MKDIR) $(dir $(HEADER_EXPORT_FILE)))
$(foreach m, $(call SET_GetValSet, $(SET_HeaderExport)), \
    $(eval name:=$(call MOD_GetExportHeaderName, $(m))) \
    $(eval dirs:=$(call MOD_GetExportHeaderDirs, $(m))) \
    $(shell echo "$(name):$(dirs)" >>$(HEADER_EXPORT_FILE)) \
)
endif

