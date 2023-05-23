LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.aux_package.all;
-------------------------------------
ENTITY AdderSub IS
  GENERIC (n : INTEGER := 8);
  PORT ( 
		ALUFN: IN STD_LOGIC_VECTOR (2 DOWNTO 0);--using the 3 lsb bits to determine how to operate;
		x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);-- two vectors of lengh 'n';
        cout: OUT STD_LOGIC;--1 output bit 
      	res: OUT STD_LOGIC_VECTOR(n-1 downto 0));--The returned vector in which we have the solution of the operation
END AdderSub;
--------------------------------------------------------------
ARCHITECTURE dfl OF AdderSub IS
	SIGNAL reg : std_logic_vector(n-1 DOWNTO 0); --the carry that propogates between the FA's
	SIGNAL sub_cont:std_logic_vector(n-1 DOWNTO 0);--determines wether to perform + or - between the vectors
	SIGNAL Xsig,Ysig : std_logic_vector(n-1 DOWNTO 0); --signals that we use to change X and Y in order to execute 
	SIGNAL cin:STD_LOGIC;--STD_LOGIC; --1 input bit
BEGIN
	sub_cont<= (others=>'0') when ALUFN = "000" else 
		   (others=>'1') when   ALUFN = "001" else --Y-X is implemented as Y + (-X)
		   (others=>'1') when   ALUFN = "010" else-- Neg(x) is implemented as 0+(-X)
		   (others=>'0');
				
	cin<='0'when ALUFN = "000" else
	     '1' when   ALUFN = "001" else --as a part of 2's complement
	     '1' when   ALUFN = "010" else --as a part of 2's complement
		 '0';
	
	Xsig<= x xor sub_cont when ALUFN = "000" or  ALUFN = "001" or ALUFN = "010" else --we use it to perform 2's complement in the case of substracting, else doesn't change a thing
		(others=>'0');
		
	Ysig<= y when ALUFN = "000" else
		   y when ALUFN = "001" else
	       (others=>'0') when ALUFN = "010" else --as mentioned above -->Neg(x) is implemented as 0+(-X)
		   (others=>'0');
		   
	
	first : FA port map(
			xi => Xsig(0),
			yi => Ysig(0),
			cin => cin,
			s => res(0),
			cout => reg(0)
	);
	
	rest : for i in 1 to n-1 generate
		chain : FA port map(
			xi => Xsig(i),
			yi => Ysig(i),
			cin => reg(i-1),
			s => res(i),
			cout => reg(i)
		);
	end generate;
	
	cout <= reg(n-1);

END dfl;

