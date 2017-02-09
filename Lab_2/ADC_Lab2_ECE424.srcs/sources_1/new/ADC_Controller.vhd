----------------------------------------------------------------------------------
-- Company: CPP
-- Engineer: Dean Coco
-- 
-- Additional Comments:
-- ECE 424L, Lab 2 Analog to Digital Converter
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ADC_Controller is
  Port (clk, ready : in std_logic;
        dataIn : in std_logic_vector(15 downto 0);
        V1, V2 : out std_logic_vector(11 downto 0);
        addr_in : out std_logic_vector(6 downto 0));
end ADC_Controller;

architecture Behavioral of ADC_Controller is
--signal--
signal state : integer := 0;
--signal addr_in_s : std_logic_vector

begin
    process
    begin
    wait until(rising_edge(clk));
        case state is
            when 0 => if(ready = '1') then V1 <= dataIn(15 downto 4); addr_in <= b"001_1011"; state <= 1;
                      end if;
            when 1 => if(ready = '1') then V2 <= dataIn(15 downto 4); addr_in <= b"001_0011"; state <= 0;
                      end if;
            when others => state <= 0;
        end case;
    end process;
end Behavioral;
