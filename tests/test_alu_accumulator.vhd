library ieee;
use ieee.std_logic_1164.all;

entity test_alu_accumulator is
end test_alu_accumulator;

architecture test of test_alu_accumulator is

    component alu_accumulator

        port (
            clk                 : in    std_logic;
            acc_clear           : in    std_logic;
            acc_sel_in          : in    std_logic;
            acc_en_in           : in    std_logic;
            acc_en_bus_out      : in    std_logic;
            a_in_en             : in    std_logic;
            a_in_clear          : in    std_logic;
            cin_nbin            : in    std_logic;
            subtract            : in    std_logic;
            alu_en              : in    std_logic;
            alu_opcode          : in    std_logic_vector (4 downto 0);
            lower_bus_in        : in    std_logic_vector (7 downto 0);
            cout_nbout          : out   std_logic;
            z_out               : out   std_logic;
            n_out               : out   std_logic;
            lower_bus_out       : out   std_logic_vector (7 downto 0)
        );

    end component;

    signal clk                 : std_logic  := '0';
    signal reset               : std_logic  := '0';
    
    signal acc_sel_in          : std_logic;
    signal acc_en_in           : std_logic;
    signal acc_en_bus_out      : std_logic;
    signal a_in_en             : std_logic;
    signal cin_nbin            : std_logic;
    signal subtract            : std_logic;
    signal alu_en              : std_logic;
    signal alu_opcode          : std_logic_vector (4 downto 0);
    signal lower_bus_in      : std_logic_vector (7 downto 0);
    signal cout_nbout          : std_logic;
    signal z_out               : std_logic;
    signal n_out               : std_logic;
    signal lower_bus_out     : std_logic_vector (7 downto 0);

begin

    clk <= not clk after 5 ns;
    reset <= '1', '0' after 10 ns;

    alu_accumulator_instance: alu_accumulator port map (
        clk => clk,
        acc_clear => reset,
        acc_sel_in => acc_sel_in,
        acc_en_in => acc_en_in,
        acc_en_bus_out => acc_en_bus_out,
        a_in_en => a_in_en,
        a_in_clear => reset,
        cin_nbin => cin_nbin,
        subtract => subtract,
        alu_en => alu_en,
        alu_opcode => alu_opcode,
        lower_bus_in => lower_bus_in,
        cout_nbout => cout_nbout,
        z_out => z_out,
        n_out => n_out,
        lower_bus_out => lower_bus_out
    );

    process
    begin

        assert false report "Starting Simulation" severity note;

        acc_sel_in <= '0';
        acc_en_in <= '0';
        acc_en_bus_out <= '0';
        a_in_en <= '0';
        cin_nbin <= '0';
        alu_en <= '0';
        alu_opcode <= "00000";
        lower_bus_in <= "00000000";
        wait for 10 ns;
        -- Put value in accumulator
        lower_bus_in <= "10000011";
        acc_sel_in <= '1';
        acc_en_in <= '1';
        wait for 10 ns;
        acc_en_in <= '0';
        acc_sel_in <= '0';
        wait for 10 ns;
        -- Move value to a register
        a_in_en <= '1';
        wait for 10 ns;
        a_in_en <= '0';
        wait for 10 ns;
        -- Put value on bus
        lower_bus_in <= "00000001";
        wait for 10 ns;
        -- Perform alu operation
        alu_opcode <= "00001";
        alu_en <= '1';
        acc_en_in <= '1';
        wait for 10 ns;
        alu_en <= '0';
        acc_en_in <= '0';
        -- Check that the correct value is on the accumualtor
        acc_en_bus_out <= '1';
        wait for 10 ns;
        assert lower_bus_out = "10000100" report "Wrong Value" severity warning;
        acc_en_bus_out <= '0';

        assert false report "End of Simulation" severity failure;

    end process;

end test;
