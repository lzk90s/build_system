#
#    file : main.mk
#    description: main framework
#
#


# default target
.PHONY: main
main: 

.SUFFIXES:

.DELETE_ON_ERROR:

# get the top directory of build system.
BUILD_SYSTEM_TOP_DIR=$(PROJECT_TOP_DIR)/scripts/core



include $(BUILD_SYSTEM_TOP_DIR)/help.mk
include $(BUILD_SYSTEM_TOP_DIR)/config.mk
include $(BUILD_SYSTEM_TOP_DIR)/prebuilt.mk



# 集合
SET_Module:=SET_Module
SET_Task:=SET_Task
SET_HeaderImport=SET_HeaderImport
SET_HeaderExport=SET_HeaderExport
SET_Depend:=SET_Depend


$(call SET_Init, $(SET_Module))
$(call SET_Init, $(SET_Task))
$(call SET_Init, $(SET_HeaderImport))
$(call SET_Init, $(SET_HeaderExport))
$(call SET_Init, $(SET_Depend))


# 图
MAP_HeaderExport:=MAP_HeaderExport


$(call MAP_Init, $(MAP_HeaderExport))



# get all modules
ifneq (x, x$(strip $(ONE_SHOT_MAKEFILE)))
all_modules:=$(strip $(ONE_SHOT_MAKEFILE))
DISABLE_AUTO_DEPS:=TRUE
else
all_modules:=$(call FindAllModuleUnder, $(PROJECT_TOP_DIR))
endif

sinclude $(all_modules)


# deal with dependence
ifneq (xTRUE, x$(strip $(DISABLE_AUTO_DEPS)))
$(foreach m, $(call SET_GetValSet, $(SET_Depend)), \
    $(eval deps:=$(call MOD_GetDepends, $(m))) \
    $(eval $(call AddDepends,$(m),$(deps))) \
)
endif



# deal with header export
ifeq (x, x$(strip $(ONE_SHOT_MAKEFILE)))
$(foreach m, $(call SET_GetValSet, $(SET_HeaderExport)), \
    $(eval name:=$(call MOD_GetExportHeaderName, $(m))) \
    $(eval dirs:=$(call MOD_GetExportHeaderDirs, $(m))) \
    $(call MAP_Append, $(MAP_HeaderExport), $(name), $(dirs)) \
)
endif


# if build just one module, load the header from file
ifneq (x, x$(strip $(ONE_SHOT_MAKEFILE)))
# if the file not exist, run make for the first time
ifneq ($(HEADER_EXPORT_FILE), $(wildcard $(HEADER_EXPORT_FILE)))
    $(warning Warning: header file not exist, this may cause error!)
endif

$(foreach m, $(call SET_GetValSet, $(SET_HeaderImport)), \
    $(eval names:=$(call MOD_GetImportHeaderNames, $(m))) \
    $(foreach n, $(names), \
        $(eval dirs:=$(shell \grep "$(n)" $(HEADER_EXPORT_FILE) | cut -d':' -f2)) \
        $(call MAP_Append, $(MAP_HeaderExport), $(n), $(dirs)) \
    ) \
)
endif



# deal with header import
$(foreach m, $(call SET_GetValSet, $(SET_HeaderImport)), \
    $(eval names:=$(call MOD_GetImportHeaderNames, $(m))) \
    $(eval dirs:=$(foreach n, $(names), \
		$(call MAP_GetValByKey, $(MAP_HeaderExport), $(n))) \
	) \
    $(eval ds:=$(sort $(call MOD_GetIncDirs, $(m)) $(dirs))) \
    $(call MOD_SetIncDirs, $(m), $(ds)) \
)
 

 
# bring in other target
include $(BUILD_SYSTEM_TOP_DIR)/Makefile


# bring in the post-built information
include $(BUILD_SYSTEM_TOP_DIR)/postbuilt.mk