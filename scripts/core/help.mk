#	
#	file : help.mk
#	description: help for makefile
#
#

.PHONY: help
help:
	$(call PrintInfoMsg,"+------------------------------------------------------------------+")
	$(call PrintErrorMsg,"- version: $(call GetSystemVersion)")
	$(call PrintErrorMsg,"- license: GPL")
	$(call PrintErrorMsg,"- description: common build system for GNU make")
	$(call PrintInfoMsg,"+------------------------------------------------------------------+")
	$(call PrintInfoMsg,"- main  : the default target")
	$(call PrintInfoMsg,"- clean_module : module clean")
	$(call PrintInfoMsg,"- distclean : rm $(PROJECT_OUTPUT_TOP_DIR)")
	$(call PrintInfoMsg,"- help : help information")
	$(call PrintInfoMsg,"- query_info : query module info")
	$(call PrintInfoMsg,"- list_task : list all tasks")
	$(call PrintInfoMsg,"- list_module : list all modules")
	$(call PrintInfoMsg,"- list_depend : list dependence between modules")
	$(call PrintInfoMsg,"- list_export : list all header to be exported")
	$(call PrintInfoMsg,"- list_import : list all header to be imported")
	$(call PrintInfoMsg,"+------------------------------------------------------------------+")
