LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------
ENTITY top IS
  GENERIC (n : INTEGER := 8;
		   k : integer := 3;   -- k=log2(n)
		   m : integer := 4	); -- m=2^(k-1)
  PORT 
  (  
		Y_i,X_i: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); --these are the input vectors of lengh n;
		  ALUFN_i : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		  ALUout_o: OUT STD_LOGIC_VECTOR(n-1 downto 0); --this is the output vector of lengh n;
		  Nflag_o,Cflag_o,Zflag_o: OUT STD_LOGIC 
  ); -- Zflag,Cflag,Nflag
end top;
------------- complete the top Architecture code --------------
ARCHITECTURE struct OF top IS 
	SIGNAL x_shft,y_shft:STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	SIGNAL x_adder, y_adder:STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	SIGNAL x_lgc, y_lgc: STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	SIGNAL cout_shftr,cout_adder : STD_LOGIC;
	SIGNAL res_shftr,res_adder,res_lgc  : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	SIGNAL zero_vec  : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	
BEGIN
zero_vec<=(others=>'0');
----------------------------------------------------------Assigning vector for shifter-----------------------------------------
	x_shft<= X_i when ALUFN_i(4 DOWNTO 3) = "10" else
			(others=>'0');
			
	y_shft<= Y_i when ALUFN_i(4 DOWNTO 3) = "10" else
			(others=>'0');
----------------------------------------------------------Assigning vector for Adder-----------------------------------------			
	x_adder<= X_i when ALUFN_i(4 DOWNTO 3) = "01" else
			(others=>'0');
			
	y_adder<= Y_i when ALUFN_i(4 DOWNTO 3) = "01" else
			(others=>'0');	
----------------------------------------------------------Assigning vector for Logic-----------------------------------------			
	x_lgc<= X_i when ALUFN_i(4 DOWNTO 3) = "11" else
			(others=>'0');
			
	y_lgc<= Y_i when ALUFN_i(4 DOWNTO 3) = "11" else
			(others=>'0');	
---------------------------------------------------------------------------------------------------------------------------
		Shifter_p : Shifter generic map (n,k) port map( 
			dir=>ALUFN_i(2 DOWNTO 0),
			x => x_shft,
			y => y_shft,
			cout=> cout_shftr,
			res => res_shftr
	);
		Adder_p : AdderSub generic map (n) port map(
			ALUFN => ALUFN_i(2 DOWNTO 0),
			x => x_adder,
			y => y_adder,
			cout=> cout_adder,
			res => res_adder
	);
	
		Logic_p : Logic generic map (n) port map(
			ALUFN => ALUFN_i(2 DOWNTO 0),
			x => x_lgc,
			y => y_lgc,
			res => res_lgc
	);
-------------------------------------------implementing MUX for output vector signal------------------------------------------	
		
		
		ALUout_o<= res_shftr when ALUFN_i(4 DOWNTO 3) = "10" else -- ALU Out value 
					res_adder when ALUFN_i(4 DOWNTO 3) = "01" else
					res_lgc when ALUFN_i(4 DOWNTO 3) = "11" else
					unaffected;
					
		
		Cflag_o<= cout_shftr when ALUFN_i(4 DOWNTO 3) = "10" else -- C flag value 
					cout_adder when ALUFN_i(4 DOWNTO 3) = "01" else
					'0' when ALUFN_i(4 DOWNTO 3) = "11" else
					unaffected;
		
		Nflag_o<= res_shftr(n-1) when ALUFN_i(4 DOWNTO 3) = "10" else -- N flag value 
					res_adder(n-1) when ALUFN_i(4 DOWNTO 3) = "01" else
					res_lgc(n-1) when ALUFN_i(4 DOWNTO 3) = "11" else
					unaffected;
		
		Zflag_o<=  '1' when ((ALUFN_i(4 DOWNTO 3) = "10") and res_shftr = zero_vec )  else -- Z flag value 
				'0' when ((ALUFN_i(4 DOWNTO 3) = "10") and not(res_shftr = zero_vec ))  else
				'1' when ALUFN_i(4 DOWNTO 3) = "01" and  res_adder = zero_vec else
				'0' when ALUFN_i(4 DOWNTO 3) = "01"and not(res_adder = zero_vec) else
				'1' when ALUFN_i(4 DOWNTO 3) = "11" and res_lgc = zero_vec else
				'0' when ALUFN_i(4 DOWNTO 3) = "11" and not(res_lgc = zero_vec) else
				unaffected;
		
			 
end struct;

