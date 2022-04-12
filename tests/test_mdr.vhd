library ieee;
use ieee.std_logic_1164.all;

entity test_mdr is
end test_mdr;

architecture test of test_mdr is

    component mdr

        port (
            clk                 : in std_logic;
            mdr_clr             : in std_logic;
            mdr_sel_in          : in std_logic;
            mdr_sel_out         : in std_logic;
            mdr_en_in           : in std_logic;
            mdr_en_out          : in std_logic;
            bus_data_in         : in std_logic_vector (7 downto 0);
            ram_upper_data_in   : in std_logic_vector (7 downto 0);
            ram_lower_data_in   : in std_logic_vector (7 downto 0);
            ram_data_out        : out std_logic_vector (7 downto 0);
            bus_upper_data_out  : out std_logic_vector (7 downto 0);
            bus_lower_data_out  : out std_logic_vector (7 downto 0)
        );

    end component;

    signal clk                 : std_logic := '0';
    signal reset               : std_logic := '0';

    signal mdr_sel_in          : std_logic;
    signal mdr_sel_out         : std_logic;
    signal mdr_en_in           : std_logic;
    signal mdr_en_out          : std_logic;
    signal bus_data_in         : std_logic_vector (7 downto 0);
    signal ram_upper_data_in   : std_logic_vector (7 downto 0);
    signal ram_lower_data_in   : std_logic_vector (7 downto 0);
    signal ram_data_out        : std_logic_vector (7 downto 0);
    signal bus_upper_data_out  : std_logic_vector (7 downto 0);
    signal bus_lower_data_out  : std_logic_vector (7 downto 0);

begin

    clk <= not clk after 5 ns;
    reset <= '1', '0' after 10 ns;

    mdr_instance: mdr port map (
        clk => clk,
        mdr_clr => reset,
        mdr_sel_in => mdr_sel_in,
        mdr_sel_out => mdr_sel_out,
        mdr_en_in => mdr_en_in,
        mdr_en_out => mdr_en_out,
        bus_data_in => bus_data_in,
        ram_upper_data_in => ram_upper_data_in,
        ram_lower_data_in => ram_lower_data_in,
        ram_data_out => ram_data_out,
        bus_upper_data_out => bus_upper_data_out,
        bus_lower_data_out => bus_lower_data_out
    );

    process
    begin

        assert false report "Start of Simulation" severity note;

        mdr_sel_in <= '0';
        mdr_sel_out <= '0';
        bus_data_in <= "11110000";
        ram_upper_data_in <= "11001100";
        ram_lower_data_in <= "00110011";
        mdr_en_in <= '0';
        mdr_en_out <= '0';
        wait for 20 ns;
        assert ram_data_out = "00000000" and bus_upper_data_out = "ZZZZZZZZ" and 
            bus_lower_data_out = "ZZZZZZZZ" report "Output error (1)" severity warning;
        mdr_sel_out <= '1';
        wait for 10 ns;
        assert ram_data_out = "00000000" report "Output error (2)" severity warning;
        wait for 10 ns;
        mdr_en_in <= '1';
        mdr_sel_out <= '0';
        wait for 10 ns;
        assert ram_data_out = "00000000" and bus_upper_data_out = "ZZZZZZZZ" and 
            bus_lower_data_out = "ZZZZZZZZ" report "Output error (3)" severity warning;
        mdr_en_in <= '0';
        mdr_sel_out <= '1';
        wait for 10 ns;
        assert ram_data_out = "11110000" and bus_upper_data_out = "ZZZZZZZZ" and 
            bus_lower_data_out = "ZZZZZZZZ" report "Output error (4)" severity warning;
        mdr_en_out <= '1';
        wait for 10 ns;
        assert ram_data_out = "11110000" and bus_upper_data_out = "11001100" and 
            bus_lower_data_out = "00000000" report "Output error (5)" severity warning;
        wait for 10 ns;
        mdr_sel_out <= '0';
        wait for 10 ns;
        assert ram_data_out = "00000000" and bus_upper_data_out = "11001100" and 
            bus_lower_data_out = "11110000" report "Output error (6)" severity warning;
        wait for 10 ns;
        mdr_en_out <= '0';
        wait for 10 ns;
        assert ram_data_out = "00000000" and bus_upper_data_out = "ZZZZZZZZ" and 
            bus_lower_data_out = "ZZZZZZZZ" report "Output error (7)" severity warning;
        wait for 10 ns;
        mdr_sel_in <= '1';
        mdr_en_in <= '1';
        wait for 10 ns;
        mdr_en_in <= '0';
        mdr_en_out <= '1';
        wait for 10 ns;
        assert ram_data_out = "00000000" and bus_upper_data_out = "11001100" and 
            bus_lower_data_out = "00110011" report "Output error (8)" severity warning;
        mdr_en_out <= '0';
        wait for 10 ns;

        assert false report "End of Simulation" severity failure;

    end process;

end test;
