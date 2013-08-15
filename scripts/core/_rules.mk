#
#   file : _rules.mk
#   description: private rules for makefile
#

$(___TARGETS): PRIVATE.PATH.RELATIVE:=$(call mod-get-relative-path, $(MOBJ))
$(___TARGETS): PRIVATE.PATH.INTERMEDIATE:=$(call mod-get-intermediate-path, $(MOBJ))
$(___TARGETS): PRIVATE.PATH.INSTALL:=$(call mod-get-install-path, $(MOBJ))

$(___TARGETS): PRIVATE.INFO.AR:=$(call mod-get-ar, $(MOBJ))
$(___TARGETS): PRIVATE.INFO.CC:=$(call mod-get-cc, $(MOBJ))
$(___TARGETS): PRIVATE.INFO.CXX:=$(call mod-get-cxx, $(MOBJ))
$(___TARGETS): PRIVATE.INFO.LD:=$(call mod-get-ld, $(MOBJ))

$(___TARGETS): PRIVATE.INFO.CFLAGS:=$(strip \
    $(call mod-get-cflags, $(MOBJ)) \
    $(addprefix -I, $(call mod-get-inc-dirs, $(MOBJ))) \
)
$(___TARGETS): PRIVATE.INFO.CXXFLAGS:=$(strip \
    $(call mod-get-cxxflags, $(MOBJ)) \
    $(addprefix -I, $(call mod-get-inc-dirs, $(MOBJ))) \
)
$(___TARGETS): PRIVATE.INFO.LDFLAGS:=$(strip \
    $(call mod-get-ldflags, $(MOBJ)) \
    $(addprefix -, $(call mod-get-ldlibs, $(MOBJ))) \
    $(addprefix -L, /usr/lib /usr/local/lib) \
    $(addprefix -L, $(call mod-get-lib-dirs, $(MOBJ))) \
    $(addprefix -L,$($(my_prefix)OUT_SHARED_LIBRARIES)) \
    $(addprefix -L, $($(my_prefix)OUT_STATIC_LIBRARIES)) \
)

$(___TARGETS): PRIVATE.INFO.STATIC_LIBRARIES:=$(strip \
    $(addprefix $($(my_prefix)OUT_STATIC_LIBRARIES)/, $(call mod-get-static-libs, $(MOBJ))) \
    $(call mod-get-arlibs, $(MOBJ)) \
)
$(___TARGETS): PRIVATE.INFO.SHARED_LIBRARIES:=$(call mod-get-shared-libs, $(MOBJ))

## header import
$(___TARGETS): PRIVATE.I_E.IMPORT_HEADERS:=$(call mod-get-import-headers, $(MOBJ))
