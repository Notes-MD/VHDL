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
[return to content](https://github.com/Notes-MD/VHDL#vhdl-cheatsheet)
