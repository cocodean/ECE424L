----------------------------------------------------------------------------------
-- Company: CPP
-- Engineer: Dean Coco
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Debouncer_test is
end Debouncer_test;

architecture Behavioral of Debouncer_test is
--component section--
component Pb_Debouncer is
    Port (Ent : in std_logic;
          clk : in std_logic;             -- button push in
          W : out std_logic );            -- debounced button push out
end component;

--signals section--
--inputs--
signal clkt : std_logic := '0';
signal Entt : std_logic := '0';
--output--
signal Wt : std_logic;

begin
dut: Pb_Debouncer port map(Entt, clkt, Wt);

clk_process: process
begin
wait for 1ns;
    clkt <= not clkt;
end process clk_process;

simulation_process: process
begin
Entt <= '1'; wait for 10ns;
Entt <= '0'; wait for 10ns;
Entt <= '1'; wait for 10ns;
Entt <= '0'; wait for 10ns;
end process simulation_process;

end Behavioral;
