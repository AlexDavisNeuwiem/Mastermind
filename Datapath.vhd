library ieee;
use ieee.std_Logic_1164.all;

entity datapath is port( 
    
    Switches                     : in  std_logic_vector(15 downto 0);
    Clock1, Clock500             : in  std_logic;
    R1, R2                       : in  std_logic;
    E1, E2, E3, E4, E5           : in  std_logic;
    ledr                         : out std_logic_vector(15 downto 0);
    hex0, hex1, hex2, hex3       : out std_logic_vector(6 downto 0);
    hex4, hex5, hex6, hex7       : out std_logic_vector(6 downto 0);
    end_game, end_time, end_round: out std_logic);
    
end datapath;


architecture arc_data of datapath is


signal code, user, rom0_s, rom1_s, rom2_s, rom3_s, dec_term: std_logic_vector(15 downto 0); 
signal result: std_logic_vector(7 downto 0);
signal h0_00, h0_01, h0_10, h0_11, h1_01, h1_11, h2_00, h2_01, h2_10, h2_11, h3_01, h3_11, h4, h6, h7: std_logic_vector(6 downto 0);
signal sel: std_logic_vector(5 downto 0);
signal timee, X, F, A, B, C, Z: std_Logic_vector(3 downto 0);
signal P, P_reg, E, E_reg: std_logic_vector(2 downto 0);
signal sel_mux: std_logic_vector(1 downto 0);
signal end_gamee, end_timee, cmp0_s, cmp1_s, cmp2_s, cmp3_s: std_logic;

component REG03 is
port (
	CLK,R,E: in std_logic;	
	D: in std_logic_vector(2 downto 0);
	Q: out std_logic_vector(2 downto 0)
        );
end component; 

component REG06 is
port (
	CLK,R,E: in std_logic;	
	D: in std_logic_vector(5 downto 0);
	Q: out std_logic_vector(5 downto 0)
        );
end component; 

component REG16 is
port (
	CLK,R,E: in std_logic;	
	D: in std_logic_vector(15 downto 0);
	Q: out std_logic_vector(15 downto 0)
        );
end component; 

component MUX2_07 is
port (
    X,Y: in std_logic_vector(6 downto 0);
    sel: in std_logic;
    saida: out std_logic_vector(6 downto 0)
        );
end component; 

component MUX4_07 is
port (
    W,X,Y,Z: in std_logic_vector(6 downto 0);
    sel: in std_logic_vector(1 downto 0);
    saida: out std_logic_vector(6 downto 0)
        );
end component; 

component MUX4_16 is
port (
    W,X,Y,Z: in std_logic_vector(15 downto 0);
    sel: in std_logic_vector(1 downto 0);
    saida: out std_logic_vector(15 downto 0)
        );
end component; 

component dec7seg is
port (
    C:  in std_logic_vector(3 downto 0);
    F:  out std_logic_vector(6 downto 0)
        );
end component; 

component SOMA is
port (
    X:  in std_logic_vector(3 downto 0);
    F:  out std_logic_vector(3 downto 0);
    end_time: in std_logic
        );
end component;

component SOMA_P is
port (
    A,B,C,D:  in std_logic;
    S:  out std_logic_vector(2 downto 0)
        );
end component;

component ROM0 is
port (
    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0)
        );
end component;

component ROM1 is
port (
    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0)
        );
end component;

component ROM2 is
port (
    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0)
        );
end component;

component ROM3 is
port (
    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0)
        );
end component;

component Selector is
port (
   in0, in1, in2, in3: in  std_logic;
   saida             : out std_logic_vector(1 downto 0)
        );
end component;

component comp_e is
port (
    inc, inu: in  std_logic_vector(15 downto 0);
    E       : out std_logic_vector(2 downto 0)
        );
end component;

component comparador is
port (
    A,B: in std_logic_vector(3 downto 0);
    C: out std_logic
        );
end component;

component comp_4 is
port (
    P: in std_logic_vector(2 downto 0);
    end_game: out std_logic
        );
end component;

component DECODER_TERMOMETRICO is
port (
      X:  in std_logic_vector(3 downto 0);
      L:  out std_logic_vector(15 downto 0)
        );
end component;

component Counter_round is
port (
  CLK: in std_logic;
  CLR: in std_logic;
  S: out std_logic_vector(3 downto 0); 
  EN: in std_logic;
  end_round: out std_logic
        );
end component;

component Counter_time is
port (
  CLK: in std_logic;
  CLR: in std_logic;
  S: out std_logic_vector(3 downto 0); 
  EN: in std_logic;
  end_time: out std_logic
        );
end component;

begin

end_game <= end_gamee; --ao interligar a saida do comp=4, usar o signal end_gamee para evitar erros
end_time <= end_timee; --ao interligar a saida do counter_time, usar o signal end_timee para evitar erros

RG1: REG03 port map 
(
	CLK  => Clock500,
	R    => R2,
	E    => E4,
	D    => P,
	Q    => P_reg
);

RG2: REG03 port map 
(
	CLK  => Clock500,
	R    => R2,
	E    => E4,
	D    => E,
	Q    => E_reg
);

RG3: REG06 port map 
(
	CLK  => Clock500,
	R    => R2,
	E    => E1,
	D    => Switches (5 downto 0),
	Q    => sel
);

RG4: REG16 port map 
(
	CLK  => Clock500,
	R    => R2,
	E    => E2,
	D    => Switches (15 downto 0),
	Q    => user
);

