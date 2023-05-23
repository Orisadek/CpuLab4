LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;

-------------------------------------
ENTITY hexDecoder IS
  GENERIC (
		   HEX_size:integer := 7;
		   input_size : integer := 4
		   );
  PORT 
  (       input:in std_logic_vector(input_size-1 downto 0);
		  decode:out std_logic_vector(HEX_size-1 downto 0)
		  );
END hexDecoder;
---------------------------

ARCHITECTURE decoder OF hexDecoder IS
signal decode_not:std_logic_vector(HEX_size-1 downto 0);
BEGIN
decode_not<=(6=>'0',others=>'1') when input = "0000" else -- 0
		(1=>'1',2=>'1',others=>'0') when input = "0001" else --1
		(2=>'0',5=>'0',others=>'1') when input = "0010" else --2
		(4=>'0',5=>'0',others=>'1') when input = "0011" else --3
		(0=>'0',3=>'0',4=>'0',others=>'1') when input = "0100" else --4
		(1=>'0',4=>'0',others=>'1') when input = "0101" else --5
		(1=>'0',others=>'1') when input = "0110" else --6
		(3=>'0',4=>'0',5=>'0',6=>'0',others=>'1') when input = "0111" else --7
		(others=>'1') when input = "1000" else --8
		(3=>'0',4=>'0',others=>'1') when input = "1001" else --9
		(3=>'0',others=>'1') when input = "1010" else --A
		(0=>'0',1=>'0',others=>'1') when input = "1011" else --B
		(0=>'0',1=>'0',2=>'0',5=>'0',others=>'1') when input = "1100" else --C
		(0=>'0',5=>'0',others=>'1') when input = "1101" else --D
		(1=>'0',2=>'0',others=>'1') when input = "1110" else --E
		(1=>'0',2=>'0',3=>'0',others=>'1'); --F

decode<=not decode_not;
------------------------------------------------------------------------		 
end decoder;
