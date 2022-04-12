library ieee;
use ieee.std_logic_1164.all;

entity test_control_unit is
end test_control_unit;

architecture test of test_control_unit is

    component control_unit

        port (
            clk                 : in  std_logic;
            master_reset        : in  std_logic;
            ir_upper_in         : in  std_logic_vector (7 downto 0);
            ir_lower_in         : in  std_logic_vector (7 downto 0);
            status_cout_nbout   : in  std_logic;
            status_z            : in  std_logic;
            status_n            : in  std_logic;
            reg_0_en_in         : out std_logic;
            reg_0_en_out        : out std_logic;
            reg_0_clr           : out std_logic;
            reg_1_en_in         : out std_logic;
            reg_1_en_out        : out std_logic;
            reg_1_clr           : out std_logic;
            reg_2_en_in         : out std_logic;
            reg_2_en_out        : out std_logic;
            reg_2_clr           : out std_logic;
            reg_3_en_in         : out std_logic;
            reg_3_en_out        : out std_logic;
            reg_3_clr           : out std_logic;
            reg_4_en_in         : out std_logic;
            reg_4_en_out        : out std_logic;
            reg_4_clr           : out std_logic;
            input_port_en_out   : out std_logic;
            output_port_en_in   : out std_logic;
            pc_load             : out std_logic;
            pc_count            : out std_logic;
            pc_en_out           : out std_logic;
            pc_reset            : out std_logic;
            ir_en_in            : out std_logic;
            ir_en_out           : out std_logic;
            ir_clr              : out std_logic;
            lower_bus_out       : out std_logic_vector (7 downto 0);
            alu_a_in_en         : out std_logic;
            alu_a_in_clr        : out std_logic;
            alu_en              : out std_logic;
            alu_sub             : out std_logic;
            alu_opcode          : out std_logic_vector (4 downto 0);
            acc_sel_in          : out std_logic;
            acc_en_in           : out std_logic;
            acc_en_bus_out      : out std_logic;
            acc_clr             : out std_logic;
            status_en           : out std_logic;
            status_clr          : out std_logic;
            cout_nbout          : out std_logic;
            halt                : out std_logic;
            mar_en              : out std_logic;
            mar_clr             : out std_logic;
            ram_nr_w            : out std_logic;
            ram_en_in           : out std_logic;
            ram_en_out          : out std_logic;
            ram_clr             : out std_logic;
            mdr_sel_in          : out std_logic;
            mdr_en_in           : out std_logic;
            mdr_sel_out         : out std_logic;
            mdr_en_out          : out std_logic;
            mdr_clr             : out std_logic
        );

    end component;

        signal clk                 : std_logic := '0';
        signal reset               : std_logic := '0';

        signal ir_upper_in         : std_logic_vector (7 downto 0);
        signal ir_lower_in         : std_logic_vector (7 downto 0);
        signal status_cout_nbout   : std_logic;
        signal status_z            : std_logic;
        signal status_n            : std_logic;
        signal reg_0_en_in         : std_logic;
        signal reg_0_en_out        : std_logic;
        signal reg_0_clr           : std_logic;
        signal reg_1_en_in         : std_logic;
        signal reg_1_en_out        : std_logic;
        signal reg_1_clr           : std_logic;
        signal reg_2_en_in         : std_logic;
        signal reg_2_en_out        : std_logic;
        signal reg_2_clr           : std_logic;
        signal reg_3_en_in         : std_logic;
        signal reg_3_en_out        : std_logic;
        signal reg_3_clr           : std_logic;
        signal reg_4_en_in         : std_logic;
        signal reg_4_en_out        : std_logic;
        signal reg_4_clr           : std_logic;
        signal input_port_en_out   : std_logic;
        signal output_port_en_in   : std_logic;
        signal pc_load             : std_logic;
        signal pc_count            : std_logic;
        signal pc_en_out           : std_logic;
        signal pc_reset            : std_logic;
        signal ir_en_in            : std_logic;
        signal ir_en_out           : std_logic;
        signal ir_clr              : std_logic;
        signal lower_bus_out       : std_logic_vector (7 downto 0);
        signal alu_a_in_en         : std_logic;
        signal alu_a_in_clr        : std_logic;
        signal alu_en              : std_logic;
        signal alu_sub             : std_logic;
        signal alu_opcode          : std_logic_vector (4 downto 0);
        signal acc_sel_in          : std_logic;
        signal acc_en_in           : std_logic;
        signal acc_en_bus_out      : std_logic;
        signal acc_clr             : std_logic;
        signal status_en           : std_logic;
        signal status_clr          : std_logic;
        signal cout_nbout          : std_logic;
        signal halt                : std_logic;
        signal mar_en              : std_logic;
        signal mar_clr             : std_logic;
        signal ram_nr_w            : std_logic;
        signal ram_en_in           : std_logic;
        signal ram_en_out          : std_logic;
        signal ram_clr             : std_logic;
        signal mdr_sel_in          : std_logic;
        signal mdr_en_in           : std_logic;
        signal mdr_sel_out         : std_logic;
        signal mdr_en_out          : std_logic;
        signal mdr_clr             : std_logic;

