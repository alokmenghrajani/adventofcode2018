module part1_test;

  reg clk = 0;
  reg en = 0;
  wire [19:0] overlaps;

  part1 dut (.clk(clk), .en(en), .overlaps(overlaps));

  always #1 clk = !clk;

  initial begin
    $display("start");
    $monitor("overlaps=", overlaps, ", done=", dut.done, ", counter3=", dut.counter3);
    #2 en = 1;
  end
endmodule
