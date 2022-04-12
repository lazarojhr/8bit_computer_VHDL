library ieee;
use ieee.std_logic_1164.all;

entity mar_mdr_ram is

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

end mar_mdr_ram;

architecture behav of mar_mdr_ram is

    component mar

        port (
            clk         : in std_logic;
            mar_clr     : in std_logic;
            mar_en      : in std_logic;
            addrs_in    : in std_logic_vector (7 downto 0);
            addrs_out   : out std_logic_vector (7 downto 0)
        );

    end component;

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

    component ram

        port (
            clk                 : in std_logic;
            ram_clr             : in std_logic;
            ram_nr_w            : in std_logic;
            ram_en              : in std_logic;
            ram_en_out          : in std_logic;
            addrs_in_mar        : in std_logic_vector (7 downto 0);
            data_in_mdr         : in std_logic_vector (7 downto 0);
            data_in_upper_bus   : in std_logic_vector (7 downto 0);
            data_out_mdr        : out std_logic_vector (7 downto 0);
            data_out_upper_bus  : out std_logic_vector (7 downto 0)
        );

    end component;

    signal mar_addrs_out_ram_in         : std_logic_vector (7 downto 0) := (others => '0');
    signal ram_upper_data_out_mdr_in    : std_logic_vector (7 downto 0) := (others => '0');
    signal ram_lower_data_out_mdr_in    : std_logic_vector (7 downto 0) := (others => '0');
    signal mdr_data_out_ram_in          : std_logic_vector (7 downto 0) := (others => '0');

begin

    mar_instance: mar port map (
        clk => clk,
        mar_clr => mar_clr,
        mar_en => mar_en,
        addrs_in => lower_bus_in,
        addrs_out => mar_addrs_out_ram_in
    );

    mdr_instance: mdr port map (
        clk => clk,
        mdr_clr => mdr_clr,
        mdr_sel_in => mdr_sel_in,
        mdr_sel_out => mdr_sel_out,
        mdr_en_in => mdr_en_in,
        mdr_en_out => mdr_en_out,
        bus_data_in => lower_bus_in,
        ram_upper_data_in => ram_upper_data_out_mdr_in,
        ram_lower_data_in => ram_lower_data_out_mdr_in,
        ram_data_out => mdr_data_out_ram_in,
        bus_upper_data_out => upper_bus_out,
        bus_lower_data_out => lower_bus_out
    );

    ram_instance: ram port map (
        clk => clk,
        ram_clr => ram_clr,
        ram_nr_w => ram_nr_w,
        ram_en => ram_en,
        ram_en_out => ram_en_out,
        addrs_in_mar => mar_addrs_out_ram_in,
        data_in_mdr => mdr_data_out_ram_in,
        data_in_upper_bus => upper_bus_in,
        data_out_mdr => ram_lower_data_out_mdr_in,
        data_out_upper_bus => ram_upper_data_out_mdr_in
    );

end behav;
