----------------------------------------------------------------------------------
-- Company: CPP
-- Engineer: Dean Coco
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity B2BCD_test is
end B2BCD_test;

architecture Behavioral of B2BCD_test is
--component to be tested--
component B2BCD is
    Port (clk : in std_logic;
          V1, V2: in std_logic_vector(11 downto 0);
          DV13, DV12, DV11, DV10 : out std_logic_vector(3 downto 0); 
          DV23, DV22, DV21, DV20 : out std_logic_vector(3 downto 0));
end component;

--signals for testing--
signal clkt : std_logic;
signal V1t, V2t: std_logic_vector(11 downto 0);
signal DV13t, DV12t, DV11t, DV10t : std_logic_vector(3 downto 0); 
signal DV23t, DV22t, DV21t, DV20t : std_logic_vector(3 downto 0);

begin
dut: B2BCD port map(clkt, V1t, V2t, DV13t, DV12t, DV11t, DV10t, DV23t, DV22t, DV21t, DV20t);

clk_process: process
begin
    clkt <= '0'; wait for 1ns;
    clkt <= '1'; wait for 1ns;
end process;

sim_process: process
begin
    V1t <= x"483"; V2t <= x"524"; wait for 20ns;
    V1t <= x"583"; V2t <= x"624"; wait for 20ns;
    wait;
end process;

end Behavioral;
