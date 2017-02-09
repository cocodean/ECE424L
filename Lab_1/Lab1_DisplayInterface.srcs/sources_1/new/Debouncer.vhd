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

entity debouncer is
    Port (clk : in STD_LOGIC;
          spb : in STD_LOGIC;
          w : out STD_LOGIC);
end debouncer;

architecture debouncerA of debouncer is
--- system states ---
type state_type is (s0,s1,s2,s3,s4,s5);
signal state : state_type := s0;
-- output signal holders --
signal SDC : unsigned( 19 downto 0) := (others =>'0');-- has to be 10 downto 0
signal D7ms : unsigned(19 downto 0) := "10101010111001100000";
signal w_s : std_logic := '0';

begin
w <= w_s;
main:process
begin
    wait until(rising_edge(clk));    
    case state is
        when s0 => w_s <= '0'; if (spb = '1') then SDC <= D7ms; state <= s1; end if;
        when s1 =>   SDC <= SDC - x"00001"; if (SDC = x"00000") then  state <= s2; else state <=s1; end if; --SDC <= SDC - "00000000000000000001";
        when s2 => if (spb = '1') then state <= s3; else state <= s0; end if;
        when s3 => if (spb = '1') then state <= s3; else SDC <= D7ms; state <= s4; end if;
        when s4 =>  SDC <= SDC - x"00001"; if ( SDC = x"00000") then state <= s5; end if;
        when s5 => w_s <= '1'; state <= s0;
    end case;
end process;

w <= '1' when (state = s5) else '0';

end debouncerA;
