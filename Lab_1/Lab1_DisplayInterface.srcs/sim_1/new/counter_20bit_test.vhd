----------------------------------------------------------------------------------
-- Company: CPP
-- Engineer: ECE
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_20bit_test is
end counter_20bit_test;

architecture Behavioral of counter_20bit_test is
--- component to be tested ---
component counter20b is
    Port (clk : in std_logic;
          count : out std_logic_vector(19 downto 0) );
end component;

--- signals for testing ---
signal clkt : std_logic;
signal counts : std_logic_vector(19 downto 0);

begin
dut: counter20b port map(clkt, counts);

clk_process: process
begin
    clkt <= '0'; wait for 1ns;
    clkt <= '1'; wait for 1ns;
end process;

end Behavioral;
