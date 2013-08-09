##--------------------------------------------------------------------------
##
#        文件：definitions.mk
#        描述：宏定义
#        修改：2013-5-31
#        注意：
#            1. 如果想添加或者修改宏定义，请参照宏定义规范，字母之间用中画线隔开
#                如：my-dir。
#            2. 宏定义统一用小写字母+中画线组成
#            3. 有的地方容易因字符串前后空格引起问题，特别是路径处理方面，所以，
#                如果出现问题，可以先确认是不是字符串前后空格引起的
#            4. 注释，每一个对外导出的宏，最好添加注释，具体参照已有宏定义
##--------------------------------------------------------------------------


hide     :=@
empty    :=
space    :=$(empty) $(empty)
comma    :=,
INFO_HEADER:=<|OUT_ROOT|>


##-------------------------------------------------------------------------
##        描述：获取当前makefile所在目录
##        参数：
##            无
##        调用方法：LOCAL_PATH=$(call my-dir)
##-------------------------------------------------------------------------
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


##-------------------------------------------------------------------------
##        描述：找到目录下的所有module.mk文件
##        参数：
##            1. 目录
##        调用方法：$(call find_all_module_in_dir, $(dir))
##-------------------------------------------------------------------------
define find-all-module-in-dir
$(shell find $(1) -path "$(PROJECT_TOP_DIR)/scripts" -prune -o -name module.mk -print)
endef


##-------------------------------------------------------------------------
##        描述：格式化统一输出
##        参数：
##            1. 输入信息
##        调用方法：
##-------------------------------------------------------------------------
define format-output
$(addprefix $(INFO_HEADER),$(patsubst $(PROJECT_OUTPUT_TOP_DIR)%, %, $(1)))
endef


##-------------------------------------------------------------------------
##        描述：设置模块id
##        参数：
##            1. 模块名
##            2. 模块类别
##        调用方法：$(call set-module-id, class, name)
##-------------------------------------------------------------------------
define set-module-id
$(strip \
    $(eval _m_class:=$(strip $(1))) \
    $(eval _m_suffix:=) \
    $(eval _m_suffix:=$(if $(findstring STATIC_LIBRARY, $(_m_class)), $(GLOBAL_STATIC_LIBRARY_SUFFIX), $(_m_suffix))) \
    $(eval _m_suffix:=$(if $(findstring SHARED_LIBRARY, $(_m_class)), $(GLOBAL_SHARED_LIBRARY_SUFFIX), $(_m_suffix))) \
    $(eval _m_name:=$(if $(filter $(_m_suffix), $(suffix $(2))), \
        $(2), $(addsuffix $(strip $(_m_suffix)), $(strip $(2))))) \
    MID.$(strip $(_m_class)).$(strip $(_m_name)) \
)
endef


##-------------------------------------------------------------------------
##        描述：assert
##        参数：
##            1. 条件
##            2. 条件不成立时输出的信息
##        调用方法：$(call assert, cond, msg)
##-------------------------------------------------------------------------
define assert
$(if $(strip $(1)),, $(error Assert Failed at module $(curr_module_name) : $(strip $(2))))
endef


##-------------------------------------------------------------------------
##        描述：非空断言
##        参数：
##            1. 条件a
##            2. [可选参数]：自定义出错信息
##            
##        调用方法：$(call assert-not-null, a)
##-------------------------------------------------------------------------
define assert-not-null
$(call assert,$(1), $(if $(strip $(2)), $(2), The variable is null!))
endef


##-------------------------------------------------------------------------
##        描述：等于断言
##        参数：
##            1. 条件a
##            2. 条件b
##            3. [可选参数]：自定义出错信息
##        调用方法：$(call assert-equal, a, b)
##-------------------------------------------------------------------------
define assert-equal
$(call assert, $(filter $(1), $(2)), $(if $(strip $(3)), $(3), $(1) is not equal to $(2)))
endef


