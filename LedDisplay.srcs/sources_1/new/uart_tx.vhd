----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.10.2019 20:34:28
-- Design Name: 
-- Module Name: uart_tx - Behavioral
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

entity uart_tx is
	Generic (CLK_PER_BIT : INTEGER := (100E6 / 9600));
	Port (  i_clk : in STD_LOGIC;
		i_data : in STD_LOGIC_VECTOR (7 downto 0);
		i_send: in STD_LOGIC;
		o_tx : out STD_LOGIC);
           
end uart_tx;

architecture Behavioral of uart_tx is
type t_UART_SM is (
	sm_IDLE,
	sm_START,
	sm_DATA,
	sm_STOP
	);
signal r_UART_SM : t_UART_SM := sm_IDLE;
signal r_clk : STD_LOGIC;
signal r_clk_cntr   : INTEGER range 0 to CLK_PER_BIT := 0;
signal r_bit_cntr   : INTEGER range 0 to 7  := 0;
begin
p_SAMPLE: process(i_clk)
begin
	if (rising_edge(i_clk)) then
	
	end if;
end process p_SAMPLE;

p_TRANSMIT: process(i_clk)
begin
	if (rising_edge(i_clk)) then
		case r_UART_SM is
			--State machine - IDLE:
			when sm_IDLE =>
				if (i_send = '1') then	
					o_tx <= '0';
					r_clk_cntr <= 0;
					r_UART_SM <= sm_START;
				end if;
			--State machine - START:
			when sm_START =>
				if (r_clk_cntr >= CLK_PER_BIT) then
					r_UART_SM <= sm_DATA;
					r_clk_cntr <= 0;
					r_bit_cntr <= 0;
				else
					r_clk_cntr <= r_clk_cntr + 1;
				end if;
	
			--State machine - DATA:
			when sm_DATA =>
				o_tx <= i_data(r_bit_cntr);
				if (r_clk_cntr >= CLK_PER_BIT) then
					if(r_bit_cntr >= 7) then
						r_UART_SM <= sm_STOP;
					end if;
					r_bit_cntr <= r_bit_cntr + 1;
					r_clk_cntr <= 0;
				else
					r_clk_cntr <= r_clk_cntr + 1;
				end if;

			--State machine - STOP:
			when sm_STOP =>
				o_tx <= '1';
				if (r_clk_cntr >= CLK_PER_BIT) then
					r_UART_SM <= sm_IDLE;
					r_clk_cntr <= 0;
				else
					r_clk_cntr <= r_clk_cntr + 1;
				end if;		 
		end case;		
	end if;
end process p_TRANSMIT;

end Behavioral;
