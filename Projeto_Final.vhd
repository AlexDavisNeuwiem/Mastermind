library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;

entity Projeto_Final is port ( 
  Clock1, Clock500, KEY0, KEY1 : in std_logic;
  Switches                     : in  std_logic_vector(15 downto 0);
  ledr                         : out std_logic_vector(15 downto 0);
  hex0, hex1, hex2, hex3       : out std_logic_vector(6 downto 0);
  hex4, hex5, hex6, hex7       : out std_logic_vector(6 downto 0)
  );
end Projeto_Final;

architecture arc_proj of Projeto_Final is
  
  signal Enter, Reset, R1, R2, E1, E2, E3, E4, E5, end_game, end_time, end_round: std_logic;
  
component Datapath is
port (
    Switches                     : in  std_logic_vector(15 downto 0);
    Clock1, Clock500             : in  std_logic;
    R1, R2                       : in  std_logic;
    E1, E2, E3, E4, E5           : in  std_logic;
    ledr                         : out std_logic_vector(15 downto 0);
    hex0, hex1, hex2, hex3       : out std_logic_vector(6 downto 0);
    hex4, hex5, hex6, hex7       : out std_logic_vector(6 downto 0);
    end_game, end_time, end_round: out std_logic
      );
end component;

component ButtonSync is
port (
    KEY0, KEY1, CLK: in  std_logic;
    Enter, Reset   : out std_logic
      );
end component;

component Controle is
port (
    Enter, Reset, CLK, end_game, end_time, end_round: in std_logic;
    R1, R2, E1, E2, E3, E4, E5: out std_logic
      );
end component;

begin

BS: ButtonSync port map 
(
	KEY0  => KEY0,
	KEY1  => KEY1,
	CLK   => Clock500,
	Enter => Enter,
	Reset => Reset
);

CNT: Controle port map 
(
    Enter      => Enter,
    Reset      => Reset,
    CLK        => Clock500,
    end_game   => end_game,
    end_time   => end_time,
    end_round  => end_round,
    R1         => R1,
    R2         => R2,
    E1         => E1,
    E2         => E2,
    E3         => E3,
    E4         => E4,
    E5         => E5
);

DTP: Datapath port map 
(
    Switches   => Switches, 
    Clock1     => Clock1,
    Clock500   => Clock500,      
    R1         => R1,
    R2         => R2,     
    E1         => E1,
    E2         => E2,
    E3         => E3,
    E4         => E4,
    E5         => E5,
    ledr       => ledr,             
    hex0       => hex0,
    hex1       => hex1,
    hex2       => hex2,
    hex3       => hex3,
    hex4       => hex4,
    hex5       => hex5,
    hex6       => hex6,
    hex7       => hex7,
    end_game   => end_game,
    end_time   => end_time,
    end_round  => end_round
);

end arc_proj;