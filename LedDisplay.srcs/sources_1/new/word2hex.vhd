----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2019 20:21:01
-- Design Name: 
-- Module Name: word2hex - Behavioral
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

entity word2hex is
	Port ( word : in STD_LOGIC_VECTOR (15 downto 0);
			nibble0 : out STD_LOGIC_VECTOR (3 downto 0);
			nibble1 : out STD_LOGIC_VECTOR (3 downto 0);
			nibble2 : out STD_LOGIC_VECTOR (3 downto 0);
			nibble3 : out STD_LOGIC_VECTOR (3 downto 0));
end word2hex;

architecture Behavioral of word2hex is

signal nib0 : STD_LOGIC_VECTOR (3 downto 0);
signal nib1 : STD_LOGIC_VECTOR (3 downto 0);
signal nib2 : STD_LOGIC_VECTOR (3 downto 0);
signal nib3 : STD_LOGIC_VECTOR (3 downto 0);

begin

	nibble0 <= nib0;
	nibble1 <= nib1;
	nibble2 <= nib2;
	nibble3 <= nib3;

	nib0 <= word(3 downto 0);
	nib1 <= word(7 downto 4);
	nib2 <= word(11 downto 8);
	nib3 <= word(15 downto 12);

end Behavioral;
