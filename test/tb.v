`timescale 1ns / 1ps

module tb ();

    reg clk, rst_n, ena;
    reg [7:0] ui_in, uio_in;
    wire [7:0] uo_out, uio_out;

    tt_um_rect_cyl uut (
        .ui_in(ui_in),
        .uio_in(uio_in),
        .uo_out(uo_out),
        .uio_out(uio_out),
        .ena(ena),
        .clk(clk),
        .rst_n(rst_n)
    );

    always #5 clk = ~clk; // 10ns clock period (100MHz)

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);
        
        clk = 0; rst_n = 0; ena = 0; ui_in = 0; uio_in = 0;
        #20 rst_n = 1; ena = 1;
        
        #10 ui_in = 8'd3; uio_in = 8'd4; // Expect r ≈ 5, θ ≈ atan(4/3)
        #20 ui_in = 8'd6; uio_in = 8'd8; // Expect r ≈ 10, θ ≈ atan(8/6)
        #20 ui_in = 8'd10; uio_in = 8'd0;// Expect r ≈ 10, θ ≈ 0
        #20;
        $finish;
    end

endmodule
