library ieee;
use ieee.std_logic_1164.all;

entity ROM3 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
    
end ROM3;

architecture Rom_Arch of ROM3 is
  
type memory is array (00 to 15) of std_logic_vector(15 downto 0);
constant my_Rom : memory := (

	00 => "1001010110000010",  --9582
	01 => "0011000010001001",  --3089
    02 => "0000000101110010",  --0172
	03 => "1000000101110000",  --8170
	04 => "0001100000100111",  --1827
	05 => "0001100101000000",  --1940
	06 => "0110100100100100",  --6924
	07 => "0100001000000111",  --4207
	08 => "0011010010011000",  --3498
	09 => "1000011100100101",  --8725
    10 => "0100001010010001",  --4291
	11 => "0011100101000001",  --3941
	12 => "0000011000110100",  --0634
	13 => "0110100001110001",  --6871
	14 => "0011001001110110",  --3276
	15 => "0011011010000111"); --3687
	 
	
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