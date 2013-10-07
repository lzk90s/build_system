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
	$(hide)echo "ID                     =$(call MOD_GetID, $(MODULE_ID))"
	$(hide)echo "NAME                   =$(call MOD_GetName, $(MODULE_ID))"
	$(hide)echo "CLASS                  =$(call MOD_GetClass, $(MODULE_ID))"
	$(hide)echo ""
	$(hide)echo "PATH.SOURCE            =$(call MOD_GetSourcePath, $(MODULE_ID))"
	$(hide)echo "PATH.RELATIVE          =$(call MOD_GetRelativePath, $(MODULE_ID))"
	$(hide)echo "PATH.INTERMEDIATE      =$(call MOD_GetInterPath, $(MODULE_ID))"
	$(hide)echo "PATH.INSTALL           =$(call MOD_GetInstallPath, $(MODULE_ID))"
	$(hide)echo ""
	$(hide)echo "FILE.SRCS              =$(call MOD_GetSrcFiles, $(MODULE_ID))"
	$(hide)echo "FILE.OBJS              =$(call MOD_GetObjFiles, $(MODULE_ID))"
	$(hide)echo ""
	$(hide)echo "INFO.OWNER             =$(call MOD_GetOwner, $(MODULE_ID))"
	$(hide)echo "INFO.AR                =$(call MOD_GetARTool, $(MODULE_ID))"
	$(hide)echo "INFO.CC                =$(call MOD_GetCCTool, $(MODULE_ID))"
	$(hide)echo "INFO.CXX               =$(call MOD_GetCXXTool, $(MODULE_ID))"
	$(hide)echo "INFO.LD                =$(call MOD_GetLinkTool, $(MODULE_ID))"
	$(hide)echo "INFO.CFLAGS            =$(call MOD_GetCFlags, $(MODULE_ID))"
	$(hide)echo "INFO.CXXFLAGS          =$(call MOD_GetCXXFlags, $(MODULE_ID))"
	$(hide)echo "INFO.LDFLAGS           =$(call MOD_GetLinkFlags, $(MODULE_ID))"
	$(hide)echo "INFO.INC_DIRS          =$(call MOD_GetIncDirs, $(MODULE_ID))"
	$(hide)echo "info.LIB_DIRS          =$(call MOD_GetLibDirs, $(MODULE_ID))"
	$(hide)echo "info.ARLIBS            =$(call MOD_GetARLibs, $(MODULE_ID))"
	$(hide)echo "info.LDLIBS            =$(call MOD_GetLDLibs, $(MODULE_ID))"
	$(hide)echo "info.STATIC_LIBS       =$(call MOD_GetStaticLibs, $(MODULE_ID))"
	$(hide)echo "info.SHARED_LIBS       =$(call MOD_GetSharedLibs, $(MODULE_ID))"
	$(hide)echo ""
	$(hide)echo "DEP.DEPENDS            =$(call MOD_GetDepends, $(MODULE_ID))"
	$(hide)echo ""
	$(hide)echo "HEADER.IMPORT_NAMES    =$(call MOD_GetImportHeaderNames, $(MODULE_ID))"
	$(hide)echo "HEADER.EXPORT_NAME     =$(call MOD_GetExportHeaderName, $(MODULE_ID))"
	$(hide)echo "HEADER.EXPORT_DIRS     =$(call MOD_GetExportHeaderDirs, $(MODULE_ID))"
	$(hide)echo ""
	$(hide)echo "TARGET.ULTIMATE        =$(call MOD_GetUltimateTarget, $(MODULE_ID))"
	$(hide)echo "TARGET.INTERMEDIATE    =$(call MOD_GetInterTarget, $(MODULE_ID))"
	$(hide)echo ""


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

	
