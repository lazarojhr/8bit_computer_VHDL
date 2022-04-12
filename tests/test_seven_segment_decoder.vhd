library ieee;
use ieee.std_logic_1164.all;

entity test_seven_segment_decoder is
end test_seven_segment_decoder;

architecture test of test_seven_segment_decoder is

    component seven_segment_decoder

        port (
            nhigh_low   : in std_logic;
            dc_point    : in std_logic;
            bin_input   : in std_logic_vector (3 downto 0);
            a           : out std_logic;
            b           : out std_logic;
            c           : out std_logic;
            d           : out std_logic;
            e           : out std_logic;
            f           : out std_logic;
            g           : out std_logic;
            dot         : out std_logic
        );

    end component;
     
    signal nhigh_low   : std_logic;
    signal dc_point    : std_logic;
    signal bin_input   : std_logic_vector (3 downto 0);
    signal a           : std_logic;
    signal b           : std_logic;
    signal c           : std_logic;
    signal d           : std_logic;
    signal e           : std_logic;
    signal f           : std_logic;
    signal g           : std_logic;
    signal dot         : std_logic;

begin

    seven_segment_decoder_instance: seven_segment_decoder port map (
        nhigh_low => nhigh_low,
        dc_point => dc_point,
        bin_input => bin_input,
        a => a,
        b => b,
        c => c,
        d => d,
        e => e,
        f => f,
        g => g,
        dot => dot
    );

    process
    begin

        assert false report "Starting Simulation" severity note;

        -- Testing common cathode
        nhigh_low <= '0';
        dc_point <= '0';
        bin_input <= "0000";
        -- zero
        wait for 10 ns;
        assert a = '1' and b = '1' and c = '1' and d = '1' and e = '1' and f = '1' and g = '0' and dot = '0'
            report "Error 1 (0)" severity warning;
        -- one
        bin_input <= "0001";
        wait for 10 ns;
        assert a = '0' and b = '1' and c = '1' and d = '0' and e = '0' and f = '0' and g = '0' and dot = '0'
            report "Error 1 (1)" severity warning;
        -- two
        bin_input <= "0010";
        wait for 10 ns;
        assert a = '1' and b = '1' and c = '0' and d = '1' and e = '1' and f = '0' and g = '1' and dot = '0'
            report "Error 1 (2)" severity warning;
        -- three
        bin_input <= "0011";
        wait for 10 ns;
        assert a = '1' and b = '1' and c = '1' and d = '1' and e = '0' and f = '0' and g = '1' and dot = '0'
            report "Error 1 (3)" severity warning;
        -- four
        bin_input <= "0100";
        wait for 10 ns;
        assert a = '0' and b = '1' and c = '1' and d = '0' and e = '0' and f = '1' and g = '1' and dot = '0'
            report "Error 1 (4)" severity warning;
        -- five
        bin_input <= "0101";
        wait for 10 ns;
        assert a = '1' and b = '0' and c = '1' and d = '1' and e = '0' and f = '1' and g = '1' and dot = '0'
            report "Error 1 (5)" severity warning;
        -- six
        bin_input <= "0110";
        wait for 10 ns;
        assert a = '1' and b = '0' and c = '1' and d = '1' and e = '1' and f = '1' and g = '1' and dot = '0'
            report "Error 1 (6)" severity warning;
        -- seven
        bin_input <= "0111";
        wait for 10 ns;
        assert a = '1' and b = '1' and c = '1' and d = '0' and e = '0' and f = '0' and g = '0' and dot = '0'
            report "Error 1 (7)" severity warning;
        -- eight
        bin_input <= "1000";
        wait for 10 ns;
        assert a = '1' and b = '1' and c = '1' and d = '1' and e = '1' and f = '1' and g = '1' and dot = '0'
            report "Error 1 (8)" severity warning;
        -- nine
        bin_input <= "1001";
        wait for 10 ns;
        assert a = '1' and b = '1' and c = '1' and d = '1' and e = '0' and f = '1' and g = '1' and dot = '0'
            report "Error 1 (9)" severity warning;
        -- ten
        bin_input <= "1010";
        wait for 10 ns;
        assert a = '1' and b = '1' and c = '1' and d = '0' and e = '1' and f = '1' and g = '1' and dot = '0'
            report "Error 1 (A)" severity warning;
        -- eleven
        bin_input <= "1011";
        wait for 10 ns;
        assert a = '0' and b = '0' and c = '1' and d = '1' and e = '1' and f = '1' and g = '1' and dot = '0'
            report "Error 1 (B)" severity warning;
        -- twelve
        bin_input <= "1100";
        wait for 10 ns;
        assert a = '1' and b = '0' and c = '0' and d = '1' and e = '1' and f = '1' and g = '0' and dot = '0'
            report "Error 1 (C)" severity warning;
        -- thirteen
        bin_input <= "1101";
        wait for 10 ns;
        assert a = '0' and b = '1' and c = '1' and d = '1' and e = '1' and f = '0' and g = '1' and dot = '0'
            report "Error 1 (D)" severity warning;
        -- fourteen
        bin_input <= "1110";
        wait for 10 ns;
        assert a = '1' and b = '0' and c = '0' and d = '1' and e = '1' and f = '1' and g = '1' and dot = '0'
            report "Error 1 (E)" severity warning;
        -- fifteen
        bin_input <= "1111";
        wait for 10 ns;
        assert a = '1' and b = '0' and c = '0' and d = '0' and e = '1' and f = '1' and g = '1' and dot = '0'
            report "Error 1 (F)" severity warning;
        -- dot
        dc_point <= '1';
        wait for 10 ns;
        assert a = '1' and b = '0' and c = '0' and d = '0' and e = '1' and f = '1' and g = '1' and dot = '1'
            report "Error 1 (DOT)" severity warning;
        wait for 10 ns;
        dc_point <= '0';
        wait for 10 ns;

        -- Testing common anode
        nhigh_low <= '1';
        dc_point <= '0';
        bin_input <= "0000";
        -- zero
        wait for 10 ns;
        assert a /= '1' and b /= '1' and c /= '1' and d /= '1' and e /= '1' and f /= '1' and g /= '0' and dot /= '0'
            report "Error 2 (0)" severity warning;
        -- one
        bin_input <= "0001";
        wait for 10 ns;
        assert a /= '0' and b /= '1' and c /= '1' and d /= '0' and e /= '0' and f /= '0' and g /= '0' and dot /= '0'
            report "Error 2 (1)" severity warning;
        -- two
        bin_input <= "0010";
        wait for 10 ns;
        assert a /= '1' and b /= '1' and c /= '0' and d /= '1' and e /= '1' and f /= '0' and g /= '1' and dot /= '0'
            report "Error 2 (2)" severity warning;
        -- three
        bin_input <= "0011";
        wait for 10 ns;
        assert a /= '1' and b /= '1' and c /= '1' and d /= '1' and e /= '0' and f /= '0' and g /= '1' and dot /= '0'
            report "Error 2 (3)" severity warning;
        -- four
        bin_input <= "0100";
        wait for 10 ns;
        assert a /= '0' and b /= '1' and c /= '1' and d /= '0' and e /= '0' and f /= '1' and g /= '1' and dot /= '0'
            report "Error 2 (4)" severity warning;
        -- five
        bin_input <= "0101";
        wait for 10 ns;
        assert a /= '1' and b /= '0' and c /= '1' and d /= '1' and e /= '0' and f /= '1' and g /= '1' and dot /= '0'
            report "Error 2 (5)" severity warning;
        -- six
        bin_input <= "0110";
        wait for 10 ns;
        assert a /= '1' and b /= '0' and c /= '1' and d /= '1' and e /= '1' and f /= '1' and g /= '1' and dot /= '0'
            report "Error 2 (6)" severity warning;
        -- seven
        bin_input <= "0111";
        wait for 10 ns;
        assert a /= '1' and b /= '1' and c /= '1' and d /= '0' and e /= '0' and f /= '0' and g /= '0' and dot /= '0'
            report "Error 2 (7)" severity warning;
        -- eight
        bin_input <= "1000";
        wait for 10 ns;
        assert a /= '1' and b /= '1' and c /= '1' and d /= '1' and e /= '1' and f /= '1' and g /= '1' and dot /= '0'
            report "Error 2 (8)" severity warning;
        -- nine
        bin_input <= "1001";
        wait for 10 ns;
        assert a /= '1' and b /= '1' and c /= '1' and d /= '1' and e /= '0' and f /= '1' and g /= '1' and dot /= '0'
            report "Error 2 (9)" severity warning;
        -- ten
        bin_input <= "1010";
        wait for 10 ns;
        assert a /= '1' and b /= '1' and c /= '1' and d /= '0' and e /= '1' and f /= '1' and g /= '1' and dot /= '0'
            report "Error 2 (A)" severity warning;
        -- eleven
        bin_input <= "1011";
        wait for 10 ns;
        assert a /= '0' and b /= '0' and c /= '1' and d /= '1' and e /= '1' and f /= '1' and g /= '1' and dot /= '0'
            report "Error 2 (B)" severity warning;
        -- twelve
        bin_input <= "1100";
        wait for 10 ns;
        assert a /= '1' and b /= '0' and c /= '0' and d /= '1' and e /= '1' and f /= '1' and g /= '0' and dot /= '0'
            report "Error 2 (C)" severity warning;
        -- thirteen
        bin_input <= "1101";
        wait for 10 ns;
        assert a /= '0' and b /= '1' and c /= '1' and d /= '1' and e /= '1' and f /= '0' and g /= '1' and dot /= '0'
            report "Error 2 (D)" severity warning;
        -- fourteen
        bin_input <= "1110";
        wait for 10 ns;
        assert a /= '1' and b /= '0' and c /= '0' and d /= '1' and e /= '1' and f /= '1' and g /= '1' and dot /= '0'
            report "Error 2 (E)" severity warning;
        -- fifteen
        bin_input <= "1111";
        wait for 10 ns;
        assert a /= '1' and b /= '0' and c /= '0' and d /= '0' and e /= '1' and f /= '1' and g /= '1' and dot /= '0'
            report "Error 2 (F)" severity warning;
        -- dot
        dc_point <= '1';
        wait for 10 ns;
        assert a /= '1' and b /= '0' and c /= '0' and d /= '0' and e /= '1' and f /= '1' and g /= '1' and dot /= '1'
            report "Error 2 (DOT)" severity warning;
        wait for 10 ns;
        dc_point <= '0';
        wait for 10 ns;

        assert false report "End of Simulation" severity failure;

    end process;

end test;
