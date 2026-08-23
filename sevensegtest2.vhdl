library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity sevensegtest2 is
    Port ( 
	        Clock      : in   STD_LOGIC;
			  DIP        : in   unsigned (2 downto 0);
           SevenSeg   : out  unsigned (7 downto 0);
			  COM        : out  unsigned (3 downto 0)
			  );
end sevensegtest2;

architecture Behavioral of sevensegtest2 is

signal  SevenSeg_sig : unsigned (7 downto 0):= "11000000" ;
signal  COM_sig      : unsigned (3 downto 0):= (others => '0');
signal  counter      :integer               := 0 ;
signal  digi         :integer               := 0 ;

begin

SevenSeg   <=    SevenSeg_sig ;
COM        <=    COM_sig;

process(Clock)
begin

if rising_edge (Clock) then
counter <= counter+1;

if (counter = 23999 ) then  --- for 1 ms delay withe clock_in :24 M ---
digi  <=  digi+1 ;
counter <= 0;
end if;

if  DIP(0) <= '0' then
case digi is
   when 0      =>
   COM_sig      <= "1110";
   SevenSeg_sig <= "11111001"; --1--
	when 1      =>
	COM_sig  <= "1101";
   SevenSeg_sig <= "10110000"; --3--
   when 2      =>
	COM_sig  <= "1011";
   SevenSeg_sig <= "10000010"; --6--
	when 3      =>
	COM_sig  <= "0111";
   SevenSeg_sig <= "10010010"; --5--
	when others =>
	digi <= 0;
end case;

elsif  DIP(1) <= '0' then
case digi is
   when 0      =>
   COM_sig  <= "1110";
   SevenSeg_sig <= "11111000"; --7--
	when 1      =>
	COM_sig  <= "1101";
   SevenSeg_sig <= "10000000"; --8--
   when 2      =>
	COM_sig  <= "1011";
   SevenSeg_sig <= "10010000"; --9--
	when 3      =>
	COM_sig  <= "0111";
   SevenSeg_sig <= "10100100"; --2--
	when others =>
	digi <= 0;
end case;

elsif  DIP(2) <= '0' then
case digi is
   when 0      =>
   COM_sig  <= "1110";
   SevenSeg_sig <= "11111000"; --7--
	when 1      =>
	COM_sig  <= "1101";
   SevenSeg_sig <= "10011001"; --4--
   when 2      =>
	COM_sig  <= "1011";
   SevenSeg_sig <= "11111001"; --1--
	when 3      =>
	COM_sig  <= "0111";
   SevenSeg_sig <= "11000000"; --0--
	when others =>
	digi <= 0;
end case;

else 
   COM_sig  <= "1111";
   ---SevenSeg_sig <= "10100100"; --5--
end if;	
end if;
end process;
end Behavioral;

