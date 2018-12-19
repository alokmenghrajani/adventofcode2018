module part2_test;

  reg clk = 0;
  wire [10:0] solution;

  part2 dut (.clk(clk));

  always #1 clk = !clk;

  initial begin
    $monitor("solution (off by one)=", dut.solution, ", done=", dut.done, ", counter2=", dut.counter2);
  end

  always @(posedge clk) begin
    if (dut.done == 1) begin
      $finish;
    end
  end
endmodule
