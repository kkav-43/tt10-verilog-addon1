/*
 * Half Adder Implementation for Tiny Tapeout
 * Author: Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_half_adder (
    input  wire [1:0] ui_in,    // 2-bit input: A (ui_in[0]), B (ui_in[1])
    output wire [1:0] uo_out,   // 2-bit output: Sum (uo_out[0]), Carry (uo_out[1])
    input  wire [7:0] uio_in,   // IOs: Not used
    output wire [7:0] uio_out,  // IOs: Not used
    output wire [7:0] uio_oe,   // IOs: Not used
    input  wire       ena,      // Enable (always 1)
    input  wire       clk,      // Clock (not used)
    input  wire       rst_n     // Active-low reset (not used)
);

  wire A = ui_in[0];
  wire B = ui_in[1];

  assign uo_out[0] = A ^ B;  // Sum = A XOR B
  assign uo_out[1] = A & B;  // Carry = A AND B

  assign uio_out = 0;  // Unused outputs set to 0
  assign uio_oe = 0;   // All IOs set to input mode

  // Handle unused inputs
  wire _unused = &{ena, clk, rst_n, uio_in};

endmodule
