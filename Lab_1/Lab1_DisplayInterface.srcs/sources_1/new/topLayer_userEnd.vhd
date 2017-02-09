----------------------------------------------------------------------------------
-- Company: CPP
-- Engineer: Dean Coco
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity topLayer_userEnd is
  Port (clk : in std_logic;
        Ent : in std_logic;
        WADD : in std_logic_vector(2 downto 0);
        DIN : in std_logic_vector(5 downto 0);
        Ena : out std_logic_vector(7 downto 0);
        seg7_out : out std_logic_vector(6 downto 0);
        DP : out std_logic );
end topLayer_userEnd;

architecture Behavioral of topLayer_userEnd is
-- components section--
component display_interface is
    Port (clk : in std_logic;
          W : in std_logic;
          WADD : in std_logic_vector(2 downto 0);
          DIN : in std_logic_vector(5 downto 0);
          Ena : out std_logic_vector(7 downto 0);
          seg7_out :  out std_logic_vector(6 downto 0);
          DP : out std_logic );
end component;

component Pb_Debouncer is
    Port (Ent : in std_logic;
          clk : in std_logic;
          W : out std_logic );
end component;

--signals section--
signal w_s : std_logic;

begin

debouncer_inst: Pb_Debouncer port map(Ent, clk, w_s);
display_interface_inst: display_interface port map(clk, w_s, WADD, DIN, Ena, seg7_out, DP);

end Behavioral;
