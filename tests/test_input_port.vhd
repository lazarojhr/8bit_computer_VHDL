library ieee;
use ieee.std_logic_1164.all;

entity test_input_port is
end test_input_port;

architecture test of test_input_port is

    component input_port

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

    end component;

    signal clk             : std_logic  := '0';
    signal reset           : std_logic  := '0';

    signal en_input        : std_logic;
    signal en_output       : std_logic;
    signal input_data_0    : std_logic;
    signal input_data_1    : std_logic;
    signal input_data_2    : std_logic;
    signal input_data_3    : std_logic;
    signal input_data_4    : std_logic;
    signal input_data_5    : std_logic;
    signal input_data_6    : std_logic;
    signal input_data_7    : std_logic;
    signal lower_bus_out   : std_logic_vector (7 downto 0);

begin

    clk <= not clk after 5 ns;
    reset <= '1', '0' after 10 ns;

    input_port_instance: input_port port map (
        clk => clk,
        clear => reset,
        en_input => en_input,
        en_output => en_output,
        input_data_0 => input_data_0,
        input_data_1 => input_data_1,
        input_data_2 => input_data_2,
        input_data_3 => input_data_3,
        input_data_4 => input_data_4,
        input_data_5 => input_data_5,
        input_data_6 => input_data_6,
        input_data_7 => input_data_7,
        lower_bus_out => lower_bus_out
    );

    process
    begin

        assert false report "Starting Simulation" severity note;

        input_data_0 <= '0';
        input_data_1 <= '0';
        input_data_2 <= '0';
        input_data_3 <= '0';
        input_data_4 <= '0';
        input_data_5 <= '0';
        input_data_6 <= '0';
        input_data_7 <= '0';
        en_input <= '0';
        en_output <= '0';
        wait for 10 ns;
        assert lower_bus_out = "ZZZZZZZZ" report "Output Error (1)" severity warning;
        input_data_0 <= '1';
        input_data_1 <= '1';
        input_data_2 <= '1';
        input_data_3 <= '1';
        input_data_4 <= '1';
        input_data_5 <= '1';
        input_data_6 <= '1';
        input_data_7 <= '1';
        wait for 10 ns;
        en_input <= '1';
        wait for 10 ns;
        en_input <= '0';
        wait for 10 ns;
        assert lower_bus_out = "ZZZZZZZZ" report "Output Error (2)" severity warning;
        wait for 10 ns;
        en_output <= '1';
        wait for 10 ns;
        assert lower_bus_out = "11111111" report "Output Error (3)" severity warning;
        input_data_0 <= '1';
        input_data_1 <= '1';
        input_data_2 <= '1';
        input_data_3 <= '1';
        input_data_4 <= '0';
        input_data_5 <= '0';
        input_data_6 <= '0';
        input_data_7 <= '0';
        en_input <= '1';
        wait for 10 ns;
        en_input <= '0';
        assert lower_bus_out = "00001111" report "Output Error (4)" severity warning;
        wait for 10 ns;
        en_output <= '0';
        wait for 40 ns;

        assert false report "End of Simulation" severity failure;

    end process;

end test;
