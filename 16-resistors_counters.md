# Registers and Counters
basic elements of Sequential circuits

## Register
A collection of flip-flops with a common clock that is treated as a unit. Typically used to store or manipulate a multi-bit value.

### Register Transfer Logic (RTL)
- Values stored in registers are treated as a unit and may be transferred between registers.
- requires 3-state outputs (often incorporated into registered in MSI logic) or multiplexers.

### Accumulator (RTL example)
can be performed recursive action, example:
```x1 + x2 + x3 + x4 ...... + xn```

### Shift Register (Right Shift)
- Chain of FFs Q -> D
- Serial In / Serial Out / Parallel Out

## Multifunction Register
Use multiplexers to change the "wiring" between the FFs for different operations.

Example:
- hold
- parallel in
- shift left
- shift right
