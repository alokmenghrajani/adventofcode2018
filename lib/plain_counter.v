/**
 * A counter which sets a signal when it restarts.
 */
module plain_counter #(parameter WIDTH=1, VAL=1) (
   input clk,
   input en,
   input inc,
   output [WIDTH-1:0] v,
   output r
);

reg [WIDTH-1:0] counter;

always @(posedge clk) begin
  if (en == 1) begin
    if (inc == 1) begin
      if (counter != (VAL-1)) begin
        counter <= counter + 1;
      end
      else begin
        counter <= 0;
      end
    end
  end
  else begin
    counter <= 0;
  end
end

assign v = counter;
assign r = (inc == 1) & (counter == (VAL - 1));

endmodule
