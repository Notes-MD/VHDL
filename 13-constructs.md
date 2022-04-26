# Constructs
\* Latches should be avoided unless needed

## concurrent statements
statements outside of any `process` and an entire process itself are concurrent

all executed in `parallel`.

Re-evaluate(/re-triggered) whenever a signal:
- in sensitive list changes (for processes) or
- on RHS changes (everything else)

Example:
- signal assignment
- selected signal assignment
- conditional signal assignment
- process
- module instantiation

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity compare is 
port( a, b        : in  std_logic;
      gr, lt, eq  : out std_logic);
end entity compare;

architecture equation of compare is
begin
    gr <= a and not b;              -- these will
    lt <= not a and b;              -- all trigger
    eq <= '1' when a = b else '0';  -- together
end architecture equation;
```

## conditional signal assignment
used only when there is priority in assignment
```vhdl
F <= A  when E = '1' else
    '0' when D = '1' else
     C;
```
```vhdl
with s select
F <= I0   when "00",
     I1   when "01",
     I2   when "10",
     I3   when "11",
     ''  when others;
```

## Processes
convenient way of implementing more complex operations

is a group of `sequential` statements that are executed when certains event happen

certain kinds of statements are only allowed within processes

nested processes aren't allowed