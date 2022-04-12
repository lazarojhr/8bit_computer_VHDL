library ieee;
use ieee.std_logic_1164.all;

entity mar is

    port (
        clk         : in std_logic;
        mar_clr     : in std_logic;
        mar_en      : in std_logic;
        addrs_in    : in std_logic_vector (7 downto 0);
        addrs_out   : out std_logic_vector (7 downto 0)
    );

end mar;

architecture behav of mar is

    component normal_register

        port (
            clk                 : in    std_logic;
            reset               : in    std_logic;
            en_input            : in    std_logic;
            normal_input        : in    std_logic_vector (7 downto 0);
            normal_output       : out   std_logic_vector (7 downto 0)
        );

    end component;

begin

    register_instance: normal_register port map (
        clk => clk,
        reset => mar_clr,
        en_input => mar_en,
        normal_input => addrs_in,
        normal_output => addrs_out
    );

end behav;
