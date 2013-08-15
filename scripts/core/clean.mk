#
#   file : clean.mk
#   description: clean target
#

.PHONY: clean_module distclean
MODULE_ID:=$(strip $(MODULE_ID))
clean_module:
	$(call assert-not-null, $(MODULE_ID), MODULE_ID is null)
	$(call set-query-id, $(MODULE_ID))
	$(call mod-target-clean)
	$(hide)echo -e "$(MODULE_ID) : Clean done!"

distclean:
	$(hide)echo -e "Delete output directory"
	$(hide)$(RM) $(PROJECT_OUTPUT_TOP_DIR)
