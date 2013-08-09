##--------------------------------------------------------------------------
##
#        文件：help.mk
#        描述：帮助
#        修改：2013-5-31
#
##--------------------------------------------------------------------------


.PHONY: help
help:
	@echo
	@echo "Common make targets:"
	@echo "----------------------------------------------------------------------------------"
	@echo "main                                    Default target"
	@echo "clean                                   clean target"
	@echo "distclean                               rm $(PROJECT_OUTPUT_TOP_DIR)" 
	@echo "show_list                               show the global list in build system"
	@echo "list_<xxx>                              show list information of xxx"
	@echo "query_module_info  <MODULE_ID=>         show the variables that <MODULE_ID> include"
	@echo "query_owners_module <MODULE_OWNER=>     show the list of module that belong to <MODULE_OWNER>"
	@echo "query_module_id <MODULE_NAME=>          query module id by module name that you give"
	@echo "help                                    You're reading it right now"
