#include <iostream>
#include <Vled_walker.h>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include <cassert>
#include <optional>
#include <cstdint>
#include <bitset>

#define VCD_FILE "test.vcd"

template <typename TickType,typename ModuleType>
void tick_module(TickType ticks, ModuleType &tb, VerilatedVcdC &tfp)
{
	tb.eval();
	tfp.dump(ticks*10 - 4); // dump 2ns before tick

	tb.i_clk = 1;
	tb.eval();
	tfp.dump(ticks*10); // tick every 10ns

	tb.i_clk = 0;
	tb.eval();
	tfp.dump(ticks*10 + 5); // trailing edge dump

	tfp.flush();

}


int main(int argc, char const *argv[])
{

	Verilated::commandArgs(argc, argv);
	Verilated::traceEverOn(true);

	VerilatedVcdC tfp{};
	Vled_walker tb{};

	tb.trace(&tfp, 99);
	tfp.open(VCD_FILE);

	uint64_t ticks{};

	for (int i = 0; i < 100; ++i)
	{
		ticks++;
		tick_module(ticks, tb, tfp);

		std::cout << "i " << i << "\n";
		std::cout << "i_clk " << (int)tb.i_clk << "\n";
		std::cout << "o_led " <<  std::bitset<8>(tb.o_leds) << "\n";
		std::cout << "r_counter " << std::bitset<3>(tb.led_walker__DOT__r_counter) << "\n";


	}
	return 0;
}
