module acre (
  input wire clk,
  input wire en,
  input wire [1:0] top_left,
  input wire [1:0] top,
  input wire [1:0] top_right,
  input wire [1:0] left,
  input wire [1:0] right,
  input wire [1:0] bottom_left,
  input wire [1:0] bottom,
  input wire [1:0] bottom_right,
  input wire [1:0] init,
  output reg [1:0] state
);

// 2'b00 => open
// 2'b10 => tree
// 2'b01 => lumberyard

wire [5:0] num_trees;
wire [5:0] num_lumberyards;

bit_counter bit_counter1 (.data({24'b0, top_left[1], top[1], top_right[1], left[1], right[1], bottom_left[1], bottom[1], bottom_right[1]}), .r(num_trees));
bit_counter bit_counter2 (.data({24'b0, top_left[0], top[0], top_right[0], left[0], right[0], bottom_left[0], bottom[0], bottom_right[0]}), .r(num_lumberyards));

always @(posedge clk) begin
  if (en == 1) begin
    if (state == 2'b00) begin
      if (num_trees >= 3) begin
        state <= 2'b10;
      end
    end
    else if (state == 2'b10) begin
      if (num_lumberyards >= 3) begin
        state <= 2'b01;
      end
    end
    else if (state == 2'b01) begin
      if ((num_trees == 0) || (num_lumberyards == 0)) begin
        state <= 2'b00;
      end
    end
  end
  else begin
    state <= init;
  end
end

endmodule
