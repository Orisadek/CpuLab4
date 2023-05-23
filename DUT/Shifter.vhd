LIBRARY ieee;
library work;
USE ieee.std_logic_1164.all;
USE work.aux_package.all;
-------------------------------------
ENTITY Shifter IS
  GENERIC (n : INTEGER := 8; --generic lengh of vector n;
		   k : integer := 3); --generic value for log(n);
  PORT (   dir: IN STD_LOGIC_VECTOR (2 DOWNTO 0); --vector of lengh k that determines that direction of the shift;
	x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0); -- -- two input vectors of lengh 'n';
             cout: OUT STD_LOGIC; --contains the bit that was shifted outside of the shifted vector; 
             res: OUT STD_LOGIC_VECTOR(n-1 downto 0)); --output vector that contains the vector after the shift;
END Shifter;
--------------------------------------------------------------
ARCHITECTURE shftr OF Shifter IS
type matrix is array (k-1 DOWNTO 0) of STD_LOGIC_VECTOR(n-1 downto 0); --Matrix of size kxn is used to store the value after each shifting level;
	SIGNAL zero_vec : STD_LOGIC_VECTOR(n-1 DOWNTO 0); --is used for padding;
	SIGNAL output:matrix;
	SIGNAL cout_vec:STD_LOGIC_VECTOR(k-1 DOWNTO 0);
	SIGNAL q : STD_LOGIC_VECTOR(k-1 DOWNTO 0); --vector of size k that contains the number of shifts that needs to be done
BEGIN
	
	zero_vec<=(others=>'0');
	q<=x(k-1 downto 0);
-------------------------------------------------Handling 1ST level shift----------------------------------------
	--if_dir: if dir="000" or dir="001" generate 
		output(0) <= y when q(0)='0' and dir="000" else --note that output(0) is the first line of the Matrix;
				  y(n-2 downto 0)&zero_vec(0) when q(0)='1' and dir="000" else --if 1 level shifting should be done (q(0) =1) shift y with one bit, pad with 1 zero, insert to the matrix;
				  y when q(0)='0' and dir="001" else --symmetricali solves the same way for the other direction;
				  '0'&y(n-1 downto 1) when q(0)='1' and dir="001" else
				  zero_vec;
				  
		cout_vec(0)<= '0' when q(0)='0' and dir="000" else --inserting the poped out bit to cout vector;
					y(n-1) when q(0)='1' and dir="000" else
					'0' when q(0)='0' and dir="001" else
					y(0) when q(0)='1' and dir="001" else
					'0';
				  
------------------------------------------------Handling from 2nd level to k-2 level-----------------------------------		
	for_i:for i in 1 to k-2 generate --the general case;
		output(i) <= output(i-1) when q(i)='0' and dir="000" else
				output(i-1)(n-1-(2**i) downto 0)&zero_vec(2**i -1 DOWNTO 0) when q(i)='1' and dir="000" else
				output(i-1) when q(i)='0' and dir="001" else
				zero_vec(2**i -1 DOWNTO 0)&output(i-1)(n-1 downto (2**i)) when q(i)='1' and dir="001" else 
				zero_vec;
		
		cout_vec(i)<= cout_vec(i-1) when q(i)='0' and dir="000" else
					output(i-1)(n-(2**i)) when q(i)='1' and dir="000" else
					cout_vec(i-1) when q(i)='0' and dir="001" else
					output(i-1)(2**i-1) when q(i)='1' and dir="001" else
					'0';
	
		end generate;
	------------------------------------------------Handling last level shift (k-1 level)-----------------------------------	
		output(k-1) <= output(k-2) when q(k-1)='0' and dir="000" else
					output(k-2) when q(k-1)='0' and dir="001" else
				 	 output(k-2)(n-1-(2**(k-1)) downto 0)&zero_vec(2**(k-1) -1 DOWNTO 0) when q(k-1)='1' and dir="000" else
					zero_vec(2**(k-1) -1 DOWNTO 0)&output(k-2)(n-1 downto (2**(k-1)))  when q(k-1)='1' and dir="001" else
					zero_vec;
		
		cout_vec(k-1)<= cout_vec(k-2) when q(k-1)='0' and dir="000" else
					output(k-2)(n-(2**(k-1))) when q(k-1)='1' and dir="000" else
					cout_vec(k-2) when q(k-1)='0' and dir="001" else
					output(k-2)((2**(k-1))-1) when q(k-1)='1' and dir="001" else
					'0';
	--end generate;			
	res<=output(k-1);
	cout<=cout_vec(k-1);
	

END shftr;
	