##-------------------------------------------------------------------------
##        描述：等于
##        参数：
##            1. 条件a
##            2. 条件b
##        调用方法：$(call equal, a, b)
##-------------------------------------------------------------------------
define is-equal
$(strip \
	$(if $(filter $(strip $(1)), $(strip $(2))), TRUE, ) \
)
endef

##-------------------------------------------------------------------------
##        描述：从所给文件列表中找出所有的c文件
##        参数：
##            1. 所给文件列表
##        调用方法：
##-------------------------------------------------------------------------
define filter-c-files
$(foreach ext, $(GLOBAL_C_FILE_SUFFIX), $(filter %$(ext), $(1)))
endef


##-------------------------------------------------------------------------
##        描述：从所给文件列表中找出所有的c++文件
##        参数：
##            1. 所给文件列表
##        调用方法：
##-------------------------------------------------------------------------
define filter-cxx-files
$(strip \
	$(foreach ext, $(GLOBAL_CXX_FILE_SUFFIX), $(filter %$(ext), $(1))) \
)
endef


define src-to-obj-inner
$(foreach ext, $(2), $(patsubst %$(ext), %.o, $(filter %$(ext), $(1))))
endef

##-------------------------------------------------------------------------
##        描述：c到obj
##        参数：
##            1. 所给文件列表
##        调用方法：
##-------------------------------------------------------------------------
define c-to-obj
$(strip \
	$(call src-to-obj-inner, $(1), $(GLOBAL_C_FILE_SUFFIX)) \
)
endef


##-------------------------------------------------------------------------
##        描述：c++到obj
##        参数：
##            1. 所给文件列表
##        调用方法：
##-------------------------------------------------------------------------
define cxx-to-obj
$(strip \
	$(call src-to-obj-inner, $(1), $(GLOBAL_CXX_FILE_SUFFIX))
)
endef


##-------------------------------------------------------------------------
##        描述：标准化静态库类似：name.a
##        参数：
##            1. 静态库
##        调用方法：
##-------------------------------------------------------------------------
define normalize-static-libs-like-name.a
$(strip \
    $(foreach arlib, $(1), \
        $(if $(call is-equal, $(GLOBAL_STATIC_LIBRARY_SUFFIX), $(suffix $(arlib))), \
            $(arlib), \
            $(addsuffix $(GLOBAL_STATIC_LIBRARY_SUFFIX), $(arlib)))) \
)
endef


##-------------------------------------------------------------------------
##        描述：标准化动态库类似：name.so
##        参数：
##            1. 动态库
##        调用方法：
##-------------------------------------------------------------------------
define normalize-shared-libs-like-name.so
$(strip \
    $(foreach solib, $(1), \
        $(if $(call is-equal, $(GLOBAL_SHARED_LIBRARY_SUFFIX), $(suffix $(solib))), \
            $(solib), \
            $(addsuffix $(GLOBAL_SHARED_LIBRARY_SUFFIX), $(solib)))) \
)
endef


##-------------------------------------------------------------------------
##        描述：标准化静态库类似：l+name
##        参数：
##            1. 静态库
##        调用方法：
##-------------------------------------------------------------------------
define normalize-static-libs-like-lname
$(strip \
    $(foreach l, $(call normalize-static-libs-like-name.a, $(1)), \
        $(addprefix $(if $(findstring -l, $(l)),,-l), \
            $(patsubst lib%$(GLOBAL_STATIC_LIBRARY_SUFFIX),%,$(addprefix lib, $(patsubst lib%,%,$(notdir $(l))))))) \
)
endef


##-------------------------------------------------------------------------
##        描述：标准化动态库类似：l+name
##        参数：
##            1. 动态库
##        调用方法：
##-------------------------------------------------------------------------
define normalize-shared-libs-like-lname
$(strip \
    $(foreach l, $(call normalize-shared-libs-like-name.so, $(1)), \
        $(addprefix $(if $(findstring -l, $(l)),, -l), \
            $(patsubst lib%$(GLOBAL_SHARED_LIBRARY_SUFFIX),%, $(addprefix lib, $(patsubst lib%,%,$(notdir $(l))))))) \
)
endef

