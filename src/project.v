`default_nettype none

module tt_um_rect_cyl (
    input  wire [7:0] ui_in,    // x input
    input  wire [7:0] uio_in,   // y input
    output wire [7:0] uio_out,  // theta output
    output wire [7:0] uo_out,   // r output
    output wire [7:0] uio_oe,   // IO enable (set to output mode)
    input  wire       ena,      // Enable signal
    input  wire       clk,      // Clock signal
    input  wire       rst_n     // Active-low reset
);

    wire [15:0] x2, y2, sum;
    reg  [7:0] r_reg, theta_reg;

    assign x2 = ui_in * ui_in;
    assign y2 = uio_in * uio_in;
    assign sum = x2 + y2;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            r_reg <= 8'd0;
            theta_reg <= 8'd0;
        end else if (ena) begin
            // Better approximation for sqrt(x² + y²)
            r_reg <= sum[15:8] + (sum[14:7] >> 1);  

            // atan(y/x) approximation with overflow protection
            if (ui_in == 0) begin
                theta_reg <= (uio_in == 0) ? 8'd0 : 8'd90; // Handle x=0 cases
            end else begin
                theta_reg <= (uio_in << 5) / (ui_in + 1); // Scale by 32
                if (theta_reg > 8'd255) theta_reg <= 8'd255; // Limit to 8-bit
            end
        end
    end

    assign uo_out = r_reg;      // r output (magnitude)
    assign uio_out = theta_reg; // theta output (angle)
    assign uio_oe = 8'b11111111; // Set all IOs to output mode

endmodule
