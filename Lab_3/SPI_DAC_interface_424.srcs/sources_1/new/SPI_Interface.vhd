----------------------------------------------------------------------------------
-- Company: CPP
-- Engineer:Dean Coco 
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SPI_Interface is
  Port (clk, go_DAC, reset : in std_logic;
        datain_DAC : in std_logic_vector(19 downto 0);
        address_DAC, command_DAC : in std_logic_vector(3 downto 0);
        transmitting, SPI_MOSI, DAC_CS, SPI_SCK : out std_logic );
end SPI_Interface;

architecture Behavioral of SPI_Interface is
-- signals and variable holders to use --
type state_type is (s0, s1, s2, s3, s4);
signal state : state_type := s0;
signal R : std_logic_vector(31 downto 0);
signal bitcounter : unsigned(4 downto 0);

begin
    process
    begin
        wait until(rising_edge(clk));
        case state is
            when s0 => SPI_SCK <= '0'; 
                       if(go_DAC = '1') 
                       then transmitting <= '1'; DAC_CS <= '0'; bitcounter <= "11111"; R <= x"0"&command_DAC&address_DAC&datain_DAC; state <= s1;
                       end if;
            when s1 => SPI_SCK <= '1'; state <= s2;
            when s2 => if(bitcounter = 0) then state <= s4;
                       else state <= s3;
                       end if;
            when s3 => R <= R(30 downto 0)&'0'; bitcounter <= bitcounter - 1; SPI_SCK <= '1'; state <= s4;
            when s4 => transmitting <= '0'; DAC_CS <= '1'; state <= s0;
            when others => state <= s0;
        end case;
        SPI_MOSI <= R(31);
    end process;
    
end Behavioral;
