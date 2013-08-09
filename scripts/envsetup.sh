#!/bin/bash

#find project root directory
function find_project_root()
{
    local TOPFILE=scripts/envsetup.sh
    if [ -n "$TOP" -a -f "$TOP/$TOPFILE" ] ; then
        echo $TOP
    else
        if [ -f $TOPFILE ] ; then
            PWD= /bin/pwd
        else
            local HERE=$PWD
            T=
            while [ \( ! \( -f $TOPFILE \) \) -a \( $PWD != "/" \) ]; do
                \cd ..
                T=`PWD= /bin/pwd`
            done
            \cd $HERE
            if [ -f "$T/$TOPFILE" ]; then
                echo $T
            fi
        fi
    fi
}

function scripts_usage() {
cat <<EOF
BUILD_PROGRAM	：构建程序
BUILD_OBJECT_FILE	: 构建目标文件集
BUILD_DYNAMIC_LIBRARY	：构建动态库
BUILD_STATIC_LIBRARY	：构建静态库
Look at the source to view more functions. The complete list is:
EOF
    T=$(find_project_root)
    local A
    A=""
    for i in `cat $T/scripts/envsetup.sh | sed -n "/^function /s/function \([a-z_]*\).*/\1/p" | sort`; do
      A="$A $i"
    done
    echo $A
}


function m()
{
    T=$(find_project_root)
    if [ "$T" ]; then
        make -C $T $@
    else
        echo "Couldn't locate the top of the tree.  Try setting TOP."
    fi
}

function gen_module_id()
{
	## 模块id生成方式：MID.路径.名称.类型
	local name=`echo ${2} | tr -d '[\r\n\t ]'`
	local class=`echo ${3} | tr -d '[\r\n\t ]'`
	local id="MID.${name}.${class}"
	echo ${id}
}

function gen_module_target_all()
{
	local id=${1}
	local target="TARGET.ALL.${id}"
	echo ${target}
}

function gen_module_target_clean()
{
	local id=${1}
	local target="TARGET.CLEAN.${id}"
	echo ${target}
}

##	param 1: build(default), clean
#function mmm()
#{
#	local cmd=
#	if [ ! "$1" ]; then
#		cmd=build
#	else
#		cmd="$1"
#	fi
#
#	local T=$(find_project_root)
#
#	if [ "$T" ]; then
#		local p=`pwd`
#		if [ ! -f ${p}/module.mk ];  then
#			echo "[${p}] no module.mk file found in current directory"
#			return
#		fi
#		local module_name_list=`cat module.mk | \egrep "\<LOCAL_MODULE\>" | cut -d'=' -f2 | tr -d '[\t ]' | tr -s '\n' ' '`
#		local module_type_list=`cat module.mk | \egrep -v "^#" | tr -s "\n" | \egrep 'BUILD_[HT][OA][SR][TG]' | cut -d'(' -f2 | cut -d')' -f1 | tr -d '[\t ]' | tr -s '\n' ' '`
#		local num=`echo ${module_name_list} | wc -w`
#
#		if [ ! "${module_name_list}" -o ! "${module_type_list}" ]; then
#			echo "Error: [${p}]no module_name or module_class found in module.mk"
#			return
#		fi
#	fi
#	
#	local target=
#	local module_id=
#	for ((i=1; i<num+1; i++)); do
#		local t_module_name=`echo ${module_name_list} | cut -d' ' -f${i} | tr -d '[\t ]'`
#		local t_module_class=`echo ${module_type_list} | cut -d' ' -f${i} | tr -d '[\t ]'`
#
#		## 去掉BUILD_ 字段，取后面部分
#		t_module_class=${t_module_class:6:${#t_module_class}}
#		module_id=$(gen_module_id ${t_module_name} ${t_module_class})
#	
#		case ${cmd} in
#			build)
#				echo "----------------------------build current module--------------------------"
#				target=$(gen_module_target_all ${module_id})
#				;;
#			clean)
#				echo "----------------------------clean-----------------------------------------"
#				target=$(gen_module_target_clean ${module_id})
#				;;
#			distclean)
#				echo "----------------------------distclean-------------------------------------"
#				target=distclean
#				;;
#			*)
#				echo "----------------------------$@-------------------------------------"
#				target=$@
#				;;
#		esac
#		
#		echo "${module_id}"
#		echo "${t_module_name}"
#		echo "${t_module_class}"
#		#make -C ${T} ${target}
#	done
#}
#

function mmm()
{
	local cmd=
	if [ ! "$1" ]; then
		cmd=build
	else
		cmd="$1"
	fi

	local T=$(find_project_root)
	local n=0

	if [ "$T" ]; then
		local p=`pwd`
		if [ ! -f ${p}/module.mk ];  then
			echo "[${p}] no module.mk file found in current directory"
			return
		fi
		local module_name_list=`cat module.mk | \egrep "\<LOCAL_MODULE\>" | cut -d'=' -f2 | tr -d '[\t\r ]' | tr -s '\n' ' '`
		n=`echo ${module_name_list} | wc -w`

		if [ ! "${module_name_list}" ]; then
			echo "Error: [${p}]no module_name or module_class found in module.mk"
			return
		fi
	fi
	
	local target=
	local module_id=
	for ((i=1; i<n+1; i++)); do
		local t_module_name=`echo ${module_name_list} | cut -d' ' -f${i} | tr -d '[\t\r\n ]'`
		module_id=`cd ${T} && make query_module_id MODULE_NAME=${t_module_name} | \egrep "MID.*" | tr -d '[\t\r ]' | tr -s '\n' ' '`
		if [ `echo "${module_id}" | wc -w`  -gt 1 ]; then
			echo "There are at least two module named ${t_module_name}, please check your module.mk"
			return
		fi
	
		case ${cmd} in
			build)
				echo "----------------------------build current module--------------------------"
				target=$(gen_module_target_all ${module_id})
				;;
			clean)
				echo "----------------------------clean-----------------------------------------"
				target=$(gen_module_target_clean ${module_id})
				;;
			distclean)
				echo "----------------------------distclean-------------------------------------"
				target=distclean
				;;
			info)
				echo "----------------------------info-------------------------------------"
				target="query_module_info MODULE_ID=${module_id}"
				;;
				
			*)
				echo "----------------------------$@-------------------------------------"
				target=$@
				;;
		esac
		
		make -C ${T} ${target}
	done

}

function generate_config_mk()
{
	local T=$(find_project_root)
	local config_mk_templete=${T}/scripts/templete/config.mk
	cp -i ${config_mk_templete} ${T}
}

function generate_module_mk()
{
	local T=$(find_project_root)
	local p=`pwd`
	local module_mk_templete=${T}/scripts/templete/module.mk
	cp -i ${module_mk_templete} ${p}
}

# project top directory is very important
PROJECT_TOP_DIR=$(find_project_root)


export PROJECT_TOP_DIR

alias gm="generate_module_mk"
alias gmv="generate_module_mk && vim module.mk"