begin

    clk <= not clk after 5 ns;
    reset <= '1', '0' after 10 ns;

    control_unit_instance: control_unit port map (
        clk => clk,
        master_reset => reset,
        ir_upper_in => ir_upper_in,
        ir_lower_in => ir_lower_in,
        status_cout_nbout => status_cout_nbout,
        status_z => status_z,
        status_n => status_n,
        reg_0_en_in => reg_0_en_in,
        reg_0_en_out => reg_0_en_out,
        reg_0_clr => reg_0_clr,
        reg_1_en_in => reg_1_en_in,
        reg_1_en_out => reg_1_en_out,
        reg_1_clr => reg_1_clr,
        reg_2_en_in => reg_2_en_in,
        reg_2_en_out => reg_2_en_out,
        reg_2_clr => reg_2_clr,
        reg_3_en_in => reg_3_en_in,
        reg_3_en_out => reg_3_en_out,
        reg_3_clr => reg_3_clr,
        reg_4_en_in => reg_4_en_in,
        reg_4_en_out => reg_4_en_out,
        reg_4_clr => reg_4_clr,
        input_port_en_out => input_port_en_out,
        output_port_en_in => output_port_en_in,
        pc_load => pc_load,
        pc_count => pc_count,
        pc_en_out => pc_en_out,
        pc_reset => pc_reset,
        ir_en_in => ir_en_in,
        ir_en_out => ir_en_out,
        ir_clr => ir_clr,
        lower_bus_out => lower_bus_out,
        alu_a_in_en => alu_a_in_en,
        alu_a_in_clr => alu_a_in_clr,
        alu_en => alu_en,
        alu_sub => alu_sub, 
        alu_opcode => alu_opcode,
        acc_sel_in => acc_sel_in,
        acc_en_in => acc_en_in,
        acc_en_bus_out => acc_en_bus_out,
        acc_clr => acc_clr,
        status_en => status_en,
        status_clr => status_clr,
        cout_nbout => cout_nbout,
        halt => halt,
        mar_en => mar_en,     
        mar_clr => mar_clr, 
        ram_nr_w => ram_nr_w,
        ram_en_in => ram_en_in,
        ram_en_out => ram_en_out,
        ram_clr => ram_clr,
        mdr_sel_in => mdr_sel_in,
        mdr_en_in => mdr_en_in,
        mdr_sel_out => mdr_sel_out,
        mdr_en_out => mdr_en_out,
        mdr_clr => mdr_clr
    );

    process
    begin

        assert false report "Start of Simulation" severity note;

        ir_upper_in <= "00000000";
        ir_lower_in <= "00000001";
        status_cout_nbout <= '0';
        status_z <= '1';
        status_n <= '0';
        wait for 20 ns;
        assert pc_en_out = '1' and mar_en = '1' report "Ring Counter 0 Error (1)" severity warning;
        wait for 10 ns;
        assert ram_en_in = '1' and ram_en_out = '1' and mdr_sel_in = '1' and mdr_en_in = '1'
            report "Ring Counter 1 Error (1)" severity warning;
        wait for 10 ns;
        assert mdr_en_out = '1' and ir_en_in = '1' report "Ring Counter 2 Error (1)" severity warning;
        wait for 10 ns;
        assert ir_en_out = '1' report "Ring Counter 3 Error (1)" severity warning;
        wait for 10 ns;
        assert alu_a_in_en = '1' and pc_count = '1' and pc_reset = '0' and halt = '0'
            report "Ring Counter 4 Error (1)" severity warning;
        wait for 10 ns;
        assert lower_bus_out = "00000001" and alu_en = '1' and status_en = '1' and acc_en_in = '1'
            report "Ring Counter 5 Error (1)" severity warning;
        wait for 10 ns;
        assert acc_en_bus_out = '1' report "Ring Counter 6 Error (1)" severity warning;
        wait for 20 ns;

        ir_upper_in <= "00000001";
        ir_lower_in <= "00000001";
        assert pc_en_out = '1' and mar_en = '1' report "Ring Counter 0 Error (2)" severity warning;
        wait for 10 ns;
        assert ram_en_in = '1' and ram_en_out = '1' and mdr_sel_in = '1' and mdr_en_in = '1'
            report "Ring Counter 1 Error (2)" severity warning;
        wait for 10 ns;
        assert mdr_en_out = '1' and ir_en_in = '1' report "Ring Counter 2 Error (2)" severity warning;
        wait for 10 ns;
        assert ir_en_out = '1' report "Ring Counter 3 Error (2)" severity warning;
        wait for 10 ns;
        assert alu_a_in_en = '1' and pc_count = '1' and pc_reset = '0' and halt = '0'
            report "Ring Counter 4 Error (2)" severity warning;
        wait for 10 ns;
        assert lower_bus_out = "00000001" and alu_en = '1' and status_en = '1' and acc_en_in = '1'
            report "Ring Counter 5 Error (2)" severity warning;
        wait for 10 ns;
        assert acc_en_bus_out = '1' and reg_0_en_in = '1' 
            report "Ring Counter 6 Error (2)" severity warning;
        wait for 20 ns;

        ir_upper_in <= "00000010";
        ir_lower_in <= "00000001";
        assert pc_en_out = '1' and mar_en = '1' report "Ring Counter 0 Error (3)" severity warning;
        wait for 10 ns;
        assert ram_en_in = '1' and ram_en_out = '1' and mdr_sel_in = '1' and mdr_en_in = '1'
            report "Ring Counter 1 Error (3)" severity warning;
        wait for 10 ns;
        assert mdr_en_out = '1' and ir_en_in = '1' report "Ring Counter 2 Error (3)" severity warning;
        wait for 10 ns;
        assert ir_en_out = '1' report "Ring Counter 3 Error (3)" severity warning;
        wait for 10 ns;
        assert alu_a_in_en = '1' and pc_count = '1' and pc_reset = '0' and halt = '0'
            report "Ring Counter 4 Error (3)" severity warning;
        wait for 10 ns;
        assert lower_bus_out = "00000001" and alu_en = '1' and status_en = '1' and acc_en_in = '1'
            report "Ring Counter 5 Error (3)" severity warning;
        wait for 10 ns;
        assert acc_en_bus_out = '1' and reg_1_en_in = '1' 
            report "Ring Counter 6 Error (3)" severity warning;
        wait for 20 ns;

        ir_upper_in <= "00000011";
        ir_lower_in <= "00000001";
        assert pc_en_out = '1' and mar_en = '1' report "Ring Counter 0 Error (4)" severity warning;
        wait for 10 ns;
        assert ram_en_in = '1' and ram_en_out = '1' and mdr_sel_in = '1' and mdr_en_in = '1'
            report "Ring Counter 1 Error (4)" severity warning;
        wait for 10 ns;
        assert mdr_en_out = '1' and ir_en_in = '1' report "Ring Counter 2 Error (4)" severity warning;
        wait for 10 ns;
        assert ir_en_out = '1' report "Ring Counter 3 Error (4)" severity warning;
        wait for 10 ns;
        assert alu_a_in_en = '1' and pc_count = '1' and pc_reset = '0' and halt = '0'
            report "Ring Counter 4 Error (4)" severity warning;
        wait for 10 ns;
        assert lower_bus_out = "00000001" and alu_en = '1' and status_en = '1' and acc_en_in = '1'
            report "Ring Counter 5 Error (4)" severity warning;
        wait for 10 ns;
        assert acc_en_bus_out = '1' and reg_2_en_in = '1' 
            report "Ring Counter 6 Error (4)" severity warning;
        wait for 20 ns;

        ir_upper_in <= "00000100";
        ir_lower_in <= "00000001";
        assert pc_en_out = '1' and mar_en = '1' report "Ring Counter 0 Error (5)" severity warning;
        wait for 10 ns;
        assert ram_en_in = '1' and ram_en_out = '1' and mdr_sel_in = '1' and mdr_en_in = '1'
            report "Ring Counter 1 Error (5)" severity warning;
        wait for 10 ns;
        assert mdr_en_out = '1' and ir_en_in = '1' report "Ring Counter 2 Error (5)" severity warning;
        wait for 10 ns;
        assert ir_en_out = '1' report "Ring Counter 3 Error (5)" severity warning;
        wait for 10 ns;
        assert alu_a_in_en = '1' and pc_count = '1' and pc_reset = '0' and halt = '0'
            report "Ring Counter 4 Error (5)" severity warning;
        wait for 10 ns;
        assert lower_bus_out = "00000001" and alu_en = '1' and status_en = '1' and acc_en_in = '1'
            report "Ring Counter 5 Error (5)" severity warning;
        wait for 10 ns;
        assert acc_en_bus_out = '1' and reg_3_en_in = '1' 
            report "Ring Counter 6 Error (5)" severity warning;
        wait for 20 ns;

        ir_upper_in <= "00000101";
        ir_lower_in <= "00000001";
        assert pc_en_out = '1' and mar_en = '1' report "Ring Counter 0 Error (6)" severity warning;
        wait for 10 ns;
        assert ram_en_in = '1' and ram_en_out = '1' and mdr_sel_in = '1' and mdr_en_in = '1'
            report "Ring Counter 1 Error (6)" severity warning;
        wait for 10 ns;
        assert mdr_en_out = '1' and ir_en_in = '1' report "Ring Counter 2 Error (6)" severity warning;
        wait for 10 ns;
        assert ir_en_out = '1' report "Ring Counter 3 Error (6)" severity warning;
        wait for 10 ns;
        assert alu_a_in_en = '1' and pc_count = '1' and pc_reset = '0' and halt = '0'
            report "Ring Counter 4 Error (6)" severity warning;
        wait for 10 ns;
        assert lower_bus_out = "00000001" and alu_en = '1' and status_en = '1' and acc_en_in = '1'
            report "Ring Counter 5 Error (6)" severity warning;
        wait for 10 ns;
        assert acc_en_bus_out = '1' and reg_4_en_in = '1' 
            report "Ring Counter 6 Error (6)" severity warning;
        wait for 20 ns;

        ir_upper_in <= "00000111";
        ir_lower_in <= "00000001";
        assert pc_en_out = '1' and mar_en = '1' report "Ring Counter 0 Error (7)" severity warning;
        wait for 10 ns;
        assert ram_en_in = '1' and ram_en_out = '1' and mdr_sel_in = '1' and mdr_en_in = '1'
            report "Ring Counter 1 Error (7)" severity warning;
        wait for 10 ns;
        assert mdr_en_out = '1' and ir_en_in = '1' report "Ring Counter 2 Error (7)" severity warning;
        wait for 10 ns;
        assert ir_en_out = '1' report "Ring Counter 3 Error (7)" severity warning;
        wait for 10 ns;
        assert alu_a_in_en = '1' and pc_count = '1' and pc_reset = '0' and halt = '0'
            report "Ring Counter 4 Error (7)" severity warning;
        wait for 10 ns;
        assert lower_bus_out = "00000001" and alu_en = '1' and status_en = '1' and acc_en_in = '1'
            report "Ring Counter 5 Error (7)" severity warning;
        wait for 10 ns;
        assert acc_en_bus_out = '1' and output_port_en_in = '1' 
            report "Ring Counter 6 Error (7)" severity warning;
        wait for 20 ns;

        ir_upper_in <= "11001000";
        ir_lower_in <= "00000000";
        assert pc_en_out = '1' and mar_en = '1' report "Ring Counter 0 Error (9)" severity warning;
        wait for 10 ns;
        assert ram_en_in = '1' and ram_en_out = '1' and mdr_sel_in = '1' and mdr_en_in = '1'
            report "Ring Counter 1 Error (9)" severity warning;
        wait for 10 ns;
        assert mdr_en_out = '1' and ir_en_in = '1' report "Ring Counter 2 Error (9)" severity warning;
        wait for 10 ns;
        assert ir_en_out = '1' report "Ring Counter 3 Error (9)" severity warning;
        wait for 10 ns;
        assert alu_a_in_en = '1' and pc_count = '1' and pc_reset = '0' and halt = '1'
            report "Ring Counter 4 Error (9)" severity warning;
        wait for 40 ns;

        assert false report "End of Simulation" severity failure;

    end process;

end test;
