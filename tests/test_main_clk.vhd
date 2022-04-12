library ieee;
use ieee.std_logic_1164.all;

entity test_main_clk is
end test_main_clk;

architecture test of test_main_clk is

    component main_clk

        port (
            clk_in   : in std_logic;
            reset    : in std_logic;
            halt     : in std_logic;
            clk_out  : out std_logic
        );

    end component;

    signal clk_in   : std_logic := '0';
    signal reset    : std_logic := '0';

    signal halt     : std_logic;
    signal clk_out  : std_logic;

begin

    clk_in <= not clk_in after 5 ns;
    reset <= '1', '0' after 10 ns;

    main_clk_instance: main_clk port map (
        clk_in => clk_in,
        reset => reset,
        halt => halt,
        clk_out => clk_out
    );

    process
    begin

        assert false report "Starting Simulation" severity note;

        halt <= '0';
        wait for 40 ns;
        halt <= '1';
        wait for 10 ns;
        assert clk_out = '0' report "Clk Error (1)" severity warning;
        wait for 10 ns;
        halt <= '0';
        wait for 10 ns;

        assert false report "End of simulation" severity failure;

    end process;

end test;
