module bit_counter_test;

  reg [31:0] data = 0;
  wire [5:0] r;

  bit_counter dut (.data(data), .r(r));

  initial begin
    $display("start");

    data = 0; #10
    if (r !== 0)
      $display("failed data=%b", data, ", r=", r);

    data = 1; #10
    if (r !== 1)
      $display("failed data=%b", data, ", r=", r);

    data = 2; #10
    if (r !== 1)
      $display("failed data=%b", data, ", r=", r);

    data = 3; #10
    if (r !== 2)
      $display("failed data=%b", data, ", r=", r);

    data = 1299704331; #10
    if (r !== 18)
      $display("failed data=%b", data, ", r=", r);

    $display("done");
  end

endmodule
