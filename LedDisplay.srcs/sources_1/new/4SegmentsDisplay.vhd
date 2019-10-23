----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2019 21:21:40
-- Design Name: 
-- Module Name: 4SegmentsDisplay - Behavioral
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

entity FourSegmentsDisplay is
	Port (
			display  : out STD_LOGIC_VECTOR (6 downto 0);
			segments : out STD_LOGIC_VECTOR (3 downto 0);
			rx       : in STD_LOGIC;
			clk      : in STD_LOGIC
		);
end FourSegmentsDisplay;

architecture behavior of FourSegmentsDisplay is

component led_segment
	Port (
		hex  : in STD_LOGIC_VECTOR (3 downto 0);
		leds : out STD_LOGIC_VECTOR (6 downto 0)
		);
end component;

component demux
	Port (
		in_A    : in STD_LOGIC_VECTOR (3 downto 0);
		in_B    : in STD_LOGIC_VECTOR (3 downto 0);
		in_C    : in STD_LOGIC_VECTOR (3 downto 0);
		in_D    : in STDW_LOGIC_VECTOR (3 downto 0);
		out_sel : out STD_LOGIC_VECTOR (3 downto 0);
		set     : in STD_LOGIC_VECTOR (1 downto 0)
	);
end component;

component word2hex
	Port ( 
		word    : in STD_LOGIC_VECTOR (15 downto 0);
		nibble0 : out STD_LOGIC_VECTOR (3 downto 0);
		nibble1 : out STD_LOGIC_VECTOR (3 downto 0);
		nibble2 : out STD_LOGIC_VECTOR (3 downto 0);
		nibble3 : out STD_LOGIC_VECTOR (3 downto 0)
	);
end component;

component segment_driver
	Port ( clk : in STD_LOGIC;
		selector : out STD_LOGIC_VECTOR (1 downto 0);
		segment : out STD_LOGIC_VECTOR (3 downto 0)
	);
end component;

--Signals:
signal sig_n0_A      : STD_LOGIC_VECTOR(3 downto 0);
signal sig_n1_B      : STD_LOGIC_VECTOR(3 downto 0);
signal sig_n2_C      : STD_LOGIC_VECTOR(3 downto 0);
signal sig_n3_D      : STD_LOGIC_VECTOR(3 downto 0);
signal sig_out_hex   : STD_LOGIC_VECTOR(3 downto 0);
signal sig_sel       : STD_LOGIC_VECTOR(1 downto 0);
signal sig_data_rx   : STD_LOGIC_VECTOR(7 downto 0);
signal sig_cntr      : INTEGER := 0;
signal sig_align     : STD_LOGIC_VECTOR(15 downto 0);
signal sig_rx_data   : STD_LOGIC_VECTOR(7 downto 0);       
signal sig_clk_trans : STD_LOGIC;
signal sig_clk_disp  : STD_LOGIC;
signal sig_rx        : STD_LOGIC := '1';

begin
sig_rx <= rx;
sig_clk_trans <= clk;
sig_clk_disp <= clk;
sig_align(7 downto 0) <= sig_rx_data;
sig_align(15 downto 8) <= x"DA";

	m_hex: led_segment
		port map(sig_out_hex,display);
	m_demux: demux
		port map(sig_n0_A,sig_n1_B,sig_n2_C,sig_n3_D,sig_out_hex,sig_sel);
	m_word2hex: word2hex
		port map(sig_align,sig_n0_A,sig_n1_B,sig_n2_C,sig_n3_D);
	m_segment_driver: segment_driver
		port map(sig_clk_disp,sig_sel,segments);

end behavior;
