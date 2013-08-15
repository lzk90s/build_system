#	
#	file : Makefile
#	description:
#
#

##	system target
.PHONY: main install all_modules

main: all_modules

ALL_TASK:=$(foreach itr, $(call list-get-itr-set, $(TASK_LIST)), \
	$(call list-get-val-by-itr, $(TASK_LIST), $(itr)) \
)
all_modules: $(ALL_TASK)

install:
	@echo "no support for this now !"
