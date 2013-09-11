#
#	file : binary.mk
#	description: host shared library
#


$(call AssertNotNull, $(LOCAL_PATH))

interPath:=$(call MOD_GetInterPath, $(MODULE))
srcPath:=$(call MOD_GetSourcePath, $(MODULE))

##    %.o : %.c
$(interPath)/%.o:$(srcPath)/%.c
	$(call MOD_TransC2Obj)

##    %.o : %.cpp
$(interPath)/%.o:$(srcPath)/%.cpp
	$(call MOD_TransCXX2Obj)

##    %.o : %.cxx
$(interPath)/%.o:$(srcPath)/%.cxx
	$(call MOD_TransCXX2Obj)
    
##    %.o : %.cc
$(interPath)/%.o:$(srcPath)/%.cc
	$(call MOD_TransCXX2Obj)
    

sinclude $(addprefix $(interPath)/, $(patsubst %.c, %.d, $(filter %.c, $(LOCAL_SRC_FILES))))
sinclude $(addprefix $(interPath)/, $(patsubst %.cpp, %.d, $(filter %.cpp, $(LOCAL_SRC_FILES))))
sinclude $(addprefix $(interPath)/, $(patsubst %.cxx, %.d, $(filter %.cxx, $(LOCAL_SRC_FILES))))
sinclude $(addprefix $(interPath)/, $(patsubst %.cc, %.d, $(filter %.cc, $(LOCAL_SRC_FILES))))


___TARGETS +=$(call mod-get-objs, $(MODULE))
