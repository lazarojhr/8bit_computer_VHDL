library ieee;
use ieee.std_logic_1164.all;

entity test_status_register is
end test_status_register;

architecture test of test_status_register is

    component status_register

        port (
            clk             : in    std_logic;
            reset           : in    std_logic;
            en_status       : in    std_logic;
            cout_nbout_in   : in    std_logic;
            z_in            : in    std_logic;
            n_in            : in    std_logic;
            cout_nbout_out  : out   std_logic;
            z_out           : out   std_logic;
            n_out           : out   std_logic
        );

    end component;

    signal clk             : std_logic  := '0';
    signal reset           : std_logic  := '0';

    signal en_status       : std_logic;
    signal cout_nbout_in   : std_logic;
    signal z_in            : std_logic;
    signal n_in            : std_logic;
    signal cout_nbout_out  : std_logic;
    signal z_out           : std_logic;
    signal n_out           : std_logic;

begin

    clk <= not clk after 5 ns;
    reset <= '1', '0' after 10 ns;

    status_register_instance: status_register port map (
        clk => clk,
        reset => reset,
        en_status => en_status,
        cout_nbout_in => cout_nbout_in,
        z_in => z_in,
        n_in => n_in,
        cout_nbout_out => cout_nbout_out,
        z_out => z_out,
        n_out => n_out
    );

    process
    begin

        assert false report "Starting Simulation" severity note;

        en_status <= '0';
        cout_nbout_in <= '0';
        z_in <= '0';
        n_in <= '0';
        wait for 10 ns;
        assert cout_nbout_out = '0' and z_out = '1' and n_out = '0' report "Wrong output values (1)" severity warning;
        cout_nbout_in <= '1';
        z_in <= '0';
        n_in <= '1';
        wait for 10 ns;
        assert cout_nbout_out = '0' and z_out = '1' and n_out = '0' report "Wrong output values (2)" severity warning;
        en_status <= '1';
        wait for 10 ns;
        assert cout_nbout_out = '1' and z_out = '0' and n_out = '1' report "Wrong output values (3)" severity warning;
        en_status <= '0';
        wait for 10 ns;
        cout_nbout_in <= '0';
        z_in <= '1';
        n_in <= '0';
        wait for 10 ns;
        assert cout_nbout_out = '1' and z_out = '0' and n_out = '1' report "Wrong output values (4)" severity warning;
        en_status <= '1';
        wait for 10 ns;
        assert cout_nbout_out = '0' and z_out = '1' and n_out = '0' report "Wrong output values (5)" severity warning;
        en_status <= '0';
        
        assert false report "End of Simulation" severity failure;

    end process;

end test;
