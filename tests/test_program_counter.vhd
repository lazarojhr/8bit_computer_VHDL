library ieee;
use ieee.std_logic_1164.all;

entity test_program_counter is
end test_program_counter;

architecture test of test_program_counter is

    component program_counter

        port (
            clk         : in    std_logic;
            reset       : in    std_logic;
            load        : in    std_logic;
            count       : in    std_logic;
            en_output   : in    std_logic;
            address_in  : in    std_logic_vector (7 downto 0);
            address_out : out   std_logic_vector (7 downto 0)
        );

    end component;
    
    signal clk         : std_logic  := '0';
    signal reset       : std_logic  := '0';

    signal load        : std_logic;
    signal count       : std_logic;
    signal en_output   : std_logic;
    signal address_in  : std_logic_vector (7 downto 0);
    signal address_out : std_logic_vector (7 downto 0);

begin

    clk <= not clk after 5 ns;
    reset <= '1', '0' after 10 ns;

    program_counter_instance: program_counter port map (
        clk => clk,
        reset => reset,
        load => load,
        count => count,
        en_output => en_output,
        address_in => address_in,
        address_out => address_out
    );

    process
    begin
        
        assert false report "Starting Simulation" severity note;

        address_in <= "11110101";
        count <= '0';
        load <= '0';
	en_output <= '0';
        wait for 10 ns;
        assert address_out = "ZZZZZZZZ" report "Wrong counter value on bus (1)" severity warning;
        count <= '1';
	wait for 10 ns;
        assert address_out = "ZZZZZZZZ" report "Wrong counter value on bus (2)" severity warning;
	count <= '0';
	wait for 10 ns;
	en_output <= '1';
	wait for 10 ns;
        assert address_out = "00000001" report "Wrong counter value on bus (3)" severity warning;
	en_output <= '0';
        wait for 10 ns;
        load <= '1';
        wait for 10 ns;
        assert address_out = "ZZZZZZZZ" report "Wrong counter value on bus (4)" severity warning;
        load <= '0';
	wait for 10 ns;
	en_output <= '1';
	wait for 10 ns;
        assert address_out = "00110101" report "Wrong counter value on bus (5)" severity warning;
	en_output <= '0';
	wait for 10 ns;
        count <= '1';
	wait for 10 ns;
        assert address_out = "ZZZZZZZZ" report "Wrong counter value on bus (6)" severity warning;
	count <= '0';
        en_output <= '1';
        wait for  10 ns;
        assert address_out = "00110110" report "Wrong counter value on bus (7)" severity warning;
        en_output <= '0';
        wait for 10 ns;
        address_in <= "11111111";
        wait for 10 ns;
        load <= '1';
        wait for 10 ns;
        load <= '0';
        wait for 10 ns;
        en_output <= '1';
        wait for 10 ns;
        assert address_out = "00111111" report "Wrong counter value on bus (8)" severity warning;
        en_output <= '0';
        wait for 10 ns;
        count <= '1';
        wait for 10 ns;
        count <= '0';
        wait for 10 ns;
        en_output <= '1';
        wait for 10 ns;
        assert address_out = "00000000" report "Wrong counter value on bus (9)" severity warning;
        en_output <= '0';
        wait for 10 ns;

        assert false report "End of Simulation" severity failure;

    end process;

end test;
