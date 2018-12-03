RUN := docker run -v ${CURDIR}:/workdir openfpga/toolchain

dev:
	$(RUN) /bin/sh

simulate-day01-part1:
	ruby gen.rb
	$(RUN) /bin/sh -c "iverilog -s part1_test day01/rom.v day01/part1.v day01/part1_test.v && ./a.out"

simulate-day01-part2:
	ruby gen.rb
	$(RUN) /bin/sh -c "iverilog -s part2_test day01/rom.v day01/part2.v day01/part2_test.v && ./a.out"

simulate-day02-part1:
	ruby gen.rb
	$(RUN) /bin/sh -c "iverilog -s checker_test lib/half_adder.v lib/bit_counter.v day02/checker.v day02/checker_test.v && ./a.out"
	$(RUN) /bin/sh -c "iverilog -s part1_test lib/half_adder.v lib/bit_counter.v day02/checker.v day02/rom.v day02/part1.v day02/part1_test.v && ./a.out"

simulate-day02-part2:
	ruby gen.rb
	$(RUN) /bin/sh -c "iverilog -s delta_test lib/half_adder.v lib/bit_counter.v day02/delta.v day02/delta_test.v && ./a.out"
	$(RUN) /bin/sh -c "iverilog -s part2_test lib/half_adder.v lib/bit_counter.v day02/delta.v day02/rom.v day02/part2.v day02/part2_test.v && ./a.out"
test:
	$(RUN) /bin/sh -c "iverilog -s half_adder_test lib/half_adder.v lib/half_adder_test.v && ./a.out"
	$(RUN) /bin/sh -c "iverilog -s full_adder_test lib/half_adder.v lib/full_adder.v lib/full_adder_test.v && ./a.out"
	$(RUN) /bin/sh -c "iverilog -s bit_counter_test lib/half_adder.v lib/bit_counter.v lib/bit_counter_test.v && ./a.out"
