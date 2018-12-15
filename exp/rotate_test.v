module rotate_test;

  wire LED1;
  wire LED2;
  wire LED3;
  wire LED4;
  wire LED5;

  reg clk = 0;
  always #5 clk = !clk;

  rotate dut (clk, LED1, LED2, LED3, LED4, LED5);

  initial begin
    $display("start");

    #10
    if ((LED1 != 0) || (LED2 != 0) || (LED3 != 0) || (LED4 != 0) || (LED5 != 1))
      $display("failed1 led1=", LED1, ", led2=", LED2, ", led3=", LED3, ", led4=", LED4, ", led5=", LED5);

    #48000010
    if ((LED1 != 1) || (LED2 != 0) || (LED3 != 0) || (LED4 != 0) || (LED5 != 0))
      $display("failed2 led1=", LED1, ", led2=", LED2, ", led3=", LED3, ", led4=", LED4, ", led5=", LED5);

    #48000010
    if ((LED1 != 0) || (LED2 != 1) || (LED3 != 0) || (LED4 != 0) || (LED5 != 0))
      $display("failed3 led1=", LED1, ", led2=", LED2, ", led3=", LED3, ", led4=", LED4, ", led5=", LED5);

    $display("done");
    $finish;
  end

endmodule
