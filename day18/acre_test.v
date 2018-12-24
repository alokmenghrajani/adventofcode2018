module acre_test;
  reg clk = 0;
  always #1 clk = !clk;
  reg en = 0;

  reg [1:0] top_left = 2'b10, top = 2'b01, top_right = 2'b00;
  reg [1:0] left = 2'b01, right = 2'b10;
  reg [1:0] bottom_left = 2'b00, bottom = 2'b01, bottom_right = 2'b00;
  reg [1:0] init = 2'b10;
  wire [1:0] state;

  acre dut (.clk(clk), .en(en), .top_left(top_left), .top(top), .top_right(top_right), .left(left), .right(right), .bottom_left(bottom_left), .bottom(bottom), .bottom_right(bottom_right), .init(init), .state(state));

  initial begin
    $display("start");
    #10
    en = 1; #2

    if (state != 1)
      $display("failed state=%b", state);

    $display("done");
    $finish;
  end

endmodule
