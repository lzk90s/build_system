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

# list
MODULE_LIST:=MODULE
TASK_LIST:=TASK
DEPEND_LIST:=DEPEND
IMPORT_LIST:=IMPORT
EXPORT_LIST:=EXPORT

$(call list-init, $(MODULE_LIST))
$(call list-init, $(TASK_LIST))
$(call list-init, $(DEPEND_LIST))
$(call list-init, $(IMPORT_LIST))
$(call list-init, $(EXPORT_LIST))

# map
HEADER_MAP:=HEADER_MAP
$(call map-init, $(HEADER_MAP))


# get all modules
ifneq (x, x$(strip $(ONE_SHOT_MAKEFILE)))
all_modules:=$(strip $(ONE_SHOT_MAKEFILE))
DISABLE_AUTO_DEPS:=TRUE
else
all_modules:=$(call find-all-module-under-dir, $(PROJECT_TOP_DIR))
endif

sinclude $(all_modules)


# deal with dependence
ifneq (xTRUE, x$(strip $(DISABLE_AUTO_DEPS)))
$(foreach itr, $(call list-get-itr-set, $(DEPEND_LIST)), \
    $(eval id:=$(call list-get-val-by-itr, $(DEPEND_LIST), $(itr))) \
    $(eval _target:=$(call mod-get-target-entry, $(id))) \
    $(eval _dep_ids:=$(call mod-get-deps, $(id))) \
    $(eval _deps:=$(foreach i, $(_dep_ids), $(call mod-get-target-entry, $(i)))) \
    $(eval $(call add-depends,$(_target),$(_deps))) \
)
endif


# deal with header export
ifeq (x, x$(strip $(ONE_SHOT_MAKEFILE)))
$(foreach itr, $(call list-get-itr-set, $(EXPORT_LIST)), \
    $(eval id:=$(call list-get-val-by-itr, $(EXPORT_LIST), $(itr))) \
    $(eval _export_name:=$(call mod-get-export-header, $(id))) \
    $(eval _export_dirs:=$(call mod-get-export-dirs, $(id))) \
    $(call map-append, $(HEADER_MAP), $(_export_name), $(_export_dirs)) \
)
endif


# if build just one module, load the header from file
ifneq (x, x$(strip $(ONE_SHOT_MAKEFILE)))
# if the file not exist, run make for the first time
$(call assert-equal, \
    $(HEADER_EXPORT_FILE), \
    $(wildcard $(HEADER_EXPORT_FILE)), \
    header file not exist! \
)

$(foreach itr, $(call list-get-itr-set, $(IMPORT_LIST)), \
    $(eval id:=$(call list-get-val-by-itr, $(IMPORT_LIST), $(itr))) \
    $(eval _import_names:=$(call mod-get-import-headers, $(id))) \
    $(foreach n, $(_import_names), \
        $(eval _dirs:=$(shell \grep "$(n)" $(HEADER_EXPORT_FILE) | cut -d':' -f2)) \
        $(call map-append, $(HEADER_MAP), $(n), $(_dirs)) \
    ) \
)
endif

# deal with header import
$(foreach itr, $(call list-get-itr-set, $(IMPORT_LIST)), \
    $(eval id:=$(call list-get-val-by-itr, $(IMPORT_LIST), $(itr))) \
    $(eval _import_names:=$(call mod-get-import-headers, $(id))) \
    $(eval _all_dirs:=$(foreach n, $(_import_names), $(call map-get-val-by-key, $(HEADER_MAP), $(n)))) \
    $(eval _d:=$(sort $(call mod-get-inc-dirs, $(id)) $(_all_dirs))) \
    $(call mod-set-inc-dirs, $(id), $(_d)) \
)
        
# bring in other target
include $(BUILD_SYSTEM_TOP_DIR)/Makefile

# bring in the post-built information
include $(BUILD_SYSTEM_TOP_DIR)/postbuilt.mk

$(call list-fini, $(MODULE_LIST))
$(call list-fini, $(TASK_LIST))
$(call list-fini, $(DEPEND_LIST))
$(call list-fini, $(IMPORT_LIST))
$(call list-fini, $(EXPORT_LIST))

$(call map-fini, $(HEADER_MAP))
