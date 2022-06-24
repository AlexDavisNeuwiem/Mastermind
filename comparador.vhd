library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity comparador is port(
    A: in std_logic_vector(3 downto 0);
    B: in std_logic_vector(3 downto 0);
    C: out std_logic
    );
end comparador;

architecture arc_comp of comparador is
begin
    C <= '1' when A = B else
                '0';
end arc_comp;

