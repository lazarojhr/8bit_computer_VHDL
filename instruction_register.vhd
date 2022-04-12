library ieee;
use ieee.std_logic_1164.all;

entity instruction_register is

    port (
        clk                 : in    std_logic;
        reset               : in    std_logic;
        en_input            : in    std_logic;
        en_output           : in    std_logic;
        lower_bus_in        : in    std_logic_vector (7 downto 0);
        upper_bus_in        : in    std_logic_vector (7 downto 0);
        lower_control_out   : out   std_logic_vector (7 downto 0);
        upper_control_out   : out   std_logic_vector (7 downto 0)
    );

end instruction_register;

architecture behav of instruction_register is

    signal data_in_lower : std_logic_vector (7 downto 0) := (others => '0');
    signal data_in_upper : std_logic_vector (7 downto 0) := (others => '0');

begin

    process (clk, reset)
    begin

        if reset = '1' then
            data_in_lower <= (others => '0');
            data_in_upper <= (others => '0');
        elsif clk'event and clk = '1' then
            if en_input = '1' then
                data_in_lower <= lower_bus_in;
                data_in_upper <= upper_bus_in;
            end if;
        end if;

    end process;

    process (en_input, en_output, lower_bus_in, upper_bus_in, data_in_lower, data_in_upper)
    begin

        if en_output = '1' then
            lower_control_out <= data_in_lower;
            upper_control_out <= data_in_upper;
        elsif en_output = '0' then
            lower_control_out <= (others => 'Z');
            upper_control_out <= (others => 'Z');
        end if;

    end process;

end behav;
