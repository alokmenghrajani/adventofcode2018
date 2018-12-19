module part1 (
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
reg [19:0] overlaps;

wire [10:0] counter1;
wire [9:0] counter2, counter3;
wire [9:0] left, top;
wire [4:0] w, h;
wire counter1_overflow, counter2_overflow, counter3_overflow, slow_counter_overflow;
wire overlap1;
reg [1:0] overlap2;
reg done;

plain_counter #(.WIDTH(11), .VAL(1237)) plain_counter1 (.clk(clk), .en(ready), .inc(1'b1), .v(counter1), .r(counter1_overflow));
plain_counter #(.WIDTH(10), .VAL(1000)) plain_counter2 (.clk(clk), .en(ready), .inc(counter1_overflow), .v(counter2), .r(counter2_overflow));
plain_counter #(.WIDTH(10), .VAL(1000)) plain_counter3 (.clk(clk), .en(ready), .inc(counter2_overflow), .v(counter3), .r(counter3_overflow));

rom rom (.clk(clk), .addr(counter1), .left(left), .top(top), .w(w), .h(h));
overlap c (.left(left), .top(top), .w(w), .h(h), .x(counter2), .y(counter3), .r(overlap1));

wire [7:0] leds;
data_exporter data_exporter1 (.clk(clk), .en(ready), .data({8'b0, overlaps}), .leds(leds));
assign leds = {PMOD1, PMOD2, PMOD3, PMOD4, PMOD7, PMOD8, PMOD9, PMOD10};

always @(posedge clk) begin
  if (ready == 1) begin
    LED1 <= 1;
    if (done == 1) begin
      LED5 <= 1;
    end
    else begin
      if (counter3_overflow == 1) begin
        done <= 1;
      end

      if ((overlap1 == 1) && (overlap2 == 0)) begin
        overlap2 = 1;
      end
      else if ((overlap1 == 1) && (overlap2 == 1)) begin
        overlap2 = 2;
      end

      if (counter1_overflow == 1) begin
        if (overlap2 == 2) begin
          overlaps <= overlaps + 1;
        end
        overlap2 = 0;
      end

      if (counter3_overflow == 1) begin
        done <= 1;
      end
    end
  end
  else begin
    done <= 0;
    overlaps <= 0;
    overlap2 <= 0;
    ready <= 1;
    LED1 <= 0;
    LED5 <= 0;
  end
end

endmodule
