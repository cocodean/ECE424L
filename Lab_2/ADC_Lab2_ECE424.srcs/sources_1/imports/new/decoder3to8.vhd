----------------------------------------------------------------------------------
-- Company: CPP
-- Engineer: Dean Coco
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder3to8 is
  Port (select_in : in std_logic_vector(2 downto 0);
        decode_out : out std_logic_vector(7 downto 0));
end decoder3to8;

architecture Behavioral of decoder3to8 is

signal c0_not : std_logic;
signal c1_not : std_logic;
signal c2_not : std_logic;
--signal decode_out_ : std_logic_vector(7 downto 0);

begin
c0_not <= not select_in(0);
c1_not <= not select_in(1);
c2_not <= not select_in(2);

decode_out(0) <= c0_not and c1_not and c2_not;
decode_out(1) <= select_in(0) and c1_not and c2_not;
decode_out(2) <= c0_not and select_in(1) and c2_not;
decode_out(3) <= select_in(0) and select_in(1) and c2_not;
decode_out(4) <= c0_not and c1_not and select_in(2);
decode_out(5) <= select_in(0) and c1_not and select_in(2);
decode_out(6) <= c0_not and select_in(1) and select_in(2);
decode_out(7) <= select_in(0) and select_in(1) and select_in(2);

--decode_out <= decode_out_;

end Behavioral;
