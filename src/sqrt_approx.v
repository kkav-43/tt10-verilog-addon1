module sqrt_approx (
    input wire [7:0] x,
    input wire [7:0] y,
    output wire [7:0] r
);
    wire [7:0] abs_x = (x[7]) ? (~x + 1) : x; // Absolute value
    wire [7:0] abs_y = (y[7]) ? (~y + 1) : y; // Absolute value

    wire [7:0] max_xy = (abs_x > abs_y) ? abs_x : abs_y;
    wire [7:0] min_xy = (abs_x > abs_y) ? abs_y : abs_x;

    assign r = max_xy + (min_xy >> 1); // r ≈ max(|x|, |y|) + min(|x|, |y|) / 2
endmodule
