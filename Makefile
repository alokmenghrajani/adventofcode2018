RUN := docker run -v ${CURDIR}:/workdir openfpga/toolchain

dev:
	docker run -it -v ${CURDIR}:/workdir openfpga/toolchain /bin/sh

exp: exp/rotate.v exp/rotate_test.v
	$(RUN) /bin/sh -c "iverilog -s rotate_test exp/rotate.v exp/rotate_test.v && /usr/local/bin/vvp -n ./a.out"
	$(RUN) /bin/sh -c "yosys -p 'synth_ice40 -blif out/rotate.blif' exp/rotate.v"
	$(RUN) /bin/sh -c "arachne-pnr -d 1k -p icestick/pins.pcf out/rotate.blif -o out/rotate.txt"
	$(RUN) /bin/sh -c "icepack out/rotate.txt out/rotate.bin"
	iceprog out/rotate.bin

simulate-day01-part1:
	ruby gen.rb
	$(RUN) /bin/sh -c "iverilog -s part1_test day01/rom.v day01/part1.v day01/part1_test.v && /usr/local/bin/vvp -n ./a.out"

simulate-day01-part2:
	ruby gen.rb
	$(RUN) /bin/sh -c "iverilog -s part2_test day01/rom.v day01/part2.v day01/part2_test.v && /usr/local/bin/vvp -n ./a.out"

simulate-day02-part1:
	ruby gen.rb
	$(RUN) /bin/sh -c "iverilog -s checker_test lib/half_adder.v lib/bit_counter.v day02/checker.v day02/checker_test.v && /usr/local/bin/vvp -n ./a.out"
	$(RUN) /bin/sh -c "iverilog -s part1_test lib/half_adder.v lib/bit_counter.v day02/checker.v day02/rom.v day02/part1.v day02/part1_test.v && /usr/local/bin/vvp -n ./a.out"

simulate-day02-part2:
	ruby gen.rb
	$(RUN) /bin/sh -c "iverilog -s delta_test lib/half_adder.v lib/bit_counter.v day02/delta.v day02/delta_test.v && ./a.out"
	$(RUN) /bin/sh -c "iverilog -s part2_test lib/half_adder.v lib/bit_counter.v day02/delta.v day02/rom.v day02/part2.v day02/part2_test.v && /usr/local/bin/vvp -n ./a.out"

simulate-day03-part1:
	ruby gen.rb
	$(RUN) /bin/sh -c "iverilog -s overlap_test day03/overlap.v day03/overlap_test.v && /usr/local/bin/vvp -n ./a.out"
	$(RUN) /bin/sh -c "iverilog -s part1_test lib/plain_counter.v day03/rom.v day03/overlap.v day03/part1.v day03/part1_test.v && /usr/local/bin/vvp -n ./a.out"

test:
	$(RUN) /bin/sh -c "iverilog -s half_adder_test lib/half_adder.v lib/half_adder_test.v && /usr/local/bin/vvp -n ./a.out"
	$(RUN) /bin/sh -c "iverilog -s full_adder_test lib/half_adder.v lib/full_adder.v lib/full_adder_test.v && /usr/local/bin/vvp -n ./a.out"
	$(RUN) /bin/sh -c "iverilog -s bit_counter_test lib/half_adder.v lib/bit_counter.v lib/bit_counter_test.v && /usr/local/bin/vvp -n ./a.out"
	$(RUN) /bin/sh -c "iverilog -s plain_counter_test lib/plain_counter.v lib/plain_counter_test.v && /usr/local/bin/vvp -n ./a.out"
