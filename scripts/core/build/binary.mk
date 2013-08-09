##--------------------------------------------------------------------------
##
#        文件：target_binary.mk
#        描述：
#        修改：2013-5-31
#
##--------------------------------------------------------------------------

$(call assert-not-null, $(LOCAL_PATH))

##    %.o : %.c
$(MODULE.$(curr_module_id).MODULE_PATH.INTERMEDIATE_PATH)/%.o:$(MODULE.$(curr_module_id).MODULE_PATH.SOURCE_PATH)/%.c
	$(call transform-c-to-object)

##    %.o : %.cpp
$(MODULE.$(curr_module_id).MODULE_PATH.INTERMEDIATE_PATH)/%.o:$(MODULE.$(curr_module_id).MODULE_PATH.SOURCE_PATH)/%.cpp
	$(call transform-cxx-to-object)

##    %.o : %.cxx
$(MODULE.$(curr_module_id).MODULE_PATH.INTERMEDIATE_PATH)/%.o:$(MODULE.$(curr_module_id).MODULE_PATH.SOURCE_PATH)/%.cxx
	$(call transform-cxx-to-object)
    
##    %.o : %.cc
$(MODULE.$(curr_module_id).MODULE_PATH.INTERMEDIATE_PATH)/%.o:$(MODULE.$(curr_module_id).MODULE_PATH.SOURCE_PATH)/%.cc
	$(call transform-cxx-to-object)
    

sinclude $(addprefix $(MODULE.$(curr_module_id).MODULE_PATH.INTERMEDIATE_PATH)/, $(patsubst %.c, %.d, $(filter %.c, $(LOCAL_SRC_FILES))))
sinclude $(addprefix $(MODULE.$(curr_module_id).MODULE_PATH.INTERMEDIATE_PATH)/, $(patsubst %.cpp, %.d, $(filter %.cpp, $(LOCAL_SRC_FILES))))
sinclude $(addprefix $(MODULE.$(curr_module_id).MODULE_PATH.INTERMEDIATE_PATH)/, $(patsubst %.cxx, %.d, $(filter %.cxx, $(LOCAL_SRC_FILES))))
sinclude $(addprefix $(MODULE.$(curr_module_id).MODULE_PATH.INTERMEDIATE_PATH)/, $(patsubst %.cc, %.d, $(filter %.cc, $(LOCAL_SRC_FILES))))


LOCAL_INTERMEDIATE_TARGETS +=  $(MODULE.$(curr_module_id).MODULE_FILE.OBJ_FILES)
