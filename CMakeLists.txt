cmake_minimum_required(VERSION 3.24)
project(sylar LANGUAGES CXX)

# ---------- 基础配置 ----------
set(CMAKE_VERBOSE_MAKEFILE ON)                # 输出详细编译信息
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# ---------- Boost ----------
# 使用 CONFIG 模式，Homebrew 安装的 Boost 自带 Config.cmake
find_package(Boost REQUIRED)                  # 或者指定组件 REQUIRED COMPONENTS system filesystem ...
message(STATUS "Found Boost: ${Boost_INCLUDE_DIRS}")
# Boost 的库文件会在 ${Boost_LIBRARIES} 里

# ---------- yaml-cpp ----------
# CONFIG 模式能自动找到 brew 安装的 cmake 配置文件
find_package(yaml-cpp CONFIG REQUIRED)
# yaml-cpp::yaml-cpp 是官方 CMake target，不需要 include_directories

# ---------- 源文件 ----------
set(LIB_SRC
    sylar/log.cc
    sylar/util.cc
    sylar/config.cc
)

# ---------- 动态库 ----------
add_library(sylar SHARED ${LIB_SRC})
# 添加头文件目录
target_include_directories(sylar PUBLIC ${PROJECT_SOURCE_DIR})
# 链接 Boost 和 yaml-cpp
target_link_libraries(sylar PUBLIC yaml-cpp::yaml-cpp ${Boost_LIBRARIES})
# 如果需要 Boost 的头文件
target_include_directories(sylar PUBLIC ${Boost_INCLUDE_DIRS})

# ---------- 可执行文件 ----------
add_executable(test tests/test.cc)
target_include_directories(test PUBLIC ${PROJECT_SOURCE_DIR})
target_link_libraries(test PUBLIC sylar yaml-cpp::yaml-cpp ${Boost_LIBRARIES})

add_executable(test_config tests/test_config.cc)
target_include_directories(test_config PUBLIC ${PROJECT_SOURCE_DIR})
target_link_libraries(test_config PUBLIC sylar yaml-cpp::yaml-cpp ${Boost_LIBRARIES})

# ---------- 输出路径 ----------
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/lib)


# cmake_minimum_required(VERSION 3.28)
# project(sylar LANGUAGES CXX) # [Note] 定义项目名 sylar，指定语言为 C++

# # [Note] 启用详细编译信息输出
# set(CMAKE_VERBOSE_MAKEFILE ON)

# # [Note] 指定 C++ 标准
# set(CMAKE_CXX_STANDARD 11)
# set(CMAKE_CXX_STANDARD_REQUIRED ON)
# set(CMAKE_CXX_EXTENSIONS OFF)

# # # [Note] 设置编译参数
# # set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -rdynamic -O0 -ggdb -Wall -Werror -Wno-deprecated -Wno-unused-function")

# # ======= Boost 设置 =======
# find_package(Boost REQUIRED)
# include_directories(${Boost_INCLUDE_DIRS})

# # # [Note] 添加头文件目录
# include_directories(${PROJECT_SOURCE_DIR})

# # # [Note] 查找 yaml-cpp 库，结果保存在 YAMLCPP 变量中
# find_package(yaml-cpp REQUIRED)
# include_directories(${YAML_CPP_INCLUDE_DIRS})

# # # [Note] 设置库源文件
# set(LIB_SRC
#     sylar/log.cc
#     sylar/util.cc
#     sylar/config.cc
# )

# # # [Note] 构建动态库 sylar
# add_library(sylar SHARED ${LIB_SRC})

# # # # [可选] 构建静态库 sylar_static（暂不启用）
# # # add_library(sylar_static STATIC ${LIB_SRC})
# # # set_target_properties(sylar_static PROPERTIES OUTPUT_NAME "sylar")

# # # [Note] 构建测试程序 test
# add_executable(test tests/test.cc)
# add_dependencies(test sylar)
# target_link_libraries(test sylar yaml-cpp ${Boost_LIBRARIES})

# # # [Note] 构建测试程序 test_config
# add_executable(test_config tests/test_config.cc)
# add_dependencies(test_config sylar)
# target_link_libraries(test_config sylar yaml-cpp ${Boost_LIBRARIES})

# # # [Note] 设置可执行文件与库的输出路径
# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin)
# set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/lib)
# set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/lib)





# cmake_minimum_required(VERSION 2.8) # [Note] 指定 CMake 的最低版本
# project(sylar)                      # [Note] 定义项目名称为 sylar

# set(CMAKE_VERBOSE_MAKEFILE ON) # [Note] 让Makefile输出详细的编译信息，便于调试
# set(CMAKE_CXX_FLAGS "$ENV{CXXFLAGS} -rdynamic -O0 -ggdb -std=c++11 -Wall -Wno-deprecated -Werror -Wno-unused-function")
# # [Note] 设置C++编译参数：
# # - 继承环境变量CXXFLAGS
# # - -rdynamic: 导出所有符号，便于调试和动态链接
# # - -O0: 关闭优化，便于调试
# # - -ggdb: 生成gdb调试信息
# # - -std=c++11: 使用C++11标准
# # - -Wall: 开启所有警告
# # - -Wno-deprecated: 忽略弃用警告
# # - -Werror: 将警告视为错误
# # - -Wno-unused-function: 忽略未使用函数的警告

# include_directories(.)                   # [Note] 添加当前目录为头文件搜索路径
# include_directories(/apps/sylar/include) # [Note] 添加 sylar 的头文件目录
# link_directories(/apps/sylar/lib)        # [Note] 添加 sylar 的库文件目录

# find_library(YAMLCPP yaml-cpp)           # [Note] 查找yaml-cpp库，并将路径赋值给YAMLCPP变量
# message("***", ${YAMLCPP})               # [Note] 输出YAMLCPP的路径，便于调试，"***"为自定义的输出信息

# set(LIB_SRC sylar/log.cc sylar/util.cc sylar/config.cc) # [Note] 定义变量LIB_SRC，包含需要编译为库的源文件

# add_library(sylar SHARED ${LIB_SRC})     # [Note】 定义静态库sylar，并添加依赖项LIB_SRC
# # add_library(sylar_static STATIC ${LIB_SRC}) SET_TARGET_PROPERTIES # [Note] 生成静态库sylar_static
# # (sylar_static PROPERTIES OUTPUT_NAME "sylar") # [Note] 设置静态库输出名为sylar

# add_executable(test tests/test.cc)           # [Note] 生成可执行文件test，源文件为tests/test.cc
# add_dependencies(test sylar)                 # [Note] 指定test依赖于sylar库
# target_link_libraries(test sylar ${YAMLCPP}) # [Note] 链接sylar动态库和yaml-cpp库

# add_executable(test_config tests/test_config.cc)    # [Note] 生成可执行文件test_config
# add_dependencies(test_config sylar)                 # [Note] 指定test_config依赖于sylar库
# target_link_libraries(test_config sylar ${YAMLCPP}) # [Note] 链接sylar动态库和yaml-cpp库

# set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin) # [Note] 设置所有可执行文件输出到bin目录
# set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib)    # [Note] 设置所有库文件输出到lib目录
