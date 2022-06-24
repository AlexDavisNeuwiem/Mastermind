library IEEE;
use IEEE.Std_Logic_1164.all;

entity MUX4_16 is
port (W,X,Y,Z: in std_logic_vector(15 downto 0);
      sel: in std_logic_vector(1 downto 0);
      saida: out std_logic_vector(15 downto 0) );
end MUX4_16;

architecture code of MUX4_16 is
begin 
    with sel select saida <= W when "00",
                             X when "01",
                             Y when "10",
	                         Z when others;
end code;