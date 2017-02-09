----------------------------------------------------------------------------------
-- Company: CPP
-- Engineer: Dean Coco
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Pb_Debouncer is
  Port (Ent : in std_logic;
        clk : in std_logic;
        W : out std_logic );
end Pb_Debouncer;

architecture Behavioral of Pb_Debouncer is
-- D Flip Flop to synchronize the user button push --
component DFF is
    Port (clk : in STD_LOGIC;
          D : in STD_LOGIC;
          Q : out STD_LOGIC);
end component;

-- Debouncer module --
component Debouncer is
    Port (clk : in STD_LOGIC;
          spb : in STD_LOGIC;
          w : out STD_LOGIC);
end component;

-- signals for wire connections and output holder --
signal dpb_s : std_logic;
signal spb_s : std_logic;

begin
dff1: DFF port map(clk, Ent, dpb_s);
dff2: DFF port map(clk, dpb_s, spb_s);
switch_debounce: Debouncer port map(clk, spb_s, W);

end Behavioral;
