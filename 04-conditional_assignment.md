# Conditional Assignment

assignment to signal is dependent on a condition or conditions.
```vhdl
F <= A when E = '1' else
     0 when D = '1' else
     C;
```
condition statements can overlap, i.e. both first `when` and `else when` can be true, however, the first condition has highest priority. In circuit design, the higher the priority, the later the condition's mux would be mapped.
#### ⚠ priority matters here ⚠

```
      | \             
 C--- |0  \           | \
      |     |         |   \
      |     |-------- |0    |  
 0--- |1    |         |     |-------- F
      |   /       A-- |1    |  
      | / |           |   /
          |           | / |
          D               |
                          E
```

### 4 Ways of implemention (same result)
```vhdl
F <= I0 when A = '0' and B = '0' else
     I1 when A = '0' and B = '1' else
     I2 when A = '1' and B = '0' else
     I3;
```
```vhdl
F <= (I0 and not A and not B) or
     (I1 and not A and B) or
     (I2 and A and not B) or
     (I3 and A and B);
```
```vhdl
--when no priority
F <= I0 when std_logic_vector'(A&B) = "00" else
     I1 when std_logic_vector'(A&B) = "01" else
     I2 when std_logic_vector'(A&B) = "10" else
     I3;
```
```vhdl
--recommended wayz
sel <= A&B; --concatenate a, b
F <= I0 when sel = "00" else
     I1 when sel = "01" else
     I2 when sel = "10" else
     I3;
```

#### ⚠ use of `when` statement signifies that **mux** is used. ⚠

-----------------------
[return to content](https://github.com/Notes-MD/VHDL#vhdl-cheatsheet)
