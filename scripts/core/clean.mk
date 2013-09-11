#
#   file : clean.mk
#   description: clean target
#

.PHONY: clean_module distclean
MODULE_ID:=$(strip $(MODULE_ID))
clean_module:
	$(call AssertNotNull, $(MODULE_ID), MODULE_ID is null)
	$(call MOD_TargetClean, $(MODULE_ID))
	$(hide)echo -e "$(MODULE_ID) : Clean done!"

distclean:
	$(hide)echo -e "Delete output directory"
	$(hide)$(RM) $(PROJECT_OUTPUT_TOP_DIR)
