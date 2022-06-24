library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity SOMA is
port (
X:  in std_logic_vector(3 downto 0);
F:  out std_logic_vector(3 downto 0);
end_time: in std_logic
      );
end SOMA;

architecture sm of SOMA is

signal Y: std_logic_vector(3 downto 0);

begin 

Y <= (X) + "0001";

with (not end_time) select
    F <= ("1010" + Y)  when '1',
         "0000" when others;
  
end sm;
