/**
 * Exports 28 bits over 8 LEDS. Runs at 1Hz (i.e. you have 1 second to read each set of 7 bits)
 * - state 0: all LEDS are on, picks up data
 * - state 1: LED0 is off, LED1-7 expose first 7 bits
 * - state 2: LED0 is on, LED1-7 are off
 * - state 3: LED0 is off, LED1-7 expose next 7 bits
 * - ...
 * - go back to state 0
 *
 * In the future, I might replace this module with a UART. I ran into some UART issues with my first board (which no
 * longer works, so I'd rather avoid UART for now).
 */
module data_exporter #(parameter WIDTH=24, VAL=12000000) (
  input wire clk,
  input wire en,
  input wire [27:0] data,
  output reg [7:0] leds
);

reg [2:0] state;
reg [27:0] data_to_send;

wire [WIDTH-1:0] slow_counter;
wire slow_counter_overflow;
plain_counter #(.WIDTH(WIDTH), .VAL(VAL)) plain_counter_slow (.clk(clk), .en(en), .inc(1'b1), .v(slow_counter), .r(slow_counter_overflow));

always @(posedge clk) begin
  if (en == 1) begin
    if (state == 0) begin
      data_to_send <= data;
      leds <= 8'b1111_1111;
      if (slow_counter_overflow == 1) begin
        state <= 1;
      end
    end
    else if (state == 1) begin
      leds <= {1'b0, data_to_send[6:0]};
      if (slow_counter_overflow == 1) begin
        state <= 2;
      end
    end
    else if (state == 2) begin
      leds <= 8'b1000_0000;
      if (slow_counter_overflow == 1) begin
        state <= 3;
      end
    end
    else if (state == 3) begin
      leds <= {1'b0, data_to_send[13:7]};
      if (slow_counter_overflow == 1) begin
        state <= 4;
      end
    end
    else if (state == 4) begin
      leds <= 8'b1000_0000;
      if (slow_counter_overflow == 1) begin
        state <= 5;
      end
    end
    else if (state == 5) begin
      leds <= {1'b0, data_to_send[20:14]};
      if (slow_counter_overflow == 1) begin
        state <= 6;
      end
    end
    else if (state == 6) begin
      leds <= 8'b1000_0000;
      if (slow_counter_overflow == 1) begin
        state <= 7;
      end
    end
    else if (state == 7) begin
      leds <= {1'b0, data_to_send[27:21]};
      if (slow_counter_overflow == 1) begin
        state <= 0;
      end
    end
  end
  else begin
    state <= 0;
    data_to_send <= 0;
    leds <= 8'b1111_1111;
  end
end

endmodule
