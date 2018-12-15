module rotate(input clk, output LED1, output LED2, output LED3, output LED4, output LED5);

  reg ready = 0;
  reg [23:0] divider;
  reg [4:0] rot;

  always @(posedge clk) begin
    if (ready) begin
      if (divider == 4800000) begin
        divider <= 0;
        rot <= {rot[3], rot[2], rot[1], rot[0], rot[4]};
      end
      else begin
        divider <= divider + 1;
      end
    end
    else begin
      ready <= 1;
      rot <= 5'b10000;
      divider <= 0;
    end
  end

  assign LED1 = rot[0];
  assign LED2 = rot[1];
  assign LED3 = rot[2];
  assign LED4 = rot[3];
  assign LED5 = rot[4];
endmodule
