library ieee;
use ieee.std_logic_1164.all;

entity test_cpu_register is
end test_cpu_register;

architecture test of test_cpu_register is

    component cpu_register

        port (
            clk             : in    std_logic;
            reset           : in    std_logic;
            en_input        : in    std_logic;
            en_output       : in    std_logic;
            lower_bus_in    : in    std_logic_vector (7 downto 0);
            lower_bus_out   : out   std_logic_vector (7 downto 0)
        );

    end component;
    
    signal clk             : std_logic  := '0';
    signal reset           : std_logic  := '0';

    signal en_input        : std_logic;
    signal en_output       : std_logic;
    signal lower_bus_in    : std_logic_vector (7 downto 0);
    signal lower_bus_out   : std_logic_vector (7 downto 0);

begin

    clk <= not clk after 5 ns;
    reset <= '1', '0' after 10 ns;

    cpu_register_instance: cpu_register port map (
        clk => clk,
        reset => reset,
        en_input => en_input,
        en_output => en_output,
        lower_bus_in => lower_bus_in,
        lower_bus_out => lower_bus_out
    );

    process
    begin
        
        assert false report "Starting Simulation" severity note;

        lower_bus_in <= "11110000";
        en_input <= '0';
        en_output <= '0';
        wait for 10 ns;
        assert lower_bus_out = "ZZZZZZZZ" report "Wrong value on bus (1)" severity warning;
        en_input <= '1';
        wait for 10 ns;
        assert lower_bus_out = "ZZZZZZZZ" report "Wrong value on bus (2)" severity warning;
        en_input <= '0';
        wait for 10 ns;
        lower_bus_in <= "00001111";
        wait for 10 ns;
        en_output <= '1';
        wait for 10 ns;
        assert lower_bus_out = "11110000" report "Wrong value on bus (3)" severity warning;
        en_input <= '1';
        en_output <= '0';
        wait for 10 ns;
        en_input <= '1';
        wait for 10 ns;
        en_input <= '0';
        assert lower_bus_out = "ZZZZZZZZ" report "Wrong value on bus (4)" severity warning;
        wait for 10 ns;
        en_output <= '1';
        wait for 10 ns;
        assert lower_bus_out = "00001111" report "Wrong value on bus (5)" severity warning;
        wait for 10 ns;
        en_output <= '0';
        wait for 10 ns;
        assert lower_bus_out = "ZZZZZZZZ" report "Wrong value on bus (6)" severity warning;
        
        assert false report "End of Simulation" severity failure;

    end process;

end test;
