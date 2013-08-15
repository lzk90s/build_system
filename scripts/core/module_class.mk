#
#	file : module_class.mk
#	description: module class
#

$(CLASS) $(MODULE)

#******************************** public ************************************#
$(PUBLIC)

# initialize module
#	p2: class
#	p3: name
define mod-init
	$(eval ___TARGETS:= ) \
	$(eval this:=$(strip $(1))) \
	$(eval $(this).class:=$(strip $(2))) \
	$(eval $(this).name:=$(strip $(3))) \
	$(eval $(this).path.source:=$(curr_mpath)) \
	$(eval $(this).path.relative:=$(patsubst $(PROJECT_TOP_DIR)/%,%,$(curr_mpath))) \
	$(eval $(this).file.srcs:=$(foreach f, $(LOCAL_SRC_FILES), $(call normalize-srcs, $(f)))) \
	$(eval $(this).file.objs:= ) \
	$(eval $(this).id:=$(call generate-mid, $($(this).class), $($(this).name))) \
	$(eval $(this).target.ultimate:= ) \
	$(eval DEP_LOCK:=DEP_LOCK) \
	$(call lock-release, $(DEP_LOCK))
endef

define mod-fini
	$(call lock-release, $(DEP_LOCK))
endef

# set intermediate path of module
#	p2: absolute path
define mod-set-intermediate-path
	$(eval this:=$(strip $(1))) \
	$(eval $(this).path.intermediate:=$(strip $(2))) \
	$(call update-objs) \
	$(call update-targets)
endef

# set install path
#	p2: absolute path
define mod-set-install-path
	$(eval this:=$(strip $(1))) \
    $(eval $(this).path.install:=$(strip $(2))) \
    $(eval $(this).target.ultimate:=$($(this).path.install)/$($(this).name)) \
    $(eval $(this).target.clean:= $($(this).target.clean) $($(this).target.ultimate))
endef

# set owner
#	p2: owner
define mod-set-owner
	$(eval this:=$(strip $(1))) \
    $(eval $(this).info.owner:=$(strip $(2)))
endef

define mod-set-ar
	$(eval this:=$(strip $(1))) \
    $(eval $(this).info.ar:=$(strip $(2)))
endef

define mod-set-cc
	$(eval this:=$(strip $(1))) \
    $(eval $(this).info.cc:=$(strip $(2)))
endef

define mod-set-cxx
	$(eval this:=$(strip $(1))) \
    $(eval $(this).info.cxx:=$(strip $(2)))
endef

define mod-set-ld
	$(eval this:=$(strip $(1))) \
    $(eval $(this).info.ld:=$(strip $(2)))
endef

define mod-set-cflags
	$(eval this:=$(strip $(1))) \
    $(eval $(this).info.cflags:= $(strip $(2)))
endef

define mod-set-cxxflags
    $(eval $(this).info.cxxflags:=$(strip $(2)))
endef

define mod-set-ldflags
	$(eval this:=$(strip $(1))) \
    $(eval $(this).info.ldflags:=$(strip $(2)))
endef

define mod-set-inc-dirs
	$(eval this:=$(strip $(1))) \
    $(eval $(this).info.inc_dirs:=$(strip $(2)))
endef

define mod-set-lib-dirs
    $(eval this:=$(strip $(1))) \
	$(eval $(this).info.lib_dirs:=$(strip $(2)))
endef

define mod-set-arlibs
	$(eval this:=$(strip $(1))) \
	$(eval $(this).info.arlibs:=$(strip $(2)))
endef

define mod-set-ldlibs
	$(eval this:=$(strip $(1))) \
    $(eval $(this).info.ldlibs:=$(strip $(2)))
endef

define mod-set-shared-libs
	$(eval this:=$(strip $(1))) \
    $(eval $(this).info.shared_libs:=$(strip $(2))) \
	$(if $(strip $(2)), $(call add-shared-libs-auto-dep), )
endef

