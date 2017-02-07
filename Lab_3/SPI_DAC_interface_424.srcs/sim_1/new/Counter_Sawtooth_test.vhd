----------------------------------------------------------------------------------
-- Company: CPP
-- Engineer: Dean Coco
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Counter_Sawtooth_test is
end Counter_Sawtooth_test;

architecture Behavioral of Counter_Sawtooth_test is
-- component to be tested --
component Counter_Sawtooth is
    Port (clk, reset, transmitting : in std_logic;
          SP : in std_logic_vector(7 downto 0);
          command_DAC, address_DAC : out std_logic_vector(3 downto 0);
          go_DAC : out std_logic;
          datain_DAC : out std_logic_vector(19 downto 0) );
end component;

-- signals to use for testing --
signal clkt, resett : std_logic := '0';
signal SPt : std_logic_vector(7 downto 0);
signal command_DACt, address_DACt : std_logic_vector(3 downto 0) := b"0000";
signal transmittingt : std_logic;
signal datain_DACt : std_logic_vector(19 downto 0);
signal go_dACt : std_logic;

begin
dut: Counter_Sawtooth port map(clkt, resett, transmittingt, SPt, command_DACt, address_DACt, go_DACt, datain_DACt);

clk_process: process
begin
    clkt <= '0'; wait for 1 ns;
    clkt <= '1'; wait for 1 ns;
end process clk_process;

simulation_process: process
begin
    resett <= '1'; transmittingt <= '0'; SPt <= "00001111";  wait for 10 ns;
    resett <= '0'; transmittingt <= '1'; SPt <= "00000111";  wait for 10 ns;
    resett <= '0'; transmittingt <= '0'; SPt <= "00010111";  wait for 10 ns;
    resett <= '0'; transmittingt <= '1'; SPt <= "00001001";  wait for 10 ns;
    resett <= '0'; transmittingt <= '0'; SPt <= "10001111";  wait for 10 ns;
    resett <= '0'; transmittingt <= '1'; SPt <= "01101111";  wait for 10 ns;
    wait;
end process simulation_process;

end Behavioral;
