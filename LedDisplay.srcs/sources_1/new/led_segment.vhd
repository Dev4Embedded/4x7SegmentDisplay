----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2019 18:02:03
-- Design Name: 
-- Module Name: led_segment - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity led_segment is
    Port (
           hex : in STD_LOGIC_VECTOR (3 downto 0);
           leds : out STD_LOGIC_VECTOR (6 downto 0)
          );
end led_segment;

architecture Behavioral of led_segment is
signal output : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
begin
    leds <= not output;

--			   A
--			 -----
--			|	  |
--		  F |     | B
--			|  G  |
--			 -----
--			|	  |
--		  E |     | C
--			|	  |
--			 -----
--			   D
segment_proc : process(hex)
begin
    case hex is
--         Num :               GFEDCBA  
       when x"0" => output <= "0111111";    -- 0 
       when x"1" => output <= "0000110";    -- 1
       when x"2" => output <= "1011011";    -- 2
	   when x"3" => output <= "1001111";	-- 3
	   when x"4" => output <= "1100110";	-- 4
	   when x"5" => output <= "1101101";	-- 5
	   when x"6" => output <= "1111101";	-- 6
	   when x"7" => output <= "0000111";	-- 7
	   when x"8" => output <= "1111111";	-- 8
	   when x"9" => output <= "1101111";	-- 9
	   when x"A" => output <= "1110111";	-- A
	   when x"B" => output <= "1111100";	-- B
	   when x"C" => output <= "0111001";	-- C
	   when x"D" => output <= "1011110";	-- D
	   when x"E" => output <= "1111001";	-- E
	   when x"F" => output <= "1110001";	-- F        
	   when others => output <= (others => 'X');
    end case;
end process segment_proc;

end Behavioral;
