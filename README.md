1. 这是什么？
  这是一个通用的Makefile脚本文件，使用GNU Make(版本大于3.81）作为工程构建工具，本Makefile脚本有如下特点：
  1. 非递归Makefile。
  2. 对外导出一些通用的变量接口，脚本内部的变化不会引起外部修改。
  3. 利用OO（object Oriented）的思想，以模块（一个module.mk文件）作为最小单元，封装模块，增加复用，使整体更加容易理解。同时，
还提供了两种数据结构的封装：list和map，list用于保存链数据，map用于保存key-val数据。
  4. 扩展性良好，通过简单的添加就可以加入新的构建模板。
  5. 提供调试查询功能，可以根据模块的唯一标识符ID来查询模块的信息，方便出错时查错。
  6. 支持模块的单独编译。
  7. 支持用户定义自定义的配置。
  8. 默认提供以C, C++作为编程语言的编译构建。
  9. 提供模块模板文件，在使用时只需拷贝模板后修改，对接口进行赋值即可。
  10. 使用简单。
  

2. 怎样使用
  1. 下载本脚本。

  2. 进入工程的顶目录，以~/project为例，在linux终端中输入
        $ cd ~/project; 

  3. 解压下载的脚本文件到工程根目录。
        $ unzip build_system.zip
        $ ls -al
        drwxr-xr-x  4 hello hello 4096 2013-08-16 10:44 .
        drwxr-xr-x 41 hello hello 4096 2013-08-16 10:43 ..
        -rw-r--r--  1 hello hello   88 2013-08-16 10:44 Makefile
        drwxr-x---  6 hello hello 4096 2013-08-16 10:44 scripts
  4. 运行
        $ source ./scripts/envsetup.sh 或 . ./scripts/envsetup.sh

  5. 本系统中把一个文件夹看作模块，进入任意一个你认为可以作为模块的目录。以~/project/test为例，把test目录看作一个模块。
        $ ls -al
        drwxr-xr-x  4 hello hello 4096 2013-08-16 10:44 .
        drwxr-xr-x 41 hello hello 4096 2013-08-16 10:43 ..
        -rw-r--r--  1 hello hello   88 2013-08-16 10:44 Makefile
        drwxr-x---  6 hello hello 4096 2013-08-16 10:44 scripts
        drwxr-x---  5 hello hello 4096 2013-08-16 10:44 test

        $ cd test && ls -al
        drwxr-x--- 2 hello hello 4096 2013-08-16 10:48 .
        drwxr-xr-x 4 hello hello 4096 2013-08-16 10:44 ..
        -rw-r--r-- 1 hello hello    1 2013-08-16 10:48 main.c

  6. 命令行输入gm，会在当前目录下生成一个module.mk文件，编辑此文件，以本例，test模块需要生成main的可执行文件
        $ vim module.mk

        ### module.mk
        
        LOCAL_PATH             :=$(call my-dir)
        
        LOCAL_MODULE           :=main
        LOCAL_MODULE_OWNER     :=
        
        LOCAL_SRC_FILES        :=main.c
        
        LOCAL_CORSS_COMPILE   :=
        LOCAL_AR              :=$(LOCAL_CROSS_COMPILE)ar
        LOCAL_CC              :=$(LOCAL_CROSS_COMPILE)gcc
        LOCAL_CPP             :=$(LOCAL_CROSS_COMPILE)gcc
        LOCAL_CXX             :=$(LOCAL_CROSS_COMPILE)g++
        LOCAL_LD              :=$(LOCAL_CC)
        
        LOCAL_INCLUDE_DIRS     :=
        LOCAL_LIBRARY_DIRS     :=
        
        LOCAL_EXPORT_HEADER_TO   :=
        LOCAL_EXPORT_HEADER_DIRS :=
        
        LOCAL_STATIC_LIBRARIES :=
        LOCAL_SHARED_LIBRARIES :=
        
        LOCAL_ARLIBS           :=
        LOCAL_LDLIBS           :=
        
        LOCAL_CFLAGS           :=
        LOCAL_CXXFLAGS         :=
        LOCAL_LDFLAGS          :=
       
        include $(BUILD_HOST_EXECUTABLE)
       
  7. 进入工程主目录，运行make即可，最后，会在~/project/out/$(version-id-type)/(host|target)/bin下生成最后的可执行文件main
        $ cd ~/project && make


3. 注意
  1. 本脚本参考了Android的构建系统，module.mk文件和Android的Android.mk文件类似，但进行了精简，修改Android的头文件拷贝
LOCAL_COPY_HEADERS_TO和LOCAL_COPY_HEADERS为LOCAL_EXPORT_HEADER_TO和LOCAL_EXPORT_HEADER_DIRS。其他主要部分是通用的。
  2. 本脚本中使用了Android构建系统中的几个宏定义，参考了Android的设计方式，在此基础上利用OO思想进行了重新设计。

4. LICENSE
  1. 请遵循Android的相关协议。
