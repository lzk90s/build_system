#
#    file : module_class.mk
#    description: module class
#



#******************************** public ************************************#
$(PUBLIC)

# initialize module
#    p2: class
#    p3: name
#	 ret: Object
define MOD_New
$(strip \
    $(eval ___TARGETS:= ) \
	$(eval _class:=$(strip $(1))) \
	$(eval _name:=$(strip $(2))) \
	$(eval _id:=$(call GenModuleID, $(_class), $(_name))) \
	$(eval this:=$(_id)) \
	$(eval $(this).id:=$(_id)) \
    $(eval $(this).class:=$(_class)) \
    $(eval $(this).name:=$(_name)) \
    $(eval $(this).path.source:=$(curr_mpath)) \
    $(eval $(this).path.relative:=$(call _GenRelativePath)) \
    $(eval $(this).file.srcs:=$(foreach f, $(LOCAL_SRC_FILES), $(call _NormalizeSrcFiles, $(f)))) \
    $(eval DEP_LOCK:=DEP_LOCK) \
    $(call lock-release, $(DEP_LOCK)) \
	$(_id) \
)
endef


define MOD_Delete
    $(call lock-release, $(DEP_LOCK))
endef


# set intermediate path of module
#    p2: absolute path
define MOD_SetInterPath
    $(eval this:=$(strip $(1))) \
    $(eval $(this).path.intermediate:=$(strip $(2))) \
    $(call _UpdateObjs) \
    $(call _UpdateTarget)
endef


# set install path
#    p2: absolute path
define MOD_SetInstallPath
    $(eval this:=$(strip $(1))) \
    $(eval $(this).path.install:=$(strip $(2))) \
    $(eval $(this).target.ultimate:=$($(this).path.install)/$($(this).name)) \
    $(eval $(this).target.clean:= $($(this).target.clean) $($(this).target.ultimate))
endef


# set owner
#    p2: owner
define MOD_SetOwner
    $(eval this:=$(strip $(1))) \
    $(eval $(this).info.owner:=$(strip $(2)))
endef


define MOD_SetARTool
    $(eval this:=$(strip $(1))) \
    $(eval $(this).info.ar:=$(strip $(2)))
endef


define MOD_SetCCTool
    $(eval this:=$(strip $(1))) \
    $(eval $(this).info.cc:=$(strip $(2)))
endef


define MOD_SetCXXTool
    $(eval this:=$(strip $(1))) \
    $(eval $(this).info.cxx:=$(strip $(2)))
endef


define MOD_SetLinkTool
    $(eval this:=$(strip $(1))) \
    $(eval $(this).info.ld:=$(strip $(2)))
endef


define MOD_SetCFlags
    $(eval this:=$(strip $(1))) \
    $(eval $(this).info.cflags:= $(strip $(2)))
endef


define MOD_SetCXXFlags
    $(eval $(this).info.cxxflags:=$(strip $(2)))
endef


define MOD_SetLinkFlags
    $(eval this:=$(strip $(1))) \
    $(eval $(this).info.ldflags:=$(strip $(2)))
endef


define MOD_SetIncDirs
    $(eval this:=$(strip $(1))) \
    $(eval $(this).info.inc_dirs:=$(strip $(2)))
endef


define MOD_SetLibDirs
    $(eval this:=$(strip $(1))) \
    $(eval $(this).info.lib_dirs:=$(strip $(2)))
endef


define MOD_SetARLibs
    $(eval this:=$(strip $(1))) \
    $(eval $(this).info.arlibs:=$(strip $(2)))
endef


define MOD_SetLDLibs
    $(eval this:=$(strip $(1))) \
    $(eval $(this).info.ldlibs:=$(strip $(2)))
endef


define MOD_SetSharedLibs
    $(eval this:=$(strip $(1))) \
    $(eval $(this).info.shared_libs:=$(strip $(2))) \
    $(if $(strip $(2)), $(call _AddSharedLibAutoDeps),)
endef


define MOD_SetStaticLibs
    $(eval this:=$(strip $(1))) \
    $(eval $(this).info.static_libs:=$(strip $(2))) \
    $(if $(strip $(2)), $(call _AddStaticLibAutoDeps),)
endef


define MOD_SetDepends
    $(eval this:=$(strip $(1))) \
    $(eval $(this).depend.deps:=$(strip $(2)))
endef


define MOD_SetExportHeaderDirs
    $(eval this:=$(strip $(1))) \
    $(eval $(this).i_e.export_header_dirs:=$(strip $(2)))
endef


define MOD_SetExportHeaderName
    $(eval this:=$(strip $(1))) \
    $(eval $(this).i_e.export_header:=$(strip $(2)))
endef


define MOD_SetImportHeaderNames
    $(eval this:=$(strip $(1))) \
    $(eval $(this).i_e.import_headers:=$(strip $(2)))
