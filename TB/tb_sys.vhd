-- test bench for adder sub unit
library IEEE;
library work;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;

entity tb_sys is
	constant n : integer := 8;
	constant k : integer := 2;   -- k=log2(n)
	constant m : integer := 4;   -- m=2^(k-1)
	constant max_range : integer := 15; 
end tb_sys;
 
architecture sys_a of tb_sys is
	type matrix_alu is array (0 to max_range) of std_logic_vector(4 downto 0);
	SIGNAL Y,X:  STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	SIGNAL ALUFN :  STD_LOGIC_VECTOR (4 DOWNTO 0);
	SIGNAL ALUout:  STD_LOGIC_VECTOR(n-1 downto 0); -- ALUout[n-1:0]&Cflag
	SIGNAL Nflag,Cflag,Zflag:  STD_LOGIC; -- Zflag,Cflag,Nflag
	SIGNAL alu_op : matrix_alu := ("01000","01001","01010","10000","10001","10010",
							"11000","11001","11010","11011","11100","11101","11110","11111","00000","00100");
begin

	top_t : top generic map (n,k,m) port map(Y,X,ALUFN,ALUout,Nflag,Cflag,Zflag);
    
	--------- start of stimulus section ------------------	
	
        tb_sys_x : process
        begin
		  x <= (others => '0');
		  wait for 50 ns;
		  for i in 0 to 50 loop
			x <= x+1;
			wait for 50 ns;
		  end loop;
		--  wait;
		end process tb_sys_x;
		
		  tb_sys_y : process
        begin
		  y <= (others => '1');
		  wait for 100 ns;
		  for i in 0 to 100 loop
			y <= y-1;
			wait for 100 ns;
		  end loop;
		--  wait;
		end process tb_sys_y;
		
		
		tb_sys_ALUFN : process
        begin
		 -- ALUFN <= (others => '0');
		  for j in 0 to max_range loop
			ALUFN <= alu_op(j);
			wait for 200 ns;
		  end loop;
		--  wait;
        end process tb_sys_ALUFN;
		
		
		
end architecture sys_a;

