# Verilog Design of Single-Cycle RISC-V Processor

## Project Overview

This project involves designing and implementing a single-cycle RISC-V processor. The processor will support a subset of the RV32I instruction set and will include a simple cache system. The main objectives are:

1. **Designing a single-cycle processor datapath and control logic.**
2. **Running and debugging logic simulations.**
3. **Implementing and integrating a cache system with the RISC-V processor.**

## Features

The processor implements the following subset of the RV32I instruction set:

- **R-Type**: `add`, `sub`, `and`, `or`
- **I-Type**: `addi`, `andi`, `ori`, `lw`, `jalr`
- **B-Type**: `beq`, `bne`
- **J-Type**: `jal`
- **S-Type**: `sw`

## Specifications

2. **Memory Access**: Reading from the register file/memory is combinational; writing is clocked.
3. **Top Module Division**: The top module is divided into two main modules - datapath and control logic. The instruction and data memories are connected to the top module in the testbench.

6. **Cache System**: Implement a simple cache system with the following characteristics:
   - Data memory will be cached; instruction memory will not be affected.
   - Single level of caching.
   - Main memory: 4 Kbytes, word-addressable (10 bits).
   - Main memory access: 4 clock cycles.
   - Data cache: 512 bytes total capacity, 16-byte blocks, direct mapping.
   - Cache policies: Write-through and write-around for write hits and misses.
   - SW instructions stall the processor; LW instructions only stall on a miss.


## Cache System

1. **Cache Controller**:
   - (FSM) with three states: idle, reading, and writing.
   - Generate stall control signals and manage cache and memory operations.

2. **Memory System Module**:
   - Replace the data memory in the single-cycle implementation with a data memory system module, which includes a cache memory module, a cache controller module, and the data memory module.
   - The memory system has a control signal `stall`, asserted when the memory system needs to stop the processor temporarily.

3. **Cache Operations**:
   - **Read Hit**: No stall; data read from cache.
   - **Read Miss**: Stall; data read from data memory and stored in the cache.
   - **Write Hit**: Stall; data written to both cache and data memory.
   - **Write Miss**: Stall; data written to data memory only.

## References

- **Textbook**: "Digital Design and Computer Architecture" by Harris and Harris for a good starting point.

