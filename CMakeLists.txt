cmake_minimum_required(VERSION 3.12)      
cmake_policy(SET CMP0074 NEW)

project(verilator_test_proj)


set(CXX_INCLUDE_DIRS sim)
set(CXX_SRCS sim/main.cpp sim/misc.h)

set(VERILATOR_TOP_MODULE cpu_datapath)
set(VERILATOR_TOP_MODULE_SRC rtl/cpu_datapath.v)
set(VERILATOR_SRCS ${VERILATOR_TOP_MODULE_SRC} rtl/alu.v rtl/cpu_control_unit.v rtl/program_counter.v rtl/register.v)
set(VERILATOR_INCLUDE_DIRS rtl)
set(verilator_args --timescale 1ns/1ns -Wall )

add_executable(verilator_test ${CXX_SRCS})

find_package(Curses REQUIRED)
target_link_libraries(verilator_test PRIVATE ${CURSES_LIBRARIES})
target_include_directories(verilator_test PRIVATE ${CURSES_INCLUDE_DIRS})

target_include_directories(verilator_test PRIVATE ${CXX_INCLUDE_DIRS})

if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    target_compile_options(verilator_test PRIVATE -pthread -gdwarf-4 -DLinux -fPIC -Wno-deprecated -pipe -fno-elide-type
                         -fdiagnostics-show-template-tree -Wall -Wextra -Wpedantic -Wvla -Wextra-semi -Wnull-dereference
                         -Wswitch-enum -fvar-tracking-assignments -Wduplicated-cond -Wduplicated-branches -rdynamic
                         -Wsuggest-override -fsanitize=address,undefined -fstack-protector)
endif()


target_link_options(verilator_test PRIVATE -fsanitize=address,undefined)               
                

find_package(verilator)
verilate(verilator_test SOURCES ${VERILATOR_SRCS} INCLUDE_DIRS ${VERILATOR_INCLUDE_DIRS} TOP_MODULE ${VERILATOR_TOP_MODULE} VERILATOR_ARGS ${verilator_args} TRACE)


