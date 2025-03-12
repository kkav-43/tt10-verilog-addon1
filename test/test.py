# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_project(dut):
    dut._log.info("Starting Rectangular to Cylindrical Converter Test")

    # Set the clock period to 10ns (100 MHz)
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())

    # Reset the DUT
    dut._log.info("Applying Reset")
    dut.ena.value = 0
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)  # Hold reset
    dut.rst_n.value = 1  # Release reset
    await ClockCycles(dut.clk, 5)   # Allow stabilization

    # Enable the module
    dut.ena.value = 1

    # Test cases: (x, y) → (r, θ)
    test_cases = [
        (3, 4, 5, 53),   # (3,4) -> r ≈ 5, theta ≈ atan(4/3) ~ 53°
        (6, 8, 10, 53),  # (6,8) -> r ≈ 10, theta ≈ atan(8/6) ~ 53°
        (10, 0, 10, 0),  # (10,0) -> r = 10, theta = 0°
        (0, 10, 10, 90), # (0,10) -> r = 10, theta = 90°
        (255, 255, 360, 45),  # Edge case: max values
    ]

    for x, y, expected_r, expected_theta in test_cases:
        dut.ui_in.value = x
        dut.uio_in.value = y
        await ClockCycles(dut.clk, 5)  # Wait for processing
        
        # Read outputs
        r_out = dut.uo_out.value.integer
        theta_out = dut.uio_out.value.integer

        # Log results
        dut._log.info(f"Input: (x={x}, y={y}) -> Output: (r={r_out}, theta={theta_out})")

        # Assertions
        assert r_out == expected_r, f"Error: Expected r={expected_r}, got {r_out}"
        assert theta_out == expected_theta, f"Error: Expected theta={expected_theta}, got {theta_out}"

    dut._log.info("All test cases passed successfully!")
