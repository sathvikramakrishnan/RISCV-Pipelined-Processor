# RISC-V 5-stage Pipelined Processor

---

This repository contains the Verilog HDL implementation of a simple **RISC-V pipelined processor**.  
For detailed information on the RISC-V instruction set, please refer to the official RISC-V Instruction Set Manual, available in the `doc` directory (originally from https://riscv.org)

## Features

* **RISC-V RV32I Instruction Set:** Implements a subset of the RV32I instruction set that can be used to write simple programs involving simple arithmetic and logical operations, memory access and branching.
* **Modularity:** The processor is broken down into separate modules based on the their functionality (e.g., Datapath, Control unit).
* **Pipelined Architecture (5-stage pipeline):** Enhances performance by executing multiple instructions concurrently, leading to higher throughput. Includes 5 stages: Instruction Fetch, Decode + Operand Fetch, Execute, Memory Access, and Write-Back.
* **Hazard Detection and Handling:** Incorporates mechanisms like **forwarding**, **stalling** and **fixed branch prediction** to ensure correct program execution by mitigating data and control hazards.


---
## Getting started

### Prerequisites

A Verilog simulator is required to test this design. Icarus Verilog (`iverilog`) and GTKWave (`gtkwave`) were used in the development of this project.

```bash
    sudo apt-get install iverilog gtkwave # For Debian/Ubuntu
```

To run the program:
```bash
    iverilog -o out datapath/*.v control/*.v components/*.v stages/*.v Pipeline.v Pipeline_tb.v # generates output file
    vvp out # runs output file
    gtkwave pipeline.vcd # opens GTKWave software to view waveforms
```

## References

[1] Digital Design and Computer Architecture RISC-V Edition by Sarah Harris, David Harris