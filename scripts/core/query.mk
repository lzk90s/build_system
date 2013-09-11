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
	$(call AssertNotNull, $(MODULE_ID), MODULE_ID is null)
	$(call banner, ID:$(MODULE_ID))
	$(hide)echo "id                     =$(call MOD_GetID, $(MODULE_ID))"
	$(hide)echo "name                   =$(call MOD_GetName, $(MODULE_ID))"
	$(hide)echo "class                  =$(call MOD_GetClass, $(MODULE_ID))"
	$(hide)echo ""
	$(hide)echo "path.source            =$(call MOD_GetSourcePath, $(MODULE_ID))"
	$(hide)echo "path.relative          =$(call MOD_GetRelativePath, $(MODULE_ID))"
	$(hide)echo "path.intermediate      =$(call MOD_GetInterPath, $(MODULE_ID))"
	$(hide)echo "path.install           =$(call MOD_GetInstallPath, $(MODULE_ID))"
	$(hide)echo ""
	$(hide)echo "file.srcs              =$(call MOD_GetSrcFiles, $(MODULE_ID))"
	$(hide)echo "file.objs              =$(call MOD_GetObjFiles, $(MODULE_ID))"
	$(hide)echo ""
	$(hide)echo "info.owner             =$(call MOD_GetOwner, $(MODULE_ID))"
	$(hide)echo "info.ar                =$(call MOD_GetARTool, $(MODULE_ID))"
	$(hide)echo "info.cc                =$(call MOD_GetCCTool, $(MODULE_ID))"
	$(hide)echo "info.cxx               =$(call MOD_GetCXXTool, $(MODULE_ID))"
	$(hide)echo "info.ld                =$(call MOD_GetLinkTool, $(MODULE_ID))"
	$(hide)echo "info.cflags            =$(call MOD_GetCFlags, $(MODULE_ID))"
	$(hide)echo "info.cxxflags          =$(call MOD_GetCXXFlags, $(MODULE_ID))"
	$(hide)echo "info.ldflags           =$(call MOD_GetLinkFlags, $(MODULE_ID))"
	$(hide)echo "info.inc_dirs          =$(call MOD_GetIncDirs, $(MODULE_ID))"
	$(hide)echo "info.lib_dirs          =$(call MOD_GetLibDris, $(MODULE_ID))"
	$(hide)echo "info.static_libs       =$(call MOD_GetStaticLibs, $(MODULE_ID))"
	$(hide)echo "info.shared_libs       =$(call MOD_GetSharedLibs, $(MODULE_ID))"
	$(hide)echo ""
	$(hide)echo "depend.deps            =$(call MOD_GetDepends, $(MODULE_ID))"
	$(hide)echo ""
	$(hide)echo "i_e.import_headers     =$(call MOD_GetImportHeaderNames, $(MODULE_ID))"
	$(hide)echo "i_e.export_header      =$(call MOD_GetExportHeaderName, $(MODULE_ID))"
	$(hide)echo "i_e.export_header_dirs =$(call MOD_GetExportHeaderDirs, $(MODULE_ID))"
	$(hide)echo ""
	$(hide)echo "target.ultimate        =$(call MOD_GetUltimateTarget, $(MODULE_ID))"
	$(hide)echo "target.intermediate    =$(call MOD_GetInterTarget, $(MODULE_ID))"
	

.PHONY: list_task list_module list_depend list_import
list_task:
	$(call banner, count:$(call SET_Count, $(SET_Task)))
	$(hide)for m in $(call SET_GetValSet, $(SET_Task)); do \
		echo $${m}	;	\
	done
	
list_module:
	$(call banner, count:$(call SET_Count, $(SET_Module)))
	$(hide)for m in $(call SET_GetValSet, $(SET_Module)); do \
		echo $${m}	;	\
	done
	
list_depend:
	$(call banner, count:$(call SET_Count, $(SET_Depend)))
	$(hide)for m in $(call SET_GetValSet, $(SET_Depend)); do \
		echo $${m};	\
	done

list_export:
	$(call banner, count:$(call SET_Count, $(SET_HeaderExport)))
	$(hide)for m in $(call SET_GetValSet, $(SET_HeaderExport)); do \
		echo $${m};	\
	done
	
list_import:
	$(call banner, count:$(call SET_Count, $(SET_HeaderImport)))
	$(hide)for m in $(call SET_GetValSet, $(SET_HeaderImport)); do \
		echo $${m};	\
	done