##-------------------------------------------------------------------------
##        描述：标准化路径为绝对路径
##        参数：
##            1. 绝对路径目录
##            2. 文件列表
##        调用方法：
##-------------------------------------------------------------------------
define normalize-to-absolute-path
$(strip \
	$(foreach f, $(2), \
		$(if $(call is-absolute-path, $(f)), \
			$(f), \
			$(addprefix $(strip $(1)), $(f)))) \
)
endef

##-------------------------------------------------------------------------
##        描述：根据模块名添加静态依赖库
##        参数：
##            1. 模块名字
##        调用方法：
##-------------------------------------------------------------------------
define add-static-lib-dependent-by-name
$(strip \
    $(eval _m_class:=$(curr_my_prefix)STATIC_LIBRARY) \
    $(eval _m_name:=$(notdir $(1))) \
    $(eval _m_id:=$(call set-module-id, $(_m_class), $(_m_name)))    \
    TARGET.ALL.$(strip $(_m_id)) \
)
endef


##-------------------------------------------------------------------------
##        描述：根据模块名添加动态依赖库
##        参数：
##            1. 模块名字
##        调用方法：
##-------------------------------------------------------------------------
define add-shared-lib-dependent-by-name
$(strip \
    $(eval _m_class:=$(curr_my_prefix)SHARED_LIBRARY) \
    $(eval _m_name:=$(notdir $(1))) \
    $(eval _m_id:=$(call set-module-id, $(_m_class), $(_m_name)))    \
    TARGET.ALL.$(strip $(_m_id)) \
)
endef


##-------------------------------------------------------------------------
##        描述：根据模块名添加可执行程序依赖
##        参数：
##            1. 模块名字
##        调用方法：
##-------------------------------------------------------------------------
define add-exe-dependent-by-name
$(strip \
    $(eval _m_class:=$(curr_my_prefix)EXECUTABLE) \
    $(eval _m_name:=$(notdir $(1))) \
    $(eval _m_id:=$(call set-module-id, $(_m_class), $(_m_name)))    \
    TARGET.ALL.$(strip $(_m_id)) \
)
endef


##
define transform-c-to-o-no-deps
$(hide)	$(MKDIR) $(dir $@)
	$(hide)echo -e "[ CC ]		-->	$(call format-output, $@)"
	$(hide)$(PRIVATE.MODULE_INFO.CC)     \
	$(PRIVATE.MODULE_INFO.CFLAGS) $(PRIVATE.MODULE_INFO.CPPFLAGS) \
	$(GLOBAL_CFLAGS)    \
	$(1) \
	-MD -MF $(patsubst %.o,%.d,$@) \
	-c -o $@ $<
endef

define transform-cxx-to-o-no-deps
$(hide)	$(MKDIR) $(dir $@)
	$(hide)echo -e "[ C++ ]		-->	$(call format-output, $@)"
	$(hide)$(PRIVATE.MODULE_INFO.CXX)     \
	$(PRIVATE.MODULE_INFO.CXXFLAGS) $(PRIVATE.MODULE_INFO.CPPFLAGS) \
	$(GLOBAL_CXXFLAGS)    \
	$(1) \
	-MD -MF $(patsubst %.o,%.d,$@) \
	-c -o $@ $<
endef

##
define transform-d-to-p-args
$(hide)	cp $(1) $(2); \
    sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
        -e '/^$$/ d' -e 's/$$/ :/' < $(1) >> $(2); \
    rm -f $(1)
endef

##
define transform-d-to-p
$(call transform-d-to-p-args,$(@:%.o=%.d),$(@:%.o=%.P))
endef


##-------------------------------------------------------------------------
##        描述：c to object
##        参数：
##        
##        调用方法：$lcatransform-c-to-object)
##-------------------------------------------------------------------------
define transform-c-to-object
$(call transform-c-to-o-no-deps)
$(call transform-d-to-p)
endef


