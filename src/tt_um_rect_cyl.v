`default_nettype none
`timescale 1ns / 1ps

module tt_um_rect_cyl (
    input wire [7:0] ui_in,    // X input (8-bit)
    input wire [7:0] uio_in,   // Y input (8-bit)
    output wire [7:0] uo_out,  // R output (8-bit magnitude)
    output wire [7:0] uio_out, // Theta output (8-bit angle)
    output wire [7:0] uio_oe,  // Output Enable
    input wire ena,            // Enable signal
    input wire clk,            // Clock signal
    input wire rst_n           // Active-low reset
);

    wire [7:0] r, theta;

    sqrt_approx sqrt_inst (
        .x(ui_in),
        .y(uio_in),
        .r(r)
    );

    atan_approx atan_inst (
        .x(ui_in),
        .y(uio_in),
        .theta(theta)
    );

    assign uo_out = ena ? r : 8'b0;
    assign uio_out = ena ? theta : 8'b0;
    assign uio_oe = 8'b0; // All inputs by default

endmodule
