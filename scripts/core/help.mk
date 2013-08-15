#	
#	file : help.mk
#	description: help for makefile
#
#

.PHONY: help
help:
	@echo "build system : $(call get-system-version)"
	@echo
	@echo "Common make targets:"
	@echo "----------------------------------------------------------------------------------"
	@echo "main                                    Default target"
	@echo "clean_module                            module clean"
	@echo "distclean                               rm $(PROJECT_OUTPUT_TOP_DIR)" 
	@echo "help                                    You're reading it right now"
