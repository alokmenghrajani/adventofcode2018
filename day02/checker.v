module checker (
  data,
  pair,
  triplet,
);
input [25:0][7:0] data;
output pair;
output triplet;

// create a matrix of 26 x 26 comparisons

wire [25:0][25:0] cells;
wire [25:0][5:0] counts;

genvar i;
genvar j;
for (i=0; i<26; i = i + 1) begin
  for (j=0; j<26; j = j + 1) begin
    assign cells[i][j] = (data[i] === data[j]);
  end
end

// for each row, count the number of bits

for (i=0; i<26; i = i + 1) begin
  bit_counter t (.data({6'b0, cells[i]}), .r(counts[i]));
end

// check if any counts results in 2 or 3

wire [0:25] p;
wire [0:25] t;

assign p[0] = (counts[0] === 2);
assign t[0] = (counts[0] === 3);

for (i=1; i<26; i = i + 1) begin
  assign p[i] = ((counts[i] === 2) | p[i-1]);
  assign t[i] = ((counts[i] === 3) | t[i-1]);
end

assign pair = p[25];
assign triplet = t[25];

endmodule
