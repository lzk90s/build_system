#
#	file: module_object.mk
#	description: object of each module
#

$(call assert-not-null, $(LOCAL_PATH), LOCAL_PATH is null)
$(call assert-not-null, $(LOCAL_MODULE), LOCAL_MODULE is null)
$(call assert-not-null, $(LOCAL_MODULE_CLASS), LOCAL_MODULE_CLASS is null)

curr_mpath	:=$(strip $(LOCAL_PATH))
curr_mclass	:=$(strip $(LOCAL_MODULE_CLASS))
curr_mname	:=$(call normalize-name)
my_prefix	:=$(call get-prefix)
curr_mid	:=$(call generate-mid, $(curr_mclass), $(curr_mname))

# module
MOBJ:=$(curr_mid)
$(call mod-init, $(MOBJ), $(curr_mclass), $(curr_mname))

# check duplicated module
$(call dup-check)

# set intermediate path
_itpath:=$(addprefix $($(my_prefix)OUT_INTERMEDIATES)/, $(call mod-get-relative-path, $(MOBJ)))
$(call mod-set-intermediate-path, $(MOBJ), $(_itpath))

# set install path
_mispath:=$(call find-install-path)
$(call mod-set-install-path, $(MOBJ), $(_mispath))

# set module owner
_owner:=$(if $(LOCAL_MODULE_OWNER), $(LOCAL_MODULE_OWNER), $(PROJECT_MODULE_OWNER))
$(call mod-set-owner, $(MOBJ), $(_owner))

# set archive tool
_ar:=$(if $(LOCAL_AR), $(LOCAL_AR), $(AR))
$(call mod-set-ar, $(MOBJ), $(_ar))

# set c compiler
_cc:=$(if $(LOCAL_CC), $(LOCAL_CC), $(CC))
$(call mod-set-cc, $(MOBJ), $(_cc))

# set c++ compiler
_cxx:=$(if $(LOCAL_CXX), $(LOCAL_CXX), $(CXX))
$(call mod-set-cxx, $(MOBJ), $(_cxx))

# set linker
_ld:=$(if $(LOCAL_LD), $(LOCAL_LD), $(LD))
$(call mod-set-ld, $(MOBJ), $(_ld))

# set CFLAGS
_cflags:=$(GLOBAL_CFLAGS) $(LOCAL_CFLAGS) $(CFLAGS)
$(call mod-set-cflags, $(MOBJ), $(_cflags))

# set CXXFLAGS
_cxxflags:=$(GLOBAL_CXXFLAGS) $(LOCAL_CXXFLAGS) $(CXXFLAGS)
$(call mod-set-cxxflags, $(MOBJ), $(_cxxflags))

# set LDFALGS
_ldflags:=$(GLOBAL_LDFLAGS) $(LOCAL_LDFLAGS) $(LDFLAGS)
$(call mod-set-ldflags, $(MOBJ), $(_ldflags))

# set archive libraries
$(call mod-set-arlibs, $(MOBJ), $(LOCAL_ARLIBS))

# set ld libs
$(call mod-set-ldlibs, $(MOBJ), $(LOCAL_LDLIBS))

# set shared libraries, name only
_shared_libs:=$(foreach l, $(LOCAL_SHARED_LIBRARIES), $(call normalize-shared-libs-to-xxx.so, $(l)))
$(call mod-set-shared-libs, $(MOBJ), $(_shared_libs))

# set static libraries, absolute path only
_static_libs:=$(foreach l, $(LOCAL_STATIC_LIBRARIES), $(call normalize-static-libs-to-xxx.a, $(l)))
$(call mod-set-static-libs, $(MOBJ), $(_static_libs))

# set include directories
_abs_inc:=$(call filter-absolute-paths, $(LOCAL_INCLUDE_DIRS))
_non_abs_inc:=$(filter-out $(_abs_inc), $(LOCAL_INCLUDE_DIRS))
ifneq (x, x$(strip $(_non_abs_inc)))
  $(call mod-set-import-headers, $(MOBJ), $(_non_abs_inc))
  $(call list-append, $(IMPORT_LIST), $(curr_mid))
endif
$(call mod-set-inc-dirs, $(MOBJ), $(_abs_inc))

# set library directories
$(call mod-set-lib-dirs, $(MOBJ), $(LOCAL_LIBRARY_DIRS))

# export header directories
_export_dirs:=$(LOCAL_EXPORT_HEADER_DIRS)
_export_name:=$(LOCAL_EXPORT_HEADER_TO)
ifneq (x, x$(strip $(_export_dirs)))
  $(call assert-not-null, $(_export_name), LOCAL_EXPORT_HEADER_TO is null!)
  $(call assert-equal, $(words $(_export_name)), 1, The name of header to be export must be single!)
  $(call list-append, $(EXPORT_LIST), $(curr_mid))
  $(call mod-set-export-header, $(MOBJ), $(_export_name))
  $(call mod-set-export-dirs, $(MOBJ), $(_export_dirs))
endif

# add current module to task list for building
_target:=$(call mod-get-target-entry, $(MOBJ))
$(call list-append, $(TASK_LIST), $(_target))

# add current module to module list
$(call list-append, $(MODULE_LIST), $(curr_mid))


# set the entry of module
TARGET_ENTRY:=$(call mod-get-target-entry, $(MOBJ))
DEPS:=$(call mod-get-intermediate-target, $(MOBJ)) $(call mod-get-ultimate-target, $(MOBJ))
$(call add-depends, $(TARGET_ENTRY),$(DEPS))


$(call mod-fini)
