module plain_counter_test;

  reg clk = 0;
  reg en = 0;
  wire [3:0] v1, v2, v3;
  wire r1, r2, r3;

  plain_counter #(.WIDTH(4), .VAL(5)) dut1 (.clk(clk), .en(en), .inc(1'b1), .v(v1), .r(r1));
  plain_counter #(.WIDTH(4), .VAL(2)) dut2 (.clk(clk), .en(en), .inc(r1), .v(v2), .r(r2));
  plain_counter #(.WIDTH(4), .VAL(2)) dut3 (.clk(clk), .en(en), .inc(r2), .v(v3), .r(r3));

  always #5 clk = !clk;

  initial begin
    $display("start");

    #10 en = 1;
    if ((v1 !== 0) || (r1 !== 0) || (v2 !== 0) || (r2 !== 0) || (v3 !== 0) || (r3 !== 0))
      $display("failed time=", $time, ", v1=", v1, ", r1=", r1, ", v2=", v2, ", r2=", r2, ", v3=", v3, ", r3=", r3);

    #10
    if ((v1 !== 1) || (r1 !== 0) || (v2 !== 0) || (r2 !== 0) || (v3 !== 0) || (r3 !== 0))
      $display("failed time=", $time, ", v1=", v1, ", r1=", r1, ", v2=", v2, ", r2=", r2, ", v3=", v3, ", r3=", r3);

    #30
    if ((v1 !== 4) || (r1 !== 1) || (v2 !== 0) || (r2 !== 0) || (v3 !== 0) || (r3 !== 0))
      $display("failed time=", $time, ", v1=", v1, ", r1=", r1, ", v2=", v2, ", r2=", r2, ", v3=", v3, ", r3=", r3);

    #10
    if ((v1 !== 0) || (r1 !== 0) || (v2 !== 1) || (r2 !== 0) || (v3 !== 0) || (r3 !== 0))
      $display("failed time=", $time, ", v1=", v1, ", r1=", r1, ", v2=", v2, ", r2=", r2, ", v3=", v3, ", r3=", r3);

    #40
    if ((v1 !== 4) || (r1 !== 1) || (v2 !== 1) || (r2 !== 1) || (v3 !== 0) || (r3 !== 0))
      $display("failed time=", $time, ", v1=", v1, ", r1=", r1, ", v2=", v2, ", r2=", r2, ", v3=", v3, ", r3=", r3);

    #10
    if ((v1 !== 0) || (r1 !== 0) || (v2 !== 0) || (r2 !== 0) || (v3 !== 1) || (r3 !== 0))
      $display("failed time=", $time, ", v1=", v1, ", r1=", r1, ", v2=", v2, ", r2=", r2, ", v3=", v3, ", r3=", r3);

    $display("done");
    $finish;
  end

endmodule
