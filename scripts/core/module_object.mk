#
#    file: module_object.mk
#    description: object of each module
#

$(call AssertNotNull, $(LOCAL_PATH), LOCAL_PATH is null)
$(call AssertNotNull, $(LOCAL_MODULE), LOCAL_MODULE is null)
$(call AssertNotNull, $(LOCAL_MODULE_CLASS), LOCAL_MODULE_CLASS is null)



curr_mpath   :=$(strip $(LOCAL_PATH))
curr_mclass  :=$(strip $(LOCAL_MODULE_CLASS))
curr_mname   :=$(call FormatName)
my_prefix    :=$(call GetPrefix)
curr_mid     :=
tmp          :=


# New Module Object
MODULE:=$(call MOD_New, $(curr_mclass), $(curr_mname))


curr_mid	 :=$(call MOD_GetID, $(MODULE))


# check duplicated module
$(call DupModCheck)


# set intermediate path
tmp:=$(addprefix $($(my_prefix)OUT_INTERMEDIATES)/, $(call MOD_GetRelativePath, $(MODULE)))
$(call MOD_SetInterPath, $(MODULE), $(tmp))


# set install path
tmp:=$(call MOD_GenModInstallPath)
$(call MOD_SetInstallPath, $(MODULE), $(tmp))


# set module owner
tmp:=$(if $(LOCAL_MODULE_OWNER), $(LOCAL_MODULE_OWNER), $(PROJECT_MODULE_OWNER))
$(call MOD_SetOwner, $(MODULE), $(tmp))


# set archive tool
tmp:=$(if $(LOCAL_AR), $(LOCAL_AR), $(AR))
$(call MOD_SetARTool, $(MODULE), $(tmp))


# set c compiler
tmp:=$(if $(LOCAL_CC), $(LOCAL_CC), $(CC))
$(call MOD_SetCCTool, $(MODULE), $(tmp))


# set c++ compiler
tmp:=$(if $(LOCAL_CXX), $(LOCAL_CXX), $(CXX))
$(call MOD_SetCXXTool, $(MODULE), $(tmp))


# set linker
tmp:=$(if $(LOCAL_LD), $(LOCAL_LD), $(LD))
$(call MOD_SetLinkTool, $(MODULE), $(tmp))


# set CFLAGS
tmp:=$(GLOBAL_CFLAGS) $(LOCAL_CFLAGS) $(CFLAGS)
$(call MOD_SetCFlags, $(MODULE), $(tmp))


# set CXXFLAGS
tmp:=$(GLOBAL_CXXFLAGS) $(LOCAL_CXXFLAGS) $(CXXFLAGS)
$(call MOD_SetCXXFlags, $(MODULE), $(tmp))


# set LDFALGS
tmp:=$(GLOBAL_LDFLAGS) $(LOCAL_LDFLAGS) $(LDFLAGS)
$(call MOD_SetLinkFlags, $(MODULE), $(tmp))


# set archive libraries
$(call MOD_SetARLibs, $(MODULE), $(LOCAL_ARLIBS))


# set ld libs
$(call MOD_SetLDLibs, $(MODULE), $(LOCAL_LDLIBS))


# set shared libraries, name only
tmp:=$(foreach l, $(LOCAL_SHARED_LIBRARIES), $(call NormSharedLib2Name.so, $(l)))
tmp:=$(call NormSharedLib2AbsPath, $(tmp))
$(call MOD_SetSharedLibs, $(MODULE), $(tmp))


# set static libraries, absolute path only
tmp:=$(foreach l, $(LOCAL_STATIC_LIBRARIES), $(call NormStaticLib2Name.a, $(l)))
tmp:=$(call NormStaticLib2AbsPath, $(tmp))
$(call MOD_SetStaticLibs, $(MODULE), $(tmp))


# set include directories
absIncDirs:=$(call FilterAbsPath, $(LOCAL_INCLUDE_DIRS))
nonAbsIncNames:=$(filter-out $(absIncDirs), $(LOCAL_INCLUDE_DIRS))

ifneq (x, x$(strip $(nonAbsIncNames)))
    $(call MOD_SetImportHeaderNames, $(MODULE), $(nonAbsIncNames))
    $(call SET_Append, $(SET_HeaderImport), $(curr_mid))
endif
$(call MOD_SetIncDirs, $(MODULE), $(absIncDirs))


# set library directories
$(call MOD_SetLibDirs, $(MODULE), $(LOCAL_LIBRARY_DIRS))


# export header directories
name:=$(word 1, $(LOCAL_EXPORT_HEADER_TO))
dirs:=$(LOCAL_EXPORT_HEADER_DIRS)

ifneq (x, x$(strip $(dirs)))
    $(call AssertNotNull, $(name), LOCAL_EXPORT_HEADER_TO is null!)
    $(call SET_Append, $(SET_HeaderExport), $(curr_mid))
    $(call MOD_SetExportHeaderName, $(MODULE), $(name))
    $(call MOD_SetExportHeaderDirs, $(MODULE), $(dirs))
endif


# add current module to task list for building
$(call SET_Append, $(SET_Task), $(curr_mid))


# add current module to module list
$(call SET_Append, $(SET_Module), $(curr_mid))


# set the entry of module
target:=$(curr_mid)
deps:=$(call MOD_GetInterTarget, $(MODULE)) $(call MOD_GetUltimateTarget, $(MODULE))


$(call AddDepends, $(target),$(deps))


$(call MOD_Delete)
