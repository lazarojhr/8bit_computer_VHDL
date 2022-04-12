library ieee;
use ieee.std_logic_1164.all;

entity test_mar is
end test_mar;

architecture test of test_mar is

    component mar

        port (
            clk         : in std_logic;
            mar_clr     : in std_logic;
            mar_en      : in std_logic;
            addrs_in    : in std_logic_vector (7 downto 0);
            addrs_out   : out std_logic_vector (7 downto 0)
        );

    end component;

    signal clk           : std_logic := '0';
    signal reset         : std_logic := '0';

    signal mar_en        : std_logic := '0';
    signal addrs_in      : std_logic_vector (7 downto 0) := (others => '0');
    signal addrs_out     : std_logic_vector (7 downto 0) := (others => '0');

begin

    clk <= not clk after 5 ns;
    reset <= '1', '0' after 10 ns;

    mar_instance: mar port map (
        clk => clk,
        mar_clr => reset,
        mar_en => mar_en,
        addrs_in => addrs_in,
        addrs_out => addrs_out
    );

    process
    begin

        assert false report "Starting Simulation" severity note;

        addrs_in <= "00000000";
        mar_en <= '0';
        wait for 10 ns;
        assert addrs_out = "00000000" report "Output Error (1)" severity warning;
        addrs_in <= "11111111";
        wait for 10 ns;
        assert addrs_out = "00000000" report "Output Error (2)" severity warning;
        mar_en <= '1';
        wait for 10 ns;
        assert addrs_out = "11111111" report "Output Error (3)" severity warning;
        mar_en <= '0';
        wait for 40 ns;

        assert false report "End of Simulation" severity failure;

    end process;

end test;
