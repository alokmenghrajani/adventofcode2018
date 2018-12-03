module part2_test;

  reg clk = 0;
  reg en = 0;
  wire signed [63:0] result;

  part2 dut (.clk(clk), .en(en), .result(result));

  always #5 clk = !clk;

  initial begin
    $display("start");
    $monitor("time=%d, clk=%b, en=%b, done=%b, result=%d, sum=%d, dut.real_counter1=%d, dut.real_counter2=%d", $time, clk, dut.en, dut.done,
      result, dut.sum1, dut.real_counter1, dut.real_counter2);

    #10 en = 1;
  end

endmodule
