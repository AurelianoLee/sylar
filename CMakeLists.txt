cmake_minimum_required(VERSION 2.8) # [Note] 指定 CMake 的最低版本
project(sylar)                      # [Note] 定义项目名称为 sylar

set(CMAKE_VERBOSE_MAKEFILE ON) # [Note] 让Makefile输出详细的编译信息，便于调试
set(CMAKE_CXX_FLAGS "$ENV{CXXFLAGS} -rdynamic -O0 -ggdb -std=c++11 -Wall -Wno-deprecated -Werror -Wno-unused-function")
# [Note] 设置C++编译参数：
# - 继承环境变量CXXFLAGS
# - -rdynamic: 导出所有符号，便于调试和动态链接
# - -O0: 关闭优化，便于调试
# - -ggdb: 生成gdb调试信息
# - -std=c++11: 使用C++11标准
# - -Wall: 开启所有警告
# - -Wno-deprecated: 忽略弃用警告
# - -Werror: 将警告视为错误
# - -Wno-unused-function: 忽略未使用函数的警告

include_directories(.)                   # [Note] 添加当前目录为头文件搜索路径
include_directories(/apps/sylar/include) # [Note] 添加 sylar 的头文件目录
link_directories(/apps/sylar/lib)        # [Note] 添加 sylar 的库文件目录

find_library(YAMLCPP yaml-cpp)           # [Note] 查找yaml-cpp库，并将路径赋值给YAMLCPP变量
message("***", ${YAMLCPP})               # [Note] 输出YAMLCPP的路径，便于调试，"***"为自定义的输出信息

set(LIB_SRC sylar/log.cc sylar/util.cc sylar/config.cc) # [Note] 定义变量LIB_SRC，包含需要编译为库的源文件

add_library(sylar SHARED ${LIB_SRC})
# add_library(sylar_static STATIC ${LIB_SRC}) SET_TARGET_PROPERTIES
# (sylar_static PROPERTIES OUTPUT_NAME "sylar")

add_executable(test tests/test.cc)
add_dependencies(test sylar)
target_link_libraries(test sylar ${YAMLCPP})

add_executable(test_config tests/test_config.cc)
add_dependencies(test_config sylar)
target_link_libraries(test_config sylar ${YAMLCPP})

set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib)
