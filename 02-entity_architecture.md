# VHDL Modules
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

## VHDL Constants
convenient for unchanged values
```vhdl
constant limit : integer := 17;
constant delay : time := 5 ns;
constant vec   : bit_vector(3 downto 0) := "1100";
```

## VHDL Aliases
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

## VHDL Type System
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


### IEEE Standard Logic
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
