#	
#	file : postbuilt.mk
#	description: post built
#

include $(BUILD_SYSTEM_TOP_DIR)/clean.mk

ifneq (xTRUE, x$(strip $(DISABLE_DEBUG)))
include $(BUILD_SYSTEM_TOP_DIR)/query.mk
endif

# save task list to file
#all_tasks:=$(call list-get-build-task)
#$(shell echo $(all_tasks) >$(PROJECT_OUT)/tasks.list)


# if build all module, save the header information exported before
ifeq (x, x$(strip $(ONE_SHOT_MAKEFILE)))
$(shell $(RM) $(HEADER_EXPORT_FILE))
$(shell $(MKDIR) $(dir $(HEADER_EXPORT_FILE)))
$(foreach itr, $(call list-get-itr-set, $(EXPORT_LIST)), \
	$(eval id:=$(call list-get-val-by-itr, $(EXPORT_LIST), $(itr))) \
	$(eval _export_name:=$(call mod-get-export-header, $(id))) \
	$(eval _export_dirs:=$(call mod-get-export-dirs, $(id))) \
	$(shell echo "$(_export_name):$(_export_dirs)" >>$(HEADER_EXPORT_FILE)) \
)
endif

