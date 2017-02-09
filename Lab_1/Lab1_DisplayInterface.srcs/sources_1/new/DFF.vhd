----------------------------------------------------------------------------------
-- Company: CPP
-- Engineer: Dean Coco
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DFF is
    Port (clk : in STD_LOGIC;
          D : in STD_LOGIC;
          Q : out STD_LOGIC);
end DFF;

architecture Behavioral of DFF is

begin

DFF_proc: process(clk)
begin
    if (rising_edge(clk)) then
    Q <= D;
    end if;
end process DFF_proc;

end Behavioral;
