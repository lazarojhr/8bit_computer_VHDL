library ieee;
use ieee.std_logic_1164.all;

entity normal_register is

    port (
        clk                 : in    std_logic;
        reset               : in    std_logic;
        en_input            : in    std_logic;
        normal_input        : in    std_logic_vector (7 downto 0);
        normal_output       : out   std_logic_vector (7 downto 0)
    );

end normal_register;

architecture behav of normal_register is
begin

    process (clk, reset)
    begin

        if reset = '1' then
            normal_output <= (others => '0');
        elsif clk'event and clk = '1' then
            if en_input = '1' then
                normal_output <= normal_input;
            end if;
        end if;

    end process;

end behav;
