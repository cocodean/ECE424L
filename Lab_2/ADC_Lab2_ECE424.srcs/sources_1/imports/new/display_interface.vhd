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

entity display_interface is
  Port (clk : in std_logic;
        W : in std_logic;
        WADD : in std_logic_vector(2 downto 0);
        DIN : in std_logic_vector(5 downto 0);
        Ena : out std_logic_vector(7 downto 0);
        seg7_out : out std_logic_vector(6 downto 0);
        DP : out std_logic );
end display_interface;

architecture Behavioral of display_interface is

-- components section ---
component RAM is
    Port(clk  : in STD_LOGIC;
         W : in std_logic;
         WADD : in std_logic_vector(2 downto 0);
         DIN : in std_logic_vector(5 downto 0);
         RADD : in std_logic_vector(2 downto 0);
         DOUT : out std_logic_vector(5 downto 0));
end component;

component counter20b is
    Port(clk : in std_logic;
         count : out std_logic_vector(19 downto 0) );
end component;

component decoder3to8 is
    Port (select_in : in std_logic_vector(2 downto 0);
          decode_out : out std_logic_vector(7 downto 0));
end component;

component binaryto7seg is
    Port (En : in STD_LOGIC;
          bin_in : in std_logic_vector(3 downto 0);
          seg_out : out std_logic_vector (6 downto 0));
end component;

-- signals section --
signal counter_s : std_logic_vector(19 downto 0);
signal dout_s : std_logic_vector(5 downto 0);

begin
counter20b_t: counter20b port map(clk, counter_s);
ram_t: RAM port map(clk, W, WADD, DIN, counter_s(19 downto 17), dout_s);
decoder3x8: decoder3to8 port map(counter_s(19 downto 17), Ena);
b2sseg: binaryto7seg port map(dout_s(5), dout_s(4 downto 1), seg7_out);
DP <= dout_s(0);

end Behavioral;
