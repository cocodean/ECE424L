----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/18/2017 11:45:00 AM
-- Design Name: 
-- Module Name: topLayer_userEnd_test - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity topLayer_userEnd_test is
end topLayer_userEnd_test;

architecture Behavioral of topLayer_userEnd_test is
--component section--
component topLayer_userEnd is
    Port (clk : in std_logic;
        Ent : in std_logic;
        WADD : in std_logic_vector(2 downto 0);
        DIN : in std_logic_vector(5 downto 0);
        Ena_ : out std_logic_vector(7 downto 0);
        seg7_out : out std_logic_vector(6 downto 0);
        DP : out std_logic );
end component;

--signals section--
--inputs--
signal clkt : std_logic := 0;
signal Entt : std_logic := 0;
signal WADDt : std_logic_vector(2 downto 0) := "000";
signal DINt : std_logic_vector(5 downto 0) := "000000";
--outputs--
signal Ena_t : std_logic_vector(7 downto 0);
signal seg7_outt : std_logic_vector(6 downto 0);
signal DPt : std_logic;

begin
dut: topLayer_userEnd port map(clk => clkt, Ent => Entt, WADD => WADDt,
                               DIN => DINt, Ena_ => Ena_t, 
                               seg7_out => seg7_outt, DP => DPt);
clk_process: process
begin
wait for 10ns;
    clkt <= not clkt;
end process clk_process;

simulation_process: process
begin
Entt <= '0'; WADDt <= "010"; DINt <= "111111"; wait for 10ns;
Entt <= '1'; WADDt <= "010"; DINt <= "111111"; wait for 10ns;
Entt <= '0'; WADDt <= "010"; DINt <= "111111"; wait for 10ns;
Entt <= '1'; WADDt <= "011"; DINt <= "111111"; wait for 10ns;
Entt <= '0'; WADDt <= "011"; DINt <= "111111"; wait for 10ns;
Entt <= '1'; WADDt <= "110"; DINt <= "111100"; wait for 10ns;
Entt <= '0'; WADDt <= "110"; DINt <= "111100"; wait for 10ns;
wait;
end process simulation_process;

end Behavioral;
