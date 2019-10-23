----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2019 20:56:02
-- Design Name: 
-- Module Name: segment_driver - Behavioral
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
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity segment_driver is
	Port ( 
		clk : in STD_LOGIC;
		selector : out STD_LOGIC_VECTOR (1 downto 0);
		segment : out STD_LOGIC_VECTOR (3 downto 0)
		);
end segment_driver;

architecture Behavioral of segment_driver is
signal result : STD_LOGIC_VECTOR(3 downto 0);
signal cntr : UNSIGNED(1 downto 0) := (others=> '0');
signal prescaler : UNSIGNED (31 downto 0) := (others => '0');
begin

	segment <= result;

counter_proc: process(clk)
	begin
		if(rising_edge(clk))then
			prescaler <= prescaler + 1;
			if(prescaler >= 500000)then
				prescaler <= (others => '0');
				selector <= STD_LOGIC_VECTOR(cntr);
				case cntr is
					when "00" => result <= "1110";
					when "01" => result <= "1101";
					when "10" => result <= "1011";
					when "11" => result <= "0111"; 
					when others => result <= "1111";
				end case;
				cntr <= cntr + 1;
				if(cntr > 3)then
					cntr <= "00";
				end if;
			end if;
		end if;
	end process counter_proc;

end Behavioral;
