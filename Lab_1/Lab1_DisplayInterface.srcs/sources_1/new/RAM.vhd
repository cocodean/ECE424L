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

entity RAM is
  Port (clk : in STD_LOGIC;
        W : in std_logic;
        WADD : in std_logic_vector(2 downto 0);
        DIN : in std_logic_vector(5 downto 0);
        RADD : in std_logic_vector(2 downto 0);
        DOUT : out std_logic_vector(5 downto 0));
end RAM;

architecture Behavioral of RAM is

type Memory is array (0 to 7) of std_logic_vector (5 downto 0);
signal RAM : Memory := (others => "000000");

begin

RAM_proc: process
begin 
    wait until (rising_edge(clk));
    if (W='1') then 
        RAM(to_integer(unsigned(WADD))) <= DIN;
    end if;
end process RAM_proc;

DOUT <= RAM(to_integer(unsigned(RADD)));
end Behavioral;
