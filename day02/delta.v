/**
 * Outputs number of bytes difference between a and b.
 */
module delta (
  a,
  b,
  r
);
input [25:0][7:0] a;
input [25:0][7:0] b;
output [5:0] r;

wire [25:0] cells;
genvar i;
for (i=0; i<26; i = i + 1) begin
  assign cells[i] = (a[i] === b[i]);
end

bit_counter t (.data({6'b0, cells}), .r(r));

endmodule
