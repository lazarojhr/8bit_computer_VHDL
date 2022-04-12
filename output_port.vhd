library ieee;
use ieee.std_logic_1164.all;

entity output_port is

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

end output_port;

architecture behav of output_port is

    signal upper_nibble   : std_logic_vector (3 downto 0) := (others => '0');
    signal lower_nibble   : std_logic_vector (3 downto 0) := (others => '0');
    signal decimal_point  : std_logic := '0';
    signal decimal_en     : std_logic := '0';
    signal high_or_low    : std_logic := '0';

    component normal_register_split

        port (
            clk                  : in    std_logic;
            reset                : in    std_logic;
            en_input             : in    std_logic;
            normal_input         : in    std_logic_vector (7 downto 0);
            normal_output_upper  : out   std_logic_vector (3 downto 0);
            normal_output_lower  : out   std_logic_vector (3 downto 0)
        );

    end component;

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

begin

    normal_register_split_instance: normal_register_split port map (
        clk => clk,
        reset => clear,
        en_input => en_input,
        normal_input => lower_bus_in,
        normal_output_upper => upper_nibble,
        normal_output_lower => lower_nibble
    );

    seven_segment_decoder_lower_instance: seven_segment_decoder port map (
        nhigh_low => high_or_low,
        dc_point => decimal_point,
        bin_input => lower_nibble,
        a => a0,
        b => b0,
        c => c0,
        d => d0,
        e => e0,
        f => f0,
        g => g0,
        dot => decimal_en
    );
    
    seven_segment_decoder_upper_instance: seven_segment_decoder port map (
        nhigh_low => high_or_low,
        dc_point => decimal_point,
        bin_input => upper_nibble,
        a => a1,
        b => b1,
        c => c1,
        d => d1,
        e => e1,
        f => f1,
        g => g1,
        dot => decimal_en
    );

end behav;
