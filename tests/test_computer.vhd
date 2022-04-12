library ieee;
use ieee.std_logic_1164.all;

entity test_computer is
end test_computer;

architecture test of test_computer is

    component computer

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

    end component;

    signal clk                   : std_logic := '0';
    signal reset                 : std_logic := '0';

    signal en_input_port_in      : std_logic;
    signal input_port_in_data_0  : std_logic;
    signal input_port_in_data_1  : std_logic;
    signal input_port_in_data_2  : std_logic;
    signal input_port_in_data_3  : std_logic;
    signal input_port_in_data_4  : std_logic;
    signal input_port_in_data_5  : std_logic;
    signal input_port_in_data_6  : std_logic;
    signal input_port_in_data_7  : std_logic;
    signal a0                    : std_logic;
    signal b0                    : std_logic;
    signal c0                    : std_logic;
    signal d0                    : std_logic;
    signal e0                    : std_logic;
    signal f0                    : std_logic;
    signal g0                    : std_logic;
    signal a1                    : std_logic;
    signal b1                    : std_logic;
    signal c1                    : std_logic;
    signal d1                    : std_logic;
    signal e1                    : std_logic;
    signal f1                    : std_logic;
    signal g1                    : std_logic;

begin

    clk <= not clk after 5 ns;
    reset <= '1', '0' after 10 ns;

    computer_instance: computer port map (
        clk => clk,
        master_reset => reset,
        en_input_port_in => en_input_port_in,
        input_port_in_data_0 => input_port_in_data_0,
        input_port_in_data_1 => input_port_in_data_1,
        input_port_in_data_2 => input_port_in_data_2,
        input_port_in_data_3 => input_port_in_data_3,
        input_port_in_data_4 => input_port_in_data_4,
        input_port_in_data_5 => input_port_in_data_5,
        input_port_in_data_6 => input_port_in_data_6,
        input_port_in_data_7 => input_port_in_data_7,
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

    process
    begin

        assert false report "Start of Simulation" severity note;

        input_port_in_data_0 <= '0';
        input_port_in_data_1 <= '0';
        input_port_in_data_2 <= '0';
        input_port_in_data_3 <= '0';
        input_port_in_data_4 <= '0';
        input_port_in_data_5 <= '0';
        input_port_in_data_6 <= '0';
        input_port_in_data_7 <= '0';
        en_input_port_in <= '0';
        wait for 1000 ns;

        assert false report "End of Simulation" severity failure;

    end process;

end test;
