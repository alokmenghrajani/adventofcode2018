module part1 (
  clk,
  en,
  pairs,
  triplets,
  product
);

input clk;
input en;
output [7:0] pairs;
output [7:0] triplets;
output [15:0] product;
reg [7:0] pairs;
reg [7:0] triplets;

reg [15:0] counter;
wire [25:0][7:0] temp;
wire pair;
wire triplet;

rom rom (.address(counter), .en(en), .data(temp));

checker c (.data(temp), .pair(pair), .triplet(triplet));

always @(posedge clk)
  begin
    if (en == 1)
      begin
      if (counter != 250)
        begin
          counter <= counter + 1;
          pairs <= pairs + pair;
          triplets <= triplets + triplet;
        end
      end
    else
      begin
        counter <= 0;
        pairs <= 0;
        triplets <= 0;
      end
  end

assign product = pairs * triplets;

endmodule
