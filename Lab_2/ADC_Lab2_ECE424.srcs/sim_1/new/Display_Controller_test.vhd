----------------------------------------------------------------------------------
-- Company: CPP
-- Engineer: Dean Coco
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Display_Controller_test is
end Display_Controller_test;

architecture Behavioral of Display_Controller_test is
--signals needed for testing--
signal clkt : std_logic;
signal dv13t, dv12t, dv11t, dv10t : std_logic_vector(3 downto 0);
signal dv23t, dv22t, dv21t, dv20t : std_logic_vector(3 downto 0);
signal Wt : std_logic;
signal WADDt : std_logic_vector(2 downto 0);
signal DINt : std_logic_vector(5 downto 0);

--component of the module to test--
component Display_Controller is
    Port (clk : in std_logic;
        dv13, dv12, dv11, dv10 : in std_logic_vector(3 downto 0);
        dv23, dv22, dv21, dv20 : in std_logic_vector(3 downto 0);
        W : out std_logic;
        WADD : out std_logic_vector(2 downto 0);
        DIN : out std_logic_vector(5 downto 0) );
end component;

begin
dut: Display_Controller port map(clkt, dv13t, dv12t, dv11t, dv10t, dv23t, dv22t, dv21t, dv20t, Wt, WADDt, DINt);

clk_process: process
begin
    clkt <= '0'; wait for 1 ns;
    clkt <= '1'; wait for 1 ns;
end process;

sim_process: process
begin
    dv13t <= x"0"; dv12t <= x"1"; dv11t <= x"2"; dv10t <= x"3";
        dv23t <= x"4"; dv22t <= x"5"; dv21t <= x"6"; dv20t <= x"7"; wait for 4ns;
    dv13t <= x"8"; dv12t <= x"9"; dv11t <= x"a"; dv10t <= x"b";
        dv23t <= x"c"; dv22t <= x"d"; dv21t <= x"e"; dv20t <= x"f"; wait for 4ns;
    dv13t <= x"0"; dv12t <= x"1"; dv11t <= x"2"; dv10t <= x"3";
        dv23t <= x"4"; dv22t <= x"5"; dv21t <= x"6"; dv20t <= x"7"; wait for 4ns;
    dv13t <= x"8"; dv12t <= x"9"; dv11t <= x"a"; dv10t <= x"b";
            dv23t <= x"c"; dv22t <= x"d"; dv21t <= x"e"; dv20t <= x"f"; wait for 4ns;
    dv13t <= x"0"; dv12t <= x"1"; dv11t <= x"2"; dv10t <= x"3";
                dv23t <= x"4"; dv22t <= x"5"; dv21t <= x"6"; dv20t <= x"7"; wait for 4ns;
    wait;
end process;

end Behavioral;
