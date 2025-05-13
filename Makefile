# Makefile for tlv5618_driver
SRC_DIR = src
BUILD_DIR = build
TARGET = $(BUILD_DIR)/sim.out
VCD = wave.vcd
SRC = $(SRC_DIR)/tlv5618_driver_tb.v $(SRC_DIR)/tlv5618_driver.v

all: $(VCD)
	gtkwave $(VCD)

$(TARGET): $(SRC)
	mkdir -p $(BUILD_DIR)
	iverilog -o $(TARGET) $(SRC)

$(VCD): $(TARGET)
	vvp $(TARGET)

clean:
	rm -rf $(BUILD_DIR) $(VCD)
