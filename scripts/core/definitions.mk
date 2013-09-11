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
define MyDir
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
define FindAllModuleUnder
$(shell find $(1) \( -path $(PROJECT_TOP_DIR)/scripts -o -path $(PROJECT_OUT) \) -prune -o -name module.mk -print)
endef


# generate module id
define GenModuleID
$(strip \
    $(strip $(1))@$(strip $(2)) \
)
endef


# equal judgement
# @param $(1) condition one
# @param $(2) condition two
# @return TRUE for equal or FALSE for not equal
define IsEqual
$(strip \
    $(if $(filter $(strip $(1)), $(strip $(2))), TRUE, ) \
)
endef


# get local prefix
# @return prefix
define GetPrefix
$(strip \
    $(if $(call IsEqual, TRUE, $(LOCAL_IS_HOST_MODULE)), \
        HOST_, \
        TARGET_ \
     ) \
)
endef


# normalize module name
# @return normalized name
define FormatName
$(strip \
    $(if $(call IsEqual, $(LOCAL_MODULE_SUFFIX), $(suffix $(LOCAL_MODULE))), \
        $(LOCAL_MODULE), \
        $(strip $(LOCAL_MODULE))$(LOCAL_MODULE_SUFFIX) \
     ) \
)
endef


# absolute path judgement
# @param $(1) path
# @return return TRUE for yes or nothing for FALSE
define IsAbsolutePath
$(strip \
    $(if $(patsubst /%,,$(1)), \
        , \
        TRUE \
     ) \
)
endef


define Format2AbsPath
$(strip \
    $(foreach f, $(2), \
        $(if $(call IsAbsolutePath, $(f)), \
            $(f), \
            $(addprefix $(strip $(1)), $(f)) \
         ) \
     ) \
)
endef


define AllCFilesUnder
$(strip \
    $(foreach c_s, $(GLOBAL_C_FILE_SUFFIX), \
        $(eval p:=$(call Format2AbsPath, $(LOCAL_PATH)/, $(1))) \
        $(shell find $(strip $(p)) -maxdepth 1 -name "*$(c_s)") \
     )  \
)
endef


define AllCXXFilesUnder
$(strip \
    $(foreach cxx_s, $(GLOBAL_CXX_FILE_SUFFIX), \
        $(eval p:=$(call Format2AbsPath, $(LOCAL_PATH)/, $(1))) \
        $(shell find $(p) -maxdepth 1 -name "*$(cxx_s)") \
     ) \
)
endef


# check duplicated module
define DupModCheck
$(strip \
    $(eval _id:=$(call MOD_GetID, $(MODULE))) \
    $(eval count.$(_id):=$(shell expr $(count.$(_id)) + 1)) \
    $(if $(call IsEqual, $(count.$(_id)), 2), \
        $(error Duplicated module : $(_id)), \
     ) \
)
endef


# add depend
# @param $(1) targets
# @param $(2) depends
define AddDepends
$(1): $(2)
	$(empty)
endef


# filter absolute path
# @param $(1) paths
# @return paths
define FilterAbsPath
$(strip \
    $(foreach f, $(1), \
        $(if $(call IsAbsolutePath, $(f)), \
            $(f), \
         ) \
     ) \
)
endef


define NormSharedLib2Name.so
$(strip \
    $(if $(call IsEqual, $(GLOBAL_SHARED_LIBRARY_SUFFIX), $(suffix $(1))), \
        $(1), \
        $(addsuffix $(GLOBAL_SHARED_LIBRARY_SUFFIX), $(1)) \
     ) \
)
endef

define NormStaticLib2Name.a
$(strip \
    $(if $(call IsEqual, $(GLOBAL_STATIC_LIBRARY_SUFFIX), $(suffix $(1))), \
        $(1), \
        $(addsuffix $(GLOBAL_STATIC_LIBRARY_SUFFIX), $(1)) \
     ) \
)
endef

define NormSharedLib2LName
$(strip \
    $(foreach l, $(call NormSharedLib2Name.so, $(1)), \
        $(addprefix \
            $(if $(findstring -l, $(l)),, -l), \
            $(patsubst lib%$(GLOBAL_SHARED_LIBRARY_SUFFIX),%, \
                $(addprefix lib, $(patsubst lib%,%,$(notdir $(l))))) \
         ) \
     ) \
)
endef

define NormStaticLib2LName
$(strip \
    $(foreach l, $(call NormStaticLib2Name.a, $(1)), \
        $(addprefix $(if $(findstring -l, $(l)),,-l), \
            $(patsubst lib%$(GLOBAL_STATIC_LIBRARY_SUFFIX),%, \
                $(addprefix lib, $(patsubst lib%,%,$(notdir $(l))))) \
         ) \
     ) \
)
endef


define NormStaticLib2AbsPath
$(strip \
    $(addprefix $($(my_prefix)OUT_STATIC_LIBRARIES)/, $(strip $(1))) \
)
endef


define NormSharedLib2AbsPath
$(strip \
    $(addprefix $($(my_prefix)OUT_SHARED_LIBRARIES)/, $(strip $(1))) \
)
endef

