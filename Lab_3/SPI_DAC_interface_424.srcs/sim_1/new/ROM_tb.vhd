library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM_tb is
end ROM_tb;

architecture behavioral of ROM_tb is
--component instantiation
component ROM is
port(
    read_en     : in std_logic; --read enable
    address     : in std_logic_vector(5 downto 0); --63 locations of rom
    data        : out std_logic_vector(11 downto 0) -- 12 bit samples to be outputted
    );
end component;

signal read_en        : std_logic := '0';
signal address        : std_logic_vector(5 downto 0):= "000000";
signal data           : std_logic_vector (11 downto 0); 

begin
uut: ROM port map(read_en => read_en, address => address, data=> data);

stim_proc:process
begin
read_en <= '1'; 
address <= "111111"; wait for 10 ns;
address <= "111011"; wait for 10 ns;
address <= "101011"; wait for 10 ns;
address <= "111100"; wait for 10 ns;
address <= "100111"; wait;
end process;

end behavioral;