# Latches and Testbenches


## Assert Statements
- used to flag condition not being met
- useful for verification in testbench

```vhdl
assert a = '1'
    report "a isn't 1"  -- optional report clause; for simulation only
    severity fatal;     -- optional severity level clase; could be: note/warning/error/fatal
```

## unintended latches
```vhdl
process (a, c)
begin
    if (a = "10") then
        b <= c;
    elsif (a = "11") then
        b <= '1';
    end if;
end process;
```
In this case, for example, since `b` have been not defined for `a = "01"` and `"00"`, we're expecting the value of `b` to stay the same- not change. This requires a feedback which introduces latch.

Feedback would be required to re-enter existing value to `b` for undefined conditions.

A latch will be produced whenever there are two paths through an entire concurrent statement, one of which assigns to a signal and the other does not.
```vhdl
process (X)
begin
    if (X="0") then
        B <= '1';
    end if;
en dprocess;
```

## Preventing latches
- if a signal is assigned in one paath it must be assigned in all paths.
- pay particular attention to **if** and **case** statemenet
- simple solution: assign default values to any used signal at the top of process, these values may be over-ridden by later code in the process. A defauled of **X** will show up well in simulation- it sythesises to **'0'**.
\* *only applies to non clocked signal*
```vhdl
process (X)
begin 
    B <= 'X';
    if (X='0') then
        B <= '1';
    end if;
end process;
```

## Unintended Latches
```vhdl
if (rising_edge(clock)) then
    if (a='1') then
        b <= c;
    end if;
end if;
```
This wouldn't form a latch.


## Testbenches
- simulation aid. used in a way that resembles real-world use of test equipment.
- a VHDL module that wraps around the module being tested. it takes the place of the real circuit that the module is intended to operate within.
- not synthesized, only simulated, hence it might not use all VHDL features.

### Testing combinational circuit
Since there is no memory, it is possible to test the circuit with all possible inputs.

Can be done by testbenches

```vhdl
library IEEE;
use IEEE.std_logic_1164.ALL;

entity decoder_testbench_vhd is
    -- no ports are defined in testbench
end entity decoder_testbench_vhd;

architecture behavior of decoder_testbench_vhd is
--input to the device being tested
signal sel_ : std_logic_vector(1 downto 0) := (others=>'0');

-- outpuits from the device being tested
signal o_ : std_logic_vector(3 downto 0);

begin
    -- instantiate the unit under test
    uut: entity work.decoder_1of4(Proc)
        port map (sel => sel_, 
                    o => o_);

    -- testbranch process- apply stimuli
    tb  : process;
    begin
        -- combinational cct.
        -- apply all possible input combinations
        sel_ <= "00"; wait for 20ns;
        sel_ <= "01"; wait for 20ns;
        sel_ <= "10"; wait for 20ns;
        sel_ <= "11"; wait for 20ns;

        wait; -- permanenet pause
    end process;
end architecture;
