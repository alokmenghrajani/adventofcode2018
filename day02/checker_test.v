module checker_test;

  reg [25:0][7:0] data;
  wire pair;
  wire triplet;

  checker dut (.data(data), .pair(pair), .triplet(triplet));

  initial begin
    $display("start");

    data[0] = 119; data[1] = 108; data[2] = 112; data[3] = 105; data[4] = 111; data[5] = 103; data[6] = 115; data[7] = 118; data[8] = 100; data[9] = 102; data[10] = 101; data[11] = 99; data[12] = 106; data[13] = 100; data[14] = 113; data[15] = 109; data[16] = 110; data[17] = 120; data[18] = 97; data[19] = 107; data[20] = 117; data[21] = 100; data[22] = 114; data[23] = 104; data[24] = 98; data[25] = 122; #10
    if ((pair != 0) || (triplet != 1))
      $display("failed data=%b", data, ", pair=", pair, ", triplet=", triplet);

    data[0] = 119; data[1] = 98; data[2] = 112; data[3] = 105; data[4] = 111; data[5] = 103; data[6] = 115; data[7] = 118; data[8] = 100; data[9] = 102; data[10] = 101; data[11] = 99; data[12] = 106; data[13] = 100; data[14] = 113; data[15] = 109; data[16] = 110; data[17] = 120; data[18] = 97; data[19] = 107; data[20] = 117; data[21] = 100; data[22] = 114; data[23] = 104; data[24] = 98; data[25] = 122; #10
    if ((pair != 1) || (triplet != 1))
      $display("failed data=%b", data, ", pair=", pair, ", triplet=", triplet);

    $display("done");
  end

endmodule
