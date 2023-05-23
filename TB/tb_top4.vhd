-- test bench for top4
library IEEE;
library work;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity tb_top4 is
 GENERIC (Y_size : INTEGER := 8;
		   X_size : integer := 8;
		   HEX_Size:integer := 14;
		   half_byte_size: integer := 4;
		   half_hex_size: integer := 6;
		   ALUout_size : integer := 8;
		   Brd_swtch_size: integer:= 8;
		   ALUFN_size : integer := 5);
end tb_top4;
 
architecture top4tb_a of tb_top4 is
signal Board_swtch:STD_LOGIC_VECTOR(Brd_swtch_size-1 DOWNTO 0);
signal key0,key1,key2:STD_LOGIC;		  
signal ALUout4_o:STD_LOGIC_VECTOR(HEX_Size-1 downto 0); --this is the output vector of ALUout_size;
signal hex32:STD_LOGIC_VECTOR(HEX_Size-1 DOWNTO 0);
signal hex10:STD_LOGIC_VECTOR(HEX_Size-1 DOWNTO 0);
signal LED95:STD_LOGIC_VECTOR(ALUFN_size-1 DOWNTO 0);
signal N_o,C_o,Z_o:STD_LOGIC;
signal clk:STD_LOGIC;
begin

	top4_tb : top4 port map (Board_swtch,key0,key1,key2,ALUout4_o,hex32,
		  hex10,LED95,N_o,C_o,Z_o,clk);
			
	--------- start of stimulus section ------------------	
	 clk_gen : process
        begin
		  clk<='0';
		  wait for 50 ns;
		  clk<='1';
		  wait for 50 ns;
		end process;
	
     tb_top4_BoardSwitch : process
        begin
		  Board_swtch <= (others => '0');
		  wait for 50 ns;
		  for i in 0 to 50 loop
			Board_swtch <= Board_swtch+1;
			wait for 50 ns;
		  end loop;
		end process;
		
	tb_top4_key0 : process
        begin
		  key0 <= '0';
		  wait for 50 ns;
		  for i in 0 to 10 loop
			key0 <= key0 xor '1';
			wait for 50 ns;
		  end loop;
		end process;
		
	tb_top4_key1 : process
        begin
		 key1 <= '0';
		  wait for 100 ns;
		  for i in 0 to 10 loop
			key1 <= key1 xor '1';
			wait for 100 ns;
		  end loop;
		end process;
		
	tb_top4_key2 : process
        begin
	  key2 <= '0';
		  wait for 150 ns;
		  for i in 0 to 10 loop
			key2 <= key2 xor '1';
			wait for 150 ns;
		  end loop;
		end process;
		
end top4tb_a;

