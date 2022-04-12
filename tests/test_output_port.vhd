library ieee;
use ieee.std_logic_1164.all;

entity test_output_port is
end test_output_port;

architecture test of test_output_port is

    component output_port

        port (
            clk          : in std_logic;
            clear        : in std_logic;
            en_input     : in std_logic;
            lower_bus_in : in std_logic_vector (7 downto 0);
            a0           : out std_logic;
            b0           : out std_logic;
            c0           : out std_logic;
            d0           : out std_logic;
            e0           : out std_logic;
            f0           : out std_logic;
            g0           : out std_logic;
            a1           : out std_logic;
            b1           : out std_logic;
            c1           : out std_logic;
            d1           : out std_logic;
            e1           : out std_logic;
            f1           : out std_logic;
            g1           : out std_logic
        );

    end component;

    signal clk          : std_logic := '0';
    signal reset        : std_logic := '0';

    signal en_input     : std_logic;
    signal lower_bus_in : std_logic_vector (7 downto 0);
    signal a0           : std_logic;
    signal b0           : std_logic;
    signal c0           : std_logic;
    signal d0           : std_logic;
    signal e0           : std_logic;
    signal f0           : std_logic;
    signal g0           : std_logic;
    signal a1           : std_logic;
    signal b1           : std_logic;
    signal c1           : std_logic;
    signal d1           : std_logic;
    signal e1           : std_logic;
    signal f1           : std_logic;
    signal g1           : std_logic;

begin

    clk <= not clk after 5 ns;
    reset <= '1', '0' after 10 ns;

    output_port_instance: output_port port map (
        clk => clk,
        clear => reset,
        en_input => en_input,
        lower_bus_in => lower_bus_in,
        a0 => a0,
        b0 => b0,
        c0 => c0,
        d0 => d0,
        e0 => e0,
        f0 => f0,
        g0 => g0,
        a1 => a1,
        b1 => b1,
        c1 => c1,
        d1 => d1,
        e1 => e1,
        f1 => f1,
        g1 => g1
    );

    process
    begin

        assert false report "Starting Simulation" severity note;

        en_input <= '0';
        lower_bus_in <= "ZZZZZZZZ";
        wait for 10 ns;
        assert a0 = '1' and b0 = '1' and c0 = '1' and d0 = '1' and e0 = '1' and f0 = '1' and g0 = '0'
            report "Error (1)" severity warning;
        assert a1 = '1' and b1 = '1' and c1 = '1' and d1 = '1' and e1 = '1' and f1 = '1' and g1 = '0'
            report "Error (2)" severity warning;
        wait for 10 ns;
        lower_bus_in <= "11110001";
        en_input <= '1';
        wait for 10 ns;
        en_input <= '0';
        assert a0 = '0' and b0 = '1' and c0 = '1' and d0 = '0' and e0 = '0' and f0 = '0' and g0 = '0'
            report "Error (3)" severity warning;
        assert a1 = '1' and b1 = '0' and c1 = '0' and d1 = '0' and e1 = '1' and f1 = '1' and g1 = '1'
            report "Error (4)" severity warning;
        wait for 10 ns;
        lower_bus_in <= "01000011";
        en_input <= '1';
        wait for 10 ns;
        en_input <= '0';
        assert a0 = '1' and b0 = '1' and c0 = '1' and d0 = '1' and e0 = '0' and f0 = '0' and g0 = '1'
            report "Error (5)" severity warning;
        assert a1 = '0' and b1 = '1' and c1 = '1' and d1 = '0' and e1 = '0' and f1 = '1' and g1 = '1'
            report "Error (6)" severity warning;
        wait for 10 ns;

        assert false report "End of Simulation" severity failure;

    end process;

end test;
