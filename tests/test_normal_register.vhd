library ieee;
use ieee.std_logic_1164.all;

entity test_normal_register is
end test_normal_register;

architecture test of test_normal_register is

    component normal_register

        port (
            clk                 : in    std_logic;
            reset               : in    std_logic;
            en_input            : in    std_logic;
            normal_input        : in    std_logic_vector (7 downto 0);
            normal_output       : out   std_logic_vector (7 downto 0)
        );

    end component;

    signal clk           : std_logic  := '0';
    signal reset         : std_logic  := '0';

    signal en_input      : std_logic;
    signal normal_input  : std_logic_vector (7 downto 0);
    signal normal_output : std_logic_vector (7 downto 0);

begin

    clk <= not clk after 5 ns;
    reset <= '1', '0' after 10 ns;

    normal_register_instance: normal_register port map (
        clk => clk,
        reset => reset,
        en_input => en_input,
        normal_input => normal_input,
        normal_output => normal_output
    );

    process
    begin

        assert false report "Starting Simulation" severity note;

        normal_input <= "00000000";
        en_input <= '0';
        wait for 10 ns;
        assert normal_output = "00000000" report "Output Error (1)" severity warning;
        normal_input <= "11111111";
        wait for 10 ns;
        assert normal_output = "00000000" report "Output Error (2)" severity warning;
        en_input <= '1';
        wait for 10 ns;
        assert normal_output = "11111111" report "Output Error (3)" severity warning;
        en_input <= '0';
        wait for 40 ns;

        assert false report "End of Simulation" severity failure;

    end process;

end test;
