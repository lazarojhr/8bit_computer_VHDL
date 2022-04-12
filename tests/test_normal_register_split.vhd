library ieee;
use ieee.std_logic_1164.all;

entity test_normal_register_split is
end test_normal_register_split;

architecture test of test_normal_register_split is

    component normal_register_split

        port (
            clk                  : in    std_logic;
            reset                : in    std_logic;
            en_input             : in    std_logic;
            normal_input         : in    std_logic_vector (7 downto 0);
            normal_output_upper  : out   std_logic_vector (3 downto 0);
            normal_output_lower  : out   std_logic_vector (3 downto 0)
        );

    end component;

    signal clk                  : std_logic  := '0';
    signal reset                : std_logic  := '0';

    signal en_input             : std_logic;
    signal normal_input         : std_logic_vector (7 downto 0);
    signal normal_output_upper  : std_logic_vector (3 downto 0);
    signal normal_output_lower  : std_logic_vector (3 downto 0);

begin

    clk <= not clk after 5 ns;
    reset <= '1', '0' after 10 ns;

    normal_register_split_instance: normal_register_split port map (
        clk => clk,
        reset => reset,
        en_input => en_input,
        normal_input => normal_input,
        normal_output_upper => normal_output_upper,
        normal_output_lower => normal_output_lower
    );

    process
    begin

        assert false report "Starting Simulation" severity note;

        normal_input <= "00000000";
        en_input <= '0';
        wait for 10 ns;
        assert normal_output_upper = "0000" and normal_output_lower = "0000"
            report "Output Error (1)" severity warning;
        normal_input <= "11111111";
        wait for 10 ns;
        assert normal_output_upper = "0000" and normal_output_lower = "0000"
            report "Output Error (2)" severity warning;
        en_input <= '1';
        wait for 10 ns;
        en_input <= '0';
        wait for 10 ns;
        assert normal_output_upper = "1111" and normal_output_lower = "1111"
            report "Output Error (3)" severity warning;
        wait for 40 ns;

        assert false report "End of Simulation" severity failure;

    end process;

end test;
