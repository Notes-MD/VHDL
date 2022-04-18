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
desscribes how the circuit works
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

