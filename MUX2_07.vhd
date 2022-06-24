library IEEE;
use IEEE.Std_Logic_1164.all;

entity MUX2_07 is
port (X,Y: in std_logic_vector(6 downto 0);
      sel: in std_logic;
      saida: out std_logic_vector(6 downto 0) );
end MUX2_07;

architecture code of MUX2_07 is
begin 
    with sel select saida <= X when '0',
	                         Y when others;
end code;
