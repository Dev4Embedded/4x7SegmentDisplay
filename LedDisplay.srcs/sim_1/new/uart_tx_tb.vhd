----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.10.2019 12:46:25
-- Design Name: 
-- Module Name: uart_tx_tb - Behavioral
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

entity uart_tx_tb is
--  Port ( );
end uart_tx_tb;

architecture Behavioral of uart_tx_tb is

component uart_tx
	Port (  i_clk : in STD_LOGIC;
		i_data : in STD_LOGIC_VECTOR (7 downto 0);
		i_send: in STD_LOGIC;
		o_tx : out STD_LOGIC);
           
end component;

constant ClockFrequency : integer := 100e6; -- 100 MHz
constant ClockPeriod    : time    := 1000 ms / ClockFrequency;

signal clk  : STD_LOGIC := '0';
signal data : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal tx   : STD_LOGIC;
signal send : STD_LOGIC;
begin

uut: uart_tx port map (
					i_clk => clk,
					i_data => data,
					i_send => send,
					o_tx => tx
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
		data <= STD_LOGIC_VECTOR(byte);
		send <= '1';
		wait for 1 us;
		send <= '0';	
		wait for 1041.7 us;	
	end loop;
end process;


end Behavioral;
