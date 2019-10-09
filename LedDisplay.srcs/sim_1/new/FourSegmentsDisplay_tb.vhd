----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.10.2019 16:46:59
-- Design Name: 
-- Module Name: FourSegmentsDisplay_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FourSegmentsDisplay_tb is
--  Port ( );
end FourSegmentsDisplay_tb;

architecture Behavioral of FourSegmentsDisplay_tb is

 -- Procedure for clock generation
  procedure clk_gen(signal clk : out std_logic; constant FREQ : real) is
    constant PERIOD    : time := 1 sec / FREQ;        -- Full period
    constant HIGH_TIME : time := PERIOD / 2;          -- High time
    constant LOW_TIME  : time := PERIOD - HIGH_TIME;  -- Low time; always >= HIGH_TIME
  begin
    -- Check the arguments
    assert (HIGH_TIME /= 0 fs) report "clk_plain: High time is zero; time resolution to large for frequency" severity FAILURE;
    -- Generate a clock cycle
    loop
      clk <= '1';
      wait for HIGH_TIME;
      clk <= '0';
      wait for LOW_TIME;
    end loop;
  end procedure;
  
component FourSegmentsDisplay is
    Port ( word : in STD_LOGIC_VECTOR (15 downto 0);
           display : out STD_LOGIC_VECTOR (6 downto 0);
           segments : out STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC);
end component FourSegmentsDisplay;

constant ClockFrequency : integer := 100e6; -- 100 MHz
constant ClockPeriod    : time    := 1000 ms / ClockFrequency;

signal word : STD_LOGIC_VECTOR(15 downto 0);
signal display: STD_LOGIC_VECTOR (6 downto 0);
signal segments: STD_LOGIC_VECTOR(3 downto 0);

signal clk : std_logic := '0';
begin

uut: FourSegmentsDisplay port map (
                                    word => word,
                                    display => display,
                                    segments => segments,
                                    clk => clk
                                    );
                                    

GENERATE_CLOCK: process
begin
   wait for (ClockPeriod / 2);
  clk <= '1';
 wait for (ClockPeriod / 2);
clk <= '0';
end process;

stimulis: process
variable digit : unsigned(15 downto 0) := to_unsigned(0,16);
begin 
  for i in 0 to 65535 loop
   digit := digit + 1;
   word <= STD_LOGIC_VECTOR(digit);
   wait for 100 ns;
  end loop;
wait for 10ns;
end process;

end Behavioral;
