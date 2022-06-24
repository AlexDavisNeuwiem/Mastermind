library ieee;
use ieee.std_logic_1164.all;

entity REG06 is port (
	CLK,R,E: in std_logic;	
	D: in std_logic_vector(5 downto 0);
	Q: out std_logic_vector(5 downto 0));
end REG06;

architecture regreg of REG06 is
begin
	process(CLK,R)
	begin
		
		if (R = '1') then
			Q <= "000000";
		elsif (CLK'event and CLK = '1') then
			if (E = '1') then
				Q <= D;
			end if;
		end if;
	
	end process;
end regreg;