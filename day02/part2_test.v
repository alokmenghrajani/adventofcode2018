module part2_test;

  reg clk = 0;
  reg en = 0;
  wire [15:0] output1;
  wire [15:0] output2;

  part2 dut (.clk(clk), .en(en), .output1(output1), .output2(output2));

  always #5 clk = !clk;

  initial begin
    $display("start");
    $monitor("time=", $time, ", clk=", clk, ", en=", en, ", output1=", output1, ", output2=", output2);
    //$monitor("time=", $time, ", clk=", clk, ", en=", en, ", counter1=", dut.counter1, ", counter2=", dut.counter2, ", r=", dut.r);

    #10 en = 1;
    #625000 $finish;
  end

endmodule
