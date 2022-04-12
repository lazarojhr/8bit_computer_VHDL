library ieee;
use ieee.std_logic_1164.all;

entity accumulator is

    port (
        clk                 : in    std_logic;
        reset               : in    std_logic;
        input_sel           : in    std_logic;
        en_input            : in    std_logic;
        lower_bus_out_en    : in    std_logic;
        alu_input           : in    std_logic_vector (7 downto 0);
        lower_bus_in        : in    std_logic_vector (7 downto 0);
        alu_output          : out   std_logic_vector (7 downto 0);
        lower_bus_out       : out   std_logic_vector (7 downto 0)
    );

end accumulator;

architecture behav of accumulator is

    signal data_input   : std_logic_vector (7 downto 0) := (others => '0');

begin

    process (clk, reset)
    begin

        if reset = '1' then
            data_input <= (others => '0');
            alu_output <= (others => '0');
        elsif clk'event and clk = '1' then
            if input_sel = '0' then
                if en_input = '1' then
                    data_input <= alu_input;
                    alu_output <= alu_input;
                end if;
            elsif input_sel = '1' then
                if en_input = '1' then
                    data_input <= lower_bus_in;
                    alu_output <= lower_bus_in;
                end if;
            end if;
        end if;

    end process;

    process (input_sel, en_input, lower_bus_out_en, alu_input, lower_bus_in, data_input)
    begin

        if lower_bus_out_en = '1' then
            lower_bus_out <= data_input;
        elsif lower_bus_out_en = '0' then
            lower_bus_out <= (others => 'Z');
        end if;

    end process;

end behav;
