module part1_test;

  reg clk = 0;
  reg en = 0;
  wire [7:0] pairs;
  wire [7:0] triplets;
  wire [15:0] product;

  part1 dut (.clk(clk), .en(en), .pairs(pairs), .triplets(triplets), .product(product));

  always #5 clk = !clk;

  initial begin
    $display("start");
    $monitor("time=", $time, ", clk=", clk, ", en=", en, ", pairs=", pairs, ", triplets=", triplets, ", product=", product);

    #10 en = 1;
    #10000 $finish;
  end

endmodule
