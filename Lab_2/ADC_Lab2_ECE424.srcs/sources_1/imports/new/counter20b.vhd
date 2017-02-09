----------------------------------------------------------------------------------
-- Company: CPP
-- Engineer: Dean Coco
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter20b is
  Port (clk : in std_logic;
        count : out std_logic_vector(19 downto 0) );
end counter20b;

architecture Behavioral of counter20b is
signal count_s : unsigned(19 downto 0) := x"00000";
begin
count <= std_logic_vector(count_s);
clk_procc: process(clk)
    begin
    if(rising_edge(clk)) then 
        count_s <= count_s + x"00001";
    end if;
    end process;
end Behavioral;
