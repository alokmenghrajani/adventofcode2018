module part1 (
  input clk,
  input en,
  output [19:0] overlaps
);

reg [19:0] overlaps;

wire [10:0] counter1;
wire [9:0] counter2;
wire [9:0] counter3;
wire [0:3][9:0] temp;
wire counter2_inc, counter3_inc, t, overlap1;
reg [1:0] overlap2;
reg done;

plain_counter #(.WIDTH(11), .VAL(1236)) plain_counter1 (.clk(clk), .en(en), .inc(1'b1), .v(counter1), .r(counter2_inc));
plain_counter #(.WIDTH(10), .VAL(1000)) plain_counter2 (.clk(clk), .en(en), .inc(counter2_inc), .v(counter2), .r(counter3_inc));
plain_counter #(.WIDTH(10), .VAL(1000)) plain_counter3 (.clk(clk), .en(en), .inc(counter3_inc), .v(counter3), .r(t));
rom rom (.address(counter1), .en(en), .data(temp));
overlap c (.data(temp), .x(counter2), .y(counter3), .r(overlap1));

always @(posedge clk) begin
  if (en == 1) begin
    if (t == 1) begin
      done <= 1;
    end
    if (counter2_inc == 1) begin
      if (done == 0) begin
        if (((overlap1 == 1) && (overlap2 == 1)) || (overlap2 == 2)) begin
          overlaps <= overlaps + 1;
        end
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
  else begin
    done <= 0;
    overlaps <= 0;
    overlap2 <= 0;
  end
end

endmodule
