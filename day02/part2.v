module part2 (
  clk,
  en,
  output1,
  output2
);

input clk;
input en;
output [15:0] output1;
output [15:0] output2;

reg [15:0] output1;
reg [15:0] output2;
reg [15:0] counter1;
reg [15:0] counter2;
wire [25:0][7:0] temp1;
wire [25:0][7:0] temp2;
wire [5:0] r;

rom rom1 (.address(counter1), .en(en), .data(temp1));
rom rom2 (.address(counter2), .en(en), .data(temp2));

delta d (.a(temp1), .b(temp2), .r(r));

always @(posedge clk)
  begin
    if (en == 1)
      begin
      if (counter2 != counter1) begin
        counter2 <= counter2 + 1;
        if (r === 25) begin
          output1 <= counter1;
          output2 <= counter2;
        end
      end
      else if (counter1 != 250)
        begin
          counter1 <= counter1 + 1;
          counter2 <= 0;
        end
      end
    else
      begin
      counter1 <= 0;
      counter2 <= 0;
      output1 <= 0;
      output2 <= 0;
      end
  end
endmodule
