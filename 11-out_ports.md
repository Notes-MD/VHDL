# Out Ports
VHDL ports of type `out` are strictly output= they cannot be read within the process.  
Need to create a 'shadow' signal if we wish to use the vcalue being assigned to the signal.

For example, this would give an error.
```vhdl
entity example is
  port (a, b, c, d : in  bit;
        c, e       : out bit);
end example;

architecture beh of example is
begin 
  c <= a and b;
  e <= c or d;   -- c is an out port and cannot be read within the module
end architecture beh;
```
Using shadow signal
```vhdl
entity example is 
  port (a, b, d  : in  bit;
        c, e     : out bit);
end example;

architecture beh of example is

signal c_i : bit; -- shadow to c
begin
  c   <= c_i; -- copy shadow to c
  c_i <= a and b;
  e   <= c_i or d;
end architecture beh;
```
