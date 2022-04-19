# Example Design: Dice
`Counter.vhdl`
```vhdl
-- entity
entity Counter is
  port (clock     : in  std_logic;
        roll      : in  std_logic;
        rollValue : out std_logic_vector(2 downto 0));
end Counter;

-- architecture
architecture Behavioral of Counter is
signal count : std_logic_vector(2 downto 0);
begin
  process (clock)
  begin
    if rising_edge(clock) then
      if (roll = '1') then
        if (count = "110") then
          count <= "001";
        else
          count <= count + "001";
        end if;
      end if;
    end if;
  end process
  rollValue <= count;

end architecture Behavioral;
```

`Decoder.vhdl`
```vhdl
entity Decoder is
  port ( rollValue  : in  std_logic_vector(2 downto 0), 
         dieLEDs    : out std_logic_vector(3 downto 0));
end entity Decoder;

architecture Behavioral of Decoder is
begin
  dieLEDs <= "0001" when rollValue = "001" else
             "0100" when rollValue = "010" else
             "0101" when rollValue = "011" else
             "0110" when rollValue = "100" else
             "0111" when rollValue = "101" else
             "1110" ;
end architecture Behavioral;

-- this die will not have 0 and 7; since dices are from 1-6. 
-- for these values, the dice will show 6

-- here the `dieLEDs` represent vectors of 4 elements- "d c b a", for:
-- b     c
-- d  a  d
-- c     b
```

`TopLevel.vhdl`
```vhdl
entity TopLevel is
  port ( clock        : in   std_logic;
          rollButton  : in   std_logic;
          dieLEDs     : iyt  std_logic_vector(3 downto 0));
end entity TopLevel;

architecture Structure of TopLevel is

-- used to wire together the modules internally
signal rollValue : std_logic_vector(2 downto 0);

begin
  -- instaniate the counter module (/calling counter method)
  theCounter:
    entity work.Counter.Behaviroal
    port map ( clock      => clock,
               roll       => rollButton,
               rollValue  => rollValue);

  -- instaniate the decoder module (/calling decoder method)
  theDecoder:
  entity work.Decoder
    port map ( rollValue  => rollValue,
               dieLEDs    => dieLEDs);

end architecture Structure;
```

-----------------------
[return to content](https://github.com/Notes-MD/VHDL#vhdl-cheatsheet)
