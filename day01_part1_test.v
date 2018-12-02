module day01_part1_test;

  reg clk = 0;
  reg en = 0;
  wire signed [63:0] result;

  day01_part1 dut (.clk(clk), .en(en), .result(result));

  always #5 clk = !clk;

  initial begin
    $display("start");
    $monitor("time=%d, clk=%b, en=%b, result=%d, dut.counter=%d, dut.temp=%d", $time, clk, dut.en, result, dut.counter, dut.temp);

    #10 en = 1;

    #10000 $finish;
  end

endmodule
