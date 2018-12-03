module full_adder_test;

  reg a = 0;
  reg b = 0;
  reg cin = 0;
  wire r;
  wire cout;

  full_adder dut (.a(a), .b(b), .cin(cin), .r(r), .cout(cout));

  initial begin
    $display("start");

    a = 0; b = 0; cin = 0; #10
    if ((r !== 0) || (cout !== 0))
      $display("failed a=", a, ", b=", b, ", cin=", cin, ", r=", r, ", cout=", cout);

    a = 1; b = 0; cin = 0; #10
    if ((r !== 1) || (cout !== 0))
      $display("failed a=", a, ", b=", b, ", cin=", cin, ", r=", r, ", cout=", cout);

    a = 0; b = 1; cin = 0; #10
    if ((r !== 1) || (cout !== 0))
      $display("failed a=", a, ", b=", b, ", cin=", cin, ", r=", r, ", cout=", cout);

    a = 1; b = 1; cin = 0; #10
    if ((r !== 0) || (cout !== 1))
      $display("failed a=", a, ", b=", b, ", cin=", cin, ", r=", r, ", cout=", cout);

    a = 0; b = 0; cin = 1; #10
    if ((r !== 1) || (cout !== 0))
      $display("failed a=", a, ", b=", b, ", cin=", cin, ", r=", r, ", cout=", cout);

    a = 1; b = 0; cin = 1; #10
    if ((r !== 0) || (cout !== 1))
      $display("failed a=", a, ", b=", b, ", cin=", cin, ", r=", r, ", cout=", cout);

    a = 0; b = 1; cin = 1; #10
    if ((r !== 0) || (cout !== 1))
      $display("failed a=", a, ", b=", b, ", cin=", cin, ", r=", r, ", cout=", cout);

    a = 1; b = 1; cin = 1; #10
    if ((r !== 1) || (cout !== 1))
      $display("failed a=", a, ", b=", b, ", cin=", cin, ", r=", r, ", cout=", cout);

    $display("done");
  end

endmodule
