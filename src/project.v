`default_nettype none

module tt_um_addon (
    input  wire [7:0] ui_in,     // X input
    input  wire [7:0] uio_in,    // Y input
    output reg  [7:0] uo_out,    // Approximate square root output
    output wire [7:0] uio_out,   // IOs: Output path
    output wire [7:0] uio_oe,    // IOs: Enable path
    input  wire       ena,       // Enable (ignored)
    input  wire       clk,       // Clock signal
    input  wire       rst_n      // Active-low reset
);

    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    reg [15:0] sum_squares;
    reg [15:0] estimate;
    reg [15:0] b;
    reg [7:0] sqrt_approx;
    integer i;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            uo_out       <= 8'd0;
            sqrt_approx  <= 8'd0;
            sum_squares  <= 16'd0;
            estimate     <= 16'd0;
            b            <= 16'd0;
        end else begin
            // Initialize
            sum_squares <= (ui_in * ui_in) + (uio_in * uio_in);
            estimate    <= 0;
            b           <= 16'h4000;  // Highest power of 4 under 16-bit

            // Adjust b to be less than or equal to sum_squares
            for (i = 0; i < 15; i = i + 1) begin
                if (b > sum_squares)
                    b <= b >> 2;
            end

            // Bitwise sqrt approximation
            for (i = 0; i < 15; i = i + 1) begin
                if (b != 0) begin
                    if (sum_squares >= (estimate + b)) begin
                        sum_squares <= sum_squares - (estimate + b);
                        estimate    <= (estimate >> 1) + b;
                    end else begin
                        estimate <= estimate >> 1;
                    end
                    b <= b >> 2;
                end
            end

            sqrt_approx <= estimate[7:0];
            uo_out      <= estimate[7:0];
        end
    end

    wire _unused = &{ena, 1'b0};

endmodule
