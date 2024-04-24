#include <iostream>
#include <Vled_walker.h>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include <cassert>
#include <optional>
#include <cstdint>
#include <bitset>
#include <random>

#define VCD_FILE "test.vcd"

template <typename TickType,typename ModuleType>
void tick_module(TickType& ticks, ModuleType &tb, VerilatedVcdC &tfp)
{
	ticks++;

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

template<typename ModuleType, typename TickType, typename T, typename U>
T wishbone_read(ModuleType& tb, VerilatedVcdC& tfp, TickType& ticks, U addr){
	tb.i_cyc = 1;
	tb.eval();
	tb.i_stb = 1;
	tb.eval();

	while(tb.o_stall){
		tick_module(ticks, tb, tfp);
	}

	tick_module(ticks, tb, tfp);
	tb.i_stb = 0;
	tb.eval();

	while(!tb.o_ack){
		tick_module(ticks,tb,tfp);
	}
	tb.i_cyc = 0;
	tb.eval();
	return tb.o_data();
}

template<typename ModuleType, typename TickType, typename T, typename U>
void wishbone_write(ModuleType& tb, VerilatedVcdC& tfp, TickType& ticks, U addr, T data){
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

	while(tb.o_stall){
		tick_module(ticks, tb, tfp);
	}

	tick_module(ticks, tb, tfp);
	tb.i_stb = 0;
	tb.eval();

	while(!tb.o_ack){
		tick_module(ticks, tb, tfp);
	}
	tb.i_cyc = 0;
	tb.eval();
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

	std::random_device dev;
    std::mt19937 rng(dev());
    std::uniform_int_distribution<std::mt19937::result_type> distribution(0,10000); // distribution in range [1, 6]

	auto random_wishbone_write_addr = std::bitset<3>(distribution(rng)).to_ullong();
	wishbone_write(tb, tfp, ticks, random_wishbone_write_addr, 1);
	assert ( std::bitset<8>(tb.o_data).test(random_wishbone_write_addr) == 1);
	tick_module(ticks, tb, tfp);
	std::cout << std::bitset<8>(tb.o_data) << "\n";
	tick_module(ticks, tb, tfp);
	tick_module(ticks, tb, tfp);
	tick_module(ticks, tb, tfp);

	return 0;
}
