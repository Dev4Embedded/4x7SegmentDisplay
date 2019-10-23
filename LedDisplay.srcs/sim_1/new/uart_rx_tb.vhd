----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.10.2019 21:54:52
-- Design Name: 
-- Module Name: uart_rx_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_rx_tb is
--  Port ( );
end uart_rx_tb;

architecture Behavioral of uart_rx_tb is

component uart_rx
	Port (
			i_clk    : in STD_LOGIC;
			i_rx     : in STD_LOGIC;
			o_data   : out STD_LOGIC_VECTOR (7 downto 0)
		);
end component;

constant ClockFrequency : integer := 100e6; -- 100 MHz
constant ClockPeriod    : time    := 1000 ms / ClockFrequency;

signal clk  : STD_LOGIC := '0';
signal rx   : STD_LOGIC := '1';
signal data : STD_LOGIC_VECTOR(7 downto 0) := (others => '0'); 
signal sample: STD_LOGIC;
begin

uut: uart_rx port map (
					i_clk => clk,
					i_rx => rx,
					o_data => data
					);

GENERATE_CLOCK: process
begin
	wait for (ClockPeriod / 2);
	clk <= '1';
	wait for (ClockPeriod / 2);
	clk <= '0';
end process;

stimulis: process
variable byte : UNSIGNED(7 downto 0) := to_unsigned(0,8);

begin
	wait for 200us;
	for i in 0 to 255 loop
		byte := to_unsigned(i,8);
		wait for 200us;
		rx <= '0';           -- START
		for j in 0 to 7 loop
			wait for 104.17us;
			rx <= byte(j);   -- BIT DATA(j)
		end loop;

		wait for 96us;
		rx <= '1';           -- BIT STOP
		wait for 500us;
	end loop;
end process;


end Behavioral;
