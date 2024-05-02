#include <iostream>
#include <Vcpu_datapath.h>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include <cassert>
#include <optional>
#include <cstdint>
#include <bitset>
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


void exec_cpu_instr(uint16_t instr, uint64_t &ticks, Vcpu_datapath &tb, VerilatedVcdC &tfp)
{
	tb.i_reset = 0;
	tb.i_instr = instr;
	
	tick_module(ticks, tb, tfp);

}

template<typename MemoryType>
void print_cpu_data(uint16_t a_reg, uint16_t d_reg, uint16_t pc, const MemoryType &memory, uint16_t m_addr, uint16_t alu_o)
{
	std::cout << std::hex;

	std::cout << "a reg       " << a_reg << "\n";
	std::cout << "d reg       " << d_reg << "\n";
	std::cout << "alu output  " << alu_o << "\n";
	std::cout << "pc          " << pc << "\n";
	std::cout << "memory [" << std::dec << m_addr << "]  " << std::hex << memory[m_addr] << "\n\n";
}
void test_cpu_datpath(Vcpu_datapath &tb, VerilatedVcdC &tfp)
{
	vluint64_t ticks{};

	std::array<uint16_t, 65536> instructions{
		0x0000,
		0xfc10,
		0x0018,
		0xe306,
		0x0010,
		0xe308,
		0x4000,
		0xec10,
		0x0011,
		0xe308,
		0x0011,
		0xfc20,
		0xee88,
		0x0011,
		0xfc10,
		0x0020,
		0xe090,
		0x0011,
		0xe308,
		0x0010,
		0xfc88,
		0xfc10,
		0x000a,
		0xe301,
		0x0018,
		0xea87
	};

	tb.cpu_datapath__DOT__block_ram_i__DOT__mem[0] = 0x34;
	
	for (size_t i = 0; i < 10; i++)
	{
		std::cout << "instr       " << instructions[tb.o_pc] << "\n";
		exec_cpu_instr(instructions[tb.o_pc], ticks, tb, tfp);
		uint16_t a_reg = tb.cpu_datapath__DOT__a_reg_i__DOT__r_data;
		uint16_t d_reg = tb.cpu_datapath__DOT__d_reg_i__DOT__r_data;
		print_cpu_data(a_reg, d_reg, tb.o_pc, tb.cpu_datapath__DOT__block_ram_i__DOT__mem , a_reg , tb.cpu_datapath__DOT__alu_o);
	}
	
}


int main(int argc, char const *argv[])
{

	
	Verilated::commandArgs(argc, argv);
	Verilated::traceEverOn(true);
	VerilatedVcdC tfp{};
	Vcpu_datapath tb{};
	tb.trace(&tfp, 99);
	tfp.open(VCD_FILE);

	test_cpu_datpath(tb, tfp);

	WINDOW* ncurses_default_win = initscr();
	assert(ncurses_default_win);

	box(ncurses_default_win, 0, 0);
	refresh();

	wprintw(ncurses_default_win, "hell");
	refresh();

	WINDOW *local_win;
	local_win = newwin(10, 50, 5, 5);
	box(local_win, 0 , 0);		/* 0, 0 gives default characters 
					 * for the vertical and horizontal
					 * lines			*/
	wrefresh(local_win);		/* Show that box 		*/

	wprintw(local_win, "child");
	wrefresh(local_win);
	wprintw(ncurses_default_win, "hello");
	refresh();
	wprintw(local_win, " child");
	wrefresh(local_win);
	getch();
	endwin();

	return 0;
}
