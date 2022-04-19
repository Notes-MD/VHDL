# Resolution function

```vhdl
signal A, B, C, T, W, Aen, Ben : std_logic;

-- valid
T   <=  A when Aen = '1' else 'Z';
T   <=  A when Ben = '1' else 'Z';

-- invalid (wont give error but wont be synthesized either)
W <= A or B;
W <= not C;
```

## `std_logic` resolution function
a functiuon thatm, given two driving values, determines the resulting outcome.  
\* built in table

|       | U &emsp; X &emsp; 0 &emsp; 1 &emsp; Z |
|-------|---------------------------------------|
| **U** | U &emsp; U &emsp; U &emsp; U &emsp; U |
| **X** | U &emsp; X &emsp; X &emsp; X &emsp; X |
| **0** | U &emsp; X &emsp; 0 &emsp; X &emsp; 0 |
| **1** | U &emsp; X &emsp; X &emsp; 1 &emsp; 1 |
| **Z** | U &emsp; X &emsp; 0 &emsp; 1 &emsp; Z |

`U` represents use of sighnals that are yet to be initialized  
`X` represents conflict between signals