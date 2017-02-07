----------------------------------------------------------------------------------
-- Company: CPP
-- Engineer: Dean Coco
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SPI_Interface_test is
end SPI_Interface_test;

architecture Behavioral of SPI_Interface_test is
-- module to be tested --
component SPI_Interface is
    Port (clk, go_DAC, reset : in std_logic;
        datain_DAC : in std_logic_vector(19 downto 0);
        address_DAC, command_DAC : in std_logic_vector(3 downto 0);
        transmitting, SPI_MOSI, DAC_CS, SPI_SCK : out std_logic );
end component;

-- signals to use for testing --
signal clkt, go_DACt, resett : std_logic;
signal datain_DACt : std_logic_vector(19 downto 0);
signal address_DACt, command_DACt : std_logic_vector(3 downto 0);
signal transmittingt, SPI_MOSIt, DAC_CSt, SPI_SCKt : std_logic;

begin
dut: SPI_Interface port map(clkt, go_DACt, resett, datain_DACt, address_DACt, command_DACt, 
                            transmittingt, SPI_MOSIt, DAC_CSt, SPI_SCKt);
clk_process: process
begin
    clkt <= '0'; wait for 1 ns;
    clkt <= '1'; wait for 1 ns;
end process;

simulation_process: process
begin
go_DACt <= '0'; resett <= '0'; datain_DACt <= x"00000"; address_DACt <= x"0"; command_DACt <= x"0"; wait for 2 ns;
go_DACt <= '1'; resett <= '0'; datain_DACt <= x"00000"; address_DACt <= x"0"; command_DACt <= x"0"; wait for 2 ns;
wait;
end process;

end Behavioral;
