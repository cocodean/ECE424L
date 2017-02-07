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
  Port (clk, reset, transmitting : in std_logic;
        SP : in std_logic_vector(8 downto 0);
        command_DAC, address_DAC : out std_logic_vector(3 downto 0);
        go_DAC : out std_logic;
        datain_DAC : out std_logic_vector(19 downto 0) );
end Counter_Sawtooth;

architecture Behavioral of Counter_Sawtooth is
-- signal holders -- 
signal SP_counter : unsigned(8 downto 0);
signal SP_mag : unsigned(5 downto 0);
signal command_DACs, address_DACs : std_logic_vector(3 downto 0);
signal datain_DACs : std_logic_vector(19 downto 0);

 -- state holders --
type state_type is (cs0, cs1, cs2, cs3, cs4, cs5, cs6);
signal state : state_type := cs0;

begin
command_DAC <= command_DACs;
address_DAC <= address_DACs;
datain_DAC <= datain_DACs;

process
    begin
        wait until(rising_edge(clk));
        if(reset = '1') then state <= cs0;
        else    
            case state is
                when cs0 => 
                        SP_counter <= unsigned(SP); 
                        SP_mag <= "000000"; 
                        datain_DACs <= x"00001"; 
                        command_DACs <= x"8"; 
                        address_DACs <= x"0"; 
                        state <= cs1;
                when cs1 => 
--                        go_DAC <= '1'; 
                        state <= cs2;
                when cs2 =>
                        if(transmitting = '0') then state <= cs3; end if;
                when cs3 => 
                        datain_DACs <= std_logic_vector(SP_mag)&"00000000000000"; 
                        command_DACs <= x"3"; 
                        address_DACs <= x"0"; 
                        state <= cs4;
                when cs4 => 
--                        go_DAC <= '1'; 
                        state <= cs5;
                when cs5 => 
                        SP_counter <= SP_counter - "000000001";
                        if(SP_counter = 0) 
                        then SP_counter <= unsigned(SP); 
                             SP_mag <= SP_mag + 1; 
                             state <= cs6;
                        end if;
                when cs6 =>
                        if(transmitting = '0') then state <= cs3;
                        end if;
                when others => -- do nothin
            end case;
        end if;
end process;

process(state)
begin
    if(state = cs1 or state = cs4) then go_DAC <= '1';
    else go_DAC <= '0'; end if;
end process;

end Behavioral;
