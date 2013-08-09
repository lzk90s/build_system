##--------------------------------------------------------------------------
##
#		文件：query.mk
#		描述：查询模块信息
#		修改：2013-5-31
#		注意：
#			1. 本文件只供调试查询用，其他规则请勿定义到此处
#			2. 每次查询，需携带查询参数，具体如下：
#				查询模块信息：query_module_info，MODULE_ID=<id>
#				查询某人负责的模块：query_owners_module，MODULE_OWNER=<owner>
#				查询模块名对应的模块ID：query_module_id_by_name， MODULE_NAME=<name>
##--------------------------------------------------------------------------

COLOR_RED:=\033[1;31m
COLOR_RESET:=\033[0m

.PHONY:query_module_info

MODULE_ID	:=$(strip $(MODULE_ID))


query_module_info: PRIVATE.MODULE_ID:=$(MODULE_ID)

query_module_info:
	$(call assert-not-null, $(MODULE_ID), MODULE_ID is null)
	$(hide)echo -e "$(COLOR_RED)"
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo "                    MODULE_ID: $(PRIVATE.MODULE_ID) "
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo -e "$(COLOR_RESET)"
	$(hide)echo -e "$(COLOR_RED)"
	$(hide)echo "++++++++++++++MODULE_BASIC	"
	$(hide)echo -e "$(COLOR_RESET)"
	$(hide)echo "MODULE_ID                          =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_ID)"
	$(hide)echo "MODULE_NAME                        =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_NAME)"
	$(hide)echo "MODULE_CLASS                       =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_CLASS)"
	$(hide)echo -e "$(COLOR_RED)"
	$(hide)echo "++++++++++++++MODULE_PATH	  "
	$(hide)echo -e "$(COLOR_RESET)"
	$(hide)echo "MODULE_PATH.SOURCE_PATH            =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_PATH.SOURCE_PATH)"
	$(hide)echo "MODULE_PATH.RELATIVE_PATH          =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_PATH.RELATIVE_PATH)"
	$(hide)echo "MODULE_PATH.INTERMEDIATE_PATH      =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_PATH.INTERMEDIATE_PATH)"
	$(hide)echo "MODULE_PATH.INSTALL_PATH           =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_PATH.INSTALL_PATH)"
	$(hide)echo -e "$(COLOR_RED)"
	$(hide)echo "++++++++++++++MODULE_FILE  "
	$(hide)echo -e "$(COLOR_RESET)"
	$(hide)echo "MODULE_FILE.COPY_HEADERS           =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_FILE.COPY_HEADERS)"
	$(hide)echo "MODULE_FILE.C_SRC_FILES            =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_FILE.C_SRC_FILES)"
	$(hide)echo "MODULE_FILE.CXX_SRC_FILES          =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_FILE.CXX_SRC_FILES)"
	$(hide)echo "MODULE_FILE.OBJ_FILES              =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_FILE.OBJ_FILES)"
	$(hide)echo -e "$(COLOR_RED)"
	$(hide)echo "++++++++++++++MODULE_INFO  "
	$(hide)echo -e "$(COLOR_RESET)"
	$(hide)echo "MODULE_INFO.OWNER                  =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_INFO.OWNER)"
	$(hide)echo "MODULE_INFO.CC                     =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_INFO.CC)"
	$(hide)echo "MODULE_INFO.CXX                    =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_INFO.CXX)"
	$(hide)echo "MODULE_INFO.LD                     =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_INFO.LD)"
	$(hide)echo "MODULE_INFO.AR                     =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_INFO.AR)"
	$(hide)echo "MODULE_INFO.INCLUDE_DIRS           =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_INFO.INCLUDE_DIRS)"
	$(hide)echo "MODULE_INFO.LIBRARY_DIRS           =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_INFO.LIBRARY_DIRS)"
	$(hide)echo "MODULE_INFO.STATIC_LIBRARIES       =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_INFO.STATIC_LIBRARIES)"
	$(hide)echo "MODULE_INFO.ARLIBS                 =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_INFO.ARLIBS)"
	$(hide)echo "MODULE_INFO.SHARED_LIBRARIES       =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_INFO.SHARED_LIBRARIES)"
	$(hide)echo "MODULE_INFO.CFLAGS                 =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_INFO.CFLAGS)"
	$(hide)echo "MODULE_INFO.ARFALGS                =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_INFO.ARFALGS)"
	$(hide)echo "MODULE_INFO.CPPFLAGS               =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_INFO.CPPFLAGS)"
	$(hide)echo "MODULE_INFO.CXXFLAGS               =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_INFO.CXXFLAGS)"
	$(hide)echo "MODULE_INFO.LDFLAGS                =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_INFO.LDFLAGS)"
	$(hide)echo "MODULE_INFO.PRE_DEPENDENTS         =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_INFO.PRE_DEPENDENTS)"
	$(hide)echo "MODULE_INFO.POST_DEPENDENTS        =$(MODULE.$(PRIVATE.MODULE_ID).MODULE_INFO.POST_DEPENDENTS)"
	$(hide)echo -e "$(COLOR_RED)"
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo -e "$(COLOR_RESET)"

.PHONY:query_owners_module
MODULE_OWNER:=$(strip $(MODULE_OWNER))
query_owners_module: PRIVATE.OWNER :=$(MODULE_OWNER)
query_owners_module:
	$(call assert-not-null, $(MODULE_OWNER), MODULE_OWNER is null)
	$(hide)echo -e "$(COLOR_RESET)"
	$(hide)echo -e "$(COLOR_RED)"
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo "                         MODULE_OWNER: $(PRIVATE.OWNER)"
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo -e "$(COLOR_RESET)"
	$(hide)echo "                               MODULES                                                                                         "
	$(hide)for m in $(LIST.MODULE_FOR_OWNER.$(strip $(PRIVATE.OWNER))); do \
		echo $${m} ;	\
	done
	$(hide)echo ""
	


.PHONY:query_module_id
MODULE_NAME:=$(strip $(MODULE_NAME))
__result=$(foreach m, $(LIST.MODULE_ID), $(if $(findstring $(MODULE_NAME), $(m)), $(m)))
query_module_id:
	$(call assert-not-null, $(MODULE_NAME), MODULE_NAME is null)
	$(hide)echo -e "$(COLOR_RESET)"
	$(hide)echo -e "$(COLOR_RED)"
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo "                               MODULE_NAME: $(MODULE_NAME)"
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo -e "$(COLOR_RESET)"
	$(hide)echo "                               MODULE_ID                                                                                      "
	$(hide)for m in $(__result); do \
		echo $${m} ;	\
	done
	$(hide)echo "***----------------------------------------------------------------------------------***"
	
	
.PHONY:list_all list_target_all list_target_install list_target_intermediate list_target_clean list_owners list_module_id
list_all:list_target_all list_target_install list_target_intermediate list_target_clean list_owners list_module_id

list_target_all:
	$(hide)echo -e "$(COLOR_RED)"
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo "                         LIST.TARGET_ALL: $(words $(LIST.TARGET_ALL))"
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo -e "$(COLOR_RESET)"
	$(hide)for m in $(LIST.TARGET_ALL); do \
		echo $${m}	;	\
	done
	$(hide)echo ""
	
list_target_install:
	$(hide)echo -e "$(COLOR_RED)"
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo "                         LIST.TARGET_INSTALL: $(words $(LIST.TARGET_INSTALL))"
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo -e "$(COLOR_RESET)"
	$(hide)for m in $(LIST.TARGET_INSTALL); do \
		echo $${m}	;	\
	done
	$(hide)echo ""
	
list_target_intermediate:
	$(hide)echo -e "$(COLOR_RED)"
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo "                         LIST.TARGET_INTERMEDIATE: $(words $(LIST.TARGET_INTERMEDIATE))"
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo -e "$(COLOR_RESET)"
	$(hide)for m in $(LIST.TARGET_INTERMEDIATE); do \
		echo $${m}	;	\
	done
	$(hide)echo ""
	
list_target_clean:
	$(hide)echo -e "$(COLOR_RED)"
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo "                         LIST.TARGET_CLEAN: $(words $(LIST.TARGET_CLEAN))"
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo -e "$(COLOR_RESET)"
	$(hide)for m in $(LIST.TARGET_CLEAN); do \
		echo $${m}	;	\
	done
	$(hide)echo ""
	
list_owners:
	$(hide)echo -e "$(COLOR_RED)"
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo "                         LIST.OWNER_ALL: $(words $(LIST.OWNER_ALL))"
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo -e "$(COLOR_RESET)"
	$(hide)for m in $(LIST.OWNER_ALL); do \
		echo $${m}	;	\
	done
	$(hide)echo ""
	
list_module_id:
	$(hide)echo -e "$(COLOR_RED)"
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo "                         LIST.MODULE_ID: $(words $(LIST.MODULE_ID))"
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo -e "$(COLOR_RESET)"
	$(hide)for m in $(LIST.MODULE_ID); do \
		echo $${m}	;	\
	done
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo ""

list_module_file:
	$(hide)echo -e "$(COLOR_RED)"
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo "                         COUNT: $(ALL_MODULE.MODULE_AMOUNT)"
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo -e "$(COLOR_RESET)"
	$(hide)for m in $(ALL_MODULE.MODULE_LIST); do \
		echo $${m}	;	\
	done
	$(hide)echo "***----------------------------------------------------------------------------------***"
	$(hide)echo ""

