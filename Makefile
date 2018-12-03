RUN := docker run -v ${CURDIR}:/workdir openfpga/toolchain

dev:
	$(RUN) /bin/sh

simulate-day01-part1:
	ruby gen.rb
	$(RUN) /bin/sh -c "iverilog -s day01_part1_test rom_day01.v day01_part1.v day01_part1_test.v && ./a.out"

simulate-day01-part2:
	ruby gen.rb
	$(RUN) /bin/sh -c "iverilog -s day01_part2_test rom_day01.v day01_part2.v day01_part2_test.v && ./a.out"

test:
	$(RUN) /bin/sh -c "iverilog -s half_adder_test lib/half_adder.v lib/half_adder_test.v && ./a.out"
	$(RUN) /bin/sh -c "iverilog -s full_adder_test lib/half_adder.v lib/full_adder.v lib/full_adder_test.v && ./a.out"
