module part1 (
  clk,
  en,
  result
);

input clk;
input en;
output [63:0] result;

reg signed [63:0] sum;
reg [15:0] counter;
wire signed [63:0] temp;

rom r (.address(counter), .en(en), .data(temp));

always @(posedge clk)
  begin
    if (en == 1)
      begin
      if (counter != 973)
        begin
          counter <= counter + 1;
          sum <= sum + temp;
        end
      end
    else
      begin
        counter <= 0;
        sum <= 0;
      end
  end

assign result = sum;

endmodule
