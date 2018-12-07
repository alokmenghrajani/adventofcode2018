module overlap (
  data,
  x,
  y,
  r
);
input [0:3][9:0] data;
input [9:0] x;
input [9:0] y;
output r;

wire [9:0] left;
wire [9:0] top;
wire [9:0] right;
wire [9:0] bottom;

assign left = data[0];
assign top = data[1];
assign right = left + data[2];
assign bottom = top + data[3];

assign r = ((x >= left) && (x < right) && (y >= top) && (y < bottom));

endmodule