endef


define MOD_GetName
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).name) \
)
endef


define MOD_GetClass
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).class) \
)
endef


define MOD_GetID
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).id) \
)
endef


define MOD_GetInterPath
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).path.intermediate) \
)
endef


define MOD_GetSourcePath
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).path.source) \
)
endef


define MOD_GetRelativePath
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).path.relative) \
)
endef


define MOD_GetInstallPath
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).path.install) \
)
endef


define MOD_GetSrcFiles
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).file.srcs) \
)
endef


define MOD_GetObjFiles
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).file.objs) \
)
endef


define MOD_GetOwner
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).info.owner) \
)
endef


define MOD_GetARTool
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).info.ar) \
)
endef


define MOD_GetCCTool
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).info.cc) \
)
endef


define MOD_GetCXXTool
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).info.cxx) \
)
endef


define MOD_GetLinkTool
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).info.ld) \
)
endef


define MOD_GetCFlags
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).info.cflags) \
)
endef


define MOD_GetCXXFlags
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).info.cxxflags) \
)
endef


define MOD_GetLinkFlags
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).info.ldflags) \
)
endef


define MOD_GetARLibs
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).info.arlibs) \
)
endef


define MOD_GetLDLibs
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).info.ldlibs) \
)
endef


define MOD_GetIncDirs
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).info.inc_dirs) \
)
endef


define MOD_GetLibDirs
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).info.lib_dirs) \
)
endef


define MOD_GetStaticLibs
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).info.static_libs) \
)
endef


define MOD_GetSharedLibs
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).info.shared_libs) \
)
endef


define MOD_GetDepends
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).depend.deps) \
)
endef


define MOD_GetExportHeaderDirs
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).i_e.export_header_dirs) \
)
endef


define MOD_GetExportHeaderName
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).i_e.export_header) \
)
endef


define MOD_GetImportHeaderNames
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).i_e.import_headers) \
)
endef


define MOD_GetUltimateTarget
$(strip \
    $(eval this:=$(strip $(1))) \
    $($(this).target.ultimate) \
)
endef

define MOD_GetInterTarget
$(strip \
	$(eval this:=$(strip $(1))) \
	$($(this).target.intermediate) \
)
endef

define MOD_TargetClean
$(strip \
    $(eval this:=$(strip $(1))) \
    $(shell rm -rf $($(this).target.clean)) \
)
endef





#****************************** static public *********************************#

define MOD_TransC2Obj
    $(hide)    $(MKDIR) $(dir $@)
    $(hide)echo -e "[ CC      ]    -->    $(call _FormatOutput, $@)"
    $(call _TransC2Obj)
    $(call _TransD2P)
endef


define MOD_TransCXX2Obj
    $(hide)    $(MKDIR) $(dir $@)
    $(hide)echo -e "[ C++     ]    -->    $(call _FormatOutput, $@)"
    $(call _TransCXX2Obj)
    $(call _TransD2P)
endef


define MOD_TransObj2Exe
    $(hide)    $(MKDIR) $(dir $@)
    $(hide)echo -e "[ LINK    ]    -->    $(call _FormatOutput, $@)"    
    $(call _TransO2Exe)
endef


define MOD_TransObj2StaticLib
    $(hide)$(MKDIR) $(dir $@)
    $(hide)echo -e "[ AR      ]    -->    $(call _FormatOutput, $@)"    
    $(hide)rm -f $@
    $(hide)$(_RepackAllStaticLibs)
    $(hide)$(PRIVATE.INFO.AR) $(GLOBAL_ARFLAGS) $@ $(filter %.o, $^)
endef


define MOD_TransObj2SharedLib
    $(hide)$(MKDIR) $(dir $@)
    $(hide)echo -e "[ LINK    ]    -->    $(call _FormatOutput, $@)"    
    $(_TransO2SharedLib)
endef


define MOD_GenModInstallPath
$(strip \
    $(eval _i:=) \
    $(eval _i:=$(strip $(if $(findstring EXECUTABLE, $(curr_mclass)), \
        $($(my_prefix)OUT_EXECUTABLES), \
        $(_i))) \
     )
    $(eval _i:=$(strip $(if $(findstring STATIC_LIBRARY, $(curr_mclass)), \
        $($(my_prefix)OUT_STATIC_LIBRARIES), \
        $(_i))) \
     )
    $(eval _i:=$(strip $(if $(findstring SHARED_LIBRARY, $(curr_mclass)), \
        $($(my_prefix)OUT_SHARED_LIBRARIES), \
        $(_i)))) \
    $(_i) \
)
endef


define MOD_Install
$(hide)    $(MKDIR) $(dir $@)
    $(hide)echo -e "[ INSTALL ]    -->    $(call _FormatOutput, $@)"
    $(hide)$(CP) $< $@
endef


