#
#	file : binary.mk
#	description: host shared library
#


$(call assert-not-null, $(LOCAL_PATH))

_ipath:=$(call mod-get-intermediate-path, $(MOBJ))
_spath:=$(call mod-get-source-path, $(MOBJ))

##    %.o : %.c
$(_ipath)/%.o:$(_spath)/%.c
	$(call mod-trans-c-to-obj)

##    %.o : %.cpp
$(_ipath)/%.o:$(_spath)/%.cpp
	$(call mod-trans-cxx-to-obj)

##    %.o : %.cxx
$(_ipath)/%.o:$(_spath)/%.cxx
	$(call mod-trans-cxx-to-obj)
    
##    %.o : %.cc
$(_ipath)/%.o:$(_spath)/%.cc
	$(call mod-trans-cxx-to-obj)
    

sinclude $(addprefix $(_ipath)/, $(patsubst %.c, %.d, $(filter %.c, $(LOCAL_SRC_FILES))))
sinclude $(addprefix $(_ipath)/, $(patsubst %.cpp, %.d, $(filter %.cpp, $(LOCAL_SRC_FILES))))
sinclude $(addprefix $(_ipath)/, $(patsubst %.cxx, %.d, $(filter %.cxx, $(LOCAL_SRC_FILES))))
sinclude $(addprefix $(_ipath)/, $(patsubst %.cc, %.d, $(filter %.cc, $(LOCAL_SRC_FILES))))


___TARGETS +=$(call mod-get-objs, $(MOBJ))
