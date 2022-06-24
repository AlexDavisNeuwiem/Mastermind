library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;

entity Controle is port ( 
    Enter, Reset, CLK, end_game, end_time, end_round: in std_logic;
    R1, R2, E1, E2, E3, E4, E5: out std_logic
  );
end Controle;

architecture arc_ctrl of Controle is
  
    type STATES is (init, setup, play, result, count_round, check, waitt);
    signal EstAtual, EstProximo: STATES;

begin

  process(CLK, Reset)
  begin
    if (Reset = '1') then
	  EstAtual <= init;
	elsif (CLK'event AND CLK = '1') then 
  	  EstAtual <= EstProximo;
	end if;
  end process;
  
  process(EstAtual, Enter, end_game, end_time, end_round)
  begin
    case EstAtual is
    
      when init =>
        R1 <= '1';
        R2 <= '1';
        E1 <= '0';
        E2 <= '0';
        E3 <= '0';
        E4 <= '0';
        E5 <= '0';
		EstProximo <= setup;
        
      when setup =>
        R1 <= '0';
        R2 <= '0';
        E1 <= '1';
        E2 <= '0';
        E3 <= '0';
        E4 <= '0';
        E5 <= '0';
        if (Enter = '1') then
		  EstProximo <= play;
		else
		  EstProximo <= setup;
		end if;
      
      when play =>
        R1 <= '0';
        R2 <= '0';
        E1 <= '0';
        E2 <= '1';
        E3 <= '0';
        E4 <= '0';
        E5 <= '0';
        if (end_time = '1' and Enter = '0') then
		  EstProximo <= result;
		elsif (end_time = '0' and Enter = '1') then
		  EstProximo <= count_round;
		else
		  EstProximo <= play;
		end if;
      
      when result =>
        R1 <= '0';
        R2 <= '0';
        E1 <= '0';
        E2 <= '0';
        E3 <= '0';
        E4 <= '0';
        E5 <= '1';
        if (Enter = '1') then
		  EstProximo <= init;
		else
		  EstProximo <= result;
		end if;
      
      when count_round =>
        R1 <= '0';
        R2 <= '0';
        E1 <= '0';
        E2 <= '0';
        E3 <= '1';
        E4 <= '0';
        E5 <= '0';
		EstProximo <= check;
      
      when check =>
        R1 <= '0';
        R2 <= '0';
        E1 <= '0';
        E2 <= '0';
        E3 <= '0';
        E4 <= '0';
        E5 <= '0';
        if ((end_round or end_game) = '1') then
		  EstProximo <= result;
		else
		  EstProximo <= waitt;
		end if;
      
      when waitt =>
        R1 <= '1';
        R2 <= '0';
        E1 <= '0';
        E2 <= '0';
        E3 <= '0';
        E4 <= '1';
        E5 <= '0';
        if (Enter = '1') then
		  EstProximo <= play;
		else
		  EstProximo <= waitt;
		end if;
    
    end case;
  end process;

end arc_ctrl;