----------------------------------------------------------------------------------
-- Company: CPP
-- Engineer: Dean Coco
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top_Layer is
  Port (clk, reset : in std_logic;
        SP : in std_logic_vector(8 downto 0);
        SPI_MOSI, DAC_CS, SPI_SCK : out std_logic );
end Top_Layer;

architecture Behavioral of Top_Layer is
-- components that make up the top layer ---
component Counter_Sawtooth is
    Port (clk, reset, transmitting : in std_logic;
          SP : in std_logic_vector(8 downto 0);
          command_DAC, address_DAC : out std_logic_vector(3 downto 0);
          go_DAC : out std_logic;
          datain_DAC : out std_logic_vector(19 downto 0) );
end component Counter_Sawtooth;

component SPI_Interface is
    Port (clk, go_DAC, reset : in std_logic;
          datain_DAC : in std_logic_vector(19 downto 0);
          address_DAC, command_DAC : in std_logic_vector(3 downto 0);
          transmitting, SPI_MOSI, DAC_CS, SPI_SCK : out std_logic );
end component SPI_Interface;

--- signals to connect the two modules ---
signal go_dac_s : std_logic;
signal datain_dac_s : std_logic_vector(19 downto 0);
signal address_dac_s : std_logic_vector(3 downto 0);
signal command_dac_s : std_logic_vector(3 downto 0);
signal transmitting_s : std_logic;

begin
-- instantiate components ---
my_spi_interface: SPI_Interface port map(clk, go_dac_s, reset, datain_dac_s, address_dac_s, command_dac_s, transmitting_s, SPI_MOSI, DAC_CS, SPI_SCK);
my_wave_generator: Counter_Sawtooth port map(clk, reset, transmitting_s, SP, command_dac_s, address_dac_s, go_dac_s, datain_dac_s);

end Behavioral;
