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

entity Display_Controller is
  Port (clk : in std_logic;
        dv13, dv12, dv11, dv10 : in std_logic_vector(3 downto 0);
        dv23, dv22, dv21, dv20 : in std_logic_vector(3 downto 0);
        W : out std_logic;
        WADD : out std_logic_vector(2 downto 0);
        DIN : out std_logic_vector(5 downto 0) );
end Display_Controller;

architecture Behavioral of Display_Controller is
-- state control signal --
signal state : integer := 0;

--signals for the output--
signal WADD_sig : unsigned(2 downto 0); -- will convert to std_logic_vector later

begin
    process
    begin
        wait until(rising_edge(clk));
        case state is
            when 0 => WADD_sig <= "111"; DIN <= "00" & dv23; W <= '0'; state <= 1;
            when 1 => WADD_sig <= WADD_sig - 1; DIN <= "00" & dv22; state <= 2;
            when 2 => WADD_sig <= WADD_sig - 1; DIN <= "00" & dv21; state <= 3;
            when 3 => WADD_sig <= WADD_sig - 1; DIN <= "00" & dv20; state <= 4;
            when 4 => WADD_sig <= WADD_sig - 1; DIN <= "00" & dv13; state <= 5;
            when 5 => WADD_sig <= WADD_sig - 1; DIN <= "00" & dv12; state <= 6;
            when 6 => WADD_sig <= WADD_sig - 1; DIN <= "00" & dv11; state <= 7;
            when 7 => WADD_sig <= WADD_sig - 1; DIN <= "00" & dv10; state <= 8;
            when 8 => W <= '1'; state <= 0;
            when others => state <= 0;
        end case;
    end process;
    WADD <= std_logic_vector(WADD_sig);
end Behavioral;
