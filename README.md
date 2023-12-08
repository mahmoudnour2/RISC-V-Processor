# RISC-V-Processor
This is a Verilog Implementation of the RISC-V processor. This is a pipelined version with a single memory for data and instruction. To use the processor you need to first change the initialized values in the instruction memory with your own RISC-V instructions and then run the simulation to get the results or synthesize it and test it on an FPGA. The processor supports the RV32I base integer instruction set according to the specifications found here:
https://riscv.org/technical/specifications/. All forty user-level instructions (listed in page 130 of the RISC-V Instruction
Set Manual – Volume I: Unprivileged ISA and explained in Chapter2 of the same manual) are implemented as
described in the specifications except ECALL, EBREAK, and FENCE instructions. Instead, the implementation
interprets the EBREAK instruction as a halting instruction that ends the execution of any program. On the other hand, the ECALL and FENCE are interpreted as no-op instructions that do nothing
