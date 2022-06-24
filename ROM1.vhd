library ieee;
use ieee.std_logic_1164.all;

entity ROM1 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
    
end ROM1;

architecture Rom_Arch of ROM1 is

type memory is array (00 to 15) of std_logic_vector(15 downto 0);
constant my_Rom : memory := (

	00 => "0001001000000100",  --1204
	01 => "0001010100110100",  --1534
    02 => "0000001000110001",  --0231
	03 => "0010010000010011",  --2413
	04 => "0011000000010101",  --3015
	05 => "0011010100000001",  --3501
	06 => "0000010100010100",  --0514
	07 => "0100001000010011",  --4213
	08 => "0011010000010010",  --3412
	09 => "0100001100000101",  --4305
    10 => "0001010001010010",  --1452
	11 => "0000000100100101",  --0125
	12 => "0011001001010001",  --3251
	13 => "0100001101010000",  --4350
	14 => "0010010000110001",  --2431
	15 => "0010000100110000"); --2130
	 
	
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