<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This project implements a Half Adder, a basic combinational circuit that adds two binary digits (A and B). The outputs are:

Sum (S) = A ⊕ B (XOR operation)
Carry (Cout) = A & B (AND operation)
Truth Table
A	B	Sum (A ⊕ B)	Carry (A & B)
0	0	0	0
0	1	1	0
1	0	1	0
1	1	0	1


## How to test

Power up the design (Tiny Tapeout environment).
Provide two binary inputs (A and B) via the ui_in pins:
ui_in[0] → A (First input bit)
ui_in[1] → B (Second input bit)
Check the outputs (uo_out):
uo_out[0] → Sum (A ⊕ B)
uo_out[1] → Carry (A & B)
Verify the output against the expected truth table.


## External hardware

No external hardware is required; all logic is implemented in the Verilog module.
