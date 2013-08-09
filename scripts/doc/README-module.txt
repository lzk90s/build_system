/** date: 2013-6-10 */

class module
{
	private:
		string module_id;			// 模块id：由path+name组成，所以，一定唯一。
		string module_name;			// 模块名称：模块的名字			:LOCAL_MODULE
		string module_class;		// 模块类别：enum { EXECUTABLE, STATIC_LIBRARY, SHARED_LIBRARY}
		struct path
		{
			string source_path;				// 模块源路径：绝对路径：模块在源码中的路径		:LOCAL_MODULE_PATH
			string intermediate_path;		// 模块中间路径：绝对路径：模块生成后存放的中间路径，最后会拷贝到模块的安装路径中。
			string install_path;			// 模块安装路径：绝对路径：模块的最终安装路径
			string relative_path;			// 模块相对路径：相对路径：模块相对工程根目录的路径
		}module_path;
		struct file
		{
			string c_src_files;				// 模块中的c源文件：绝对路径		:LOCAL_SRC_FILES
			string cxx_src_files;			// 模块中的c++源文件：绝对路径		:LOCAL_SRC_FILES
			string obj_files;				// 模块中生成的中间object文件：绝对路径
		}module_file;
		struct info
		{
			string owner;					// 模块负责人。
			string ar;						// ar
			string cc;						// 模块的c编译器，如果没有指定，则继承系统编译器	:LOCAL_CC
			string cxx;						// 模块的c++编译器，如果没有指定，则继承系统编译器	:LOCAL_CXX
			string cflags;					// 模块的特定的CFLAGS			:LOCAL_CFLAGS
			string cppflags;				// 模块的特定的CPPFLAGS			:LOCAL_CPPFLAGS
			string cxxflags;				// 模块的特定的CXXFLAGS			:LOCAL_CXXFLAGS
			string ldflags;					// 模块的特定的LDFLAGS			:LOCAL_LDFLAGS
			string include_dirs;			// 模块头文件搜寻目录：绝对路径		:LOCAL_INCLUDE_DIRS
			string library_dirs				// 模块库的搜寻目录：绝对路径		:LOCAL_LD_DIRS
			string static_libraries;		// 需要链接的内部静态库，会自动生成依赖。		:
			string shared_libraries;		// 需要链接的内部动态库	，会自动生成依赖:
			string ldlibs;					// 需要的外部动态库；如-lm, -lpthread
			string pre_dependents;			// 前置依赖，即编译本模块之前的动作
			string post_dependents;			// 后置依赖，即编译本模块后的动作。
		}module_info;
}
