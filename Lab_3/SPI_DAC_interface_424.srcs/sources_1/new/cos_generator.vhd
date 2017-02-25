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

entity cos_generator is
  Port (clk, reset, transmitting : in std_logic;
        SP : in std_logic_vector(8 downto 0);
        command_DAC, address_DAC : out std_logic_vector(3 downto 0);
        go_DAC : out std_logic;
        datain_DAC : out std_logic_vector(19 downto 0) );
end cos_generator;

architecture Behavioral of cos_generator is
-- signal holders -- 
signal SP_counter : unsigned(8 downto 0);
signal SP_mag : unsigned(5 downto 0) := "000000";
signal command_DACs, address_DACs : std_logic_vector(3 downto 0);
signal datain_DACs : std_logic_vector(19 downto 0);

 -- state holders --
type state_type is (cs0, cs1, cs2, cs3, cs4, cs5, cs6, cs7, cs8, cs9, cs10, cs11, cs12, cs13);
signal state : state_type := cs0;

-- ROM component --
component ROM is
    Port (read_ena : in std_logic;
          read_add : in std_logic_vector(5 downto 0);
          data_out : out std_logic_vector(11 downto 0) );
end component;

-- ROM signals --
signal rom_enable : std_logic := '1';
signal rom_data : std_logic_vector(11 downto 0);

begin
command_DAC <= command_DACs;
address_DAC <= address_DACs;
datain_DAC <= datain_DACs;

-- instantiate ROM --
myROM: ROM port map(rom_enable, std_logic_vector(sp_mag), rom_data);

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
                        command_DACs <= x"8";       -- setup internal ref register
                        address_DACs <= x"0";       -- output A
                        state <= cs1;
                when cs1 => -- send go_dac signal
                        state <= cs2;
                when cs2 =>
                        if(transmitting = '0') then state <= cs7; end if;
                when cs7 => -- setup the internal ref voltage for channel B
                            address_DACs <= x"1";   -- output B
                            state <= cs8;
                when cs8 => -- send go_dac signal
                        state <= cs9;
                when cs9 =>
                        if(transmitting = '0') then state <= cs3; end if;
                when cs3 => -- first send the cosine wave
                        datain_DACs <= rom_data &"00000000"; -- cosine wave
                        command_DACs <= x"3"; 
                        address_DACs <= x"0";   -- channel A
                        state <= cs4;
                when cs4 => -- send go_dac signal
                        state <= cs5;
                when cs5 => 
                        SP_counter <= SP_counter - "000000001";
                        if(SP_counter = 0) 
                        then SP_counter <= unsigned(SP); 
                             --SP_mag <= SP_mag + 1;    -- save for the end
                             state <= cs6;
                        end if;
                when cs6 =>
                        if(transmitting = '0') then state <= cs10;
                        end if;
                when cs10 => -- next send the sawtooth wave
                        datain_DACs <= std_logic_vector(SP_mag) & "00000000000000";
                        address_DACs <= x"1"; state <= cs11;
                when cs11 => -- send go_dac signal
                            state <= cs12;
                when cs12 => 
                        SP_counter <= SP_counter - "000000001";
                        if(SP_counter = 0) 
                        then SP_counter <= unsigned(SP); 
                             SP_mag <= SP_mag + 1;    -- save for the end
                             state <= cs13;
                        end if;
                when cs13 => if(transmitting = '0') then state <= cs3; end if;
                when others => -- do nothin
                            state <= cs0;
            end case;
        end if;
end process;

go_DAC <= '1' when(state = cs1 or state = cs4 or state = cs8 or state = cs11) else '0';

end Behavioral;
