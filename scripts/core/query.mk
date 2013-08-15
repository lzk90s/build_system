#
#   file : query.mk
#   description: query information of specific module
#
#

COLOR_RED:=\033[1;31m
COLOR_RESET:=\033[0m

# show banner
# p1: title
define banner
	$(hide)echo -e "$(COLOR_RED)"
	$(hide)echo "***-----------------------------------------------------------------------***"
	$(hide)echo "                      $(1)  "
	$(hide)echo "***-----------------------------------------------------------------------***"
	$(hide)echo -e "$(COLOR_RESET)"
endef

.PHONY:query_info

# query by id
MODULE_ID:=$(strip $(MODULE_ID))


query_info:
	$(call assert-not-null, $(MODULE_ID), MODULE_ID is null)
	$(call banner, ID:$(MODULE_ID))
	$(hide)echo "id                     =$(call mod-get-id, $(MODULE_ID))"
	$(hide)echo "name                   =$(call mod-get-name, $(MODULE_ID))"
	$(hide)echo "class                  =$(call mod-get-class, $(MODULE_ID))"
	$(hide)echo ""
	$(hide)echo "path.source            =$(call mod-get-source-path, $(MODULE_ID))"
	$(hide)echo "path.relative          =$(call mod-get-relative-path, $(MODULE_ID))"
	$(hide)echo "path.intermediate      =$(call mod-get-intermediate-path, $(MODULE_ID))"
	$(hide)echo "path.install           =$(call mod-get-install-path, $(MODULE_ID))"
	$(hide)echo ""
	$(hide)echo "file.srcs              =$(call mod-get-srcs, $(MODULE_ID))"
	$(hide)echo "file.objs              =$(call mod-get-objs, $(MODULE_ID))"
	$(hide)echo ""
	$(hide)echo "info.owner             =$(call mod-get-owner, $(MODULE_ID))"
	$(hide)echo "info.ar                =$(call mod-get-ar, $(MODULE_ID))"
	$(hide)echo "info.cc                =$(call mod-get-cc, $(MODULE_ID))"
	$(hide)echo "info.cxx               =$(call mod-get-cxx, $(MODULE_ID))"
	$(hide)echo "info.ld                =$(call mod-get-ld, $(MODULE_ID))"
	$(hide)echo "info.cflags            =$(call mod-get-cflags, $(MODULE_ID))"
	$(hide)echo "info.cxxflags          =$(call mod-get-cxxflags, $(MODULE_ID))"
	$(hide)echo "info.ldflags           =$(call mod-get-ldflags, $(MODULE_ID))"
	$(hide)echo "info.inc_dirs          =$(call mod-get-inc-dirs, $(MODULE_ID))"
	$(hide)echo "info.lib_dirs          =$(call mod-get-lib-dirs, $(MODULE_ID))"
	$(hide)echo "info.static_libs       =$(call mod-get-static-libs, $(MODULE_ID))"
	$(hide)echo "info.shared_libs       =$(call mod-get-shared-libs, $(MODULE_ID))"
	$(hide)echo ""
	$(hide)echo "depend.deps            =$(call mod-get-deps, $(MODULE_ID))"
	$(hide)echo ""
	$(hide)echo "i_e.import_headers     =$(call mod-get-import-headers, $(MODULE_ID))"
	$(hide)echo "i_e.export_header      =$(call mod-get-export-header, $(MODULE_ID))"
	$(hide)echo "i_e.export_header_dirs =$(call mod-get-export-dirs, $(MODULE_ID))"
	$(hide)echo ""
	$(hide)echo "target.ultimate        =$(call mod-get-ultimate-target, $(MODULE_ID))"
	$(hide)echo "target.intermediate    =$(call mod-get-intermediate-target, $(MODULE_ID))"
	$(hide)echo "target.MAIN            =$(call mod-get-target-entry, $(MODULE_ID))"
	

.PHONY: list_task list_module list_depend list_import
list_task:
	$(call banner, count:$(call list-count, $(TASK_LIST)))
	$(eval _all_tasks:=$(foreach itr, $(call list-get-itr-set, $(TASK_LIST)), \
		$(call list-get-val-by-itr, $(TASK_LIST), $(itr))) \
	)
	$(hide)for m in $(_all_tasks); do \
		echo $${m}	;	\
	done
	
list_module:
	$(call banner, count:$(call list-count, $(MODULE_LIST)))
	$(eval _all_modules:=$(foreach itr, $(call list-get-itr-set, $(MODULE_LIST)), \
		$(call list-get-val-by-itr, $(MODULE_LIST), $(itr))) \
	)
	$(hide)for m in $(_all_modules); do \
		echo $${m}	;	\
	done
	
list_depend:
	$(call banner, count:$(call list-count, $(DEPEND_LIST)))
	$(eval _all_deps:=$(foreach itr, $(call list-get-itr-set, $(DEPEND_LIST)), \
		$(call list-get-val-by-itr, $(DEPEND_LIST), $(itr))) \
	)
	$(hide)for m in $(_all_deps); do \
		echo $${m};	\
	done

list_export:
	$(call banner, count:$(call list-count, $(EXPORT_LIST)))
	$(eval _all_exports:=$(foreach itr, $(call list-get-itr-set, $(EXPORT_LIST)), \
		$(call list-get-val-by-itr, $(EXPORT_LIST), $(itr))) \
	)
	$(hide)for m in $(_all_exports); do \
		echo $${m};	\
	done
	
list_import:
	$(call banner, count:$(call list-count, $(IMPORT_LIST)))
	$(eval _all_imports:=$(foreach itr, $(call list-get-itr-set, $(IMPORT_LIST)), \
		$(call list-get-val-by-itr, $(IMPORT_LIST), $(itr))) \
	)
	$(hide)for m in $(_all_imports); do \
		echo $${m};	\
	done
