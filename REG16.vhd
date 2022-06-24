library ieee;
use ieee.std_logic_1164.all;

entity REG16 is port (
	CLK,R,E: in std_logic;	
	D: in std_logic_vector(15 downto 0);
	Q: out std_logic_vector(15 downto 0));
end REG16;

architecture regreg of REG16 is
begin
	process(CLK,R)
	begin
		
		if (R = '1') then
			Q <= "0000000000000000";
		elsif (CLK'event and CLK = '1') then
			if (E = '1') then
				Q <= D;
			end if;
		end if;
	
	end process;
end regreg;