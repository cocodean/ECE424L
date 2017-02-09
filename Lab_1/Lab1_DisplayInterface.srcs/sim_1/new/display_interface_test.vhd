----------------------------------------------------------------------------------
-- Company: CPP
-- Engineer: Dean Coco
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display_interface_test is
end display_interface_test;

architecture Behavioral of display_interface_test is
-- components section --
component display_interface is
    Port ( clk : in std_logic;
          W : in std_logic;
          WADD : in std_logic_vector(2 downto 0);
          DIN : in std_logic_vector(5 downto 0);
          Ena : out std_logic_vector(7 downto 0);
          seg7_out :  out std_logic_vector(6 downto 0);
          DP : out std_logic );
end component;
         
-- signals section --
--*inputs*--
signal clkt : std_logic := '0';
signal Wt : std_logic := '0';
signal WADDt : std_logic_vector(2 downto 0) := "000";
signal DINt : std_logic_vector(5 downto 0) := "000000";
--*outputs*--
signal Ena_t : std_logic_vector(7 downto 0);
signal seg7_outt : std_logic_vector(6 downto 0);
signal DPt : std_logic;

begin
dut: display_interface port map(clk => clkt, W => Wt, WADD => WADDt, 
                                 DIN => DINt, Ena => Ena_t, 
                                 seg7_out => seg7_outt, DP => DPt);
clk_process: process
begin
clkt <= '0'; wait for 1 ns;
clkt <= '1'; wait for 1 ns;
end process;

stim_proc: process
begin
Wt <= '0'; WADDt <= "001"; DINt <= "000001"; wait for 10ns;
Wt <= '1'; WADDt <= "010"; DINt <= "000010"; wait for 10ns;
Wt <= '0'; WADDt <= "011"; DINt <= "000100"; wait for 10ns;
Wt <= '1'; WADDt <= "100"; DINt <= "001000"; wait for 10ns;
Wt <= '0'; WADDt <= "101"; DINt <= "010000"; wait for 10ns;
Wt <= '1'; WADDt <= "110"; DINt <= "100000"; wait for 10ns;
Wt <= '0'; WADDt <= "111"; DINt <= "100001"; wait for 10ns;
wait;
end process stim_proc;
end Behavioral;
