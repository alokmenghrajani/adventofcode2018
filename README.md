# adventofcode2018
My attempt at solving [Advent of Code 2018](https://adventofcode.com/2018) using Verilog + icestick fpga.

![icestick](icestick/board.jpg)

The Lattice icestick is a [cheap](https://www.digikey.com/product-detail/en/lattice-semiconductor-corporation/ICE40HX1K-STICK-EVN/220-2656-ND/4289604) (~$25) FPGA development board with a complete [open source](http://www.clifford.at/icestorm/) toolkit. The board works on Linux, Mac OS X and Windows.

I was initially planning to just use the plain board, but it seems I'm going to need a flash?

## Why?
Why not!
_(also, a good excuse for me to learn some Verilog)_

## Goal
Solve each day's puzzle using Verilog and the icestick FPGA. I initially was planning to use the actual puzzle
inputs, but getting things to work on this FPGA is tricky because there's a limited number of logic cells (about 1000) and also a very limited amount of ram (8kB).

The FPGA tooling is also not designed with performance in mind. E.g. iverilog is extremely slow, yosys fails with
some large inputs, etc.

Using the smaller sample inputs makes it potentially possible to solve each day's puzzle.

## Input / Ouput
The puzzle input is encoded either as ram or logic cells (depending on the puzzle input). A custom ruby script [gen.rb](https://github.com/alokmenghrajani/adventofcode2018/blob/master/gen.rb) is used to convert the ascii input into something more useful at an electrical/logic level.

For the output, there are two solutions. The first solution is to use various I/O pins and to connect external LEDs (or a simple LCD display). The second solution is to use the same USB port which is used to program the FPGA but as a UART.

I initially picked external LEDs (because it's simpler) but then got the UART to work.

## Build
There's a Makefile, with various rules per day. Everything gets built inside Docker; iceprog is however required on the host machine to program the FPGA.

```
git clone https://github.com/alokmenghrajani/adventofcode2018
cd adventofcode2018
make simulate-day01-part1
make simulate-day01-part2
...
```

## Results
| day | iverilog    | icestick                        |
| --- | ----------- | ------------------------------- |
| 01  | parts 1 & 2 |                                 |
| 02  | parts 1 & 2 |                                 |
| 03  | parts 1 & 2 | parts 1 & 2 using external LEDs |
| 18  | part 1      |                                 |