define mod-set-static-libs
	$(eval this:=$(strip $(1))) \
    $(eval $(this).info.static_libs:=$(strip $(2))) \
	$(if $(strip $(2)), $(call add-static-libs-auto-dep), )
endef

define mod-set-deps
	$(eval this:=$(strip $(1))) \
	$(eval $(this).depend.deps:=$(strip $(2)))
endef

define mod-set-export-dirs
	$(eval this:=$(strip $(1))) \
	$(eval $(this).i_e.export_header_dirs:=$(strip $(2)))
endef

define mod-set-export-header
	$(eval this:=$(strip $(1))) \
	$(eval $(this).i_e.export_header:=$(strip $(2)))
endef

define mod-set-import-headers
	$(eval this:=$(strip $(1))) \
	$(eval $(this).i_e.import_headers:=$(strip $(2)))
endef

define mod-get-name
$(strip \
	$(eval this:=$(strip $(1))) \
    $($(this).name) \
)
endef

define mod-get-class
$(strip \
	$(eval this:=$(strip $(1))) \
    $($(this).class) \
)
endef

define mod-get-id
$(strip \
	$(eval this:=$(strip $(1))) \
    $($(this).id) \
)
endef

define mod-get-intermediate-path
$(strip \
	$(eval this:=$(strip $(1))) \
    $($(this).path.intermediate) \
)
endef

define mod-get-source-path
$(strip \
	$(eval this:=$(strip $(1))) \
    $($(this).path.source) \
)
endef

define mod-get-relative-path
$(strip \
	$(eval this:=$(strip $(1))) \
    $($(this).path.relative) \
)
endef

define mod-get-install-path
$(strip \
	$(eval this:=$(strip $(1))) \
    $($(this).path.install) \
)
endef

define mod-get-srcs
$(strip \
	$(eval this:=$(strip $(1))) \
    $($(this).file.srcs) \
)
endef

define mod-get-objs
$(strip \
	$(eval this:=$(strip $(1))) \
    $($(this).file.objs) \
)
endef

define mod-get-owner
$(strip \
	$(eval this:=$(strip $(1))) \
    $($(this).info.owner) \
)
endef

define mod-get-ar
$(strip \
	$(eval this:=$(strip $(1))) \
    $($(this).info.ar) \
)
endef

define mod-get-cc
$(strip \
	$(eval this:=$(strip $(1))) \
    $($(this).info.cc) \
)
endef

define mod-get-cxx
$(strip \
	$(eval this:=$(strip $(1))) \
    $($(this).info.cxx) \
)
endef

define mod-get-ld
$(strip \
	$(eval this:=$(strip $(1))) \
    $($(this).info.ld) \
)
endef

define mod-get-cflags
$(strip \
	$(eval this:=$(strip $(1))) \
    $($(this).info.cflags) \
)
endef

define mod-get-cxxflags
$(strip \
	$(eval this:=$(strip $(1))) \
    $($(this).info.cxxflags) \
)
endef

define mod-get-ldflags
$(strip \
	$(eval this:=$(strip $(1))) \
    $($(this).info.ldflags) \
)
endef

define mod-get-arlibs
$(strip \
	$(eval this:=$(strip $(1))) \
	$($(this).info.arlibs) \
)
endef

define mod-get-ldlibs
$(strip \
	$(eval this:=$(strip $(1))) \
	$($(this).info.ldlibs) \
)
endef

define mod-get-inc-dirs
$(strip \
	$(eval this:=$(strip $(1))) \
	$($(this).info.inc_dirs) \
)
endef

define mod-get-lib-dirs
$(strip \
	$(eval this:=$(strip $(1))) \
	$($(this).info.lib_dirs) \
)
endef

define mod-get-static-libs
$(strip \
	$(eval this:=$(strip $(1))) \
    $($(this).info.static_libs) \
)
endef

define mod-get-shared-libs
$(strip \
	$(eval this:=$(strip $(1))) \
    $($(this).info.shared_libs) \
)
endef

define mod-get-deps
$(strip \
	$(eval this:=$(strip $(1))) \
	$($(this).depend.deps) \
)
endef

