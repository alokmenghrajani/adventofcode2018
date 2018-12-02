module day01_part2(
  clk,
  en,
  result
);

input clk;
input en;
output reg [63:0] result;
output done;

reg signed [63:0] sum1;
reg [31:0] real_counter1;
reg [15:0] wrapped_counter1;
wire signed [63:0] temp1;

reg signed [63:0] sum2;
reg [31:0] real_counter2;
reg [15:0] wrapped_counter2;
wire signed [63:0] temp2;

reg done;

rom_day01 rom1 (.address(wrapped_counter1), .en(en), .data(temp1));
rom_day01 rom2 (.address(wrapped_counter2), .en(en), .data(temp2));

always @(posedge clk)
  begin
    if (en == 1)
      begin
      if (done == 0)
        begin
          if (real_counter2 != real_counter1) begin
            if (sum1 == sum2) begin
              done <= 1;
              result <= sum1;
            end

            real_counter2 <= real_counter2 + 1;
            if (wrapped_counter2 == 972) begin
              wrapped_counter2 <= 0;
            end else begin
              wrapped_counter2 <= wrapped_counter2 + 1;
            end
            sum2 <= sum2 + temp2;
          end else begin
            real_counter1 <= real_counter1 + 1;
            if (wrapped_counter1 == 972) begin
              wrapped_counter1 <= 0;
            end else begin
              wrapped_counter1 <= wrapped_counter1 + 1;
            end
            sum1 <= sum1 + temp1;
            real_counter2 <= 0;
            wrapped_counter2 <= 0;
            sum2 <= 0;
          end
        end
      end
    else
      begin
        real_counter1 <= 0;
        wrapped_counter1 <= 0;
        sum1 <= 0;

        real_counter2 <= 0;
        wrapped_counter2 <= 0;
        sum2 <= 0;

        done <= 0;
        result <= 0;
      end
  end

endmodule
