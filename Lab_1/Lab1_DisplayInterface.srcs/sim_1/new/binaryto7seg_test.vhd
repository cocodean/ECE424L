----------------------------------------------------------------------------------
-- Company: CPP
-- Engineer: Dean Coco
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity binaryto7seg_test is
end binaryto7seg_test;

architecture Behavioral of binaryto7seg_test is
--- component to be tested ---
component binaryto7seg is
    Port (En : in STD_LOGIC;
          bin_in : in std_logic_vector(3 downto 0);
          seg_out : out std_logic_vector (6 downto 0));
end component;

--- signals for testing ---
signal ent : std_logic;
signal bin_int : std_logic_vector(3 downto 0);
signal seg_outt : std_logic_vector(6 downto 0);

begin
dut: binaryto7seg port map(ent, bin_int, seg_outt);

sim_proces: process
begin
    ent <= '1'; bin_int <= x"0"; wait for 2 ns;
    ent <= '1'; bin_int <= x"1"; wait for 2 ns;
    ent <= '1'; bin_int <= x"2"; wait for 2 ns;
    ent <= '1'; bin_int <= x"3"; wait for 2 ns;
    ent <= '1'; bin_int <= x"4"; wait for 2 ns;
    ent <= '1'; bin_int <= x"5"; wait for 2 ns;
    ent <= '1'; bin_int <= x"6"; wait for 2 ns;
    ent <= '1'; bin_int <= x"7"; wait for 2 ns;
    ent <= '1'; bin_int <= x"8"; wait for 2 ns;
    ent <= '1'; bin_int <= x"9"; wait for 2 ns;
    ent <= '1'; bin_int <= x"A"; wait for 2 ns;
    ent <= '1'; bin_int <= x"B"; wait for 2 ns;
    ent <= '1'; bin_int <= x"C"; wait for 2 ns;
    ent <= '1'; bin_int <= x"D"; wait for 2 ns;
    ent <= '1'; bin_int <= x"E"; wait for 2 ns;
    ent <= '1'; bin_int <= x"F"; wait;
end process;

end Behavioral;
