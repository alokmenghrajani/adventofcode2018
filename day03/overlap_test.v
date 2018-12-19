module overlap_test;

  reg [9:0] left;
  reg [9:0] top;
  reg [4:0] w;
  reg [4:0] h;

  reg [9:0] x;
  reg [9:0] y;
  wire r;

  overlap dut (.left(left), .top(top), .w(w), .h(h), .x(x), .y(y), .r(r));

  initial begin
    $display("start");

    left = 10'd3;
    top = 10'd1;
    w = 5'd4;
    h = 5'd4;
    x = 4; y = 4; #10
    if (r != 1)
      $display("failed pos=", left, top, w, h, ", x=", x, ", y=", y, ", r=", r);

    x = 4; y = 5; #10
    if (r != 0)
      $display("failed pos=", left, top, w, h, ", x=", x, ", y=", y, ", r=", r);

    $display("done");
  end

endmodule
