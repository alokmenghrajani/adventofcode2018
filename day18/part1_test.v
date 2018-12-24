module part1_test;

  reg clk = 0;
  always #1 clk = !clk;
  reg en = 0;

  wire [2499:0] trees;
  wire [2499:0] lumberyards;

  field dut (.clk(clk), .en(en), .trees(trees), .lumberyards(lumberyards));

  integer i, j;

  initial begin
    $display("start");
    #10
    en = 1;

    // after 10 iterations
    #20
    for (i=0; i<50; i = i+1) begin
      for (j=0; j<50; j = j+1) begin
        if ((trees[i*50+j] == 0) && (lumberyards[i*50+j]==0))
          $write(".");
        else if ((trees[i*50+j] == 1) && (lumberyards[i*50+j]==0))
          $write("|");
        else if ((trees[i*50+j] == 0) && (lumberyards[i*50+j]==1))
          $write("#");
        else
          $write("E");
      end
      $display();
    end
    $display();

    $display("tree=%b", trees);
    $display("lumberyards=%b", lumberyards);

    $finish;
  end
endmodule
