import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_half_adder(dut):
    """Test Half Adder"""
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    test_cases = [
        (0, 0, 0, 0),  # A=0, B=0 => Sum=0, Carry=0
        (0, 1, 1, 0),  # A=0, B=1 => Sum=1, Carry=0
        (1, 0, 1, 0),  # A=1, B=0 => Sum=1, Carry=0
        (1, 1, 0, 1)   # A=1, B=1 => Sum=0, Carry=1
    ]

    for A, B, expected_sum, expected_carry in test_cases:
        dut.ui_in.value = (B << 1) | A
        await ClockCycles(dut.clk, 1)

        assert dut.uo_out[0].value == expected_sum, f"Sum failed for A={A}, B={B}"
        assert dut.uo_out[1].value == expected_carry, f"Carry failed for A={A}, B={B}"