CR: Counter_round port map 
(
  CLK        => Clock500,
  CLR        => R2,
  S          => X,
  EN         => E3,
  end_round  => end_round
);

CT: Counter_time port map 
(
  CLK        => Clock1,
  CLR        => R1,
  S          => timee,
  EN         => E2,
  end_time   => end_timee
);

SELEC: Selector port map 
(
  in0     => E1,
  in1     => E2,
  in2     => R1,
  in3     => E5,
  saida   => sel_mux
);

CMPE: comp_e port map 
(
  inc  => code,
  inu  => user,
  E    => E
);

CMP0: comparador port map 
(
  A  => code (3 downto 0),
  B  => user (3 downto 0),
  C  => cmp0_s
);

CMP1: comparador port map 
(
  A  => code (7 downto 4),
  B  => user (7 downto 4),
  C  => cmp1_s
);

CMP2: comparador port map 
(
  A  => code (11 downto 8),
  B  => user(11 downto 8),
  C  => cmp2_s
);

CMP3: comparador port map 
(
  A  => code(15 downto 12),
  B  => user(15 downto 12),
  C  => cmp3_s
);

CMP4: comp_4 port map 
(
  P         => P,
  end_game  => end_gamee
);

DCDR: DECODER_TERMOMETRICO port map 
(
  X   => X,
  L   => dec_term
);

with (not E1) select
    ledr <= dec_term when '1',
            "0000000000000000" when others;

 
Z <= (not X);

SM: SOMA port map 
(
  X        => Z,
  F        => F,
  end_time => end_timee
);

result <= "000" & end_gamee & F;

SMP: SOMA_P port map 
(
  A  => cmp0_s,
  B  => cmp1_s,
  C  => cmp2_s,
  D  => cmp3_s,
  S   => P
);

RM0: ROM0 port map 
(
  address  => sel (5 downto 2),
  data     => rom0_s
);

RM1: ROM1 port map 
(
  address  => sel (5 downto 2),
  data     => rom1_s
);

RM2: ROM2 port map 
(
  address  => sel (5 downto 2),
  data     => rom2_s
);

RM3: ROM3 port map 
(
  address  => sel (5 downto 2),
  data     => rom3_s
);

MUXCODE: MUX4_16 port map 
(
  W      => rom0_s,
  X      => rom1_s,
  Y      => rom2_s,
  Z      => rom3_s,
  sel    => sel (1 downto 0),
  saida  => code
);

MUX0: MUX4_07 port map 
(
  W      => h0_00,
  X      => h0_01,
  Y      => h0_10,
  Z      => h0_11,
  sel    => sel_mux,
  saida  => hex0
);

MUX1: MUX4_07 port map 
(
  W      => "1000111",
  X      => h1_01,
  Y      => "0000110",
  Z      => h1_11,
  sel    => sel_mux,
  saida  => hex1
);

MUX2: MUX4_07 port map 
(
  W      => h2_00,
  X      => h2_01,
  Y      => h2_10,
  Z      => h2_11,
  sel    => sel_mux,
  saida  => hex2
);

MUX3: MUX4_07 port map 
(
  W      => "1000110",
  X      => h3_01,
  Y      => "0001100",
  Z      => h3_11,
  sel    => sel_mux,
  saida  => hex3
);

MUX4: MUX2_07 port map 
(
  X      => "1111111",
  Y      => h4,
  sel    => E2,
  saida  => hex4
);

MUX5: MUX2_07 port map 
(
  X      => "1111111",
  Y      => "0000111",
  sel    => E2,
  saida  => hex5
);

MUX6: MUX2_07 port map 
(
  X      => "1111111",
  Y      => h6,
  sel    => E5,
  saida  => hex6
);

MUX7: MUX2_07 port map 
(
  X      => "1111111",
  Y      => h7,
  sel    => E5,
  saida  => hex7
);

A <= "00" & sel (1 downto 0);

D7S_h0_00: dec7seg port map 
(
  C  => A,
  F  => h0_00
);

D7S_h0_01: dec7seg port map 
(
  C  => user (3 downto 0),
  F  => h0_01
);

B <= '0' & E_reg (2 downto 0);

D7S_h0_10: dec7seg port map 
(
  C  => B,
  F  => h0_10
);

D7S_h0_11: dec7seg port map 
(
  C  => code (3 downto 0),
  F  => h0_11
);

D7S_h1_01: dec7seg port map 
(
  C  => user (7 downto 4),
  F  => h1_01
);

D7S_h1_11: dec7seg port map 
(
  C  => code (7 downto 4),
  F  => h1_11
);

D7S_h2_00: dec7seg port map 
(
  C  => sel (5 downto 2),
  F  => h2_00
);

D7S_h2_01: dec7seg port map 
(
  C  => user (11 downto 8),
  F  => h2_01
);

C <= '0' & P_reg (2 downto 0);

D7S_h2_10: dec7seg port map 
(
  C  => C,
  F  => h2_10
);

D7S_h2_11: dec7seg port map 
(
  C  => code (11 downto 8),
  F  => h2_11
);

D7S_h3_01: dec7seg port map 
(
  C  => user (15 downto 12),
  F  => h3_01
);

D7S_h3_11: dec7seg port map 
(
  C  => code (15 downto 12),
  F  => h3_11
);

D7S_h4: dec7seg port map 
(
  C  => timee,
  F  => h4
);

D7S_h6: dec7seg port map 
(
  C  => result (3 downto 0),
  F  => h6
);

D7S_h7: dec7seg port map 
(
  C  => result (7 downto 4),
  F  => h7
);

end arc_data;