define mod-get-export-dirs
$(strip \
	$(eval this:=$(strip $(1))) \
	$($(this).i_e.export_header_dirs) \
)
endef

define mod-get-export-header
$(strip \
	$(eval this:=$(strip $(1))) \
	$($(this).i_e.export_header) \
)
endef

define mod-get-import-headers
$(strip \
	$(eval this:=$(strip $(1))) \
	$($(this).i_e.import_headers) \
)
endef

define mod-get-ultimate-target
$(strip \
	$(eval this:=$(strip $(1))) \
    $($(this).target.ultimate) \
)
endef

define mod-get-intermediate-target
$(strip \
	$(eval this:=$(strip $(1))) \
    $($(this).target.intermediate) \
)
endef

define mod-get-target-entry
$(strip \
	$(eval this:=$(strip $(1))) \
	$($(this).target.MAIN) \
)
endef

define mod-target-clean
$(strip \
	$(eval this:=$(strip $(1))) \
    $(shell rm -rf $($(this).target.clean)) \
)
endef


#****************************** static public *********************************#
$(PUBLIC) $(STATIC)

define mod-trans-c-to-obj
	$(hide)	$(MKDIR) $(dir $@)
	$(hide)echo -e "[ CC      ]    -->    $(call format-output, $@)"
	$(call trans-c-to-obj-inner)
	$(call trans-d-to-p)
endef

define mod-trans-cxx-to-obj
	$(hide)	$(MKDIR) $(dir $@)
	$(hide)echo -e "[ C++     ]    -->    $(call format-output, $@)"
	$(call trans-cxx-to-obj-inner)
	$(call trans-d-to-p)
endef

define mod-trans-o-to-exe
	$(hide)	$(MKDIR) $(dir $@)
	$(hide)echo -e "[ LINK    ]    -->    $(call format-output, $@)"	
	$(call trans-o-to-exe-inner)
endef

define mod-trans-o-to-static-lib
	$(hide)$(MKDIR) $(dir $@)
	$(hide)echo -e "[ AR      ]    -->    $(call format-output, $@)"	
	$(hide)rm -f $@
	$(hide)$(repack-static-libs)
	$(hide)$(PRIVATE.INFO.AR) $(GLOBAL_ARFLAGS) $@ $(filter %.o, $^)
endef

define mod-trans-o-to-shared-lib
	$(hide)$(MKDIR) $(dir $@)
	$(hide)echo -e "[ LINK    ]    -->    $(call format-output, $@)"	
	$(trans-o-to-shared-lib-inner)
endef

#********************************* private **********************************#
$(PRIVATE)

define update-objs
	$(eval _srcs:=$(call mod-get-srcs, $(MOBJ))) \
	$(eval _c_srcs:=$(call filter-c-srcs, $(_srcs))) \
	$(eval _cxx_srcs:=$(call filter-cxx-srcs, $(_srcs))) \
	$(eval _new_objs:=$(strip \
		$(foreach f, $(_c_srcs), $(call c-2-obj, $(f))) \
		$(foreach f, $(_cxx_srcs), $(call cxx-2-obj, $(f)))) \
	 ) \
	$(eval $(this).file.objs:=$(_new_objs))
endef

define update-targets
	$(eval _id:=$(call mod-get-id, $(MOBJ))) \
	$(eval $(this).target.MAIN:=module_$(_id)) \
	$(eval $(this).target.ultimate:=$($(this).path.install)/$($(this).name)) \
    $(eval $(this).target.intermediate:=$($(this).path.intermediate)/$($(this).name)) \
    $(eval $(this).target.clean:=$(strip \
		$($(this).target.clean) \
		$($(this).target.intermediate) \
		$($(this).file.objs)) \
	 )
endef

