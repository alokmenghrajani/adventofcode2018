module data_exporter_test;

  reg clk = 0;
  reg en = 0;
  reg [27:0] data = 28'b1000_0010_0001_1110_1101_0011_0100;
  wire [7:0] leds;

  data_exporter #(.WIDTH(4), .VAL(5)) dut (.clk(clk), .en(en), .data(data), .leds(leds));

  always #5 clk = !clk;

  initial begin
    $display("start");
    #10 en = 1;
    #10
    if (leds != 8'b1111_1111)
      $display("failed 0: leds=", leds);
    #50
    if (leds != 8'b0011_0100)
      $display("failed 1: leds=", leds);
    #50
    if (leds != 8'b1000_0000)
      $display("failed 2: leds=", leds);
    #50
    if (leds != 8'b0101_1010)
      $display("failed 3: leds=", leds);
    #50
    if (leds != 8'b1000_0000)
      $display("failed 4: leds=", leds);
    #50
    if (leds != 8'b0000_0111)
      $display("failed 5: leds=", leds);
    #50
    if (leds != 8'b1000_0000)
      $display("failed 6: leds=", leds);
    #50
    if (leds != 8'b0100_0001)
      $display("failed 7: leds=", leds);
    #50
    if (leds != 8'b1111_1111)
      $display("failed 8: leds=", leds);

    $display("done");
    $finish;
  end
endmodule
