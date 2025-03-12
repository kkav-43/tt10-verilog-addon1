SIM ?= icarus
TOPLEVEL_LANG ?= verilog
SRC_DIR = $(PWD)/../src
PROJECT_SOURCES = tt_um_rect_cyl.v sqrt_approx.v atan_approx.v project.v
TB_SOURCE = tb.v
TEST_MODULE = test

ifeq ($(GATES),yes)
    SIM_BUILD = sim_build/gl
    COMPILE_ARGS += -DGL_TEST -DFUNCTIONAL -DUSE_POWER_PINS -DSIM -DUNIT_DELAY=\#1
    VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v
    VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v
    VERILOG_SOURCES += $(SRC_DIR)/gate_level_netlist.v
else
    SIM_BUILD = sim_build/rtl
    VERILOG_SOURCES += $(addprefix $(SRC_DIR)/, $(PROJECT_SOURCES))
endif

COMPILE_ARGS += -I$(SRC_DIR)
VERILOG_SOURCES += $(PWD)/$(TB_SOURCE)
TOPLEVEL = tb
MODULE = $(TEST_MODULE)
include $(shell cocotb-config --makefiles)/Makefile.sim
