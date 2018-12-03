/**
 * Half-adder.
 *
 * Verilog can synthesize addition, but that feels like cheating.
 */
module half_adder (
  a,
  b,
  r,
  c
);

input a;
input b;
output r;
output c;

assign r = a ^ b;
assign c = a & b;

endmodule
