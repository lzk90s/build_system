##--------------------------------------------------------------------------
##
#        文件：module_class.mk
#        描述：模块变量
#        修改：2013-6-3
##--------------------------------------------------------------------------


$(call assert-not-null, $(LOCAL_PATH), LOCAL_PATH is null)
$(call assert-not-null, $(LOCAL_MODULE), LOCAL_MODULE is null)
$(call assert-not-null, $(LOCAL_MODULE_CLASS), LOCAL_MODULE_CLASS is null)

curr_module_path       :=$(strip $(LOCAL_PATH))
curr_module_suffix     :=$(strip $(LOCAL_MODULE_SUFFIX))
curr_module_name       :=$(strip \
	$(if $(call is-equal, $(curr_module_suffix), $(suffix $(LOCAL_MODULE))), \
		$(LOCAL_MODULE), \
		$(strip $(LOCAL_MODULE))$(curr_module_suffix)) \
)
curr_module_class      :=$(strip $(LOCAL_MODULE_CLASS))
curr_module_id         :=$(call set-module-id, $(curr_module_class), $(curr_module_name))
curr_module_is_host    :=$(if $(call is-equal, TRUE, $(LOCAL_IS_HOST_MODULE)), TRUE, FALSE)
curr_my_prefix		   :=$(strip \
	$(if $(call is-equal, TRUE, $(curr_module_is_host)), \
		HOST_, \
		TARGET_) \
)


count.$(curr_module_id):=$(shell expr $(count.$(curr_module_id)) + 1)
$(call assert-equal, 1, $(count.$(curr_module_id)), Duplicated module found !)


#####################################################################################################
##                                
##                                            模块属性 
##
#####################################################################################################
MODULE.$(curr_module_id).MODULE_ID       :=$(strip $(curr_module_id))
MODULE.$(curr_module_id).MODULE_NAME     :=$(strip $(curr_module_name))
MODULE.$(curr_module_id).MODULE_CLASS    :=$(strip $(curr_module_class))

MODULE.$(curr_module_id).MODULE_PATH.SOURCE_PATH       :=$(strip $(curr_module_path))
MODULE.$(curr_module_id).MODULE_PATH.RELATIVE_PATH     :=$(strip \
	$(if $(call is-equal, $(curr_module_path), $(PROJECT_TOP_DIR)), \
		  . , \
		$(patsubst $(PROJECT_TOP_DIR)/%,%,$(curr_module_path))) \
)
MODULE.$(curr_module_id).MODULE_PATH.INTERMEDIATE_PATH :=$(strip \
	$(addprefix $($(curr_my_prefix)OUT_INTERMEDIATES)/, \
		$(MODULE.$(curr_module_id).MODULE_PATH.RELATIVE_PATH)) \
)

install_path:=
install_path:=$(strip \
	$(if $(findstring EXECUTABLE, $(curr_module_class)), \
		$($(curr_my_prefix)OUT_EXECUTABLES), \
		$(install_path)) \
)
install_path:=$(strip \
	$(if $(findstring STATIC_LIBRARY, $(curr_module_class)), \
		$($(curr_my_prefix)OUT_STATIC_LIBRARIES), \
		$(install_path)) \
)
install_path:=$(strip \
	$(if $(findstring SHARED_LIBRARY, $(curr_module_class)), \
		$($(curr_my_prefix)OUT_SHARED_LIBRARIES), \
		$(install_path)) \
)
MODULE.$(curr_module_id).MODULE_PATH.INSTALL_PATH :=$(install_path)

MODULE.$(curr_module_id).MODULE_FILE.C_SRC_FILES  :=$(strip \
	$(foreach c_f, $(call filter-c-files, $(LOCAL_SRC_FILES)), \
			$(call normalize-to-absolute-path, $(LOCAL_PATH)/, $(c_f))) \
)
MODULE.$(curr_module_id).MODULE_FILE.CXX_SRC_FILES:=$(strip \
	$(foreach cxx_f, $(call filter-cxx-files, $(LOCAL_SRC_FILES)), \
			$(call normalize-to-absolute-path, $(LOCAL_PATH)/, $(cxx_f))) \
)
MODULE.$(curr_module_id).MODULE_FILE.OBJ_FILES    :=$(strip \
	$(addprefix $(MODULE.$(curr_module_id).MODULE_PATH.INTERMEDIATE_PATH)/, \
		$(patsubst $(MODULE.$(curr_module_id).MODULE_PATH.SOURCE_PATH)/%, %, \
			$(call c-to-obj, $(MODULE.$(curr_module_id).MODULE_FILE.C_SRC_FILES)))) \
	$(addprefix $(MODULE.$(curr_module_id).MODULE_PATH.INTERMEDIATE_PATH)/, \
		$(patsubst $(MODULE.$(curr_module_id).MODULE_PATH.SOURCE_PATH)/%, %, \
			$(call cxx-to-obj, $(MODULE.$(curr_module_id).MODULE_FILE.CXX_SRC_FILES)))) \
)
MODULE.$(curr_module_id).MODULE_FILE.COPY_HEADERS :=$(strip \
	$(foreach h, $(LOCAL_COPY_HEADERS), \
		$(call normalize-to-absolute-path, $(LOCAL_PATH)/, $(h))) \
)

