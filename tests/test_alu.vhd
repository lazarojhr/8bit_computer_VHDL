library ieee;
use ieee.std_logic_1164.all;

entity test_alu is
end test_alu;

architecture test of test_alu is

    component alu

        port (
            reset           : in    std_logic;
            cin_nbin        : in    std_logic;
            alu_en          : in    std_logic;
            alu_sel         : in    std_logic_vector (4 downto 0);
            acc_input       : in    std_logic_vector (7 downto 0);
            lower_bus_in    : in    std_logic_vector (7 downto 0);
            cout_nbout      : out   std_logic;
            z_out           : out   std_logic;
            n_out           : out   std_logic;
            output          : out   std_logic_vector (7 downto 0)
        );

    end component;

    signal clk             : std_logic  := '0';
    signal reset           : std_logic  := '0';
    
    signal cin_nbin        : std_logic;
    signal alu_en          : std_logic;
    signal alu_sel         : std_logic_vector (4 downto 0);
    signal acc_input       : std_logic_vector (7 downto 0);
    signal lower_bus_in    : std_logic_vector (7 downto 0);
    signal cout_nbout      : std_logic;
    signal z_out           : std_logic;
    signal n_out           : std_logic;
    signal output          : std_logic_vector (7 downto 0);

begin

    clk <= not clk after 5 ns;
    reset <= '1', '0' after 10 ns;

    alu_instace: alu port map (
        reset => reset,
        cin_nbin => cin_nbin,
        alu_en => alu_en,
        alu_sel => alu_sel,
        acc_input => acc_input,
        lower_bus_in => lower_bus_in,
        cout_nbout => cout_nbout,
        z_out => z_out,
        n_out => n_out,
        output => output
    );

    process
    begin

        assert false report "Starting Simulation" severity note;

        -- testing ADDER
        acc_input <= "10000000";
        lower_bus_in <= "00000001";
        alu_sel <= "00000";
        cin_nbin <= '0';
        alu_en <= '0';
        wait for 10 ns;
        alu_sel <= "00000";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "10000001" report "Error Adding" severity warning;
        assert cout_nbout = '0' report "Error Adding" severity warning;
        assert z_out = '0' report "Error Adding" severity warning;
        assert n_out = '0' report "Error Adding" severity warning;
        wait for 10 ns;
        acc_input <= "11111111";
        lower_bus_in <= "00000001";
        alu_sel <= "00001";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        assert output = "00000000" report "Error Adding" severity warning;
        assert cout_nbout = '1' report "Error Adding" severity warning;
        assert z_out = '1' report "Error Adding" severity warning;
        assert n_out = '0' report "Error Adding" severity warning;
        wait for 10 ns;
        -- testing AND
        acc_input <= "11000000";
        lower_bus_in <= "11000001";
        alu_sel <= "00010";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "11000000" report "Error AND" severity warning;
        assert cout_nbout = '0' report "Error AND" severity warning;
        assert z_out = '0' report "Error AND" severity warning;
        assert n_out = '0' report "Error AND" severity warning;
        wait for 10 ns;
        alu_sel <= "00011";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "11000000" report "Error AND" severity warning;
        assert cout_nbout = '0' report "Error AND" severity warning;
        assert z_out = '0' report "Error AND" severity warning;
        assert n_out = '0' report "Error AND" severity warning;
        wait for 10 ns;
        -- testing OR
        alu_sel <= "00100";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "11000001" report "Error OR" severity warning;
        assert cout_nbout = '0' report "Error OR" severity warning;
        assert z_out = '0' report "Error OR" severity warning;
        assert n_out = '0' report "Error OR" severity warning;
        wait for 10 ns;
        alu_sel <= "00101";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "11000001" report "Error OR" severity warning;
        assert cout_nbout = '0' report "Error OR" severity warning;
        assert z_out = '0' report "Error OR" severity warning;
        assert n_out = '0' report "Error OR" severity warning;
        wait for 10 ns;
        -- testing NAND
        alu_sel <= "00110";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "00111111" report "Error NAND" severity warning;
        assert cout_nbout = '0' report "Error NAND" severity warning;
        assert z_out = '0' report "Error NAND" severity warning;
        assert n_out = '0' report "Error NAND" severity warning;
        wait for 10 ns;
        -- testing NOR
        alu_sel <= "00111";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "00111110" report "Error NOR" severity warning;
        assert cout_nbout = '0' report "Error NOR" severity warning;
        assert z_out = '0' report "Error NOR" severity warning;
        assert n_out = '0' report "Error NOR" severity warning;
        wait for 10 ns;
        -- testing XOR
        alu_sel <= "01000";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "00000001" report "Error XOR" severity warning;
        assert cout_nbout = '0' report "Error XOR" severity warning;
        assert z_out = '0' report "Error XOR" severity warning;
        assert n_out = '0' report "Error XOR" severity warning;
        wait for 10 ns;
        alu_sel <= "01001";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "00000001" report "Error XOR" severity warning;
        assert cout_nbout = '0' report "Error XOR" severity warning;
        assert z_out = '0' report "Error XOR" severity warning;
        assert n_out = '0' report "Error XOR" severity warning;
        wait for 10 ns;
        -- testing XNOR
        alu_sel <= "01010";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "11111110" report "Error XNOR" severity warning;
        assert cout_nbout = '0' report "Error XNOR" severity warning;
        assert z_out = '0' report "Error XNOR" severity warning;
        assert n_out = '0' report "Error XNOR" severity warning;
        wait for 10 ns;
        -- testing INVERTER
        alu_sel <= "01011";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "00111111" report "Error NOT" severity warning;
        assert cout_nbout = '0' report "Error NOT" severity warning;
        assert z_out = '0' report "Error NOT" severity warning;
        assert n_out = '0' report "Error NOT" severity warning;
        wait for 10 ns;
        -- testing CLEAR
        acc_input <= "00000000";
        alu_sel <= "01100";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "00000000" report "Error CLEAR" severity warning;
        assert cout_nbout = '0' report "Error CLEAR" severity warning;
        assert z_out = '1' report "Error CLEAR" severity warning;
        assert n_out = '0' report "Error CLEAR" severity warning;
        wait for 10 ns;
        -- testing SUBTRACTOR
        acc_input <= "00000100";
        lower_bus_in <= "00000101";
        alu_sel <= "01101";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "11111111" report "Error Subtracting" severity warning;
        assert cout_nbout = '1' report "Error Subtracting" severity warning;
        assert z_out = '0' report "Error Subtracting" severity warning;
        assert n_out = '1' report "Error Subtracting" severity warning;
        wait for 10 ns;
        acc_input <= "00000110";
        lower_bus_in <= "00000101";
        alu_sel <= "01110";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "00000001" report "Error Subtracting" severity warning;
        assert cout_nbout = '0' report "Error Subtracting" severity warning;
        assert z_out = '0' report "Error Subtracting" severity warning;
        assert n_out = '0' report "Error Subtracting" severity warning;
        wait for 10 ns;
        -- testing MULTIPLIER
        acc_input <= "11111111";
        alu_sel <= "01111";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "11100001" report "Error Multiplying" severity warning;
        assert cout_nbout = '0' report "Error Multiplying" severity warning;
        assert z_out = '0' report "Error Multiplying" severity warning;
        assert n_out = '0' report "Error Multiplying" severity warning;
        wait for 10 ns;
        -- testing SHIFTING
        acc_input <= "10001000";
        alu_sel <= "10000";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "00010000" report "Error Shifting Left" severity warning;
        assert cout_nbout = '1' report "Error Shifting Left" severity warning;
        assert z_out = '0' report "Error Shifting Left" severity warning;
        assert n_out = '0' report "Error Shifting Left" severity warning;
        wait for 10 ns;
        alu_sel <= "10001";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "01000100" report "Error Shifting Right" severity warning;
        assert cout_nbout = '0' report "Error Shifting Right" severity warning;
        assert z_out = '0' report "Error Shifting Right" severity warning;
        assert n_out = '0' report "Error Shifting Right" severity warning;
        wait for 10 ns;
        -- testing ROTATING
        alu_sel <= "10010";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "00010001" report "Error Rotating Left" severity warning;
        assert cout_nbout = '0' report "Error Rotating Left" severity warning;
        assert z_out = '0' report "Error Rotating Left" severity warning;
        assert n_out = '0' report "Error Rotating Left" severity warning;
        wait for 10 ns;
        alu_sel <= "10011";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "01000100" report "Error Rotating Right" severity warning;
        assert cout_nbout = '0' report "Error Rotating Right" severity warning;
        assert z_out = '0' report "Error Rotating Right" severity warning;
        assert n_out = '0' report "Error Rotating Right" severity warning;
        wait for 10 ns;
        -- testing MOVL
        acc_input <= "11110101";
        alu_sel <= "10100";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "11110101" report "Error MOVL" severity warning;
        assert cout_nbout = '0' report "Error MOVL" severity warning;
        assert z_out = '0' report "Error MOVL" severity warning;
        assert n_out = '0' report "Error MOVL" severity warning;
        wait for 10 ns;
        -- testing MOVW
        alu_sel <= "10101";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "11110101" report "Error MOVW" severity warning;
        assert cout_nbout = '0' report "Error MOVW" severity warning;
        assert z_out = '0' report "Error MOVW" severity warning;
        assert n_out = '0' report "Error MOVW" severity warning;
        wait for 10 ns;
        -- testing MOVR
        alu_sel <= "10110";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "11110101" report "Error MOVR" severity warning;
        assert cout_nbout = '0' report "Error MOVR" severity warning;
        assert z_out = '0' report "Error MOVR" severity warning;
        assert n_out = '0' report "Error MOVR" severity warning;
        wait for 10 ns;
        -- testing MOVA
        alu_sel <= "10111";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "11110101" report "Error MOVA" severity warning;
        assert cout_nbout = '0' report "Error MOVA" severity warning;
        assert z_out = '0' report "Error MOVA" severity warning;
        assert n_out = '0' report "Error MOVA" severity warning;
        wait for 10 ns;
        -- testing NOP
        alu_sel <= "11000";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "11110101" report "Error NOP" severity warning;
        assert cout_nbout = '0' report "Error NOP" severity warning;
        assert z_out = '0' report "Error NOP" severity warning;
        assert n_out = '0' report "Error NOP" severity warning;
        wait for 10 ns;
        -- testing HALT
        alu_sel <= "11001";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "11110101" report "Error HALT" severity warning;
        assert cout_nbout = '0' report "Error HALT" severity warning;
        assert z_out = '0' report "Error HALT" severity warning;
        assert n_out = '0' report "Error HALT" severity warning;
        wait for 10 ns;
        -- testing GOTO
        alu_sel <= "11010";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "11110101" report "Error GOTO" severity warning;
        assert cout_nbout = '0' report "Error GOTO" severity warning;
        assert z_out = '0' report "Error GOTO" severity warning;
        assert n_out = '0' report "Error GOTO" severity warning;
        wait for 10 ns;
        -- testing SKIPN
        alu_sel <= "11011";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "11110101" report "Error SKIPN" severity warning;
        assert cout_nbout = '0' report "Error SKIPN" severity warning;
        assert z_out = '0' report "Error SKIPN" severity warning;
        assert n_out = '0' report "Error SKIPN" severity warning;
        wait for 10 ns;
        -- testing SKIPZ
        alu_sel <= "11100";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "11110101" report "Error SKIPZ" severity warning;
        assert cout_nbout = '0' report "Error SKIPZ" severity warning;
        assert z_out = '0' report "Error SKIPZ" severity warning;
        assert n_out = '0' report "Error SKIPZ" severity warning;
        wait for 10 ns;
        -- testing SKIPNZ
        alu_sel <= "11101";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "11110101" report "Error SKIPNZ" severity warning;
        assert cout_nbout = '0' report "Error SKIPNZ" severity warning;
        assert z_out = '0' report "Error SKIPNZ" severity warning;
        assert n_out = '0' report "Error SKIPNZ" severity warning;
        wait for 10 ns;
        -- testing MOVF
        alu_sel <= "11110";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "11110101" report "Error MOVF" severity warning;
        assert cout_nbout = '0' report "Error MOVF" severity warning;
        assert z_out = '0' report "Error MOVF" severity warning;
        assert n_out = '0' report "Error MOVF" severity warning;
        wait for 10 ns;
        -- testing RETURN (NOT IMPLEMENTED)
        alu_sel <= "11111";
        wait for 10 ns;
        alu_en <= '1';
        wait for 10 ns;
        alu_en <= '0';
        wait for 10 ns;
        assert output = "00000000" report "Error RETURN" severity warning;
        assert cout_nbout = '0' report "Error RETURN" severity warning;
        assert z_out = '1' report "Error RETURN" severity warning;
        assert n_out = '0' report "Error RETURN" severity warning;
        wait for 20 ns;

        assert false report "End of Simulation" severity failure;

    end process;

end test;
