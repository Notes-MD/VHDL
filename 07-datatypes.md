# Type System (Datatypes)

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
[return to content](https://github.com/Notes-MD/VHDL#vhdl-cheatsheet)
