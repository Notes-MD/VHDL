library IEEE;
use IEEE.std_logic_1164.ALL;

entity bank_safe is
    port (am                : in    std_logic;
          three_oclock       : in    std_logic;
          ten_oclock        : in    std_logic;
          mon, tue, wed, thu, fri, sat    : in    std_logic;
          unlock            : out   std_logic);
end entity bank_safe;

architecture behaviour of bank_safe is
    signal sat_open, work_morn, work_eve, work_days : std_logic;
begin
    work_days   <= mon or tue or wed or thu or fri;
    work_mor    <= am and ten_oclock and work_days;
    work_eve    <= (not am) and three_oclock and work_days;
    sat_open    <= (not am) and three_oclock and sat;
    unlock      <= sat_open or work_mor or work_eve;
end architecture behaviour;