MODULE.$(curr_module_id).MODULE_INFO.OWNER:=$(strip \
	$(if $(strip $(LOCAL_MODULE_OWNER)), \
		$(LOCAL_MODULE_OWNER), \
	$(PROJECT_MODULE_OWNER)) \
)
MODULE.$(curr_module_id).MODULE_INFO.AR   :=$(if $(LOCAL_CC), $(LOCAL_AR), $(AR))
MODULE.$(curr_module_id).MODULE_INFO.CC   :=$(if $(LOCAL_CC), $(LOCAL_CC), $(CC))
MODULE.$(curr_module_id).MODULE_INFO.CXX  :=$(if $(LOCAL_CXX), $(LOCAL_CC), $(CXX))
MODULE.$(curr_module_id).MODULE_INFO.LD   :=$(if $(LOCAL_CXX), $(LOCAL_CC), $(LD))
MODULE.$(curr_module_id).MODULE_INFO.INCLUDE_DIRS    :=$(curr_module_path)  \
	$(foreach i, $(LOCAL_INCLUDE_DIRS), \
		$(if $(patsubst /%,,$(i)), \
			$(call add-copy-header-dir, $(i)), \
			$(i)))
MODULE.$(curr_module_id).MODULE_INFO.LIBRARY_DIRS    :=$(strip $(LOCAL_LIBRARY_DIRS))

MODULE.$(curr_module_id).MODULE_INFO.STATIC_LIBRARIES:=$(strip \
	$(addprefix $($(curr_my_prefix)OUT_STATIC_LIBRARIES)/, \
		$(call normalize-static-libs-like-name.a, $(LOCAL_STATIC_LIBRARIES))) \
)
MODULE.$(curr_module_id).MODULE_INFO.SHARED_LIBRARIES:=$(strip \
	$(call normalize-shared-libs-like-name.so, $(LOCAL_SHARED_LIBRARIES)) \
)

MODULE.$(curr_module_id).MODULE_INFO.ARLIBS  :=$(strip \
	$(foreach a, $(LOCAL_ARLIBS), \
		$(call normalize-to-absolute-path, $(LOCAL_PATH)/, $(a))) \
)
MODULE.$(curr_module_id).MODULE_INFO.LDLIBS  :=$(LOCAL_LDLIBS)
MODULE.$(curr_module_id).MODULE_INFO.CFLAGS  :=$(LOCAL_CFLAGS) \
	$(addprefix -I, $(MODULE.$(curr_module_id).MODULE_INFO.INCLUDE_DIRS))
MODULE.$(curr_module_id).MODULE_INFO.ARFALGS :=$(LOCAL_ARFLAGS)
MODULE.$(curr_module_id).MODULE_INFO.CPPFLAGS:=$(LOCAL_CPPFLAGS)
MODULE.$(curr_module_id).MODULE_INFO.CXXFLAGS:=$(LOCAL_CXXFLAGS) \
	$(addprefix -I, $(MODULE.$(curr_module_id).MODULE_INFO.INCLUDE_DIRS))
MODULE.$(curr_module_id).MODULE_INFO.LDFLAGS :=$(LOCAL_LDFLAGS) \
	$(addprefix -L, $(MODULE.$(curr_module_id).MODULE_INFO.LIBRARY_DIRS)) \
	$(MODULE.$(curr_module_id).MODULE_INFO.LDLIBS)

MODULE.$(curr_module_id).MODULE_INFO.PRE_DEPENDENTS :=$(LOCAL_PRE_DEPENDENTS) \
	$(foreach al, $(notdir $(MODULE.$(curr_module_id).MODULE_INFO.STATIC_LIBRARIES)), \
		$(call add-static-lib-dependent-by-name, $(al)))    \
	$(foreach sl, $(notdir $(MODULE.$(curr_module_id).MODULE_INFO.SHARED_LIBRARIES)), \
		$(call add-shared-lib-dependent-by-name, $(sl)))
MODULE.$(curr_module_id).MODULE_INFO.POST_DEPENDENTS:=$(LOCAL_POST_DEPENDENTS)



#####################################################################################################
##                                
##                                                模块操作 
##
#####################################################################################################
TARGET.ALL.$(MODULE.$(curr_module_id).MODULE_ID): DEPEND.PREPOSE.$(MODULE.$(curr_module_id).MODULE_ID) \
                                                    TARGET.INTERMEDIATE.$(MODULE.$(curr_module_id).MODULE_ID) \
                                                    TARGET.INSTALL.$(MODULE.$(curr_module_id).MODULE_ID) \
                                                    DEPEND.POSTPOSE.$(MODULE.$(curr_module_id).MODULE_ID)
