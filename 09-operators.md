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
[return to content](https://github.com/Notes-MD/VHDL#vhdl-cheatsheet)
