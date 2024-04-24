cmake_minimum_required(VERSION 3.12)      
cmake_policy(SET CMP0074 NEW)

project(verilator_test_proj)

find_package(verilator)

set(cxx_sources sim_main.cpp)
set(verilator_top_module led_walker)
set(verilator_top_module_source led_walker.v)
set(verilog_sources ${verilator_top_module_source} blinky.v)
set(top_module led_walker)
set(verilator_args --timescale 1ns/1ns -Wall )

add_executable(verilator_test ${cxx_sources})

target_compile_options(verilator_test PRIVATE -pthread -gdwarf-4 -DLinux -fPIC -Wno-deprecated -pipe -fno-elide-type
                     -fdiagnostics-show-template-tree -Wall -Wextra -Wpedantic -Wvla -Wextra-semi -Wnull-dereference
                     -Wswitch-enum -fvar-tracking-assignments -Wduplicated-cond -Wduplicated-branches -rdynamic
                     -Wsuggest-override -fsanitize=address,undefined -fstack-protector)

target_link_options(verilator_test PRIVATE -fsanitize=address,undefined)               
                

verilate(verilator_test SOURCES ${verilog_sources} TOP_MODULE ${verilator_top_module} VERILATOR_ARGS ${verilator_args} TRACE)


