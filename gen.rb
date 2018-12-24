def day01
  # We'll create a 16-bit address and 32-bit data rom. We could create exactly what we need...
  f = File.new('inputs/day01.txt', 'r')
  o = File.new('day01/rom.v', 'w+')

  o.puts("module rom (")
  o.puts("  address, // address input")
  o.puts("  en,      // enable input")
  o.puts("  data     // data output")
  o.puts(");")
  o.puts("input [15:0] address;")
  o.puts("input en;")
  o.puts("output [63:0] data;")
  o.puts("reg [63:0] data;")
  o.puts("always @ (en or address)")
  o.puts("begin")
  o.puts("  case (address)")

  address = 0
  while (line = f.gets)
    l = line.chomp
    o.puts("    #{address}: data = #{l};")
    address += 1
  end
  o.puts("  endcase")
  o.puts("end")
  o.puts("endmodule")

  o.close
  f.close
end

def day02
  # We'll create a 16-bit address and 26 x 8-bit data rom.
  f = File.new('inputs/day02.txt', 'r')
  o = File.new('day02/rom.v', 'w+')

  o.puts("module rom (")
  o.puts("  address, // address input")
  o.puts("  en,      // enable input")
  o.puts("  data     // data output")
  o.puts(");")
  o.puts("input [15:0] address;")
  o.puts("input en;")
  o.puts("output [25:0][7:0] data;")
  o.puts("reg [25:0][7:0] data;")
  o.puts("always @ (en or address)")
  o.puts("begin")
  o.puts("  case (address)")

  address = 0
  while (line = f.gets)
    l = line.chomp
    o.puts("    #{address}:")
    o.puts("    begin")
    for i in 0..25 do
      o.puts("       data[#{i}] = #{l[i].ord};")
    end
    o.puts("    end")
    address += 1
  end
  o.puts("  endcase")
  o.puts("end")
  o.puts("endmodule")

  o.close
  f.close
end

def day03
  # We'll create a 10-bit address and 4 x 10-bit data rom.
  f = File.new('inputs/day03.txt', 'r')
  o = File.new('day03/rom.v', 'w+')

  o.puts("module rom (")
  o.puts("  input clk,")
  o.puts("  input wire [10:0] addr,")
  o.puts("  output reg [9:0] left,")
  o.puts("  output reg [9:0] top,")
  o.puts("  output reg [4:0] w,")
  o.puts("  output reg [4:0] h")
  o.puts(");")
  o.puts("")
  o.puts("reg [9:0] rom0 [1236:0];")
  o.puts("reg [9:0] rom1 [1236:0];")
  o.puts("reg [4:0] rom2 [1236:0];")
  o.puts("reg [4:0] rom3 [1236:0];")
  o.puts("always @ (negedge clk) begin")
  o.puts("  left <= rom0[addr];")
  o.puts("  top <= rom1[addr];")
  o.puts("  w <= rom2[addr];")
  o.puts("  h <= rom3[addr];")
  o.puts("end")
  o.puts("")
  o.puts(" initial begin")
  address = 0
  while (line = f.gets)
    l = line.chomp
    m = /#\d+ @ (\d+),(\d+): (\d+)x(\d+)/.match(l)
    o.puts("  rom0[#{address}] <= 10'd#{m[1]};")
    o.puts("  rom1[#{address}] <= 10'd#{m[2]};")
    o.puts("  rom2[#{address}] <= 5'd#{m[3]};")
    o.puts("  rom3[#{address}] <= 5'd#{m[4]};")
    address += 1
  end
  o.puts("end")
  o.puts("endmodule")
  o.close
  f.close
end

def day18
  # Read input file
  f = File.new('inputs/day18.txt', 'r')
  arr = []
  while (line = f.gets)
    l = line.chomp
    arr.push(l.split(''))
  end
  f.close

  size = arr.length

  # generate output
  o = File.new('day18/field.v', 'w+')

  o.puts("module field (")
  o.puts("  input wire clk,")
  o.puts("  input wire en,")
  o.puts("  output wire [#{size*size-1}:0] trees,")
  o.puts("  output wire [#{size*size-1}:0] lumberyards")
  o.puts(");")
  o.puts("")

  for x in 0..(size-1) do
    for y in 0..(size-1) do
      case arr[x][y]
      when '.'
        init = "2'b00"
      when '|'
        init = "2'b10"
      when '#'
        init = "2'b01"
      end
      top_left = "{trees[#{(x-1)*size+(y-1)}], lumberyards[#{(x-1)*size+(y-1)}]}"
      top = "{trees[#{(x-1)*size+(y)}], lumberyards[#{(x-1)*size+(y)}]}"
      top_right = "{trees[#{(x-1)*size+(y+1)}], lumberyards[#{(x-1)*size+(y+1)}]}"
      left = "{trees[#{(x)*size+(y-1)}], lumberyards[#{(x)*size+(y-1)}]}"
      right = "{trees[#{(x)*size+(y+1)}], lumberyards[#{(x)*size+(y+1)}]}"
      bottom_left = "{trees[#{(x+1)*size+(y-1)}], lumberyards[#{(x+1)*size+(y-1)}]}"
      bottom = "{trees[#{(x+1)*size+(y)}], lumberyards[#{(x+1)*size+(y)}]}"
      bottom_right = "{trees[#{(x+1)*size+(y+1)}], lumberyards[#{(x+1)*size+(y+1)}]}"
      if x == 0
        top_left = "2'b0"
        top = "2'b0"
        top_right = "2'b0"
      end
      if x == (size - 1)
        bottom_left = "2'b0"
        bottom = "2'b0"
        bottom_right = "2'b0"
      end
      if y == 0
        top_left = "2'b0"
        left = "2'b0"
        bottom_left = "2'b0"
      end
      if y == (size - 1)
        top_right = "2'b0"
        right = "2'b0"
        bottom_right = "2'b0"
      end

      o.puts("acre acre_#{x}_#{y} (.clk(clk), .en(en), .top_left(#{top_left}), " +
        ".top(#{top}), .top_right(#{top_right}), .left(#{left}), " +
        ".right(#{right}), .bottom_left(#{bottom_left}), .bottom(#{bottom}), " +
        ".bottom_right(#{bottom_right}), .init(#{init}), .state({trees[#{x*size+y}], lumberyards[#{x*size+y}]}));")
    end
  end

  o.puts("endmodule")
  o.close
end

day01()
day02()
day03()
day18()
