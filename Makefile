PCF_FILE        =  test.pcf
VCD_FILE 		=  build/test.vcd
SYNTH_V_SRCS    =  led_walker.v
SYNTH_TOP_MODULE=  led_walker
YOSYS_FLAGS     =  -p 'synth_ice40 -json $(OUTPUT_JSON)'
NEXTPNR_FLAGS   =  --hx8k --package ct256 --pcf-allow-unconstrained

BUILD_DIR       =  synth_build
OUTPUT_ASC      =  $(BUILD_DIR)/test.asc
OUTPUT_JSON     =  $(BUILD_DIR)/test.json
OUTPUT_BIN      =  $(BUILD_DIR)/test.bin

clean:
	rm -rf $(BUILD_DIR)

synth: $(SYNTH_V_SRCS)
	mkdir -p $(BUILD_DIR)
	yosys $(YOSYS_FLAGS) $(SYNTH_V_SRCS)
	nextpnr-ice40 $(NEXTPNR_FLAGS) --top $(SYNTH_TOP_MODULE) --pcf $(PCF_FILE) --json $(OUTPUT_JSON) --asc $(OUTPUT_ASC) 
	icepack $(OUTPUT_ASC) $(OUTPUT_BIN)

view_vcd: $(VCD_FILE)
	gtkwave $(VCD_FILE)