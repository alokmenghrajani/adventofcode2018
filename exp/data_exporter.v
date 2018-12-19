module part1c (
  input wire clk,
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

wire [7:0] leds;
data_exporter data_exporter1 (.clk(clk), .en(ready), .data({8'b0, overlaps}), .leds(leds));
//assign leds = overlaps[7:0];
assign leds = {PMOD1, PMOD2, PMOD3, PMOD4, PMOD7, PMOD8, PMOD9, PMOD10};

always @(posedge clk) begin
  if (ready == 1) begin
    LED5 <= 1;
  end
  else begin
    ready <= 1;
    LED5 <= 0;
    overlaps <= 20'b0110_1001_0110_1001_0110;
  end
end

endmodule
