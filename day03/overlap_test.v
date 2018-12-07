module overlap_test;

  reg [0:3][9:0] data;
  reg [9:0] x;
  reg [9:0] y;
  wire r;

  overlap dut (.data(data), .x(x), .y(y), .r(r));

  initial begin
    $display("start");

    data = {10'd3, 10'd1, 10'd4, 10'd4};
    x = 4; y = 4; #10
    if (r != 1)
      $display("failed data=", data[0], data[1], data[2], data[3], ", x=", x, ", y=", y, ", r=", r);

    x = 4; y = 5; #10
    if (r != 0)
      $display("failed data=", data[0], data[1], data[2], data[3], ", x=", x, ", y=", y, ", r=", r);

    $display("done");
  end

endmodule
