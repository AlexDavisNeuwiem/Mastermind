library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity Counter_time is port ( 
  CLK: in std_logic;
  CLR: in std_logic;
  S: out std_logic_vector(3 downto 0); 
  EN: in std_logic;
  end_time: out std_logic
  );
end Counter_time;

architecture behv of Counter_time is
  signal cnt: std_logic_vector(3 downto 0) := "0000";
  signal m: std_logic := '0';
begin

  process(CLK,CLR)
  begin
    if (CLR = '1') then
      cnt <= "0000";
    elsif (CLK'event and CLK = '1') then 
        if (EN = '1') then
           cnt <= cnt + "0001";
        end if;
    end if;
  end process;

end_time <= '1' when (cnt = "1010") else '0';
S <= cnt;

end behv;