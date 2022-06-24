library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity comp_4 is port(
    P: in std_logic_vector(2 downto 0);
    end_game: out std_logic
    );
end comp_4;

architecture cmp4 of comp_4 is
begin
    end_game <= '1' when P = "100" else
                '0';
end cmp4;