##-------------------------------------------------------------------------
##        描述：c++ to object
##        参数：
##        
##        调用方法：$lcatransform-c-to-object)
##-------------------------------------------------------------------------
define transform-cxx-to-object
$(call transform-cxx-to-o-no-deps)
$(call transform-d-to-p)
endef


##-------------------------------------------------------------------------
##        描述：把目标文件编译为可执行文件
##        参数：
##            1. 目录
##        调用方法：$(call transform-o-to-executable)
##-------------------------------------------------------------------------
define transform-o-to-executable
$(hide)	$(MKDIR) $(dir $@)
	$(hide)echo -e "[ LINK ]	-->	$(call format-output, $@)"	
	$(hide)$(PRIVATE.MODULE_INFO.LD) \
	$(PRIVATE.MODULE_INFO.CFLAGS)  $(PRIVATE.MODULE_INFO.LDFLAGS) \
	$(GLOBAL_CFLAGS) $(GLOBAL_LDFLAGS) \
	-L$($(curr_my_prefix)OUT_SHARED_LIBRARIES) \
	-L$($(curr_my_prefix)OUT_STATIC_LIBRARIES) \
	-o $@  $^ \
	-Wl,--whole-archive \
	$(call normalize-static-libs-like-lname, $(PRIVATE.MODULE_INFO.STATIC_LIBRARIES)) \
	-Wl,--no-whole-archive \
	$(call normalize-shared-libs-like-lname, $(PRIVATE.MODULE_INFO.SHARED_LIBRARIES))
endef


##
define _extract-and-include-single-host-whole-static-lib
	ldir=$(PRIVATE.MODULE_PATH.INTERMEDIATE_PATH)/WHOLE/$(basename $(notdir $(1)))_objs;\
	rm -rf $$ldir; \
	mkdir -p $$ldir; \
	filelist=; \
	for f in `$(PRIVATE.MODULE_INFO.AR) t $(1) | \grep '\.o$$'`; do \
		$(PRIVATE.MODULE_INFO.AR) p $(1) $$f > $$ldir/$$f; \
		filelist="$$filelist $$ldir/$$f"; \
	done ; \
	$(PRIVATE.MODULE_INFO.AR) $(GLOBAL_ARFLAGS) $(PRIVATE.MODULE_INFO.ARFLAGS) $@ $$filelist;
endef

define extract-and-include-host-whole-static-libs
$(eval _all_static_libs:=$(PRIVATE.MODULE_INFO.STATIC_LIBRARIES) $(PRIVATE.MODULE_INFO.ARLIBS)) \
		$(foreach lib,$(_all_static_libs), \
    $(call _extract-and-include-single-host-whole-static-lib, $(lib)))
endef


##-------------------------------------------------------------------------
##        描述：构建静态库
##        参数：
##        
##        调用方法：$(call transform-o-to-static-library)
##-------------------------------------------------------------------------
define transform-o-to-static-library
$(hide)	mkdir -p $(dir $@)
	$(hide)echo -e "[ AR ]		-->	$(call format-output, $@)"	
	$(hide)rm -f $@
	$(hide)$(extract-and-include-host-whole-static-libs)
	$(hide)$(PRIVATE.MODULE_INFO.AR) $(GLOBAL_ARFLAGS) $(PRIVATE.MODULE_INFO.ARFLAGS) $@ $(filter %.o, $^)
endef

##
define transform-o-to-shared-library-inner
$(hide)	$(PRIVATE.MODULE_INFO.CC) \
	$(PRIVATE.MODULE_INFO.CFLAGS) $(PRIVATE.MODULE_INFO.CPPFLAGS) \
	$(GLOBAL_CFLAGS) $(GLOBAL_LDFLAGS) \
	-shared  -fPIC \
	-L$($(curr_my_prefix)OUT_SHARED_LIBRARIES) \
	-L$($(curr_my_prefix)OUT_STATIC_LIBRARIES) \
	-o $@ $^    \
	-Wl,--whole-archive \
	$(call normalize-static-libs-like-lname, $(PRIVATE.MODULE_INFO.STATIC_LIBRARIES))    \
	-Wl,--no-whole-archive \
	$(call normalize-shared-libs-like-lname, $(PRIVATE.MODULE_INFO.SHARED_LIBRARIES))
