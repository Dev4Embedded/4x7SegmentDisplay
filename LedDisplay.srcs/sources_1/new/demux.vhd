----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2019 20:47:36
-- Design Name: 
-- Module Name: demux - Behavioral
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

entity demux is
    Port ( in_A : in STD_LOGIC_VECTOR (3 downto 0);
           in_B : in STD_LOGIC_VECTOR (3 downto 0);
           in_C : in STD_LOGIC_VECTOR (3 downto 0);
           in_D : in STD_LOGIC_VECTOR (3 downto 0);
           out_sel : out STD_LOGIC_VECTOR (3 downto 0);
           set : in STD_LOGIC_VECTOR (1 downto 0));
end demux;

architecture Behavioral of demux is

begin

demux_proc: process(set)
begin
    case set is
        when "00" => out_sel <= in_A;
        when "01" => out_sel <= in_B;
        when "10" => out_sel <= in_C;
        when "11" => out_sel <= in_D;
        when others => out_sel <= "0000";
     end case;
end process demux_proc;

end Behavioral;
