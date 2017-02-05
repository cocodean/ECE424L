----------------------------------------------------------------------------------
-- Company: CPP
-- Engineer: Dean Coco
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter_Sawtooth is
  Port (clk : in std_logic;
        SP_counter_out : out std_logic_vector(7 downto 0);
        SP_mag_out : out std_logic_vector(5 downto 0) );
end Counter_Sawtooth;

architecture Behavioral of Counter_Sawtooth is
-- signal holders -- 
signal SP_counter : unsigned(7 downto 0);
signal SP_mag : unsigned(5 downto 0);
signal SP : unsigned;
signal datain_DAC : std_logic_vector(19 downto 0);
signal command_DAC, address_DAC : std_logic_vector(3 downto 0);
signal transmitting, go_DAC : std_logic;

type state_type is (cs0, cs1, cs2, cs3, cs4, cs5, cs6);

begin
    process
    begin
        case state is
            when cs0 => 
                    SP_counter <= SP; SP_mag <= 0; datain_DAC <= x"00001"; commmand_DAC <= x"0"; address_DAC <= x"0"; state <= cs1;
            when cs1 => 
                    go_DAC <= '1'; state <= cs2;
            when cs2 =>
                    if(transmitting = '0') then state <= cs3; end if;
            when cs3 => 
                    datain_DAC <= SP_mag&"00000000000000"; command_DAC <= x"0"; address_DAC <= x"0"; state <= cs4;
            when cs4 => 
                    go_DAC <= '1'; state <= cs5;
            when cs5 => 
                    SP_counter <= SP_counter - 1;
                    if(SP_counter = 0) 
                    then SP_counter <= SP; SP_mag <= SP_mag + 1; state <= cs6;
                    else SP_counter <= SP_counter - 1;
                    end if;
            when cs6 =>
                    if(transmitting = '0') then state <= cs3;
                    end if;
            when others => -- do nothin
        end case;
    end process;

end Behavioral;
