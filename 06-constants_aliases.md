# Constants

convenient for unchanged values
```vhdl
constant limit : integer := 17;
constant delay : time := 5 ns;
constant vec   : bit_vector(3 downto 0) := "1100";
```

# Aliases

- used to rename signals to make their purpose clearer or for convenience.
- they may also be used to access sub-ranges of vectors
```vhdl
signal data : bit_vector(15 downto 0);

-- lower byte of data
alias low_data : bit_vector( 7 downto 0) is data(7 downto 0);

-- upper byte of data
alias high_data : bit_vector( 7 downto 0) is data(15 downto 8);

-- with this, later on in the same coad, instead of writing 
-- data(15 downto 8), we can just write high_data
```

-----------------------
[return to content](https://github.com/Notes-MD/VHDL#vhdl-cheatsheet)
