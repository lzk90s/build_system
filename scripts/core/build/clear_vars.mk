##--------------------------------------------------------------------------
##
#        文件：clear_vars.mk
#        描述：局部变量重置
#        修改：2013-5-31
#
##--------------------------------------------------------------------------

$(call assert-not-null, $(LOCAL_PATH), LOCAL_PATH is null)

LOCAL_MODULE:=
LOCAL_MODULE_PATH:=
LOCAL_MODULE_CLASS:=
LOCAL_MODULE_TAGS:=
LOCAL_MODULE_OWNER:=
LOCAL_IS_HOST_MODULE:=
LOCAL_MODULE_SUFFIX:=

LOCAL_SRC_FILES:=

LOCAL_CORSS_COMPILE:=
LOCAL_AR:=
LOCAL_CC:=
LOCAL_CXX:=
LOCAL_LD:=

LOCAL_STATIC_LIBRARIES:=
LOCAL_SHARED_LIBRARIES:=
LOCAL_LDLIBS:=

LOCAL_COPY_HEADERS_TO:=
LOCAL_COPY_HEADERS:=

LOCAL_MODULE_INSTALL_PATH:=

LOCAL_ARFLAGS:=
LOCAL_CFLAGS:=
LOCAL_CPPFLAGS:=
LOCAL_CXXFLAGS:=
LOCAL_LDFLAGS:=
LOCAL_LINT_FLAGS:=

LOCAL_INCLUDE_DIRS:=
LOCAL_LIBRARY_DIRS:=

LOCAL_PRE_DEPENDENTS:=
LOCAL_POST_DEPENDENTS:=


MAKEFILE_LIST :=$(lastword $(MAKEFILE_LIST))
