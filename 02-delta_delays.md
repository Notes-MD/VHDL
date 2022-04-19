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
[return to content](https://github.com/Notes-MD/VHDL#vhdl-cheatsheet)
