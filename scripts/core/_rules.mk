#
#   file : _rules.mk
#   description: private rules for makefile
#


$(___TARGETS): PRIVATE.ID:=$(call MOD_GetID, $(MODULE))
$(___TARGETS): PRIVATE.PATH.RELATIVE:=$(call MOD_GetRelativePath, $(MODULE))
$(___TARGETS): PRIVATE.PATH.INTERMEDIATE:=$(call MOD_GetInterPath, $(MODULE))
$(___TARGETS): PRIVATE.PATH.INSTALL:=$(call MOD_GetInstallPath, $(MODULE))

$(___TARGETS): PRIVATE.INFO.AR:=$(call MOD_GetARTool, $(MODULE))
$(___TARGETS): PRIVATE.INFO.CC:=$(call MOD_GetCCTool, $(MODULE))
$(___TARGETS): PRIVATE.INFO.CXX:=$(call MOD_GetCXXTool, $(MODULE))
$(___TARGETS): PRIVATE.INFO.LD:=$(call MOD_GetLinkTool, $(MODULE))

$(___TARGETS): PRIVATE.INFO.CFLAGS:=$(strip \
    $(call MOD_GetCFlags, $(MODULE)) \
    $(addprefix -I, $(call MOD_GetIncDirs, $(MODULE))) \
)
$(___TARGETS): PRIVATE.INFO.CXXFLAGS:=$(strip \
    $(call MOD_GetCXXFlags, $(MODULE)) \
    $(addprefix -I, $(call MOD_GetIncDirs, $(MODULE))) \
)

$(___TARGETS): PRIVATE.INFO.LDFLAGS:=$(strip \
    $(call MOD_GetLinkFlags, $(MODULE)) \
    $(addprefix -L, /usr/lib /usr/local/lib) \
    $(addprefix -L, $(call MOD_GetLibDirs, $(MODULE))) \
    $(addprefix -L,$($(my_prefix)OUT_SHARED_LIBRARIES)) \
    $(addprefix -L, $($(my_prefix)OUT_STATIC_LIBRARIES)) \
)

$(___TARGETS): PRIVATE.INFO.STATIC_LIBRARIES:=$(sort $(call MOD_GetStaticLibs, $(MODULE)) $(call MOD_GetARLibs, $(MODULE)))
$(___TARGETS): PRIVATE.INFO.SHARED_LIBRARIES:=$(sort $(call MOD_GetSharedLibs, $(MODULE)))

## header import
$(___TARGETS): PRIVATE.I_E.IMPORT_HEADERS:=$(call MOD_GetImportHeaderNames, $(MODULE))
