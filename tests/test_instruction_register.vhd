library ieee;
use ieee.std_logic_1164.all;

entity test_instruction_register is
end test_instruction_register;

architecture test of test_instruction_register is

    component instruction_register

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

    end component;
    
    signal clk                  : std_logic := '0';
    signal reset                : std_logic := '0';

    signal en_input             : std_logic := '0';
    signal en_output            : std_logic := '0';
    signal lower_bus_in         : std_logic_vector (7 downto 0) := (others => 'Z');
    signal upper_bus_in         : std_logic_vector (7 downto 0) := (others => 'Z');
    signal lower_control_out    : std_logic_vector (7 downto 0) := (others => 'Z');
    signal upper_control_out    : std_logic_vector (7 downto 0) := (others => 'Z');

begin

    clk <= not clk after 5 ns;
    reset <= '1', '0' after 10 ns;

    instruction_register_instance: instruction_register port map (
        clk => clk,
        reset => reset,
        en_input => en_input,
        en_output => en_output,
        lower_bus_in => lower_bus_in,
        upper_bus_in => upper_bus_in,
        lower_control_out => lower_control_out,
        upper_control_out => upper_control_out
    );

    process
    begin
        
        assert false report "Starting Simulation" severity note;

        lower_bus_in <= "11110000";
        upper_bus_in <= "00001111";
        en_input <= '0';
        en_output <= '0';
        wait for 10 ns;
        en_input <= '1';
        wait for 10 ns;
        assert lower_control_out = "ZZZZZZZZ" and upper_control_out = "ZZZZZZZZ" report "Wrong value on bus (1)" severity warning;
        en_input <= '0';
        wait for 10 ns;
        lower_bus_in <= "00001111";
        upper_bus_in <= "11110000";
        en_input <= '1';
        en_output <= '1';
        wait for 10 ns;
        en_input <= '0';
        en_output <= '0';
        assert lower_control_out = "00001111" and upper_control_out = "11110000" report "Wrong value on bus (2)" severity warning;
        wait for 10 ns;
        en_output <= '1';
        wait for 10 ns;
        assert lower_control_out = "00001111" and upper_control_out = "11110000" report "Wrong value on bus (3)" severity warning;
        en_output <= '0';
        wait for 10 ns;
        
        assert false report "End of Simulation" severity failure;

    end process;

end test;
