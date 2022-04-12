library ieee;
use ieee.std_logic_1164.all;

entity computer is

    port (
        clk                   : in std_logic;
        master_reset          : in std_logic;
        en_input_port_in      : in std_logic;
        input_port_in_data_0  : in std_logic;
        input_port_in_data_1  : in std_logic;
        input_port_in_data_2  : in std_logic;
        input_port_in_data_3  : in std_logic;
        input_port_in_data_4  : in std_logic;
        input_port_in_data_5  : in std_logic;
        input_port_in_data_6  : in std_logic;
        input_port_in_data_7  : in std_logic;
        a0                    : out std_logic;
        b0                    : out std_logic;
        c0                    : out std_logic;
        d0                    : out std_logic;
        e0                    : out std_logic;
        f0                    : out std_logic;
        g0                    : out std_logic;
        a1                    : out std_logic;
        b1                    : out std_logic;
        c1                    : out std_logic;
        d1                    : out std_logic;
        e1                    : out std_logic;
        f1                    : out std_logic;
        g1                    : out std_logic
    );

end computer;

architecture behav of computer is

    component main_clk

        port (
            clk_in   : in std_logic;
            reset    : in std_logic;
            halt     : in std_logic;
            clk_out  : out std_logic
        );

    end component;

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

    component input_port

        port (
            clk             : in std_logic;
            clear           : in std_logic;
            en_input        : in std_logic;
            en_output       : in std_logic;
            input_data_0    : in std_logic;
            input_data_1    : in std_logic;
            input_data_2    : in std_logic;
            input_data_3    : in std_logic;
            input_data_4    : in std_logic;
            input_data_5    : in std_logic;
            input_data_6    : in std_logic;
            input_data_7    : in std_logic;
            lower_bus_out   : out std_logic_vector (7 downto 0)
        );

    end component;

    component output_port

        port (
            clk          : in std_logic;
            clear        : in std_logic;
            en_input     : in std_logic;
            lower_bus_in : in std_logic_vector (7 downto 0);
            a0           : out std_logic;
            b0           : out std_logic;
            c0           : out std_logic;
            d0           : out std_logic;
            e0           : out std_logic;
            f0           : out std_logic;
            g0           : out std_logic;
            a1           : out std_logic;
            b1           : out std_logic;
            c1           : out std_logic;
            d1           : out std_logic;
            e1           : out std_logic;
            f1           : out std_logic;
            g1           : out std_logic
        );

    end component;

    signal halt                 : std_logic := '0';
    signal master_clk           : std_logic;
    signal mar_en               : std_logic;
    signal mar_clr              : std_logic;
    signal mdr_sel_in           : std_logic;
    signal mdr_en_in            : std_logic;
    signal mdr_sel_out          : std_logic;
    signal mdr_en_out           : std_logic;
    signal mdr_clr              : std_logic;
    signal ram_nr_w             : std_logic;
    signal ram_en_in            : std_logic;
    signal ram_en_out           : std_logic;
    signal ram_clr              : std_logic;
    signal input_port_en_out    : std_logic;
    signal output_port_en_in    : std_logic;
    signal lower_bus            : std_logic_vector (7 downto 0) := (others => 'Z');
    signal upper_bus            : std_logic_vector (7 downto 0) := (others => 'Z');

begin

    main_clk_instance: main_clk port map (
        clk_in => clk,
        reset => master_reset,
        halt => halt,
        clk_out => master_clk
    );

    cpu_instance: cpu port map (
        clk => master_clk,
        master_reset => master_reset,
        lower_bus_in => lower_bus,
        upper_bus_in => upper_bus,
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
        lower_bus_out => lower_bus
    );

    mar_mdr_ram_instance: mar_mdr_ram port map (
        clk => master_clk,
        mar_en => mar_en,
        mar_clr => mar_clr,
        ram_nr_w => ram_nr_w,
        ram_en => ram_en_in,
        ram_en_out => ram_en_out,
        ram_clr => ram_clr,
        mdr_en_in => mdr_en_in,
        mdr_en_out => mdr_en_out,
        mdr_sel_in => mdr_sel_in,
        mdr_sel_out => mdr_sel_out,
        mdr_clr => mdr_clr,
        upper_bus_in => upper_bus,
        lower_bus_in => lower_bus,
        upper_bus_out => upper_bus,
        lower_bus_out => lower_bus
    );

    input_port_instance: input_port port map (
        clk => master_clk,
        clear => master_reset,
        en_input => en_input_port_in,
        en_output => input_port_en_out,
        input_data_0 => input_port_in_data_0,
        input_data_1 => input_port_in_data_1,
        input_data_2 => input_port_in_data_2,
        input_data_3 => input_port_in_data_3,
        input_data_4 => input_port_in_data_4,
        input_data_5 => input_port_in_data_5,
        input_data_6 => input_port_in_data_6,
        input_data_7 => input_port_in_data_7,
        lower_bus_out => lower_bus
    );

    output_port_instance: output_port port map (
        clk => master_clk,
        clear => master_reset,
        en_input =>output_port_en_in,
        lower_bus_in => lower_bus,
        a0 => a0,
        b0 => b0,
        c0 => c0,
        d0 => d0,
        e0 => e0,
        f0 => f0,
        g0 => g0,
        a1 => a1,
        b1 => b1,
        c1 => c1,
        d1 => d1,
        e1 => e1,
        f1 => f1,
        g1 => g1
    );

end behav;
