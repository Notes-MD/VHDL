# Introduction

```
         VHDL ---------------------------> Language Subset

          |                                     | 
         \|/                                   \|/ 

      Synthesis                  ------ Hardware Synthesis
(testbenches/modelling)          |
                                 |              |
          |                      |              | 
         \|/                     |             \|/ 
                                 |
      Simulation    <------------|           Hardware
                                        (FPGA/Custom Logic)

```
 
## Simulate or Model
VHDL may be used to **simulate** or **model** the behavious of hardware:
- this mode allows full use of the language feature, e.g. *"wait for time"* statements
- resembles a regular programming language but has extra feature that allow the accurate modelling of hardware, eg: **parallism** or **concurrency**.

## Synthesize to hardware
VDHL may be **synthesized to hardware**:
- this allows thee creationofactual hardware that will be realized in CPLDs, FPGAs or ASICs.
- Uses a subset of the language features: 
  - for example, cant have file I/O on a FPGA
  - cant specify timing delays-  there aren't controllable in real hardware 

time isn't controllable in hardware!

## Descriptions (uses at different levels)
### Behavioural
More abstract- describe what we want; not the details of how. Relationship between inputs and outputs.
### Data Flow
Described at the level of movement and manululation of data (RTL). 
### Structural
Low level- basically connecting together blocks/gates.

## Design approaches
### Top Down
- start wit a more behavioural description of the desired function. It would be possible to simulate this in a fashion similar to casual software programs.
- VHDL would gradually migrate to a detailed data-flow or structudal description that may be implemented in hardware.
### Structureal VHDL
= indicates connections between blocks or primitive operations usch as AND, OR etc.
```vhdl
-- C = AB 
G1: and port map ( res=>C,
                   in1=>A,
                   in2=>B);
-- E = C + D
G2: or port map (  res=>E,
                   in1=>C,
                   in2=>D);
```
Labels: `G1` & `G2` <br>
Componenets: `and`, `or` (all logical operation are supported, eg: xor, nor, nand, etc.).

### RTL (Register Transfer Level) VHDL
Libraries also contain 'standard' functions
```vhdl
E <= C or D after 5 ns;
C <= A and B after 5 ns;
```
\* the `after 5 ns` part is ignored (or cause error) for hardware synthesis. are used to model the measured performance of a circuit.

#### ⚠ Order of statements is not important! All operate in parallel! ⚠

### Signal assignment
```vhdl
E <= C or D after 5 ns;
```
Any changes in `C or D` position triggers a re-evaliation of the entire expression leading to a change in E after 5ns.

This resembles the actual hardware where input changes lead to output changes.

### Ongoing changes
Inversting oscillator.
```vhdl
clk <= not clk after 10 ns;
```
\* Cannot synthesize this to hardware. Only useful for simulation. 

-----------------------
[return to content](https://github.com/Notes-MD/VHDL#vhdl-cheatsheet)
