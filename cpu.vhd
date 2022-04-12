library ieee;
use ieee.std_logic_1164.all;

entity cpu is

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

end cpu;

architecture behav of cpu is

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

    component cpu_register

        port (
            clk                 : in    std_logic;
            reset               : in    std_logic;
            en_input            : in    std_logic;
            en_output           : in    std_logic;
            lower_bus_in        : in    std_logic_vector (7 downto 0);
            lower_bus_out       : out   std_logic_vector (7 downto 0)
        );

    end component;

    component program_counter

        port (
            clk         : in    std_logic;
            reset       : in    std_logic;
            load        : in    std_logic;
            count       : in    std_logic;
            en_output   : in    std_logic;
            address_in  : in    std_logic_vector (7 downto 0);
            address_out : out   std_logic_vector (7 downto 0)
        );

    end component;

    component instruction_register

        port (
            clk                 : in    std_logic;
            reset               : in    std_logic;
            en_input            : in    std_logic;
            en_output           : in    std_logic;
            lower_bus_in        : in    std_logic_vector (7 downto 0);
            upper_bus_in        : in    std_logic_vector (7 downto 0);
            lower_control_out   : out   std_logic_vector (7 downto 0);
            upper_control_out   : out   std_logic_vector (7 downto 0)
        );

    end component;

    component alu_accumulator

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

    end component;

    component status_register

        port (
            clk             : in    std_logic;
            reset           : in    std_logic;
            en_status       : in    std_logic;
            cout_nbout_in   : in    std_logic;
            z_in            : in    std_logic;
            n_in            : in    std_logic;
            cout_nbout_out  : out   std_logic;
            z_out           : out   std_logic;
            n_out           : out   std_logic
        );

    end component;
            
    signal reg_0_en_in         : std_logic := '0';
    signal reg_0_en_out        : std_logic := '0';
    signal reg_0_clr           : std_logic := '0';
    signal reg_1_en_in         : std_logic := '0';
    signal reg_1_en_out        : std_logic := '0';
    signal reg_1_clr           : std_logic := '0';
    signal reg_2_en_in         : std_logic := '0';
    signal reg_2_en_out        : std_logic := '0';
    signal reg_2_clr           : std_logic := '0';
    signal reg_3_en_in         : std_logic := '0';
    signal reg_3_en_out        : std_logic := '0';
    signal reg_3_clr           : std_logic := '0';
    signal reg_4_en_in         : std_logic := '0';
    signal reg_4_en_out        : std_logic := '0';
    signal reg_4_clr           : std_logic := '0';

    signal pc_load             : std_logic := '0';
    signal pc_count            : std_logic := '0';
    signal pc_en_out           : std_logic := '0';
    signal pc_reset            : std_logic := '0';
    
    signal ir_en_in            : std_logic := '0';
    signal ir_en_out           : std_logic := '0';
    signal ir_clr              : std_logic := '0';
    signal ir_lower_out        : std_logic_vector (7 downto 0) := (others => 'Z');
    signal ir_upper_out        : std_logic_vector (7 downto 0) := (others => 'Z');

    signal alu_a_in_en         : std_logic := '0';
    signal alu_a_in_clr        : std_logic := '0';
    signal alu_en              : std_logic := '0';
    signal alu_sub             : std_logic := '0';
    signal alu_opcode          : std_logic_vector (4 downto 0) := (others => '0');
    signal acc_sel_in          : std_logic := '0';
    signal acc_en_in           : std_logic := '0';
    signal acc_en_bus_out      : std_logic := '0';
    signal acc_clr             : std_logic := '0';
    signal alu_cout_nbout      : std_logic := '0';
    signal alu_z_out           : std_logic := '0';
    signal alu_n_out           : std_logic := '0';

    signal status_en           : std_logic := '0';
    signal status_clr          : std_logic := '0';
    signal cout_nbout          : std_logic := '0';
    signal status_cout_nbout   : std_logic := '0';
    signal status_z            : std_logic := '1';
    signal status_n            : std_logic := '0';

begin

    control_unit_instance: control_unit port map (
        clk => clk,
        master_reset => master_reset,
        ir_upper_in => ir_upper_out,
        ir_lower_in => ir_lower_out,
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

    cpu_register_instance_0: cpu_register port map (
        clk => clk,
        reset => reg_0_clr,
        en_input => reg_0_en_in,
        en_output => reg_0_en_out,
        lower_bus_in => lower_bus_in,
        lower_bus_out => lower_bus_out
    );
    
    cpu_register_instance_1: cpu_register port map (
        clk => clk,
        reset => reg_1_clr,
        en_input => reg_1_en_in,
        en_output => reg_1_en_out,
        lower_bus_in => lower_bus_in,
        lower_bus_out => lower_bus_out
    );
    
    cpu_register_instance_2: cpu_register port map (
        clk => clk,
        reset => reg_2_clr,
        en_input => reg_2_en_in,
        en_output => reg_2_en_out,
        lower_bus_in => lower_bus_in,
        lower_bus_out => lower_bus_out
    );
    
    cpu_register_instance_3: cpu_register port map (
        clk => clk,
        reset => reg_3_clr,
        en_input => reg_3_en_in,
        en_output => reg_3_en_out,
        lower_bus_in => lower_bus_in,
        lower_bus_out => lower_bus_out
    );
    
    cpu_register_instance_4: cpu_register port map (
        clk => clk,
        reset => reg_4_clr,
        en_input => reg_4_en_in,
        en_output => reg_4_en_out,
        lower_bus_in => lower_bus_in,
        lower_bus_out => lower_bus_out
    );

    program_counter_instance: program_counter port map (
        clk => clk,
        reset => master_reset,
        load => pc_load,
        count => pc_count,
        en_output => pc_en_out,
        address_in => lower_bus_in,
        address_out => lower_bus_out
    );

    instruction_register_instance: instruction_register port map (
        clk => clk,
        reset => ir_clr,
        en_input => ir_en_in,
        en_output => ir_en_out,
        lower_bus_in => lower_bus_in,
        upper_bus_in => upper_bus_in,
        lower_control_out => ir_lower_out,
        upper_control_out => ir_upper_out
    );

    alu_accumulator_instance: alu_accumulator port map (
        clk => clk,
        acc_clear => acc_clr,
        acc_sel_in => acc_sel_in,
        acc_en_in => acc_en_in,
        acc_en_bus_out => acc_en_bus_out,
        a_in_en => alu_a_in_en,
        a_in_clear => alu_a_in_clr,
        cin_nbin => cout_nbout,
        subtract => alu_sub,
        alu_en => alu_en,
        alu_opcode => alu_opcode,
        lower_bus_in => lower_bus_in,
        cout_nbout => alu_cout_nbout,
        z_out => alu_z_out,
        n_out => alu_n_out,
        lower_bus_out => lower_bus_out
    );

    status_register_instance: status_register port map (
        clk => clk,
        reset => status_clr,
        en_status => status_en,
        cout_nbout_in => alu_cout_nbout,
        z_in => alu_z_out,
        n_in => alu_n_out,
        cout_nbout_out => status_cout_nbout,
        z_out => status_z,
        n_out => status_n
    );

end behav;