define add-shared-libs-auto-dep
	$(eval _shared_libs:=$(call mod-get-shared-libs, $(MOBJ))) \
	$(eval _ids:=$(foreach lib, $(_shared_libs), \
		$(eval _shared_lib_name:=$(call normalize-shared-libs-to-xxx.so, $(lib))) \
		$(eval _shared_lib_class:=$(my_prefix)SHARED_LIBRARY) \
		$(call generate-mid, $(_shared_lib_class), $(_shared_lib_name)) \
		) \
	 ) \
	$(eval _ids:=$(sort $(_ids) $(call mod-get-deps, $(MOBJ)))) \
	$(call mod-set-deps, $(MOBJ), $(_ids)) \
	$(if $(call lock-is-locked, $(DEP_LOCK)), \
		, \
		$(call list-append, $(DEPEND_LIST), $(curr_mid)) \
		$(call lock-hold, $(DEP_LOCK)) \
	 )
endef

define add-static-libs-auto-dep
	$(eval _static_libs:=$(call mod-get-static-libs, $(MOBJ))) \
	$(eval _ids:=$(foreach lib, $(_static_libs), \
		$(eval _shared_lib_name:=$(call normalize-static-libs-to-xxx.a, $(lib))) \
		$(eval _shared_lib_class:=$(my_prefix)STATIC_LIBRARY) \
		$(call generate-mid, $(_shared_lib_class), $(_shared_lib_name)) \
		) \
	 ) \
	$(eval _ids:=$(sort $(_ids) $(call mod-get-deps, $(MOBJ)))) \
	$(call mod-set-deps, $(MOBJ), $(_ids)) \
	$(if $(call lock-is-locked, $(DEP_LOCK)), \
		, \
		$(call list-append, $(DEPEND_LIST), $(curr_mid)) \
		$(call lock-hold, $(DEP_LOCK)) \
	 )
endef

define filter-c-srcs
$(strip \
    $(foreach ext, $(GLOBAL_C_FILE_SUFFIX), $(filter %$(ext), $(1))) \
)
endef

define filter-cxx-srcs
$(strip \
    $(foreach ext, $(GLOBAL_CXX_FILE_SUFFIX), $(filter %$(ext), $(1))) \
)
endef

define c-2-obj
$(strip \
    $(eval _ip:=$(call mod-get-intermediate-path, $(MOBJ))) \
    $(eval _sp:=$(call mod-get-source-path, $(MOBJ))) \
    $(eval _tmp:=$(foreach e, $(GLOBAL_C_FILE_SUFFIX), \
		$(eval _s:=$(filter %$(e), $(1))) \
		$(patsubst %$(e), %.o, $(_s))) \
	 ) \
    $(patsubst $(_sp)%, $(_ip)%, $(_tmp)) \
)
endef

define cxx-2-obj
$(strip \
    $(eval _ip:=$(call mod-get-intermediate-path, $(MOBJ))) \
    $(eval _sp:=$(call mod-get-source-path, $(MOBJ))) \
    $(eval _tmp:=$(foreach e, $(GLOBAL_CXX_FILE_SUFFIX), \
		$(eval _s:=$(filter %$(e), $(1))) \
		$(patsubst %$(e), %.o, $(_s))) \
	 ) \
    $(patsubst $(_sp)%, $(_ip)%, $(_tmp)) \
)
endef

define trans-c-to-obj-inner
	$(hide)$(eval _incdirs:=$(foreach n, $(PRIVATE.I_E.IMPORT_HEADERS), \
		$(call map-get-val-by-key, $(HEADER_MAP), $(n))) \
	 ) \
	$(PRIVATE.INFO.CC) \
	$(addprefix -I, $(_incdirs)) \
	$(PRIVATE.INFO.CFLAGS) \
	$(1) \
	-MD -MF $(patsubst %.o,%.d,$@) \
	-c -o $@ $<
endef

define trans-cxx-to-obj-inner
	$(hide)$(eval _incdirs:=$(foreach n, $(PRIVATE.I_E.IMPORT_HEADERS), \
		$(call map-get-val-by-key, $(HEADER_MAP), $(n))) \
	 ) \
	$(PRIVATE.INFO.CXX)     \
	$(addprefix -I, $(_incdirs)) \
	$(PRIVATE.INFO.CXXFLAGS) \
	$(1) \
	-MD -MF $(patsubst %.o,%.d,$@) \
	-c -o $@ $<
