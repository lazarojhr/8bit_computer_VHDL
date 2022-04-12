library ieee;
use ieee.std_logic_1164.all;

entity normal_register_split is

    port (
        clk                  : in    std_logic;
        reset                : in    std_logic;
        en_input             : in    std_logic;
        normal_input         : in    std_logic_vector (7 downto 0);
        normal_output_upper  : out   std_logic_vector (3 downto 0);
        normal_output_lower  : out   std_logic_vector (3 downto 0)
    );

end normal_register_split;

architecture behav of normal_register_split is
begin

    process (clk, reset)
    begin

        if reset = '1' then
            normal_output_upper <= (others => '0');
            normal_output_lower <= (others => '0');
        elsif clk'event and clk = '1' then
            if en_input = '1' then
                normal_output_upper <= normal_input(7 downto 4);
                normal_output_lower <= normal_input(3 downto 0);
            end if;
        end if;

    end process;

end behav;
