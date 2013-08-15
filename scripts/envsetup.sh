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
    make -C ${T} $@
}

PROJECT_OUT_TOP_DIR=${PROJECT_TOP_DIR}/out
function mmm()
{
    local T=$(find_project_root)
    local P=`pwd`
    local ARGS=$@
    local mfile=${P}/module.mk
    echo ${mfile}
    if [ ! -f ${mfile} ]; then
        echo "module.mk not found!"
        return
    fi
    ONE_SHOT_MAKEFILE=${mfile} make -C ${T} ${ARGS}
}

function gmv()
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
