/**
 * Takes a 32-bit data and returns the number of bits set to 1.
 */
module bit_counter (
  data,
  r
);

input [31:0] data;
output [5:0] r;

// the first layer is 16 half-adders, resulting in 16 2-bit results
// layer 2 is 8 2-bit adders, resulting in 8 3-bit results
// layer 3 is 4 3-bit adders, resulting in 4 4-bit results
// layer 4 is 2 4-bit adders, resulting in 2 5-bit results
// and then finally, we use a 5-bit adder, resulting in 6-bit result

wire [15:0][1:0] layer1;
wire [7:0][2:0] layer2;
wire [3:0][3:0] layer3;
wire [2:0][4:0] layer4;

genvar i;
for (i=0; i<16; i = i + 1) begin
  half_adder t (.a(data[i*2]), .b(data[i*2+1]), .r(layer1[i][0]), .c(layer1[i][1]));
end
for (i=0; i<8; i = i + 1) begin
  assign layer2[i] = layer1[i*2] + layer1[i*2+1];
end
for (i=0; i<4; i = i + 1) begin
  assign layer3[i] = layer2[i*2] + layer2[i*2+1];
end
for (i=0; i<2; i = i + 1) begin
  assign layer4[i] = layer3[i*2] + layer3[i*2+1];
end
assign r = layer4[0] + layer4[1];

endmodule
