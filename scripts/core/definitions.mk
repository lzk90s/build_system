#
#   file : definitions.mk
#   description: global macro
#
#

hide     :=@
empty    :=
space    :=$(empty) $(empty)
comma    :=,

CLASS:=
PRIVATE:=
PUBLIC:=
STATIC:=

# get the path of current module
# @return current module path
define my-dir
$(strip \
  $(eval LOCAL_MODULE_MAKEFILE :=$$(lastword $$(MAKEFILE_LIST))) \
  $(if $(filter $(CLEAR_VARS),$(LOCAL_MODULE_MAKEFILE)), \
    $(error LOCAL_PATH must be set before including $$(CLEAR_VARS)) \
   , \
    $(patsubst %/,%,$(dir $(LOCAL_MODULE_MAKEFILE))) \
   ) \
 )
endef

# find all module under giving directory
# @param $(1) directory
# @return module list
define find-all-module-under-dir
$(shell find $(1) \( -path $(PROJECT_TOP_DIR)/scripts -o -path $(PROJECT_OUT) \) -prune -o -name module.mk -print)
endef

# generate module id
define generate-mid
$(strip \
    $(strip $(1))@$(strip $(2)) \
)
endef


# equal judgement
# @param $(1) condition one
# @param $(2) condition two
# @return TRUE for equal or FALSE for not equal
define is-equal
$(strip \
    $(if $(filter $(strip $(1)), $(strip $(2))), TRUE, ) \
)
endef

# get local prefix
# @return prefix
define get-prefix
$(strip \
    $(if $(call is-equal, TRUE, $(LOCAL_IS_HOST_MODULE)), \
        HOST_, \
        TARGET_ \
     ) \
)
endef

# normalize module name
# @return normalized name
define normalize-name
$(strip \
    $(if $(call is-equal, $(LOCAL_MODULE_SUFFIX), $(suffix $(LOCAL_MODULE))), \
        $(LOCAL_MODULE), \
        $(strip $(LOCAL_MODULE))$(LOCAL_MODULE_SUFFIX) \
     ) \
)
endef

# find module install path
# @param $(1) module class
# @return module install path
define find-install-path
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


# absolute path judgement
# @param $(1) path
# @return return TRUE for yes or nothing for FALSE
define is-absolute-path
$(strip \
    $(if $(patsubst /%,,$(1)), \
        , \
        TRUE \
     ) \
)
endef

# set module querying id
# @param $(1) module id
define set-query-id
$(strip \
    $(eval mod_this:=$(strip $(1))) \
)
endef

define normalize-to-absolute-path
$(strip \
    $(foreach f, $(2), \
        $(if $(call is-absolute-path, $(f)), \
            $(f), \
            $(addprefix $(strip $(1)), $(f)) \
         ) \
     ) \
)
endef


define copy-one-file
$(hide)    $(MKDIR) $(dir $@)
    $(hide)echo -e "[ INSTALL ]    -->    $(call format-output, $@)"
    $(hide)$(CP) $< $@
endef


define all-headers-under
$(strip \
    $(foreach h_s, $(GLOBAL_HEADER_FILE_SUFFIX), \
        $(eval p:=$(call normalize-to-absolute-path, $(LOCAL_PATH)/, $(1))) \
        $(shell find $(p) -maxdepth 1 -name "*$(h_s)") \
     ) \
)
endef


define all-c-srcs-under
$(strip \
    $(foreach c_s, $(GLOBAL_C_FILE_SUFFIX), \
        $(eval p:=$(call normalize-to-absolute-path, $(LOCAL_PATH)/, $(1))) \
        $(shell find $(strip $(p)) -maxdepth 1 -name "*$(c_s)") \
     )  \
)
endef


define all-cxx-srcs-under
$(strip \
    $(foreach cxx_s, $(GLOBAL_CXX_FILE_SUFFIX), \
        $(eval p:=$(call normalize-to-absolute-path, $(LOCAL_PATH)/, $(1))) \
        $(shell find $(p) -maxdepth 1 -name "*$(cxx_s)") \
     ) \
)
endef

# check duplicated module
define dup-check
$(strip \
    $(eval _id:=$(call mod-get-id, $(MOBJ))) \
    $(eval count.$(_id):=$(shell expr $(count.$(_id)) + 1)) \
    $(if $(call is-equal, $(count.$(_id)), 2), \
        $(error Duplicated module : $(_id)), \
     ) \
)
endef

# add depend
# @param $(1) targets
# @param $(2) depends
define add-depends
$(1): $(2)
	$(empty)
endef


# filter absolute path
# @param $(1) paths
# @return paths
define filter-absolute-paths
$(strip \
    $(foreach f, $(1), \
        $(if $(call is-absolute-path, $(f)), \
            $(f), \
         ) \
     ) \
)
endef

# lock
define lock-hold
$(strip \
    $(eval lock_obj:=LOCK.$(strip $(1))) \
    $(eval $(lock_obj).status:=LOCKED) \
)
endef

# unlock
define lock-release
$(strip \
    $(eval lock_obj:=LOCK.$(strip $(1))) \
    $(eval $(lock_obj).status:=UNLOCKED) \
)
endef

# get status of lock
define lock-is-locked
$(strip \
    $(eval lock_obj:=LOCK.$(strip $(1))) \
    $(if $(call is-equal, LOCKED, $($(lock_obj).status)), \
        TRUE, \
     ) \
)
endef