#********************************* private **********************************#
$(PRIVATE)


define _GenRelativePath
$(strip \
    $(if $(call IsEqual, $(PROJECT_TOP_DIR), $(curr_mpath)), \
        ., \
        $(patsubst $(PROJECT_TOP_DIR)/%,%,$(curr_mpath)) \
     ) \
)
endef


define _UpdateObjs
    $(eval srcs:=$(call MOD_GetSrcFiles, $(MODULE))) \
    $(eval cs:=$(call _FilterCSrcFiles, $(srcs))) \
    $(eval cxxs:=$(call _FilterCXXSrcFiles, $(srcs))) \
    $(eval objs:=$(strip \
        $(foreach f, $(cs), $(call _C2Obj, $(f))) \
        $(foreach f, $(cxxs), $(call _CXX2Obj, $(f)))) \
     ) \
    $(eval $(this).file.objs:=$(objs))
endef


define _UpdateTarget
    $(eval $(this).target.ultimate:=$($(this).path.install)/$($(this).name)) \
    $(eval $(this).target.intermediate:=$($(this).path.intermediate)/$($(this).name)) \
    $(eval $(this).target.clean:=$(strip \
        $($(this).target.clean) \
        $($(this).target.intermediate) \
        $($(this).file.objs)) \
     )
endef


define _AddSharedLibAutoDeps
    $(eval libs:=$(notdir $(call MOD_GetSharedLibs, $(MODULE)))) \
    $(eval newIds:=$(foreach lib, $(libs), \
        $(eval lname:=$(call NormSharedLib2Name.so, $(lib))) \
        $(eval lclass:=$(my_prefix)SHARED_LIBRARY) \
        $(call GenModuleID, $(lclass), $(lname)) \
        ) \
    ) \
    $(eval oldIds:=$(call MOD_GetDepends, $(MODULE))) \
    $(eval ids:=$(sort $(oldIds) $(newIds))) \
    $(call MOD_SetDepends, $(MODULE), $(ids)) \
    $(call SET_Append, $(SET_Depend), $(curr_mid))
endef


define _AddStaticLibAutoDeps
    $(eval libs:=$(notdir $(call MOD_GetStaticLibs, $(MODULE)))) \
    $(eval newIds:=$(foreach lib, $(libs), \
        $(eval lname:=$(call NormStaticLib2Name.a, $(lib))) \
        $(eval lclass:=$(my_prefix)STATIC_LIBRARY) \
        $(call GenModuleID, $(lclass), $(lname)) \
        ) \
    ) \
    $(eval oldIds:=$(call MOD_GetDepends, $(MODULE))) \
    $(eval ids:=$(sort $(oldIds) $(newIds))) \
    $(call MOD_SetDepends, $(MODULE), $(ids)) \
    $(call SET_Append, $(SET_Depend), $(curr_mid))
endef



define _FilterCSrcFiles
$(strip \
    $(foreach ext, $(GLOBAL_C_FILE_SUFFIX), $(filter %$(ext), $(1))) \
)
endef


define _FilterCXXSrcFiles
$(strip \
    $(foreach ext, $(GLOBAL_CXX_FILE_SUFFIX), $(filter %$(ext), $(1))) \
)
endef


define _C2Obj
$(strip \
    $(eval _ip:=$(call MOD_GetInterPath, $(MODULE))) \
    $(eval _sp:=$(call MOD_GetSourcePath, $(MODULE))) \
    $(eval _tmp:=$(foreach e, $(GLOBAL_C_FILE_SUFFIX), \
        $(eval _s:=$(filter %$(e), $(1))) \
        $(patsubst %$(e), %.o, $(_s))) \
     ) \
    $(patsubst $(_sp)%, $(_ip)%, $(_tmp)) \
)
endef


define _CXX2Obj
$(strip \
    $(eval _ip:=$(call MOD_GetInterPath, $(MODULE))) \
    $(eval _sp:=$(call MOD_GetSourcePath, $(MODULE))) \
    $(eval _tmp:=$(foreach e, $(GLOBAL_CXX_FILE_SUFFIX), \
        $(eval _s:=$(filter %$(e), $(1))) \
        $(patsubst %$(e), %.o, $(_s))) \
     ) \
    $(patsubst $(_sp)%, $(_ip)%, $(_tmp)) \
)
endef


define _TransC2Obj
    $(hide)$(eval _incdirs:=$(foreach n, $(PRIVATE.I_E.IMPORT_HEADERS), \
        $(call MAP_GetValByKey, $(MAP_HeaderExport), $(n))) \
     ) \
    $(PRIVATE.INFO.CC) \
    $(addprefix -I, $(_incdirs)) \
    $(PRIVATE.INFO.CFLAGS) \
    $(1) \
    -MD -MF $(patsubst %.o,%.d,$@) \
    -c -o $@ $<
