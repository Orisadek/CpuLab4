LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------
ENTITY top4 IS
  GENERIC (Y_size : INTEGER := 8;
		   X_size : integer := 8;
		   HEX_Size:integer := 14;
		   half_byte_size: integer := 4;
		   half_hex_size: integer := 7;
		   ALUout_size : integer := 8;
		   Brd_swtch_size: integer:= 8;
		   ALUFN_size : integer := 5);
  PORT 
  (       Board_swtch:in STD_LOGIC_VECTOR(Brd_swtch_size-1 DOWNTO 0);
		  key0,key1,key2: in STD_LOGIC;		  
		  ALUout4_o: out STD_LOGIC_VECTOR(HEX_Size-1 downto 0); --this is the output vector of ALUout_size;
		  hex32:out STD_LOGIC_VECTOR(HEX_Size-1 DOWNTO 0);
		  hex10:out STD_LOGIC_VECTOR(HEX_Size-1 DOWNTO 0);
		  LED95:out STD_LOGIC_VECTOR(ALUFN_size-1 DOWNTO 0);
		  N_o,C_o,Z_o:out STD_LOGIC
		  );
END top4;
------------- complete the top Architecture code --------------
ARCHITECTURE top_4_struct OF top4 IS
	SIGNAL reg0:STD_LOGIC_VECTOR(Y_size-1 DOWNTO 0);
	SIGNAL reg1:STD_LOGIC_VECTOR(X_size-1 DOWNTO 0);
	SIGNAL reg2:STD_LOGIC_VECTOR(ALUFN_size-1 DOWNTO 0); 
	SIGNAL Y_in:STD_LOGIC_VECTOR(Y_size-1 DOWNTO 0);
	SIGNAL X_in:STD_LOGIC_VECTOR(X_size-1 DOWNTO 0);
	SIGNAL ALUFN_in:STD_LOGIC_VECTOR(ALUFN_size-1 DOWNTO 0);
	SIGNAL ALUout_decode:STD_LOGIC_VECTOR(ALUout_size-1 DOWNTO 0);

BEGIN
-----------------------Port map Top----------------------------------------------------
top4_p : top port map( 
		Y_i=> Y_in,
		X_i=> X_in,
		ALUout_o=> ALUout_decode,
		ALUFN_i=> ALUFN_in,
		Nflag_o=> N_o,
		Cflag_o=> C_o,
		Zflag_o=>Z_o
	);
---------------------------------------------------------------------		 
	reg0 <= Board_swtch  when key0 = '0' else -- latch register for Y
			unaffected;
	
	reg1 <= Board_swtch  when key2 = '0' else -- latch register for X
			unaffected;
	
	reg2<= Board_swtch(ALUFN_size-1 DOWNTO 0) when key1 = '0' else -- latch register for Alufn
			unaffected;
	
	-----------------------ALUout decoder------------------------------------
	hex_portmap_4 : hexDecoder port map(   
		input=>ALUout_decode(half_byte_size-1 downto 0),
		decode=>ALUout4_o(half_hex_size-1 downto 0)
	);
	
	hex_portmap_5 : hexDecoder port map( 
		input=>ALUout_decode(Y_size-1 downto half_byte_size),
		decode=>ALUout4_o(HEX_Size-1 downto half_hex_size)
	);
	-------------------------------------------------------------------------------
	Y_in <= reg0;
	--------------------Y decoder------------------------------------
	hex_portmap_2 : hexDecoder port map(  
		input=>reg0(half_byte_size-1 downto 0),
		decode=>hex32(half_hex_size-1 downto 0)
	);
	
	hex_portmap_3 : hexDecoder port map( 
		input=>reg0(Y_size-1 downto half_byte_size),
		decode=>hex32(HEX_Size-1 downto half_hex_size)
	);
	--hex32  <= reg0; 
-----------------------------------------------------------------------------------
	X_in <= reg1;
-------------------------X decoder------------------------------------	
	--hex10 <= reg1;
	hex_portmap_0 : hexDecoder port map(  
		input=>reg1(half_byte_size-1 downto 0),
		decode=>hex10(half_hex_size-1 downto 0)
	);
	
	hex_portmap_1 : hexDecoder port map( 
		input=>reg1(Y_size-1 downto half_byte_size),
		decode=>hex10(HEX_Size-1 downto half_hex_size)
	);
---------------------------------------------------------------------------------------------------------------
	ALUFN_in<= reg2;
	LED95<= reg2;
------------------------------------------------------------------------		 
end top_4_struct;

