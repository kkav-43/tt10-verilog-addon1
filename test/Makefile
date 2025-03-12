# Makefile for cocotb-based simulation
# See https://docs.cocotb.org/en/stable/quickstart.html for more info

# Defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog
SRC_DIR = $(PWD)/../src
PROJECT_SOURCES = project.v
TB_SOURCE = tb.v
TEST_MODULE = test

# Define Simulation Build Directory
ifeq ($(GATES),yes)
    SIM_BUILD = sim_build/gl

    # Gate-level simulation settings
    COMPILE_ARGS += -DGL_TEST -DFUNCTIONAL -DUSE_POWER_PINS -DSIM -DUNIT_DELAY=\#1

    # Include Sky130 standard cell libraries
    VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v
    VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v

    # Include gate-level netlist
    VERILOG_SOURCES += $(SRC_DIR)/gate_level_netlist.v
else
    SIM_BUILD = sim_build/rtl

    # RTL Simulation sources
    VERILOG_SOURCES += $(addprefix $(SRC_DIR)/, $(PROJECT_SOURCES))
endif

# Allow configuration sharing between design and testbench
COMPILE_ARGS += -I$(SRC_DIR)

# Include the testbench source
VERILOG_SOURCES += $(PWD)/$(TB_SOURCE)
TOPLEVEL = tb

# Test module name
MODULE = $(TEST_MODULE)

# Include cocotb's make rules to handle the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