endef


define _TransCXX2Obj
    $(hide)$(eval _incdirs:=$(foreach n, $(PRIVATE.I_E.IMPORT_HEADERS), \
        $(call MAP_GetValByKey, $(MAP_HeaderExport), $(n))) \
     ) \
    $(PRIVATE.INFO.CXX)     \
    $(addprefix -I, $(_incdirs)) \
    $(PRIVATE.INFO.CXXFLAGS) \
    $(1) \
    -MD -MF $(patsubst %.o,%.d,$@) \
    -c -o $@ $<
endef


define _TransD2PWithArgs
$(hide)    cp $(1) $(2); \
sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
    -e '/^$$/ d' -e 's/$$/ :/' < $(1) >> $(2); \
rm -f $(1)
endef


define _TransD2P
    $(call _TransD2PWithArgs,$(@:%.o=%.d),$(@:%.o=%.P))
endef


define _RepackStaticLib
$(strip \
    ldir=$(PRIVATE.PATH.INTERMEDIATE)/WHOLE/$(basename $(notdir $(1)))_objs;\
    rm -rf $$ldir; \
    mkdir -p $$ldir; \
    filelist=; \
    for f in `$(PRIVATE.INFO.AR) t $(1) | \grep '\.o$$'`; do \
        $(PRIVATE.INFO.AR) p $(1) $$f > $$ldir/$$f; \
        filelist="$$filelist $$ldir/$$f"; \
    done ; \
    $(PRIVATE.INFO.AR) $(GLOBAL_ARFLAGS)  $@ $$filelist; \
)
endef


define _RepackAllStaticLibs
    $(eval libs:=$(PRIVATE.INFO.STATIC_LIBRARIES)) \
    $(foreach lib, $(libs), $(call _RepackStaticLib, $(lib)))
endef


define _TransO2SharedLib
    $(hide)$(PRIVATE.INFO.LD) \
    $(PRIVATE.INFO.CFLAGS) $(PRIVATE.INFO.CXXFLAGS) \
    $(PRIVATE.INFO.LDFLAGS) \
	-Wl,-rpath-link=$($(my_prefix)OUT_SHARED_LIBRARIES) \
    -shared -Wl,-soname,$(notdir $@) \
	-Wl,--whole-archive \
	$(call NormStaticLib2LName, $(notdir $(PRIVATE.INFO.STATIC_LIBRARIES)))    \
	-Wl,--no-whole-archive \
	-Wl,--start-group \
	$(call NormStaticLib2LName,$(notdir $(PRIVATE.INFO.STATIC_LIBRARIES)))  \
	-Wl,--end-group \
	$(call NormSharedLib2LName, $(notdir $(PRIVATE.INFO.SHARED_LIBRARIES))) \
	$(filter %$(GLOBAL_OBJ_FILE_SUFFIX), $^) \
	-o $@ 
endef


define _TransO2Exe
    $(hide)$(PRIVATE.INFO.LD) \
    $(PRIVATE.INFO.CFLAGS) $(PRIVATE.INFO.CXXFLAGS) \
    $(PRIVATE.INFO.LDFLAGS) \
	-Wl,--whole-archive \
	$(call NormStaticLib2LName, $(notdir $(PRIVATE.INFO.STATIC_LIBRARIES)))    \
	-Wl,--no-whole-archive \
	-Wl,--start-group \
	$(call NormStaticLib2LName,$(notdir $(PRIVATE.INFO.STATIC_LIBRARIES))) \
	-Wl,--end-group \
	$(call NormSharedLib2LName, $(notdir $(PRIVATE.INFO.SHARED_LIBRARIES))) \
	$(filter %$(GLOBAL_OBJ_FILE_SUFFIX), $^) \
	-o $@ 
endef


define _NormalizeSrcFiles
$(strip \
    $(if $(call IsAbsolutePath, $(1)), \
        $(1), \
        $(addprefix $($(this).path.source)/, $(1)) \
     ) \
)
endef



INFO_HEADER:=<|OUT_ROOT|>
define _FormatOutput
    $(addprefix $(INFO_HEADER),$(patsubst $(PROJECT_OUTPUT_TOP_DIR)%, %, $(1)))
endef




$(PRIVATE)
# name
# class
# id

# path.source
# path.relative
# path.intermediate
# path.install

# file.srcs
# file.objs

# info.owner
# info.ar
# info.cc
# info.cxx
# info.ld
# info.cflags
# info.cxxflags
# info.ldflags
# info.inc_dirs
# info.lib_dirs
# info.arlibs
# info.ldlibs
# info.static_libs
# info.shared_libs

# i_e.export_header_dirs
# i_e.export_header
# i_e.import_headers

# depend.deps

# target.ultimate
# target.intermediate
# target.clean
# target.MAIN = target.intermediate + target.ultimate
