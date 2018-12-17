module overlap (
  input wire [9:0] left,
  input wire [9:0] top,
  input wire [9:0] w,
  input wire [9:0] h,
  input wire [9:0] x,
  input wire [9:0] y,
  output wire r
);

wire [9:0] right;
wire [9:0] bottom;
assign right = left + w;
assign bottom = top + h;

assign r = ((x >= left) && (x < right) && (y >= top) && (y < bottom));

endmodule
