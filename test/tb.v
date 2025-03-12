`default_nettype none
`timescale 1ns / 1ps

module tb ();

  // Dump waveforms
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
  end

  // Clock generation
  reg clk = 0;
  always #5 clk = ~clk;  // 10ns clock period (100MHz)

  // Declare inputs and outputs
  reg rst_n, ena;
  reg [7:0] ui_in, uio_in;
  wire [7:0] uo_out, uio_out, uio_oe;

`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // Instantiate the module under test
  tt_um_rect_cyl uut (
`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif
      .ui_in  (ui_in),
      .uio_in (uio_in),
      .uio_out(uio_out),
      .uo_out (uo_out),
      .uio_oe (uio_oe),
      .ena    (ena),
      .clk    (clk),
      .rst_n  (rst_n)
  );

  // Monitor signals
  initial begin
    $monitor("Time: %0t | X: %d, Y: %d -> R: %d, Theta: %d",
             $time, ui_in, uio_in, uo_out, uio_out);
  end

  // Test sequence
  initial begin
    // Initialize signals
    rst_n = 0; ena = 0; ui_in = 0; uio_in = 0;
    #20;
    
    rst_n = 1;  // Release reset
    #10;        // Allow system to stabilize
    ena = 1;    // Enable module
    
    // Apply test inputs
    #10 ui_in = 8'd3;  uio_in = 8'd4;   // Expect r ≈ 5, theta ≈ atan(4/3)
    #20 ui_in = 8'd6;  uio_in = 8'd8;   // Expect r ≈ 10, theta ≈ atan(8/6)
    #20 ui_in = 8'd10; uio_in = 8'd0;   // Expect r ≈ 10, theta ≈ 90°
    #20 ui_in = 8'd0;  uio_in = 8'd10;  // Expect r ≈ 10, theta ≈ 0°
    #20 ui_in = 8'd255; uio_in = 8'd255; // Edge case: max values
    #20 ui_in = 8'd0;   uio_in = 8'd0;   // Edge case: both zero
    #20;

    $finish;
  end

endmodule
