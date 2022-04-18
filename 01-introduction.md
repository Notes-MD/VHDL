# VHDL Introduction

**VHDL** : **V**HSIC **H**ardware **D**escriptive **L**anugage<br>
**VHSIC** : **V**ery **H**igh **S**cale **I**ntegrated **C**ircuit
<br>

⚠ **Think in Hardware** ⚠
<br> <br>

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

#### Order of statements is not important!  All operate in parallel!

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

## Delta Delays δ
- delta delays are used to propagate changes in zero real time <u> if no delay is specified </u>.
- this maintains the expected "input change leads to output change" relationship even though everything hapens with zero delay, i.e. at same time!
\* that does not take delay in the gate into account.

Example:
```vhdl
D <= A and B;
E <= not B;
F <= C or E;
```
If initially, A = 1, B = 0, C = 0 => D = 0, E = 1, F = 1 <br>
| | |
|-|-|
T      | B changes to 1 <br>
T + δ  | D changes to 1, E changes to 0 <br>
T + 2δ | F changes to 0
| | |

#### Not everything that can be simulated can be synthesized to hardware!

 ## Vectors
 - allow the collective use of groups of signals called vectors
 - similar to arrays as they may be subscripted
 ```vhdl
 C(3) <= B(3) or A(3);
 C(2) <= B(2) or A(2);
 C(1) <= B(1) or A(1);
 C(0) <= B(0) or A(0);
 ```

 ## Conditional Assignment
 assignment to signal is dependent on a condition or conditions.
 ```vhdl
 F <= A when E = '1' else
      0 when D = '1' else
      C;
```
condition statements can overlap, i.e. both first `when` and `else when` can be true, however, the first condition has highest priority. In circuit design, the higher the priority, the later the condition's mux would be mapped.
#### priority matters here

```
      | \             
 C--- |0  \           | \
      |     |         |   \
      |     |-------- |0    |  
 0--- |1    |         |     |-------- F
      |   /       A-- |1    |  
      | / |           |   /
          |           | / |
          D               |
                          E
```

### 4 Ways of implemention (same result)
```vhdl
F <= I0 when A = '0' and B = '0' else
     I1 when A = '0' and B = '1' else
     I2 when A = '1' and B = '0' else
     I3;
```
```vhdl
F <= (I0 and not A and not B) or
     (I1 and not A and B) or
     (I2 and A and not B) or
     (I3 and A and B);
```
```vhdl
--when no priority
F <= I0 when std_logic_vector'(A&B) = "00" else
     I1 when std_logic_vector'(A&B) = "01" else
     I2 when std_logic_vector'(A&B) = "10" else
     I3;
```
```vhdl
--recommended wayz
sel <= A&B; --concatenate a, b
F <= I0 when sel = "00" else
     I1 when sel = "01" else
     I2 when sel = "10" else
     I3;
```

#### use of `when` statement signifies that **mux** is used.
