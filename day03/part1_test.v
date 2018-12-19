module part1_test;

  reg clk = 0;
  wire [19:0] overlaps;

  part1 dut (.clk(clk));

  always #1 clk = !clk;

  initial begin
    $display("start");
    #10
    $monitor("overlaps=", dut.overlaps, ", done=", dut.done, ", counter3=", dut.counter3);
  end
endmodule
