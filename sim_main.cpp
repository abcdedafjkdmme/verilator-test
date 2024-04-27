#include <iostream>
#include <Vuart_tx.h>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include <cassert>
#include <optional>
#include <cstdint>
#include <bitset>
#include <random>
#include <curses.h>

#define VCD_FILE "test.vcd"

template <typename TickType, typename ModuleType>
void tick_module(TickType &ticks, ModuleType &tb, VerilatedVcdC &tfp)
{
	ticks++;

	tb.eval();
	tfp.dump(ticks * 10 - 4); // dump 2ns before tick

	tb.i_clk = 1;
	tb.eval();
	tfp.dump(ticks * 10); // tick every 10ns

	tb.i_clk = 0;
	tb.eval();
	tfp.dump(ticks * 10 + 5); // trailing edge dump

	tfp.flush();
}

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

void test_uart_tx(Vuart_tx &tb, VerilatedVcdC &tfp)
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

/*
int main(int argc, char const *argv[])
{

	initscr();

	Verilated::commandArgs(argc, argv);
	Verilated::traceEverOn(true);

	VerilatedVcdC tfp{};
	Vuart_tx tb{};

	tb.trace(&tfp, 99);
	tfp.open(VCD_FILE);

	test_uart_tx(tb, tfp);

	printw("hlp");
	refresh();

	printw("dlkajdf");
	refresh();
	

	endwin();

	return 0;
}
*/

int main()
{	
	initscr();			/* Start curses mode 		  */
	printw("Hello World !!!");	/* Print Hello World		  */
	refresh();			/* Print it on to the real screen */
	getch();			/* Wait for user input */
	endwin();			/* End curses mode		  */

	return 0;
}