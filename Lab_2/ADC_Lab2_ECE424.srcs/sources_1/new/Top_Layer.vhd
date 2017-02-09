----------------------------------------------------------------------------------
-- Company: CPP
-- Engineer: Dean Coco
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity Top_Layer is
  Port (clk : in std_logic;
        vauxp3, vauxn3 : in std_logic;
        vauxp11, vauxn11 : in std_logic;
        Ena : out std_logic_vector(7 downto 0);
        sseg : out std_logic_vector(6 downto 0);
        dp : out std_logic );
end Top_Layer;

architecture Behavioral of Top_Layer is
--** signals to connect the modules **--
signal enable : std_logic;
--- ADC -> ADC Controller ---
signal readys : std_logic;
signal address_ins : std_logic_vector(6 downto 0);
signal datas : std_logic_vector(15 downto 0);
--- ADC Controller -> B2BCD ----
signal v1s, v2s : std_logic_vector(11 downto 0);
---- B2BCD -> Display Controller ----
signal DV13s, DV12s, DV11s, DV10s : std_logic_vector(3 downto 0); 
signal DV23s, DV22s, DV21s, DV20s : std_logic_vector(3 downto 0);
---- Display Controller -> Display Interface ----
signal ws : std_logic;
signal wadds : std_logic_vector(2 downto 0);
signal dins : std_logic_vector(5 downto 0);

--** components comprising of the ADC controller and display **--
component ADC_Controller is
    Port (clk, ready : in std_logic;
          dataIn : in std_logic_vector(15 downto 0);
          V1, V2 : out std_logic_vector(11 downto 0);
          addr_in : out std_logic_vector(6 downto 0));
end component ADC_Controller;

component B2BCD is
    Port (clk : in std_logic;
          V1, V2: in std_logic_vector(11 downto 0);
          DV13, DV12, DV11, DV10 : out std_logic_vector(3 downto 0); 
          DV23, DV22, DV21, DV20 : out std_logic_vector(3 downto 0));
end component B2BCD;

component DisplayController is
    Port (clk : in std_logic;
          dv13, dv12, dv11, dv10 : in std_logic_vector(3 downto 0);
          dv23, dv22, dv21, dv20 : in std_logic_vector(3 downto 0);
          W : out std_logic;
          WADD : out std_logic_vector(2 downto 0);
          DIN : out std_logic_vector(5 downto 0) );
end component DisplayController;

component DisplayInterface is
    Port (clk : in std_logic;
          W : in std_logic;
          WADD : in std_logic_vector(2 downto 0);
          DIN : in std_logic_vector(5 downto 0);
          Ena : out std_logic_vector(7 downto 0);
          seg7_out : out std_logic_vector(6 downto 0);
          DP : out std_logic );
end component DisplayInterface;

component xadc_wiz_0 is
    port
   (
    daddr_in        : in  STD_LOGIC_VECTOR (6 downto 0);     -- Address bus for the dynamic reconfiguration port
    den_in          : in  STD_LOGIC;                         -- Enable Signal for the dynamic reconfiguration port
    di_in           : in  STD_LOGIC_VECTOR (15 downto 0) := (others => '0');    -- Input data bus for the dynamic reconfiguration port
    dwe_in          : in  STD_LOGIC := '0';                         -- Write Enable for the dynamic reconfiguration port
    do_out          : out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
    drdy_out        : out  STD_LOGIC;                        -- Data ready signal for the dynamic reconfiguration port
    dclk_in         : in  STD_LOGIC;                         -- Clock input for the dynamic reconfiguration port
    reset_in        : in  STD_LOGIC := '0';                         -- Reset signal for the System Monitor control logic
    vauxp3          : in  STD_LOGIC;                         -- Auxiliary Channel 3
    vauxn3          : in  STD_LOGIC;
    vauxp11         : in  STD_LOGIC;                         -- Auxiliary Channel 11
    vauxn11         : in  STD_LOGIC;
    busy_out        : out  STD_LOGIC;                        -- ADC Busy signal
    channel_out     : out  STD_LOGIC_VECTOR (4 downto 0);    -- Channel Selection Outputs
    eoc_out         : out  STD_LOGIC;                        -- End of Conversion Signal
    eos_out         : out  STD_LOGIC;                        -- End of Sequence Signal
    alarm_out       : out STD_LOGIC;                         -- OR'ed output of all the Alarms
    vp_in           : in  STD_LOGIC := '0';                         -- Dedicated Analog Input Pair
    vn_in           : in  STD_LOGIC := '0'
);
end component xadc_wiz_0;

begin
_adc_controller: ADC_Controller port map(clk, readys, datas, v1s, v2s, address_ins);
_B2BCD_inst: B2BCD port map(clk, v1s, v2s, dv13s, dv12s, dv11s, dv10s, dv23s, dv22s, dv21s, dv20s);
_display_controll: Display_Controller port map(clk, dv13s, dv12s, dv11s, dv10s, dv23s, dv22s, dv21s, dv20s, ws, wadds, dins);
_xadc_inst: xadc_wiz_0 port map(address_ins, enable, open, open, datas, readys, clk, open, vauxp3, vauxn3, vauxp11, vauxn11, open, open, enable, open, open, open, open);

end Behavioral;
