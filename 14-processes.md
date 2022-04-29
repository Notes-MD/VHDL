# Processes
convenient way of implementing more complex operations

is a group of `sequential` statements that are executed when certains event happen

certain kinds of statements are only allowed within processes

#### nested processes aren't allowed

```vhdl
architecture processed_eg of example
  begin
    signal A, B, C : std_logic;
    process( A, B )
      begin
        C <= not B;
        B <= not A;
    end process;

end architecture processed_eg
```

statements within a process are executed sequentially, unlike statements outside a process


Unlike a fucntion, changes made to variables within a process will remain even after process is over.

## Sensitive list
Any changes in the signal inn the sensitivity list causes the processes to be re-executed.

Process without sensitivity list would loop forever.

```vhdl
architecture sample of example is
signal A, B, C : std_logic;
begin
  process (A, B) -- A and B are sensitive signals
  begin
    A <= B and not A; -- this would restart the process with the updated values; would go recursive until A isn't changed.
    C <= B xor A;
  end process;
end architecture sample;
```