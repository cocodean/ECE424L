----------------------------------------------------------------------------------
-- Company: CPP
-- Engineer: Dean Coco
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RAM_test is
end RAM_test;

architecture Behavioral of RAM_test is
-- component to be tested --
component RAM is 
    Port (clk : in STD_LOGIC;
          W : in std_logic;
          WADD : in std_logic_vector(2 downto 0);
          DIN : in std_logic_vector(5 downto 0);
          RADD : in std_logic_vector(2 downto 0);
          DOUT : out std_logic_vector(5 downto 0));
end component;

-- signals for testing --
signal clkt, wt : std_logic;
signal waddt, raddt : std_logic_vector(2 downto 0);
signal dint, doutt : std_logic_vector(5 downto 0);

begin
dut: RAM port map(clkt, wt, waddt, dint, raddt, doutt);

clk_process: process
begin
clkt <= '0'; wait for 1 ns;
clkt <= '1'; wait for 1 ns;
end process;

sim_process: process
begin
wt <= '1'; waddt <= "000"; dint <= "001000"; raddt <= "000"; wait for 2 ns;
wt <= '0'; waddt <= "001"; dint <= "001010"; raddt <= "000"; wait for 2 ns;
wt <= '1'; waddt <= "001"; dint <= "001010"; raddt <= "001"; wait for 2 ns;
wt <= '1'; waddt <= "100"; dint <= "001011"; raddt <= "001"; wait for 2 ns;
wt <= '1'; waddt <= "110"; dint <= "001110"; raddt <= "100"; wait for 2 ns;
wt <= '1'; waddt <= "111"; dint <= "011100"; raddt <= "110"; wait for 2 ns;
wt <= '0'; waddt <= "001"; dint <= "001010"; raddt <= "111"; wait for 2 ns;
end process;

end Behavioral;
