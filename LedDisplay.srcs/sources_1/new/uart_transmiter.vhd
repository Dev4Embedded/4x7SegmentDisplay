----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.10.2019 19:01:36
-- Design Name: 
-- Module Name: uart_transmiter - Behavioral
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

entity uart_transmiter is
    Port ( 
        clk     : in STD_LOGIC;
        rx      : in STD_LOGIC;
        data    : out STD_LOGIC_VECTOR (7 downto 0);
        tx	: out STD_LOGIC;
        send 	: in STD_LOGIC
        );
end uart_transmiter;

architecture Behavioral of uart_transmiter is

component uart_rx is
    Port  ( 
        i_clk    : in STD_LOGIC;
        i_rx     : in STD_LOGIC;
        o_data   : out STD_LOGIC_VECTOR (7 downto 0)
        );
end component uart_rx;

component uart_tx is
	Port (  i_clk : in STD_LOGIC;
		i_data : in STD_LOGIC_VECTOR (7 downto 0);
		i_send: in STD_LOGIC;
		o_tx : out STD_LOGIC
		);
end component uart_tx;
		

signal clk2clk :    STD_LOGIC;
signal rx2rx :      STD_LOGIC;
signal data2led:    STD_LOGIC_VECTOR(7 downto 0);

begin
clk2clk <= clk;
rx2rx <= rx;
data <= data2led;

m_uart_rx: uart_rx
	port map(clk2clk,rx2rx,data2led);

m_uart_tx: uart_tx
	port map(clk2clk,data2led,send,tx);

end Behavioral;
