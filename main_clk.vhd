library ieee;
use ieee.std_logic_1164.all;

entity main_clk is

    port (
        clk_in   : in std_logic;
        reset    : in std_logic;
        halt     : in std_logic;
        clk_out  : out std_logic
    );

end main_clk;

architecture behav of main_clk is
begin

    process (clk_in, reset, halt)
    begin

        if reset = '1' or halt = '1' then
            clk_out <= '0';
        elsif clk_in'event and clk_in = '1' then
            clk_out <= '1';
        elsif clk_in'event and clk_in = '0' then
            clk_out <= '0';
        end if;

    end process;

end behav;
