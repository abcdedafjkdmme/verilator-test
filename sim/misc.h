#pragma once

#include <verilated.h>
#include <verilated_vcd_c.h>
#include <random>
#include <bitset>


const std::string term_color_red("\033[0;31m");
const std::string term_color_green("\033[1;32m");
const std::string term_color_yellow("\033[1;33m");
const std::string term_color_cyan("\033[0;36m");
const std::string term_color_magenta("\033[0;35m");
const std::string term_color_reset("\033[0m");
const std::string term_color_white("\x1B[37m");
const std::string term_color_blue("\x1B[34m");

template <typename ModuleType, typename TickType, typename T, typename U>
T wishbone_read(ModuleType &tb, VerilatedVcdC &tfp, TickType &ticks, U addr)
{
	tb.i_cyc = 1;
	tb.eval();
	tb.i_stb = 1;
	tb.eval();

	while (tb.o_stall)
	{
		tick_module(ticks, tb, tfp);
	}

	tick_module(ticks, tb, tfp);
	tb.i_stb = 0;
	tb.eval();

	while (!tb.o_ack)
	{
		tick_module(ticks, tb, tfp);
	}
	tb.i_cyc = 0;
	tb.eval();
	return tb.o_data();
}

template <typename ModuleType, typename TickType, typename T, typename U>
void wishbone_write(ModuleType &tb, VerilatedVcdC &tfp, TickType &ticks, U addr, T data)
{
	tb.i_cyc = 1;
	tb.eval();
	tb.i_stb = 1;
	tb.eval();
	tb.i_we = 1;
	tb.eval();
	tb.i_addr = addr;
	tb.eval();
	tb.i_data = data;
	tb.eval();

	while (tb.o_stall)
	{
		tick_module(ticks, tb, tfp);
	}

	tick_module(ticks, tb, tfp);
	tb.i_stb = 0;
	tb.eval();

	while (!tb.o_ack)
	{
		tick_module(ticks, tb, tfp);
	}
	tb.i_cyc = 0;
	tb.eval();
}

template <typename UART_Type>
void test_uart_tx(UART_Type &tb, VerilatedVcdC &tfp)
{
	uint64_t ticks{};

	tb.i_stb = 1;
	tb.eval();

	tb.i_wr = 1;
	tb.eval();

	std::random_device dev;
	std::mt19937 rng(dev());
	std::uniform_int_distribution<std::mt19937::result_type> distribution(0, 255); // distribution in range [1, 6]
	auto random_byte_val = std::bitset<3>(distribution(rng)).to_ullong();
	std::bitset<8> test_data = random_byte_val;
	tb.i_data = (uint8_t)test_data.to_ulong();

	tb.eval();
	for (int i = 0; i < 100; i++)
	{
		tick_module(ticks, tb, tfp);
		tb.eval();

		if (i == 0)
			assert(tb.o_uart_tx == 0);
		else if (i == 1)
			assert(tb.o_uart_tx == test_data[0]);
		else if (i == 2)
			assert(tb.o_uart_tx == test_data[1]);
		else if (i == 3)
			assert(tb.o_uart_tx == test_data[2]);
		else if (i == 4)
			assert(tb.o_uart_tx == test_data[3]);
		else if (i == 5)
			assert(tb.o_uart_tx == test_data[4]);
		else if (i == 6)
			assert(tb.o_uart_tx == test_data[5]);
		else if (i == 7)
			assert(tb.o_uart_tx == test_data[6]);
		else if (i == 8)
			assert(tb.o_uart_tx == test_data[7]);
		else if (i == 9)
			assert(tb.o_uart_tx == 1);
		else if (i == 10)
			assert(tb.o_busy == 0);
	}
}