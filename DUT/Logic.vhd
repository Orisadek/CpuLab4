LIBRARY ieee;
library work;
USE ieee.std_logic_1164.all;
USE work.aux_package.all;
-------------------------------------
-------------------------------------
ENTITY Logic IS
  GENERIC (n : INTEGER := 8);
  PORT ( 
			ALUFN: IN STD_LOGIC_VECTOR (2 DOWNTO 0); --using the 3 lsb bits to determine how to operate;
			x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);  -- two vectors of lengh 'n';
            res: OUT STD_LOGIC_VECTOR(n-1 downto 0));  -- the output vector which is the solution of the operation;
END Logic;
--------------------------------------------------------------
ARCHITECTURE lgc OF Logic IS

BEGIN
	res<= not(y) when ALUFN="000" else
		y or x when ALUFN="001" else
		y and x when ALUFN="010" else
		y xor x when ALUFN="011" else
		y nor x when ALUFN="100" else
		y nand x when ALUFN="101" else
		y xnor x when ALUFN="111" else
		(others=>'0');
	 --as explained in office hours -> cout should be 0 in logic;

END lgc;

