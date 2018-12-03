module half_adder_test;

  reg a = 0;
  reg b = 0;
  wire r;
  wire c;

  half_adder dut (.a(a), .b(b), .r(r), .c(c));

  initial begin
    $display("start");

    a = 0; b = 0; #10
    if ((r !== 0) || (c !== 0))
      $display("failed a=", a, ", b=", b, ", r=", r, ", c=", c);

    a = 1; b = 0; #10
    if ((r !== 1) || (c !== 0))
      $display("failed a=", a, ", b=", b, ", r=", r, ", c=", c);

    a = 0; b = 1; #10
    if ((r !== 1) || (c !== 0))
      $display("failed a=", a, ", b=", b, ", r=", r, ", c=", c);

    a = 1; b = 1; #10
    if ((r !== 0) || (c !== 1))
      $display("failed a=", a, ", b=", b, ", r=", r, ", c=", c);

    $display("done");
  end

endmodule
