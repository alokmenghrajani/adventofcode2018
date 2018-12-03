/**
 * 1-bit full adder.
 *
 * Verilog can synthesize addition, but that feels like cheating.
 */
module full_adder (
  a,
  b,
  cin,
  r,
  cout
);

input a;
input b;
input cin;
output r;
output cout;

wire t;
wire c1;
wire c2;

half_adder ha1 (.a(a), .b(b), .r(t), .c(c1));
half_adder ha2 (.a(t), .b(cin), .r(r), .c(c2));
assign cout = c1 | c2;

endmodule
