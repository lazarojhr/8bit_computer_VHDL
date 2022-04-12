library ieee;
use ieee.std_logic_1164.all;

entity test_cpu is 
end test_cpu;

architecture test of test_cpu is

    component cpu

        port (
            clk                 : in std_logic;
            master_reset        : in std_logic;
            lower_bus_in        : in std_logic_vector (7 downto 0);
            upper_bus_in        : in std_logic_vector (7 downto 0);
            mar_en              : out std_logic;
            mar_clr             : out std_logic;
            mdr_sel_in          : out std_logic;
            mdr_en_in           : out std_logic;
            mdr_sel_out         : out std_logic;
            mdr_en_out          : out std_logic;
            mdr_clr             : out std_logic;
            ram_nr_w            : out std_logic;
            ram_en_in           : out std_logic;
            ram_en_out          : out std_logic;
            ram_clr             : out std_logic;
            halt                : out std_logic;
            input_port_en_out   : out std_logic;
            output_port_en_in   : out std_logic;
            lower_bus_out       : out std_logic_vector (7 downto 0)
        );

    end component;

    signal clk                 : std_logic := '0';
    signal reset               : std_logic := '0';

    signal lower_bus_in        : std_logic_vector (7 downto 0);
    signal upper_bus_in        : std_logic_vector (7 downto 0);
    signal mar_en              : std_logic;
    signal mar_clr             : std_logic;
    signal mdr_sel_in          : std_logic;
    signal mdr_en_in           : std_logic;
    signal mdr_sel_out         : std_logic;
    signal mdr_en_out          : std_logic;
    signal mdr_clr             : std_logic;
    signal ram_nr_w            : std_logic;
    signal ram_en_in           : std_logic;
    signal ram_en_out          : std_logic;
    signal ram_clr             : std_logic;
    signal halt                : std_logic;
    signal input_port_en_out   : std_logic;
    signal output_port_en_in   : std_logic;
    signal lower_bus_out       : std_logic_vector (7 downto 0) := (others => 'Z');

begin

    clk <= not clk after 5 ns;
    reset <= '1', '0' after 10 ns;

    cpu_instance: cpu port map (
        clk => clk,
        master_reset => reset,
        lower_bus_in => lower_bus_in,
        upper_bus_in => upper_bus_in,
        mar_en => mar_en,
        mar_clr => mar_clr,
        mdr_sel_in => mdr_sel_in,
        mdr_en_in => mdr_en_in,
        mdr_sel_out => mdr_sel_out,
        mdr_en_out => mdr_en_out,
        mdr_clr => mdr_clr,
        ram_nr_w => ram_nr_w,
        ram_en_in => ram_en_in,
        ram_en_out => ram_en_out,
        ram_clr => ram_clr,
        halt => halt,
        input_port_en_out => input_port_en_out,
        output_port_en_in => output_port_en_in,
        lower_bus_out => lower_bus_out
    );

    process
    begin

        assert false report "Starting Simulation" severity note;

        upper_bus_in <= "00001001";
        lower_bus_in <= "00000001";
        lower_bus_out <= (others => 'Z');
        wait for 10 ns;
        assert mar_en = '1' report "Error (0)" severity warning;
        wait for 15 ns;
        assert ram_en_in = '1' and ram_en_out = '1' and mdr_sel_in = '1' and mdr_en_in = '1'
            report "Error (1)" severity warning;
        wait for 10 ns;
        assert mdr_en_out = '1' report "Error (2)" severity warning;
        wait for 100 ns;

        assert false report "End of Simulation" severity failure;

    end process;

end test;
