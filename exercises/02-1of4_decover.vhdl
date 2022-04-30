-- to implement:
-- sel(1- 0)  |  o(3-0)
--    00      |   0001
--    01      |   0010
--    10      |   0100
--    11      |   1000

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder_1of4 is
    port ( sel : in     std_logic_vector(1 downto 0);
            o  : out    std_logic_vector(3 downto 0));
end entity decoder_1of4;

architecture NoProc of decoder_1of4 is
begin
    with sel select
    0 <= "0001" when "00",
         "0010" when "01",
         "0100" when "10",
         "1000" when "11",
         "XXXX" when others;
end architecture NoProc;
