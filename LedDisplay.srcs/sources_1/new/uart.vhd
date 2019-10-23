----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.10.2019 20:03:14
-- Design Name: 
-- Module Name: uart - Behavioral
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

entity uart_rx is
	Generic (CLK_PER_BIT : INTEGER := (100E6 / 9600));
	Port (
			i_clk    : in STD_LOGIC;
			i_rx     : in STD_LOGIC;
			o_data   : out STD_LOGIC_VECTOR (7 downto 0)
		);
end uart_rx;

architecture Behavioral of uart_rx is

type t_UART_SM is (
					sm_IDLE,
					sm_START,
					sm_DATA,
					sm_STOP
				);
signal r_UART_SM    : t_UART_SM := sm_IDLE; 
signal r_bit_rx     : STD_LOGIC;
signal r_clk_cntr   : INTEGER range 0 to CLK_PER_BIT := 0;
signal r_bit_cntr   : INTEGER range 0 to 7  := 0;
signal r_rx_data    : STD_LOGIC_VECTOR (7 downto 0);

begin
p_SAMPLE: process(i_clk)
begin
	if (rising_edge(i_clk)) then
		r_bit_rx <= i_rx;
	end if;
end process p_SAMPLE;

p_RECEIVE: process(i_clk)
begin
	if (rising_edge(i_clk)) then
		case r_UART_SM is

			when sm_IDLE =>
				if(r_bit_rx = '0') then
					r_UART_SM <= sm_START;
					r_clk_cntr <= 0;
					r_bit_cntr <= 0;
				end if;

			when sm_START =>
				r_clk_cntr <= r_clk_cntr + 1;
				if(r_clk_cntr = CLK_PER_BIT / 2)then
					r_clk_cntr <=0;
					r_UART_SM <= sm_DATA;
				end if;

			when sm_DATA =>
				if (r_clk_cntr = CLK_PER_BIT) then
					r_rx_data(r_bit_cntr) <= r_bit_rx;
					if(r_bit_cntr = 7) then
						r_UART_SM <= sm_STOP;
					else
						r_bit_cntr <= r_bit_cntr + 1;
					end if;
					r_clk_cntr <= 0;
				else
					r_clk_cntr <= r_clk_cntr + 1;
				end if;

				when sm_STOP =>
				if (r_clk_cntr = CLK_PER_BIT) then
					o_data <= r_rx_data;
					r_UART_SM <= sm_IDLE;
				else
					r_clk_cntr <= r_clk_cntr + 1;
				end if;

		end case;
	end if;
end process p_RECEIVE;

end Behavioral;
