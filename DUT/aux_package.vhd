library IEEE;
use ieee.std_logic_1164.all;

package aux_package is
---------------------------------------------------------------------
component top_signal_tap IS
  GENERIC (HEX_Size:integer := 14;
		   Brd_swtch_size: integer:= 8;
		   ALUFN_size : integer := 5);
  PORT 
  (     Board_swtch:in STD_LOGIC_VECTOR(Brd_swtch_size-1 DOWNTO 0);
		  key0,key1,key2: in STD_LOGIC;		  
		  ALUout4_o: out STD_LOGIC_VECTOR(HEX_Size-1 downto 0); --this is the output vector of ALUout_size;
		  hex32:out STD_LOGIC_VECTOR(HEX_Size-1 DOWNTO 0);
		  hex10:out STD_LOGIC_VECTOR(HEX_Size-1 DOWNTO 0);
		  LED95:out STD_LOGIC_VECTOR(ALUFN_size-1 DOWNTO 0);
		  N_o,C_o,Z_o:out STD_LOGIC;
		  clk:in STD_LOGIC
		  );
END component;
--------------------------------------------------------
component top4 is
	GENERIC (Y_size : INTEGER := 8;
		   X_size : integer := 8;
		   HEX_Size:integer := 14;
		   half_byte_size: integer := 4;
		   half_hex_size: integer := 7;
		   ALUout_size : integer := 8;
		   Brd_swtch_size: integer:= 8;
		   ALUFN_size : integer := 5); 
	PORT 
	(  
		 Board_swtch:in STD_LOGIC_VECTOR(Brd_swtch_size-1 DOWNTO 0);
		  key0,key1,key2: in STD_LOGIC;		  
		  ALUout4_o: out STD_LOGIC_VECTOR(HEX_Size-1 downto 0); --this is the output vector of ALUout_size;
		  hex32:out STD_LOGIC_VECTOR(HEX_Size-1 DOWNTO 0);
		  hex10:out STD_LOGIC_VECTOR(HEX_Size-1 DOWNTO 0);
		  LED95:out STD_LOGIC_VECTOR(ALUFN_size-1 DOWNTO 0);
		  N_o,C_o,Z_o:out STD_LOGIC
		); 
end component;

------------------------------------------------------------------------------------------------------------
component top is
	GENERIC (n : INTEGER := 8;
		     k : integer := 3;   -- k=log2(n)
		     m : integer := 4	); -- m=2^(k-1)
	PORT 
	(  
		Y_i,X_i: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		ALUout_o: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		Nflag_o,Cflag_o,Zflag_o: OUT STD_LOGIC); -- Zflag,Cflag,Nflag
end component;
---------------------------------------------------------  
component FA is
	PORT (
		xi, yi, cin: IN std_logic;
		s, cout: OUT std_logic);
end component; 	
---------------------------------------------------------	
component Logic is
	GENERIC (n : INTEGER := 8); 
	PORT (
		ALUFN: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
        res: OUT STD_LOGIC_VECTOR(n-1 downto 0));
end component; 	
---------------------------------------------------------	
component Shifter is
	GENERIC (n : INTEGER := 8;
			 k : integer := 3); 
	PORT (
		dir: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
        cout: OUT STD_LOGIC;
        res: OUT STD_LOGIC_VECTOR(n-1 downto 0));
end component; 	
---------------------------------------------------------	
component AdderSub is
	GENERIC (n : INTEGER := 8); 
	PORT (
		ALUFN: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
        cout: OUT STD_LOGIC;
        res: OUT STD_LOGIC_VECTOR(n-1 downto 0));
end component; 	
---------------------------------------------------------	
component hexDecoder IS -- the decoder for the hex
  GENERIC (
		   HEX_size:integer := 7;
		   input_size : integer := 4
		   );
  PORT 
  (       input:in std_logic_vector(input_size-1 downto 0);
		  decode:out std_logic_vector(HEX_size-1 downto 0)
		  );
end component;

-------------------------------------------------------------------
	
end aux_package;

