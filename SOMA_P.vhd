library IEEE;
use IEEE.Std_Logic_1164.all;

entity SOMA_P is
port (A, B, C, D: in std_logic;
      S: out std_logic_vector(2 downto 0));
end SOMA_P;

architecture smp of SOMA_P is
 
 signal E0, E1, F0, F1, G, S0, S1, S2: std_logic;
 
 component halfadder is
  port (A: in std_logic;
        B: in std_logic;
        S: out std_logic;
        Cout: out std_logic);
 end component; 
 
 component fulladder is
  port (A: in std_logic;
        B: in std_logic;
        Cin: in std_logic;
        S: out std_logic;
        Cout: out std_logic);
 end component;

begin

 HA1: halfadder port map 
(
    A => A,
    B => B,
    S => E0,
    Cout => E1
);

 HA2: halfadder port map 
(
    A => C,
    B => D,
    S => F0,
    Cout => F1
);

 HA3: halfadder port map 
(
    A => E0,
    B => F0,
    S => S0,
    Cout => G
);

 FA: fulladder port map 
(
    A => E1,
    B => F1, 
    Cin => G,
    S => S1,
    Cout => S2
);

S <= S2 & S1 & S0;

end smp;