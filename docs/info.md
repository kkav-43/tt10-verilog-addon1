<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This project implements a Rectangular to Cylindrical Coordinate Converter. It takes Cartesian coordinates (x, y) as inputs and outputs the corresponding cylindrical coordinates (r, θ).

Mathematical Computation:

  Radius (r) Calculation: : r=√(𝑥^2+𝑦^2 )
  Theta (θ) Approximation : 𝜃=𝑡𝑎𝑛^-1 (𝑦/𝑥)
The angle is scaled to an 8-bit representation.


## How to test

1.Power up the design (Tiny Tapeout environment).
2.Provide inputs (ui_in and uio_in) via the pins:
   ui_in[7:0] → x-coordinate
   uio_in[7:0] → y-coordinate
3.Check the outputs (uo_out and uio_out):
   uo_out[7:0] → Radius (r)
   uio_out[7:0] → Theta (θ, scaled to 8-bit)
4.Verify results using the formulas above.

## External hardware

No external hardware is required; all calculations are performed within the Verilog module using CORDIC-based computation for r and θ.
