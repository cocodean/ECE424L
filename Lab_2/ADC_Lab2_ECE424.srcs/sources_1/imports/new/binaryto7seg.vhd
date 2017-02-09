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

entity binaryto7seg is
  Port (En : in STD_LOGIC;
        bin_in : in std_logic_vector(3 downto 0);
        seg_out : out std_logic_vector (6 downto 0));
end binaryto7seg;

architecture Behavioral of binaryto7seg is
-- the 7-segment displays are active low --
type rom is array(0 to 15) of std_logic_vector(6 downto 0);
constant conv_bin : rom := ("0000001","1001111","0010010","0000110","1001100","0100100",
                            "0100000","0001111","0000000","0000100","0001000","1100000",
                            "0110001","1000010","0110000","0111000");

begin
seg_proc: process(bin_in, En)
	begin
	if En = '1' then seg_out <= conv_bin(to_integer(unsigned(bin_in)));
	else seg_out <= "1111111"; end if;
	end process;
end Behavioral;
