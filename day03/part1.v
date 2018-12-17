module part1 (
  input wire clk,
  output reg LED1,
  output reg LED2,
  output reg LED5
);

reg ready = 0;
reg [19:0] overlaps, result;

wire [10:0] counter1;
wire [9:0] counter2, counter3;
wire [9:0] left, top, w, h;
wire counter1_overflow, counter2_overflow, counter3_overflow, slow_counter_overflow;
wire overlap1;
reg [1:0] overlap2;
reg done;

plain_counter #(.WIDTH(11), .VAL(1236)) plain_counter1 (.clk(clk), .en(ready), .inc(1'b1), .v(counter1), .r(counter1_overflow));
plain_counter #(.WIDTH(10), .VAL(1000)) plain_counter2 (.clk(clk), .en(ready), .inc(counter1_overflow), .v(counter2), .r(counter2_overflow));
plain_counter #(.WIDTH(10), .VAL(1000)) plain_counter3 (.clk(clk), .en(ready), .inc(counter2_overflow), .v(counter3), .r(counter3_overflow));

wire [22:0] slow_counter;
plain_counter #(.WIDTH(23), .VAL(6000000)) plain_counter_slow (.clk(clk), .en(ready), .inc(1'b1), .v(slow_counter), .r(slow_counter_overflow));

rom rom (.clk(clk), .addr(counter1), .left(left), .top(top), .w(w), .h(h));
overlap c (.left(left), .top(top), .w(w), .h(h), .x(counter2), .y(counter3), .r(overlap1));

always @(posedge clk) begin
  if (ready == 1) begin
    if (done == 1) begin
      LED5 <= 1;
      LED1 <= overlaps[0];
      if (slow_counter_overflow == 1) begin
        overlaps <= {overlaps[0], overlaps[19:1]};
        result <= {result[0], result[19:1]};
      end
      if (result == 1) begin
        LED2 <= 1;
      end
      else begin
        LED2 <= 0;
      end
    end
    else begin
      if (slow_counter_overflow == 1) begin
        LED5 <= ~LED5;
      end

      if (counter3_overflow == 1) begin
        done <= 1;
      end

      if (counter2_inc == 1) begin
        if (((overlap1 == 1) && (overlap2 == 1)) || (overlap2 == 2)) begin
          overlaps <= overlaps + 1;
        end
        overlap2 <= 0;
      end
      else begin
        if ((overlap1 == 1) && (overlap2 == 0)) begin
          overlap2 <= 1;
        end
        if ((overlap1 == 1) && (overlap2 == 1)) begin
          overlap2 <= 2;
        end
      end
    end
  end
  else begin
    done <= 0;
    overlaps <= 0;
    overlap2 <= 0;
    ready <= 1;
    result <= 1;
    LED1 <= 0;
    LED2 <= 0;
    LED5 <= 0;
  end
end

endmodule
