----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2019 19:07:52
-- Design Name: 
-- Module Name: led_tb - Behavioral
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
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity led_segment_tb is
end;

architecture bench of led_segment_tb is

component led_segment
	Port (
		hex : in STD_LOGIC_VECTOR (3 downto 0);
		leds : out STD_LOGIC_VECTOR (6 downto 0)
		);
end component;

signal hex: STD_LOGIC_VECTOR (3 downto 0);
signal leds: STD_LOGIC_VECTOR (6 downto 0) ;

begin

uut: led_segment port map ( hex  => hex,
						    leds => leds );

stimulus: process
begin
	hex <= "0000";
--   leds <= "0000000";
	for i in 0 to 16 loop
		hex <= STD_LOGIC_VECTOR(to_unsigned(i,4));
		wait for 1 ns;
	end loop;

	wait;
end process;

end;
