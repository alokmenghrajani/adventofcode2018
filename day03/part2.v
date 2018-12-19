module part2 (
  input wire clk,
  output reg LED1,
  output reg LED5,
  output wire PMOD1,
  output wire PMOD2,
  output wire PMOD3,
  output wire PMOD4,
  output wire PMOD7,
  output wire PMOD8,
  output wire PMOD9,
  output wire PMOD10
);

reg ready = 0;
reg [10:0] solution;

wire [10:0] counter1, counter2;
wire [9:0] left1, left2, top1, top2, right1, right2, bottom1, bottom2;
wire [4:0] w1, w2, h1, h2;
wire counter1_overflow, counter2_overflow;
reg overlap1;
reg done;

plain_counter #(.WIDTH(11), .VAL(1237)) plain_counter1 (.clk(clk), .en(ready), .inc(1'b1), .v(counter1), .r(counter1_overflow));
plain_counter #(.WIDTH(11), .VAL(1237)) plain_counter2 (.clk(clk), .en(ready), .inc(counter1_overflow), .v(counter2), .r(counter2_overflow));

rom rom1 (.clk(clk), .addr(counter1), .left(left1), .top(top1), .w(w1), .h(h1));
rom rom2 (.clk(clk), .addr(counter2), .left(left2), .top(top2), .w(w2), .h(h2));

wire [7:0] leds;
data_exporter data_exporter1 (.clk(clk), .en(ready), .data({17'b0, solution}), .leds(leds));
assign leds = {PMOD1, PMOD2, PMOD3, PMOD4, PMOD7, PMOD8, PMOD9, PMOD10};

assign right1 = left1 + w1;
assign bottom1 = top1 + h1;
assign right2 = left2 + w2;
assign bottom2 = top2 + h2;

always @(posedge clk) begin
  if (ready == 1) begin
    LED1 <= 1;
    if (done == 1) begin
      LED5 <= 1;
    end
    else begin
      if (!((left1 >= right2) | (right1 <= left2) | (top1 >= bottom2) | (bottom1 <= top2))) begin
        if (counter1 != counter2) begin
          overlap1 = 1;
        end
      end

      if (counter1_overflow) begin
        if (overlap1 == 0) begin
          solution <= counter2;
        end
        overlap1 = 0;
      end

      if (counter2_overflow == 1) begin
        done <= 1;
      end
    end
  end
  else begin
    done <= 0;
    solution <= 0;
    overlap1 <= 0;
    ready <= 1;
    LED1 <= 0;
    LED5 <= 0;
  end
end

endmodule
