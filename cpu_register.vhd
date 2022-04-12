library ieee;
use ieee.std_logic_1164.all;

entity cpu_register is

    port (
        clk                 : in    std_logic;
        reset               : in    std_logic;
        en_input            : in    std_logic;
        en_output           : in    std_logic;
        lower_bus_in        : in    std_logic_vector (7 downto 0);
        lower_bus_out       : out   std_logic_vector (7 downto 0)
    );

end cpu_register;

architecture behav of cpu_register is

    signal data_in  : std_logic_vector (7 downto 0) := (others => '0');

begin

    process (clk, reset)
    begin

        if reset = '1' then
            data_in <= (others => '0');
        elsif clk'event and clk = '1' then
            if en_input = '1' then
                data_in <= lower_bus_in;
            end if;
        end if;

    end process;

    process (en_input, en_output, lower_bus_in, data_in)
    begin

        if en_output = '1' then
            lower_bus_out <= data_in;
        elsif en_output = '0' then
            lower_bus_out <= (others => 'Z');
        end if;

    end process;

end behav;
