library ieee;
use ieee.std_logic_1164.all;

entity test_accumulator is
end test_accumulator;

architecture test of test_accumulator is

    component accumulator

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

    end component;
    
    signal clk                 : std_logic  := '0';
    signal reset               : std_logic  := '0';

    signal input_sel           : std_logic;
    signal en_input            : std_logic;
    signal lower_bus_out_en    : std_logic;
    signal alu_input           : std_logic_vector (7 downto 0);
    signal lower_bus_in        : std_logic_vector (7 downto 0);
    signal alu_output          : std_logic_vector (7 downto 0);
    signal lower_bus_out       : std_logic_vector (7 downto 0);

begin

    clk <= not clk after 5 ns;
    reset <= '1', '0' after 10 ns;

    accumulator_instance: accumulator port map (
        clk => clk,
        reset => reset,
        input_sel => input_sel,
        en_input => en_input,
        lower_bus_out_en => lower_bus_out_en,
        alu_input => alu_input,
        lower_bus_in => lower_bus_in,
        alu_output => alu_output,
        lower_bus_out => lower_bus_out
    );

    process
    begin
        
        assert false report "Starting Simulation" severity note;

        alu_input <= "11001100";
        lower_bus_in <= "11110000";
        input_sel <= '0';
        lower_bus_out_en <= '0';
        en_input <= '0';
        wait for 10 ns;
        en_input <= '1';
        wait for 10 ns;
        en_input <= '0';
        wait for 10 ns;
        assert alu_output = alu_input and lower_bus_out = "ZZZZZZZZ" report "Error storing ALU value" severity warning;
        lower_bus_out_en <= '1';
        wait for 10 ns;
        assert alu_output = alu_input and lower_bus_out = alu_input report "Error putting value on the bus (1)" severity warning;
        alu_input <= "11111100";
        lower_bus_in <= "11111110";
        lower_bus_out_en <= '0';
        input_sel <= '1';
        en_input <= '1';
        wait for 10 ns;
        assert alu_output = lower_bus_in and lower_bus_out = "ZZZZZZZZ" report "Error storing bus value" severity warning;
        input_sel <= '0';
        en_input <= '0';
        wait for 10 ns;
        lower_bus_out_en <= '1';
        wait for 10 ns;
        assert alu_output = lower_bus_in and lower_bus_out = lower_bus_in report "Error putting value on the bus (2)" severity warning;
        lower_bus_out_en <= '0';
        wait for 10 ns;

        assert false report "End of Simulation" severity failure;

    end process;

end test;
