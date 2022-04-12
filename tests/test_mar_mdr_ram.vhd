library ieee;
use ieee.std_logic_1164.all;

entity test_mar_mdr_ram is
end test_mar_mdr_ram;

architecture test of test_mar_mdr_ram is

    component mar_mdr_ram

        port (
            clk             : in std_logic;
            mar_en          : in std_logic;
            mar_clr         : in std_logic;
            ram_nr_w        : in std_logic;
            ram_en          : in std_logic;
            ram_en_out      : in std_logic;
            ram_clr         : in std_logic;
            mdr_en_in       : in std_logic;
            mdr_en_out      : in std_logic;
            mdr_sel_in      : in std_logic;
            mdr_sel_out     : in std_logic;
            mdr_clr         : in std_logic;
            upper_bus_in    : in std_logic_vector (7 downto 0);
            lower_bus_in    : in std_logic_vector (7 downto 0);
            upper_bus_out   : out std_logic_vector (7 downto 0);
            lower_bus_out   : out std_logic_vector (7 downto 0)
        );

    end component;

    signal clk             : std_logic := '0';
    signal reset           : std_logic := '0';

    signal mar_en          : std_logic;
    signal ram_nr_w        : std_logic;
    signal ram_en          : std_logic;
    signal ram_en_out      : std_logic;
    signal mdr_en_in       : std_logic;
    signal mdr_en_out      : std_logic;
    signal mdr_sel_in      : std_logic;
    signal mdr_sel_out     : std_logic;
    signal upper_bus_in    : std_logic_vector (7 downto 0);
    signal lower_bus_in    : std_logic_vector (7 downto 0);
    signal upper_bus_out   : std_logic_vector (7 downto 0);
    signal lower_bus_out   : std_logic_vector (7 downto 0);

begin

    clk <= not clk after 5 ns;
    reset <= '1', '0' after 10 ns;

    mar_mdr_ram_instance: mar_mdr_ram port map (
        clk => clk,
        mar_en => mar_en,
        mar_clr => reset,
        ram_nr_w => ram_nr_w,
        ram_en => ram_en,
        ram_en_out => ram_en_out,
        ram_clr => reset,
        mdr_en_in => mdr_en_in,
        mdr_en_out => mdr_en_out,
        mdr_sel_in => mdr_sel_in,
        mdr_sel_out => mdr_sel_out,
        mdr_clr => reset,
        upper_bus_in => upper_bus_in,
        lower_bus_in => lower_bus_in,
        upper_bus_out => upper_bus_out,
        lower_bus_out => lower_bus_out
    );

    process
    begin

        assert false report "Start of Simulation" severity note;

        mar_en <= '0';
        ram_nr_w <= '0';
        ram_en <= '0';
        ram_en_out <= '0';
        mdr_en_in <= '0';
        mdr_en_out <= '0';
        mdr_sel_in <= '0';
        mdr_sel_out <= '0';
        upper_bus_in <= "ZZZZZZZZ";
        lower_bus_in <= "ZZZZZZZZ";
        wait for 10 ns;
        -- Program Space
        -- Write data
        -- Put address on MAR
        lower_bus_in <= "00000000";
        mar_en <= '1';
        wait for 10 ns;
        mar_en <= '0';
        lower_bus_in <= "ZZZZZZZZ";
        wait for 10 ns;
        -- Put data on MDR
        lower_bus_in <= "11111111";
        mdr_sel_in <= '0';
        mdr_en_in <= '1';
        wait for 10 ns;
        mdr_en_in <= '0';
        lower_bus_in <= "ZZZZZZZZ";
        wait for 10 ns;
        -- Store data on RAM
        upper_bus_in <= "11110000";
        mdr_sel_out <= '1';
        ram_nr_w <= '1';
        ram_en <= '1';
        wait for 10 ns;
        mdr_sel_out <= '0';
        ram_nr_w <= '0';
        ram_en <= '0';
        upper_bus_in <= "ZZZZZZZZ";
        wait for 10 ns;
        -- Read data
        -- Put address on MAR
        lower_bus_in <= "00000000";
        mar_en <= '1';
        wait for 10 ns;
        mar_en <= '0';
        lower_bus_in <= "ZZZZZZZZ";
        wait for 10 ns;
        -- Put data from RAM on MDR
        ram_nr_w <= '0';
        ram_en <= '1';
        ram_en_out <= '1';
        mdr_sel_in <= '1';
        mdr_en_in <= '1';
        wait for 10 ns;
        ram_en <= '0';
        ram_en_out <= '0';
        mdr_sel_in <= '0';
        mdr_en_in <= '0';
        wait for 10 ns;
        -- Put he data on the bus
        mdr_sel_out <= '0';
        mdr_en_out <= '1';
        wait for 10 ns;
        assert upper_bus_out = "11110000" and lower_bus_out = "11111111"
            report "ERROR (1)" severity warning;
        wait for 10 ns;
        mdr_en_out <= '0';
        wait for 10 ns;

        -- User Space
        -- Write data
        -- Put address on MAR
        lower_bus_in <= "11111111";
        mar_en <= '1';
        wait for 10 ns;
        mar_en <= '0';
        lower_bus_in <= "ZZZZZZZZ";
        wait for 10 ns;
        -- Put data on MDR
        lower_bus_in <= "00001111";
        mdr_sel_in <= '0';
        mdr_en_in <= '1';
        wait for 10 ns;
        mdr_en_in <= '0';
        lower_bus_in <= "ZZZZZZZZ";
        wait for 10 ns;
        -- Store data on RAM
        upper_bus_in <= "11111111";
        mdr_sel_out <= '1';
        ram_nr_w <= '1';
        ram_en <= '1';
        wait for 10 ns;
        mdr_sel_out <= '0';
        ram_nr_w <= '0';
        ram_en <= '0';
        upper_bus_in <= "ZZZZZZZZ";
        wait for 10 ns;
        -- Read data
        -- Put address on MAR
        lower_bus_in <= "11111111";
        mar_en <= '1';
        wait for 10 ns;
        mar_en <= '0';
        lower_bus_in <= "ZZZZZZZZ";
        wait for 10 ns;
        -- Put data from RAM on MDR
        ram_nr_w <= '0';
        ram_en <= '1';
        ram_en_out <= '1';
        mdr_sel_in <= '1';
        mdr_en_in <= '1';
        wait for 10 ns;
        ram_en <= '0';
        ram_en_out <= '0';
        mdr_sel_in <= '0';
        mdr_en_in <= '0';
        wait for 10 ns;
        -- Put he data on the bus
        mdr_sel_out <= '0';
        mdr_en_out <= '1';
        wait for 10 ns;
        assert upper_bus_out = "11111111" and lower_bus_out = "00001111"
            report "ERROR (2)" severity warning;
        wait for 10 ns;
        mdr_en_out <= '0';
        wait for 10 ns;

        assert false report "End of Simulation" severity failure;

    end process;

end test;
