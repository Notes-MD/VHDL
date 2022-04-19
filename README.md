# VHDL Cheatsheet

**VHDL** : **V**HSIC **H**ardware **D**escriptive **L**anugage<br>
**VHSIC** : **V**ery **H**igh **S**cale **I**ntegrated **C**ircuit
<br>

#### ⚠ Think in Hardware ⚠

## Content
1. [Introduction](https://github.com/Notes-MD/VHDL#introduction)
   - [Simulate or Model](https://github.com/Notes-MD/VHDL#simulate-or-model)
   - [Synthesize to hardware](https://github.com/Notes-MD/VHDL#synthesize-to-hardware)
   - [Descriptions (uses at different levels)](https://github.com/Notes-MD/VHDL#descriptions-uses-at-different-levels)
     - [Behavioural](https://github.com/Notes-MD/VHDL#behavioural)
     - [Data Flow](https://github.com/Notes-MD/VHDL#data-flow)
     - [Structural](https://github.com/Notes-MD/VHDL#structural)
   - [Design approaches](https://github.com/Notes-MD/VHDL#design-approaches)
     - [Top Down](https://github.com/Notes-MD/VHDL#top-down)
     - [Structureal VHDL](https://github.com/Notes-MD/VHDL#structureal-vhdl)
     - [RTL (Register Transfer Level) VHDL](https://github.com/Notes-MD/VHDL#rtl-register-transfer-level-vhdl)
     - [Signal assignment](https://github.com/Notes-MD/VHDL#signal-assignment)
     - [Ongoing changes](https://github.com/Notes-MD/VHDL#ongoing-changes)
2. [Delta Delays δ](https://github.com/Notes-MD/VHDL#delta-delays-%CE%B4)
3. [Vectors](https://github.com/Notes-MD/VHDL#vectors)
4. [Conditional Assignment](https://github.com/Notes-MD/VHDL#conditional-assignment)
   - [4 Ways of implemention](https://github.com/Notes-MD/VHDL#4-ways-of-implemention)
5. [Modules](https://github.com/Notes-MD/VHDL#modules)
   - [Entity](https://github.com/Notes-MD/VHDL#entity)
   - [Architecture](https://github.com/Notes-MD/VHDL#architecture)
   - [VHDL Entity & Ports](https://github.com/Notes-MD/VHDL#vhdl-entity--ports)
   - [Component Pins & VHDL Ports](https://github.com/Notes-MD/VHDL#component-pins--vhdl-ports)
   - [Hierarchy](https://github.com/Notes-MD/VHDL#hierarchy)
   - [VHDL Signals](https://github.com/Notes-MD/VHDL#vhdl-signals)
6. [Constants](https://github.com/Notes-MD/VHDL#constants)
7. [Aliases](https://github.com/Notes-MD/VHDL#aliases)
   - [Type System (Datatypes)](https://github.com/Notes-MD/VHDL#type-system-datatypes)
   - [IEEE Standard Logic](https://github.com/Notes-MD/VHDL#ieee-standard-logic)
8. [Arrays](https://github.com/Notes-MD/VHDL#arrays)
   - [Vectors: 1 dimension Arrays](https://github.com/Notes-MD/VHDL#vectors-1-dimension-arrays)
   - [Aggregates](https://github.com/Notes-MD/VHDL#aggregates)
   - [Example: Read Only Memory](https://github.com/Notes-MD/VHDL#example-read-only-memory)
9. [Operators](https://github.com/Notes-MD/VHDL#operators)
   - [Operators from highest preference](https://github.com/Notes-MD/VHDL#operators-from-highest-preference)
   - [Theory](https://github.com/Notes-MD/VHDL#theory)
10. [Example Design: Dice](https://github.com/Notes-MD/VHDL#example-design-dice)

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
# Delta Delays δ
delta delays are used to propagate changes in zero real time <u> if no delay is specified </u>.

This maintains the expected "input change leads to output change" relationship even though everything hapens with zero delay, i.e. at same time!
\* that does not take delay in the gate into account.

Example:
```vhdl
D <= A and B;
E <= not B;
F <= C or E;
```
If initially, A = 1, B = 0, C = 0 => D = 0, E = 1, F = 1 <br>
|||
|-|-|
T      | B changes to 1 <br>
T + δ  | D changes to 1, E changes to 0 <br>
T + 2δ | F changes to 0
|||

#### ⚠ Not everything that can be simulated can be synthesized to hardware! ⚠

-----------------------
# Vectors

- allow the collective use of groups of signals called vectors
- similar to arrays as they may be subscripted
```vhdl
C(3) <= B(3) or A(3);
C(2) <= B(2) or A(2);
C(1) <= B(1) or A(1);
C(0) <= B(0) or A(0);
```

-----------------------
# Conditional Assignment

assignment to signal is dependent on a condition or conditions.
```vhdl
F <= A when E = '1' else
     0 when D = '1' else
     C;
```
condition statements can overlap, i.e. both first `when` and `else when` can be true, however, the first condition has highest priority. In circuit design, the higher the priority, the later the condition's mux would be mapped.
#### ⚠ priority matters here ⚠

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

#### ⚠ use of `when` statement signifies that **mux** is used. ⚠

-----------------------

# Modules
modules allow the creation of blocks that may then be used as a unit.

## Entity
Interface: specifies inputs and outputs of the circuit.
```vhdl
-- basically a method in vhdl
-- instance can be called any number of time
entity two_gates is 
port ( A, B, C, D : in bit;
       E          : out bit);
end entity two_gates;
```

## Architecture
describes how the circuit works
- the **architecture** speciefies the contents of a module through the use of statements.
- it may use the ports defined in the entity and/or may use `signals` defined within the architecture 
- multiple architecture may be defiled. a common use of this is to allow the adoption of different style architectures for simulation and synthesis to hardware.
```vhdl
-- calling two_gates module here
architecture gates of two_gates is

signal C : bit;

begin
  C <= A and B after 5 ns;
  E <= C or D after 4 ns;
end architecture gates;
```

```vhdl
-- again calling two_gates module
architecture RTL of two_gates is

begin
E <= '1' when D = '1' else
     '1' when A&B == '11' else
     '0';
end architecture RTL;
```

**Generics:**<br>
useful to parametize modules, eg: allow creation of modules that can have ports of varying widths (number of bits).


## VHDL Entity & Ports
- the **entity** specifies the **interface** to the module by describing the **ports**.
- ports allow access to the module contents (a bit like pins on device)
- port directions:
  - **in**:  port is driven from outside the module
  - **out**: port is driven from inside the module
  - **inout**: port is driven ion both directions (but not at the same time)
  - **buffer**: not used; 

## Component Pins & VHDL Ports
The ports on the **top-level entity** in the hieararchy are mapped to actual pins on the ephysical implementation. <br>
**Usually require a pin assignment file that related pin numbers to port names- for example `.ucf` (user constrained file) files for xilinx FPGAs.*

## Hierarchy
a hierarchy may be created by **installing** (/calling) modules within other modules. 

## VHDL Signals
- takes the place of wires or notes in digital circuit
- changes in signals may trigger changes in other signals
- changes propagate through the 'circuit'. this may lead to ongoing changes
- may have initial values (of most use for simulation but will not be synthasised)
- for a signal to have a particular initial value, to be synthasised, the signal should be made as an assignment

examples:
```vhdl
signal limit : integer;
signal delay : time := 5 ns;
signal vec   : bit_vector(0 to 3) := "0011";
```
`:=` is how initial value is defined (for simulation).<br>
in `bit_vector(0 to 3) := "0011";` 0(most significant; 0th value) 0(1st value) 1(2nd value) 1(least significant; 3rd value). Alternatively, `bit_vector(3 downto 0) := "1100";` is more common method for same operation.

-----------------------
# Constants

convenient for unchanged values
```vhdl
constant limit : integer := 17;
constant delay : time := 5 ns;
constant vec   : bit_vector(3 downto 0) := "1100";
```

-----------------------
# Aliases

- used to rename signals to make their purpose clearer or for convenience.
- they may also be used to access sub-ranges of vectors
```vhdl
signal data : bit_vector(15 downto 0);

-- lower byte of data
alias low_data : bit_vector( 7 downto 0) is data(7 downto 0);

-- upper byte of data
alias high_data : bit_vector( 7 downto 0) is data(15 downto 8);

-- with this, later on in the same coad, instead of writing 
-- data(15 downto 8), we can just write high_data
```

-----------------------
## Type System (Datatypes)

strongly typed language
<br> assignment etc. only between compatible types
<br> operations can take place only between same data-types
|Datata type| Description/Range|
|-|-|
Bit       | value '0' or '1' (need quots!) <br> \* not used in practice as not sufficiently representative. IEEE `std_logic` is preferred as it is more flexible.
Boolean   | `TRUE` or `FALSE`
Integer   | -(2<sup>31</sup>-1) to +(2<sup>31</sup>-1)
positive  | 1 to +(2<sup>31</sup>-1)
natural   | 0 to +(2<sup>31</sup>-1)
real      | -1.0e-38 to 1.0e38
character | usual range use in quotes, eg: 'a' or '*'
range     | ingeger with units fs, ps, ns, us, ms, sec, min, hr


## IEEE Standard Logic
*standard on all devices
- a 2-level logic system is inadequate for modelling real digital systems
- for example it doesn't represent:
  - 3-state logic
  - unknown values
  - weak pull-up/down
  - conflicts (illegal values)

- logic levels <br>
  **`U`** : uninitialised- inital value for signal   
  **`X`** : forcing unknown- usually indicates a conflict (shouldn't be used instead of dont care)  
  **`-`** : dont care  
  **`W`** : weakly driven unknown  
  **`Z`** : 3-state - undriven signal, high impedance  
  **`0`** : logic 0 - driven low  
  **`1`** : logic 1 - driven high  
  **`H`** : weakly driven high  
  **`L`** : weakly driven low   
  only `Z`, `0`, `1`, `H` and `L` end up in hardware.<br>
  dont compare non-bary values, `U`, `Z`, `X`.


-----------------------
# Arrays
Used to model memory.

Declare datatype
```vhdl
type word is array(7 downto 0) of bit;
```
Declare the signals and constants of this type
```vhdl
signal   ALU    : word;
signal   reg0   : word := "10100000";
constant max    : word := x"A4"; --x signifies hexadecimal 
signal   x      : word := ('1', '1', '0', '0', '0', '0', '0', '0');
signal   y      : word := (7=>'1', 6=>'1', others => '0');
```

## Vectors: 1 dimension Arrays
- subscript range can use `to` or `downto`
- `downto` is more common
- elements are selected by index or subrange of index, eg: `reg0(3)`, `ALU(3 downto 0)`

concatenation operator may be used to assemble vectors from several pieces:
```vhdl
type word is array(7 downto 0) of bit;

signal ALU          : word;
signal reg0, reg1   : word;

reg0 <= '1' & "0000" & "101";
reg1 <= ALU(3 downto 0) & ALU(7 downto 4);
```

## Aggregates
given signal declaration
```vhdl
signal x, y, z   : bit;
signal ar        : bit_vector(3 downto 0);
```
these are legal aggregate assignments:
```vhdl
(x, y, z) <= bit_vector('0', '0', '1');
ar <= ('1', '0', '1', '1');
ar <= (1 => '1', 3 => '1', other => '0');
ar <= (other => '0'); -- useful of clearing an array of unknown size
```

### Example: Read Only Memory
```vhdl
entity ROM is
port (addr  : in   bit_vector(2 downto 0);
      data  : out  bit_vector(3 downto 0));
end ROM;

architecture const_rom of ROM is

type a_ROM is array (0 to 7) of bit_vector(3 downto 0);
constant the_ROM : a_ROM := ("1001", "0101", "1101", "1011", "0110", "1000", "1111", "1010");

begin
  data <= the_ROM(vec2int(addr));
end const_rom;
```

-----------------------
# Operators

## Operators from highest preference
### binary
`and`, `or`, `nand`, `nor`, `xor`, `nxor`  

### relational
`=`, `/=`, `<`, `<=`, `>`, `>=`  
used with **if statements** and the result is either `TRUE`, or `FALSE`  

### shift
`sll` (shift left logic): move all elements one left and add `0` at the end. <br>
`srl` (shift right logic): move all elements one right and add `0` at the first element. <br>
`sla` (shift left arithmetic): <br>
`sra` (shift right arithmetic): <br>
`rol` (rotate):<br>
`ror` 

### add
`+`, `-`, `&`

### unary sign
`+`. `-`

### multiplication
`*`, `/`, `mod`, `rem`  


## Theory
Not all operators can be synthesized or they mnay be too expensive in hardware, eg: devision; whereas some doesn't cost anything in hardware- just more wires.
```vhdl
-- Y rotated 1 bit
X <= Y(0) & Y(7 downto 1);

-- Y = 1 0 1 1 0 0 1 1
-- X = 1 1 0 1 1 0 0 1
```

-----------------------
# Example Design: Dice
`Counter.vhdl`
```vhdl
-- entity
entity Counter is
  port (clock     : in  std_logic;
        roll      : in  std_logic;
        rollValue : out std_logic_vector(2 downto 0));
end Counter;

-- architecture
architecture Behavioral of Counter is
signal count : std_logic_vector(2 downto 0);
begin
  process (clock)
  begin
    if rising_edge(clock) then
      if (roll = '1') then
        if (count = "110") then
          count <= "001";
        else
          count <= count + "001";
        end if;
      end if;
    end if;
  end process
  rollValue <= count;

end architecture Behavioral;
```

`Decoder.vhdl`
```vhdl
entity Decoder is
  port ( rollValue  : in  std_logic_vector(2 downto 0), 
         dieLEDs    : out std_logic_vector(3 downto 0));
end entity Decoder;

architecture Behavioral of Decoder is
begin
  dieLEDs <= "0001" when rollValue = "001" else
             "0100" when rollValue = "010" else
             "0101" when rollValue = "011" else
             "0110" when rollValue = "100" else
             "0111" when rollValue = "101" else
             "1110" ;
end architecture Behavioral;

-- this die will not have 0 and 7; since dices are from 1-6. 
-- for these values, the dice will show 6

-- here the `dieLEDs` represent vectors of 4 elements- "d c b a", for:
-- b     c
-- d  a  d
-- c     b
```

`TopLevel.vhdl`
```vhdl
entity TopLevel is
  port ( clock        : in   std_logic;
          rollButton  : in   std_logic;
          dieLEDs     : iyt  std_logic_vector(3 downto 0));
end entity TopLevel;

architecture Structure of TopLevel is

-- used to wire together the modules internally
signal rollValue : std_logic_vector(2 downto 0);

begin
  -- instaniate the counter module (/calling counter method)
  theCounter:
    port map ( clock      => clock,
               roll       => rollButton,
               rollValue  => rollValue);

  -- instaniate the decoder module (/calling decoder method)
  theDecoder:
  entity work.Decoder
    port map ( rollValue  => rollValue,
               dieLEDs    => dieLEDs);

end architecture Structure;
```