----------------------------------------------------------------------------------
-- Company: CPP
-- Engineer: Dean Coco
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder3x8_test is
end decoder3x8_test;

architecture Behavioral of decoder3x8_test is
-- component to be tested --
component decoder3to8 is
    Port (select_in : in std_logic_vector(2 downto 0);
          decode_out : out std_logic_vector(7 downto 0));
end component;

-- signals for testing --
signal select_int : std_logic_vector(2 downto 0);
signal decode_outt : std_logic_vector(7 downto 0);

begin
dut: decoder3to8 port map(select_int, decode_outt);

sim_process: process
begin
select_int <= "000"; wait for 2 ns;
select_int <= "001"; wait for 2 ns;
select_int <= "010"; wait for 2 ns;
select_int <= "011"; wait for 2 ns;
select_int <= "100"; wait for 2 ns;
select_int <= "101"; wait for 2 ns;
select_int <= "110"; wait for 2 ns;
select_int <= "111"; wait for 2 ns;
end process;

end Behavioral;