TARGET.INSTALL.$(MODULE.$(curr_module_id).MODULE_ID): $(MODULE.$(curr_module_id).MODULE_PATH.INSTALL_PATH)/$(MODULE.$(curr_module_id).MODULE_NAME)
TARGET.INTERMEDIATE.$(MODULE.$(curr_module_id).MODULE_ID):$(MODULE.$(curr_module_id).MODULE_PATH.INTERMEDIATE_PATH)/$(MODULE.$(curr_module_id).MODULE_NAME)
DEPEND.PREPOSE.$(MODULE.$(curr_module_id).MODULE_ID): $(MODULE.$(curr_module_id).MODULE_INFO.PRE_DEPENDENTS)
DEPEND.POSTPOSE.$(MODULE.$(curr_module_id).MODULE_ID): $(MODULE.$(curr_module_id).MODULE_INFO.POST_DEPENDENTS)


#####################################################################################################
##                                
##                                                链表 
##
#####################################################################################################
include $(BUILD_SYSTEM_TOP_DIR)/list.mk


#####################################################################################################
##                                
##                                                模块头文件拷贝 
##
#####################################################################################################
include $(BUILD_SYSTEM_TOP_DIR)/copy_headers.mk


#####################################################################################################
##                                
##                                                具体编译 
##
#####################################################################################################
$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_ID          :=$(strip $(MODULE.$(curr_module_id).MODULE_ID))
$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_NAME        :=$(strip $(MODULE.$(curr_module_id).MODULE_NAME))
$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_CLASS       :=$(strip $(MODULE.$(curr_module_id).MODULE_CLASS))

$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_PATH.SOURCE_PATH      :=$(strip $(MODULE.$(curr_module_id).MODULE_PATH.SOURCE_PATH))
$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_PATH.RELATIVE_PATH    :=$(strip $(MODULE.$(curr_module_id).MODULE_PATH.RELATIVE_PATH))
$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_PATH.INTERMEDIATE_PATH:=$(strip $(MODULE.$(curr_module_id).MODULE_PATH.INTERMEDIATE_PATH))
$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_PATH.INSTALL_PATH     :=$(strip $(MODULE.$(curr_module_id).MODULE_PATH.INSTALL_PATH))

$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_FILE.C_SRC_FILES      :=$(strip $(MODULE.$(curr_module_id).MODULE_FILE.C_SRC_FILES))
$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_FILE.CXX_SRC_FILES    :=$(strip $(MODULE.$(curr_module_id).MODULE_FILE.C_SRC_FILES))
$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_FILE.OBJ_FILES        :=$(strip $(MODULE.$(curr_module_id).MODULE_FILE.OBJ_FILES))

$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_INFO.OWNER    :=$(strip $(MODULE.$(curr_module_id).MODULE_INFO.OWNER))
$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_INFO.CC       :=$(strip $(MODULE.$(curr_module_id).MODULE_INFO.CC))
$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_INFO.CXX      :=$(strip $(MODULE.$(curr_module_id).MODULE_INFO.CXX))
$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_INFO.LD       :=$(strip $(MODULE.$(curr_module_id).MODULE_INFO.LD))
$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_INFO.AR       :=$(strip $(MODULE.$(curr_module_id).MODULE_INFO.AR))
$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_INFO.CFLAGS   :=$(strip $(MODULE.$(curr_module_id).MODULE_INFO.CFLAGS))
$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_INFO.ARFALGS  :=$(strip $(MODULE.$(curr_module_id).MODULE_INFO.ARFALGS))
$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_INFO.CPPFLAGS :=$(strip $(MODULE.$(curr_module_id).MODULE_INFO.CPPFLAGS))
$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_INFO.CXXFLAGS :=$(strip $(MODULE.$(curr_module_id).MODULE_INFO.CXXFLAGS))
$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_INFO.LDFLAGS  :=$(strip $(MODULE.$(curr_module_id).MODULE_INFO.LDFLAGS))
$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_INFO.STATIC_LIBRARIES:=$(strip $(MODULE.$(curr_module_id).MODULE_INFO.STATIC_LIBRARIES))
$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_INFO.ARLIBS   :=$(strip $(MODULE.$(curr_module_id).MODULE_INFO.ARLIBS))
$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_INFO.SHARED_LIBRARIES:=$(strip \
	$(call normalize-shared-libs-like-lname, $(MODULE.$(curr_module_id).MODULE_INFO.SHARED_LIBRARIES)) \
)
$(LOCAL_INTERMEDIATE_TARGETS):    PRIVATE.MODULE_INFO.IS_HOST_MODULE  :=$(strip $(strip $(curr_module_is_host)))
