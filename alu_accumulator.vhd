library ieee;
use ieee.std_logic_1164.all;

entity alu_accumulator is

    port (
        clk                 : in    std_logic;
        acc_clear           : in    std_logic;
        acc_sel_in          : in    std_logic;
        acc_en_in           : in    std_logic;
        acc_en_bus_out      : in    std_logic;
        a_in_en             : in    std_logic;
        a_in_clear          : in    std_logic;
        cin_nbin            : in    std_logic;
        subtract            : in    std_logic;
        alu_en              : in    std_logic;
        alu_opcode          : in    std_logic_vector (4 downto 0);
        lower_bus_in        : in    std_logic_vector (7 downto 0);
        cout_nbout          : out   std_logic;
        z_out               : out   std_logic;
        n_out               : out   std_logic;
        lower_bus_out       : out   std_logic_vector (7 downto 0)
    );

end alu_accumulator;

architecture behav of alu_accumulator is

    component normal_register

        port (
            clk             : in std_logic;
            reset           : in std_logic;
            en_input        : in std_logic;
            normal_input    : in std_logic_vector (7 downto 0);
            normal_output   : out std_logic_vector (7 downto 0)
        );

    end component;

    component accumulator

        port (
            clk                 : in    std_logic;
            reset               : in    std_logic;
            input_sel           : in    std_logic;
            en_input            : in    std_logic;
            lower_bus_out_en    : in    std_logic;
            alu_input           : in    std_logic_vector (7 downto 0);
            lower_bus_in        : in    std_logic_vector (7 downto 0);
            alu_output          : out   std_logic_vector (7 downto 0);
            lower_bus_out       : out   std_logic_vector (7 downto 0)
        );

    end component;
    
    component alu

        port (
            reset           : in    std_logic;
            cin_nbin        : in    std_logic;
            alu_en          : in    std_logic;
            alu_sel         : in    std_logic_vector (4 downto 0);
            acc_input       : in    std_logic_vector (7 downto 0);
            lower_bus_in    : in    std_logic_vector (7 downto 0);
            cout_nbout      : out   std_logic;
            z_out           : out   std_logic;
            n_out           : out   std_logic;
            output          : out   std_logic_vector (7 downto 0)
        );

    end component;

    signal output       : std_logic_vector (7 downto 0) := (others => '0');
    signal alu_output   : std_logic_vector (7 downto 0) := (others => '0');
    signal a_output     : std_logic_vector (7 downto 0) := (others => '0');

begin

    a_register_instance: normal_register port map (
        clk => clk,
        reset => a_in_clear,
        en_input => a_in_en,
        normal_input => alu_output,
        normal_output => a_output
    );

    accumulator_instance: accumulator port map (
        clk => clk,
        reset => acc_clear,
        input_sel => acc_sel_in,
        en_input => acc_en_in,
        lower_bus_out_en => acc_en_bus_out,
        alu_input => output,
        lower_bus_in => lower_bus_in,
        alu_output => alu_output,
        lower_bus_out => lower_bus_out
    );

    alu_instance: alu port map (
        reset => acc_clear,
        cin_nbin => cin_nbin,
        alu_en => alu_en,
        alu_sel => alu_opcode,
        acc_input => a_output,
        lower_bus_in => lower_bus_in,
        cout_nbout => cout_nbout,
        z_out => z_out,
        n_out => n_out,
        output => output
    );

end behav;
