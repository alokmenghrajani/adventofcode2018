module partx (
  input wire clk,
  output reg LED1,
  output reg LED2,
  output reg LED3
);

reg ready = 0;
wire [22:0] counter1;
wire counter1_done;
reg [19:0] result;

plain_counter #(.WIDTH(23), .VAL(6000000)) plain_counter1 (.clk(clk), .en(ready), .inc(1'b1), .v(counter1), .r(counter1_overflow));

always @(posedge clk) begin
  if (ready == 1) begin
    if (counter1_overflow == 1) begin
      LED1 <= ~LED1;
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
    ready <= 1;
    LED1 <= 0;
    LED2 <= 0;
    result <= 20'b00010;
  end
end

endmodule
