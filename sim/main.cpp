#include <iostream>
#include <Vcpu_datapath.h>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include <cassert>
#include <optional>
#include <cstdint>
#include <bitset>
#include <random>
#include <curses.h>
#include <array>
#include <vector>

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

void exec_cpu_instr(uint16_t instr, uint16_t &a_reg, uint16_t &d_reg, std::array<uint16_t, 65536> &memory, uint16_t &pc, uint64_t &ticks, Vcpu_datapath &tb, VerilatedVcdC &tfp)
{

	tb.i_instr = instr;
	tb.i_a_reg_data = a_reg;
	tb.i_d_reg_data = d_reg;
	tb.i_pc = pc;
	tb.i_m = memory[tb.o_m_addr];

	tick_module(ticks, tb, tfp);

	a_reg = tb.o_a_we ? tb.o_a_reg_data : a_reg;
	d_reg = tb.o_d_we ? tb.o_d_reg_data : d_reg;
	pc = tb.o_pc;
	memory[tb.o_m_addr] = tb.o_m_we ? tb.o_m : memory[tb.o_m_addr];

}

void print_cpu_data( uint16_t a_reg, uint16_t d_reg, uint16_t pc, const std::array<uint16_t, 65536> &memory, uint16_t m_addr, uint16_t alu_o)
{
	std::cout << std::hex;
	
	std::cout << "a reg       " << a_reg << "\n";
	std::cout << "d reg       " << d_reg << "\n";
	std::cout << "alu output  " << alu_o << "\n";
	std::cout << "pc          " << pc << "\n";
	std::cout << "memory [" << m_addr << "]  "  << memory[m_addr] << "\n\n";
}
void test_cpu_datpath(Vcpu_datapath &tb, VerilatedVcdC &tfp)
{
	uint64_t ticks{};

	std::array<uint16_t, 65536> instructions{
		0x0002,
		0xec10,
		0x0003,
		0xe090,
		0x0000,
		0xe308
	};
	uint16_t a_reg{};
	uint16_t d_reg{};
	uint16_t pc{};
	std::array<uint16_t, 65536> memory{};

	for (size_t i = 0; i < 10; i++)
	{
		std::cout << "instr       " << instructions[pc] << "\n";
		exec_cpu_instr(instructions[pc], a_reg, d_reg, memory, pc, ticks, tb, tfp);
		print_cpu_data( a_reg, d_reg, pc, memory, tb.o_m_addr, tb.cpu_datapath__DOT__alu_o);
	}
	
	
}

int main(int argc, char const *argv[])
{

	// WINDOW* ncurses_win = initscr();
	// assert(ncurses_win);

	Verilated::commandArgs(argc, argv);
	Verilated::traceEverOn(true);

	VerilatedVcdC tfp{};
	Vcpu_datapath tb{};

	tb.trace(&tfp, 99);
	tfp.open(VCD_FILE);

	test_cpu_datpath(tb, tfp);

	// printw("hlp");
	// refresh();

	// refresh();

	// getch();
	// endwin();

	return 0;
}
