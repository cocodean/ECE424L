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

entity B2BCD is
  Port (clk : in std_logic;
        V1, V2: in std_logic_vector(11 downto 0);
        DV13, DV12, DV11, DV10 : out std_logic_vector(3 downto 0); 
        DV23, DV22, DV21, DV20 : out std_logic_vector(3 downto 0));
end B2BCD;

architecture Behavioral of B2BCD is
-- signals --
signal D3t, D2t, D1t, D0t : unsigned(3 downto 0) := x"0";
signal R : unsigned(11 downto 0);

signal state : integer := 0;

begin
    process
    begin
    wait until(rising_edge(clk));
        case state is
            when 0 => R <= unsigned(V1); state <= 1;
            when 1 => if(R > 999) then D3t <= D3t + 1; R <= R - 1000;
                      elsif(R > 99) then D2t <= D2t + 1; R <= R - 100;
                      elsif(R > 9) then D1t <= D1t + 1; R <= R - 10;
                      else DV10 <= std_logic_vector(R(3 downto 0)); DV11 <= std_logic_vector(D1t); DV12 <= std_logic_vector(D2t); DV13 <= std_logic_vector(D3t);
                           R <= unsigned(V2); D3t <= x"0"; D2t <= x"0"; D1t <= x"0"; state <= 2;
                      end if;
            when 2 => if(R > 999) then D3t <= D3t + 1; R <= R - 1000;
                      elsif(R > 99) then D2t <= D2t + 1; R <= R - 100;
                      elsif(R > 9) then D1t <= D1t + 1; R <= R - 10;
                      else DV20 <= std_logic_vector(R(3 downto 0)); DV21 <= std_logic_vector(D1t); DV22 <= std_logic_vector(D2t); DV23 <= std_logic_vector(D3t);
                           R <= unsigned(V1); D3t <= x"0"; D2t <= x"0"; D1t <= x"0"; state <= 0;
                      end if;
            when others => state <= 0;
        end case;
    end process;

end Behavioral;