endef

define trans-d-to-p-args
$(hide)	cp $(1) $(2); \
sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
    -e '/^$$/ d' -e 's/$$/ :/' < $(1) >> $(2); \
rm -f $(1)
endef

define trans-d-to-p
	$(call trans-d-to-p-args,$(@:%.o=%.d),$(@:%.o=%.P))
endef

define _repack-static-lib
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

define repack-static-libs
	$(eval _all_static_libs:=$(PRIVATE.INFO.STATIC_LIBRARIES)) \
	$(foreach lib,$(_all_static_libs), $(call _repack-static-lib, $(lib)))
endef

define trans-o-to-shared-lib-inner
	$(hide)$(PRIVATE.INFO.LD) \
	$(PRIVATE.INFO.CFLAGS) $(PRIVATE.INFO.CXXFLAGS) \
	$(PRIVATE.INFO.LDFLAGS) \
	-shared  -fPIC \
	-o $@ $^    \
	-Wl,--whole-archive \
	$(call normalize-static-libs-to-lxxx, $(PRIVATE.INFO.STATIC_LIBRARIES))    \
	-Wl,--no-whole-archive \
	$(call normalize-shared-libs-to-lxxx, $(PRIVATE.INFO.SHARED_LIBRARIES))
endef

define trans-o-to-exe-inner
	$(hide)$(PRIVATE.INFO.LD) \
	$(PRIVATE.INFO.CFLAGS) $(PRIVATE.INFO.CXXFLAGS) \
	$(PRIVATE.INFO.LDFLAGS) \
	-o $@  $^ \
	-Wl,--whole-archive \
	$(call normalize-static-libs-to-lxxx, $(PRIVATE.INFO.STATIC_LIBRARIES)) \
	-Wl,--no-whole-archive \
	$(call normalize-shared-libs-to-lxxx, $(PRIVATE.INFO.SHARED_LIBRARIES))
endef

define normalize-srcs
$(strip \
    $(if $(call is-absolute-path, $(1)), \
        $(1), \
        $(addprefix $(call mod-get-source-path, $(MOBJ))/, $(1)) \
	 ) \
)
endef

define normalize-shared-libs-to-xxx.so
$(strip \
    $(if $(call is-equal, $(GLOBAL_SHARED_LIBRARY_SUFFIX), $(suffix $(1))), \
        $(1), \
        $(addsuffix $(GLOBAL_SHARED_LIBRARY_SUFFIX), $(1)) \
	 ) \
)
endef

define normalize-static-libs-to-xxx.a
$(strip \
    $(if $(call is-equal, $(GLOBAL_STATIC_LIBRARY_SUFFIX), $(suffix $(1))), \
        $(1), \
        $(addsuffix $(GLOBAL_STATIC_LIBRARY_SUFFIX), $(1)) \
	 ) \
)
endef

define normalize-shared-libs-to-lxxx
$(strip \
    $(foreach l, $(call normalize-shared-libs-to-xxx.so, $(1)), \
        $(addprefix \
			$(if $(findstring -l, $(l)),, -l), \
            $(patsubst lib%$(GLOBAL_SHARED_LIBRARY_SUFFIX),%, \
				$(addprefix lib, $(patsubst lib%,%,$(notdir $(l))))) \
		 ) \
	 ) \
)
endef

define normalize-static-libs-to-lxxx
$(strip \
    $(foreach l, $(call normalize-static-libs-to-xxx.a, $(1)), \
        $(addprefix $(if $(findstring -l, $(l)),,-l), \
            $(patsubst lib%$(GLOBAL_STATIC_LIBRARY_SUFFIX),%, \
				$(addprefix lib, $(patsubst lib%,%,$(notdir $(l))))) \
		 ) \
	 ) \
)
endef

INFO_HEADER:=<|OUT_ROOT|>
define format-output
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
