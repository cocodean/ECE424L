----------------------------------------------------------------------------------
-- Company: CPP
-- Engineer: Dean Coco
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ADC_Controller_test is
end ADC_Controller_test;

architecture Behavioral of ADC_Controller_test is
--components--
component ADC_Controller is
    Port (clk, ready : in std_logic;
          dataIn : in std_logic_vector(15 downto 0);
          V1, V2 : out std_logic_vector(11 downto 0));
end component;

--signals--
signal clkt, readyt : std_logic;
signal dataInt : std_logic_vector(15 downto 0);
signal V1t, V2t : std_logic_vector(11 downto 0);

begin
dut: ADC_Controller port map(clkt, readyt, dataInt, V1t, V2t);

clk_process: process
begin 
    clkt <= '0'; wait for 2 ns;
    clkt <= '1'; wait for 2 ns;
end process;

sim_process: process
begin
    readyt <= '0'; dataInt <= x"0111"; wait for 6 ns;
    readyt <= '1'; dataInt <= x"0111"; wait for 6 ns;
    readyt <= '0'; dataInt <= x"0101"; wait for 6 ns;
    readyt <= '1'; dataInt <= x"0101"; wait for 6 ns;
    readyt <= '0'; dataInt <= x"0111"; wait for 6 ns;
    readyt <= '1'; dataInt <= x"0110"; wait for 6 ns;
end process;

end Behavioral;
