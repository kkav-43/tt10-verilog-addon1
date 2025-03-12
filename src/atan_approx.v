module atan_approx (
    input wire [7:0] x,
    input wire [7:0] y,
    output wire [7:0] theta
);
    wire [7:0] abs_x = (x[7]) ? (~x + 1) : x;
    wire [7:0] abs_y = (y[7]) ? (~y + 1) : y;
    wire [7:0] ratio = (abs_x > abs_y) ? (abs_y << 4) / abs_x : (abs_x << 4) / abs_y;
    
    wire [7:0] base_theta = (ratio > 8) ? 45 : (ratio * 45 / 8);
    assign theta = (abs_x > abs_y) ? base_theta : (90 - base_theta);
endmodule
