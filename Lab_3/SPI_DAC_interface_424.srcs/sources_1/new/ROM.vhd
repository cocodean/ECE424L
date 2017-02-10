library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM is
port(
    read_en     : in std_logic; --read enable
    address     : in std_logic_vector(5 downto 0); --63 locations of rom
    data        : out std_logic_vector(11 downto 0) -- 12 bit samples to be outputted
    );
end ROM;

architecture behavioral of ROM is 
--RAM block 12x64
type RAM is array (integer range <>) of unsigned(11 downto 0); 
signal memory : RAM(0 to 63) := (others => "000000000000");

--Cosine Wave generator
signal Amplitude    : std_logic_vector(11 downto 0);

begin

ROM_proc: process(read_en)
begin
if(read_en = '1') then
  for addresst in 0 to 63 loop
       memory(addresst) <= to_unsigned(addresst,12);
  end loop;
end if;
end process ROM_proc;

data <= std_logic_vector(memory (to_integer(unsigned(address)))) when (read_en = '1') else (others => '0');

end behavioral;