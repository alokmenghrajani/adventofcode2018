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


day01()
day02()
