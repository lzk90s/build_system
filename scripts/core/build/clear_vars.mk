#
#	file : clear_vars.mk
#	description: clear variables
#


$(call assert-not-null, $(LOCAL_PATH), LOCAL_PATH is null)

LOCAL_PATH:=
LOCAL_MODULE           :=
LOCAL_MODULE_OWNER     :=

LOCAL_MODULE_CLASS:=
LOCAL_IS_HOST_MODULE:=
LOCAL_MODULE_SUFFIX:=

LOCAL_SRC_FILES:=

LOCAL_CORSS_COMPILE:=
LOCAL_AR:=
LOCAL_CC:=
LOCAL_CXX:=
LOCAL_LD:=

LOCAL_INCLUDE_DIRS     :=
LOCAL_LIBRARY_DIRS     :=

LOCAL_EXPORT_HEADER_TO	 :=
LOCAL_EXPORT_HEADER_DIRS :=

LOCAL_STATIC_LIBRARIES :=
LOCAL_SHARED_LIBRARIES :=

LOCAL_ARLIBS           :=
LOCAL_LDLIBS           :=

LOCAL_CFLAGS           :=
LOCAL_CXXFLAGS         :=
LOCAL_LDFLAGS          :=

LOCAL_ARFLAGS:=
LOCAL_CFLAGS:=
LOCAL_CPPFLAGS:=
LOCAL_CXXFLAGS:=
LOCAL_LDFLAGS:=
LOCAL_LINT_FLAGS:=


MAKEFILE_LIST :=$(lastword $(MAKEFILE_LIST))
