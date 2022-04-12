library ieee;
use ieee.std_logic_1164.all;

entity input_port is

    port (
        clk             : in std_logic;
        clear           : in std_logic;
        en_input        : in std_logic;
        en_output       : in std_logic;
        input_data_0    : in std_logic;
        input_data_1    : in std_logic;
        input_data_2    : in std_logic;
        input_data_3    : in std_logic;
        input_data_4    : in std_logic;
        input_data_5    : in std_logic;
        input_data_6    : in std_logic;
        input_data_7    : in std_logic;
        lower_bus_out   : out std_logic_vector (7 downto 0)
    );

end input_port;

architecture behav of input_port is
    
    signal data_in    : std_logic_vector (7 downto 0) := (others => '0');

begin
    
    process (clk, clear)
    begin

        if clear = '1' then
            data_in <= (others => '0');
        elsif clk'event and clk = '1' then
            if en_input = '1' then
                data_in <= (7 => input_data_7, 6 => input_data_6,
                            5 => input_data_5, 4 => input_data_4,
                            3 => input_data_3, 2 => input_data_2,
                            1 => input_data_1, 0 => input_data_0
                );
            end if;
        end if;

    end process;

    process (en_input, en_output, input_data_0, input_data_1, input_data_2, input_data_3, 
        input_data_4, input_data_5, input_data_6, input_data_7, data_in)
    begin

        if en_output = '1' then
            lower_bus_out <= data_in;
        elsif en_output = '0' then
            lower_bus_out <= (others => 'Z');
        end if;

    end process;
end behav;