endef


##-------------------------------------------------------------------------
##        描述：构建共享库
##        参数：
##        
##        调用方法：$(call transform-o-to-shared-library)
##-------------------------------------------------------------------------
define transform-o-to-shared-library
$(hide)	$(MKDIR) $(dir $@)
	$(hide)echo -e "[ CC ]		-->	$(call format-output, $@)"	
	$(transform-o-to-shared-library-inner)
endef


##-------------------------------------------------------------------------
##        描述：拷贝文件
##        参数：
##        
##        调用方法：$(call copy_file)
##-------------------------------------------------------------------------
define copy-one-file
$(hide)	$(MKDIR) $(dir $@)
	$(hide)echo -e "[ CP ]		-->	$(call format-output, $@)"
	$(hide)$(CP) $< $@
endef


##-------------------------------------------------------------------------
##        描述：清理目标
##        参数：
##            
##        调用方法：
##-------------------------------------------------------------------------
define target-clean 
$(hide)	echo -e "[ RM ]		-->	$(call format-output, $(PRIVATE.ALL_FILE_NEED_CLEAN))"
	$(hide)$(RM) $(PRIVATE.ALL_FILE_NEED_CLEAN)
endef

##-------------------------------------------------------------------------
##        描述：获取模块的根目录
##        参数：
##            1. 模块ID
##            
##        调用方法：root_dir=$(call get-module-root-dir, $(call set-module-id, class, name)
##-------------------------------------------------------------------------
define get-module-root-dir
$(strip $(MODULE.$(strip $(1)).MODULE_PATH.ROOT_DIR_PATH))
endef


##-------------------------------------------------------------------------
##        描述：添加头文件目录。用在拷贝头文件处
##        参数：
##            1. 目的目录
##        调用方法：
##-------------------------------------------------------------------------
define add-copy-header-dir
$(strip \
    $(addprefix $($(curr_my_prefix)OUT_HEADERS)/, \
		$(strip $(1))) \
)
endef

##-------------------------------------------------------------------------
##        描述：目录下的所有头文件
##        参数：
##            1. 目录
##        调用方法：
##-------------------------------------------------------------------------
define all-headers-under
$(strip \
	$(foreach h_s, $(GLOBAL_HEADER_FILE_SUFFIX), \
		$(eval p:=$(call normalize-to-absolute-path, $(LOCAL_PATH)/, $(1))) \
		$(shell find $(p) -maxdepth 1 -name "*$(h_s)")) \
)
endef

##-------------------------------------------------------------------------
##        描述：目录下的所有C文件
##        参数：
##            1. 目录
##        调用方法：
##-------------------------------------------------------------------------
define all-c-srcs-under
$(strip \
	$(foreach c_s, $(GLOBAL_C_FILE_SUFFIX), \
		$(eval p:=$(call normalize-to-absolute-path, $(LOCAL_PATH)/, $(1))) \
		$(shell find $(strip $(p)) -maxdepth 1 -name "*$(c_s)"))  \
)
endef

##-------------------------------------------------------------------------
##        描述：目录下的所有C++文件
##        参数：
##            1. 目录
##        调用方法：
##-------------------------------------------------------------------------
define all-cxx-srcs-under
$(strip \
	$(foreach cxx_s, $(GLOBAL_CXX_FILE_SUFFIX), \
		$(eval p:=$(call normalize-to-absolute-path, $(LOCAL_PATH)/, $(1))) \
		$(shell find $(p) -maxdepth 1 -name "*$(cxx_s)")) \
)
endef

##-------------------------------------------------------------------------
##        描述：判断是否是绝对路径，如果是，返回TRUE，否则返回空
##        参数：
##            1. 路径
##        调用方法：
##-------------------------------------------------------------------------
define is-absolute-path
$(strip \
	$(if $(patsubst /%,,$(1)), \
		, \
		TRUE) \
)
endef
