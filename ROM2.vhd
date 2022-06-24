library ieee;
use ieee.std_logic_1164.all;

entity ROM2 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
    
end ROM2;

architecture Rom_Arch of ROM2 is
  
type memory is array (00 to 15) of std_logic_vector(15 downto 0);
constant my_Rom : memory := (

	00 => "0101001100110010",  --5312
	01 => "0011000100000101",  --3105
    02 => "0001000000100011",  --1023
	03 => "0111010100000011",  --7503
	04 => "0110000001010010",  --6052
	05 => "0110001001010001",  --6251
	06 => "0000001001010011",  --0253
	07 => "0101011001110000",  --5670
	08 => "0000001100010010",  --0312
	09 => "0111001101010000",  --7350
    10 => "0010011100010101",  --2715
	11 => "0100000000110110",  --4036
	12 => "0000000101100101",  --0165
	13 => "0001001000000011",  --1203
	14 => "0101000000110100",  --5034
	15 => "0101000101100100"); --5164
	 
	
begin
   process (address)
   begin
     case address is
       when "0000" => data <= my_rom(00);
       when "0001" => data <= my_rom(01);
       when "0010" => data <= my_rom(02);
       when "0011" => data <= my_rom(03);
       when "0100" => data <= my_rom(04);
       when "0101" => data <= my_rom(05);
       when "0110" => data <= my_rom(06);
       when "0111" => data <= my_rom(07);
       when "1000" => data <= my_rom(08);
       when "1001" => data <= my_rom(09);
	   when "1010" => data <= my_rom(10);
	   when "1011" => data <= my_rom(11);
       when "1100" => data <= my_rom(12);
	   when "1101" => data <= my_rom(13);
	   when "1110" => data <= my_rom(14);
	   when others => data <= my_rom(15);
     end case;
  end process;
end architecture Rom_Arch;