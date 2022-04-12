library ieee;
use ieee.std_logic_1164.all;

entity control_unit is

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

end control_unit;

architecture behav of control_unit is

    type opcode_array is array (0 to 31) of std_logic_vector (4 downto 0);
    constant opcode_values :    opcode_array := (
        "00000", "00001", "00010", "00011", "00100", "00101", "00110", "00111",
        "01000", "01001", "01010", "01011", "01100", "01101", "01110", "01111",
        "10000", "10001", "10010", "10011", "10100", "10101", "10110", "10111",
        "11000", "11001", "11010", "11011", "11100", "11101", "11110", "11111"
    );

    type input_output_selector_array is array (0 to 7) of std_logic_vector (2 downto 0);
    constant input_output_selector_values :     input_output_selector_array := (
        "000", "001", "010", "011", "100", "101", "110", "111"
    );

    type ring_counter is (
        counter_0,
        counter_1,
        counter_2,
        counter_3,
        counter_4,
        counter_5,
        counter_6,
        counter_7
    );

    signal current_state            : ring_counter := counter_0;
    signal next_state               : ring_counter := counter_0;

    signal opcode                   : std_logic_vector (4 downto 0) := (others => '0');
    signal input_output_selector    : std_logic_vector (2 downto 0) := (others => '0');
    signal addrs_or_literal         : std_logic_vector (7 downto 0) := (others => '0');

begin

    process (clk, master_reset)
    begin

        if master_reset = '1' then
            reg_0_en_in <= '0';
            reg_0_en_out <= '0';
            reg_0_clr <= '1';
            reg_1_en_in <= '0';
            reg_1_en_out <= '0';
            reg_1_clr <= '1';
            reg_2_en_in <= '0';
            reg_2_en_out <= '0';
            reg_2_clr <= '1';
            reg_3_en_in <= '0';         
            reg_3_en_out <= '0';       
            reg_3_clr <= '1';          
            reg_4_en_in <= '0';        
            reg_4_en_out <= '0';       
            reg_4_clr <= '1';          
            input_port_en_out <= '0';  
            output_port_en_in <= '0';  
            pc_load <= '0';            
            pc_count <= '0';           
            pc_en_out <= '1';          
            pc_reset <= '1';           
            ir_en_in <= '0';           
            ir_en_out <= '0';          
            ir_clr <= '1';             
            lower_bus_out <= (others => 'Z');     
            alu_a_in_en <= '0';        
            alu_a_in_clr <= '1';       
            alu_en <= '0';             
            alu_sub <= '0';            
            alu_opcode <= (others => '0');       
            acc_sel_in <= '0';         
            acc_en_in <= '0';          
            acc_en_bus_out <= '0';     
            acc_clr <= '1';            
            status_en <= '0';          
            status_clr <= '1';         
            cout_nbout <= '0';         
            halt <= '0';               
            mar_en <= '1';             
            mar_clr <= '1';            
            ram_nr_w <= '0';           
            ram_en_in <= '0';          
            ram_en_out <= '0';         
            ram_clr <= '1';            
            mdr_sel_in <= '0';         
            mdr_en_in <= '0';          
            mdr_sel_out <= '0';        
            mdr_en_out <= '0';         
            mdr_clr <= '1';            
            opcode <= (others => '0');   
            input_output_selector <= (others => '0');
            addrs_or_literal <= (others => '0');     
        elsif clk'event and clk = '0' then

            case next_state is
                when counter_0 =>
                    pc_en_out <= '1';
                    mar_en <= '1';

                    reg_0_en_in <= '0';
                    reg_0_en_out <= '0';
                    reg_0_clr <= '0';
                    reg_1_en_in <= '0';
                    reg_1_en_out <= '0';
                    reg_1_clr <= '0';
                    reg_2_en_in <= '0';
                    reg_2_en_out <= '0';
                    reg_2_clr <= '0';
                    reg_3_en_in <= '0';         
                    reg_3_en_out <= '0';       
                    reg_3_clr <= '0';          
                    reg_4_en_in <= '0';        
                    reg_4_en_out <= '0';       
                    reg_4_clr <= '0';          
                    input_port_en_out <= '0';  
                    output_port_en_in <= '0';  
                    pc_load <= '0';            
                    pc_count <= '0';           
                    pc_reset <= '0';           
                    ir_en_in <= '0';           
                    ir_en_out <= '0';          
                    ir_clr <= '0';             
                    lower_bus_out <= (others => 'Z');     
                    alu_a_in_en <= '0';        
                    alu_a_in_clr <= '0';       
                    alu_en <= '0';             
                    alu_sub <= '0';            
                    alu_opcode <= (others => '0');       
                    acc_sel_in <= '0';         
                    acc_en_in <= '0';          
                    acc_en_bus_out <= '0';     
                    acc_clr <= '0';            
                    status_en <= '0';          
                    status_clr <= '0';         
                    cout_nbout <= '0';         
                    mar_clr <= '0';            
                    ram_nr_w <= '0';           
                    ram_en_in <= '0';          
                    ram_en_out <= '0';         
                    ram_clr <= '0';            
                    mdr_sel_in <= '0';         
                    mdr_en_in <= '0';          
                    mdr_sel_out <= '0';        
                    mdr_en_out <= '0';         
                    mdr_clr <= '0';            
                when counter_1 =>
                    ram_en_in <= '1';
                    ram_en_out <= '1';
                    mdr_sel_in <= '1';
                    mdr_en_in <= '1';

                    reg_0_en_in <= '0';
                    reg_0_en_out <= '0';
                    reg_0_clr <= '0';
                    reg_1_en_in <= '0';
                    reg_1_en_out <= '0';
                    reg_1_clr <= '0';
                    reg_2_en_in <= '0';
                    reg_2_en_out <= '0';
                    reg_2_clr <= '0';
                    reg_3_en_in <= '0';         
                    reg_3_en_out <= '0';       
                    reg_3_clr <= '0';          
                    reg_4_en_in <= '0';        
                    reg_4_en_out <= '0';       
                    reg_4_clr <= '0';          
                    input_port_en_out <= '0';  
                    output_port_en_in <= '0';  
                    pc_load <= '0';            
                    pc_count <= '0';           
                    pc_en_out <= '0';          
                    pc_reset <= '0';           
                    ir_en_in <= '0';           
                    ir_en_out <= '0';          
                    ir_clr <= '0';             
                    lower_bus_out <= (others => 'Z');     
                    alu_a_in_en <= '0';        
                    alu_a_in_clr <= '0';       
                    alu_en <= '0';             
                    alu_sub <= '0';            
                    alu_opcode <= (others => '0');       
                    acc_sel_in <= '0';         
                    acc_en_in <= '0';          
                    acc_en_bus_out <= '0';     
                    acc_clr <= '0';            
                    status_en <= '0';          
                    status_clr <= '0';         
                    cout_nbout <= '0';         
                    mar_en <= '0';             
                    mar_clr <= '0';            
                    ram_nr_w <= '0';           
                    ram_clr <= '0';            
                    mdr_sel_out <= '0';        
                    mdr_en_out <= '0';         
                    mdr_clr <= '0';            
                when counter_2 =>
                    mdr_en_out <= '1';
                    ir_en_in <= '1';

                    reg_0_en_in <= '0';
                    reg_0_en_out <= '0';
                    reg_0_clr <= '0';
                    reg_1_en_in <= '0';
                    reg_1_en_out <= '0';
                    reg_1_clr <= '0';
                    reg_2_en_in <= '0';
                    reg_2_en_out <= '0';
                    reg_2_clr <= '0';
                    reg_3_en_in <= '0';         
                    reg_3_en_out <= '0';       
                    reg_3_clr <= '0';          
                    reg_4_en_in <= '0';        
                    reg_4_en_out <= '0';       
                    reg_4_clr <= '0';          
                    input_port_en_out <= '0';  
                    output_port_en_in <= '0';  
                    pc_load <= '0';            
                    pc_count <= '0';           
                    pc_en_out <= '0';          
                    pc_reset <= '0';           
                    ir_en_out <= '0';          
                    ir_clr <= '0';             
                    lower_bus_out <= (others => 'Z');     
                    alu_a_in_en <= '0';        
                    alu_a_in_clr <= '0';       
                    alu_en <= '0';             
                    alu_sub <= '0';            
                    alu_opcode <= (others => '0');       
                    acc_sel_in <= '0';         
                    acc_en_in <= '0';          
                    acc_en_bus_out <= '0';     
                    acc_clr <= '0';            
                    status_en <= '0';          
                    status_clr <= '0';         
                    cout_nbout <= '0';         
                    mar_en <= '0';             
                    mar_clr <= '0';            
                    ram_nr_w <= '0';           
                    ram_en_in <= '0';          
                    ram_en_out <= '0';         
                    ram_clr <= '0';            
                    mdr_sel_in <= '0';         
                    mdr_en_in <= '0';          
                    mdr_sel_out <= '0';        
                    mdr_clr <= '0';            
                when counter_3 =>
                    ir_en_out <= '1';
                    opcode <= (4 => ir_upper_in(7), 3 => ir_upper_in(6),
                               2 => ir_upper_in(5), 1 => ir_upper_in(4),
                               0 => ir_upper_in(3)
                    );
                    input_output_selector <= (2 => ir_upper_in(2), 1 => ir_upper_in(1),
                                              0 => ir_upper_in(0)
                    );
                    addrs_or_literal <= ir_lower_in;

                    reg_0_en_in <= '0';
                    reg_0_en_out <= '0';
                    reg_0_clr <= '0';
                    reg_1_en_in <= '0';
                    reg_1_en_out <= '0';
                    reg_1_clr <= '0';
                    reg_2_en_in <= '0';
                    reg_2_en_out <= '0';
                    reg_2_clr <= '0';
                    reg_3_en_in <= '0';         
                    reg_3_en_out <= '0';       
                    reg_3_clr <= '0';          
                    reg_4_en_in <= '0';        
                    reg_4_en_out <= '0';       
                    reg_4_clr <= '0';          
                    input_port_en_out <= '0';  
                    output_port_en_in <= '0';  
                    pc_load <= '0';            
                    pc_count <= '0';           
                    pc_en_out <= '0';          
                    pc_reset <= '0';           
                    ir_en_in <= '0';           
                    ir_clr <= '0';             
                    lower_bus_out <= (others => 'Z');     
                    alu_a_in_en <= '0';        
                    alu_a_in_clr <= '0';       
                    alu_en <= '0';             
                    alu_sub <= '0';            
                    alu_opcode <= (others => '0');       
                    acc_sel_in <= '0';         
                    acc_en_in <= '0';          
                    acc_en_bus_out <= '0';     
                    acc_clr <= '0';            
                    status_en <= '0';          
                    status_clr <= '0';         
                    cout_nbout <= '0';         
                    mar_en <= '0';             
                    mar_clr <= '0';            
                    ram_nr_w <= '0';           
                    ram_en_in <= '0';          
                    ram_en_out <= '0';         
                    ram_clr <= '0';            
                    mdr_sel_in <= '0';         
                    mdr_en_in <= '0';          
                    mdr_sel_out <= '0';        
                    mdr_en_out <= '0';         
                    mdr_clr <= '0';            
                when counter_4 =>
                    alu_a_in_en <= '1';
                    pc_count <= '1';
                    if opcode = opcode_values(26) then
                        pc_reset <= '1';
                    end if;
                    if opcode = opcode_values(25) then
                        halt <= '1';
                    end if;

                    reg_0_en_in <= '0';
                    reg_0_en_out <= '0';
                    reg_0_clr <= '0';
                    reg_1_en_in <= '0';
                    reg_1_en_out <= '0';
                    reg_1_clr <= '0';
                    reg_2_en_in <= '0';
                    reg_2_en_out <= '0';
                    reg_2_clr <= '0';
                    reg_3_en_in <= '0';         
                    reg_3_en_out <= '0';       
                    reg_3_clr <= '0';          
                    reg_4_en_in <= '0';        
                    reg_4_en_out <= '0';       
                    reg_4_clr <= '0';          
                    input_port_en_out <= '0';  
                    output_port_en_in <= '0';  
                    pc_load <= '0';            
                    pc_en_out <= '0';          
                    ir_en_in <= '0';           
                    ir_en_out <= '0';          
                    ir_clr <= '0';             
                    lower_bus_out <= (others => 'Z');     
                    alu_a_in_clr <= '0';       
                    alu_en <= '0';             
                    alu_sub <= '0';            
                    alu_opcode <= (others => '0');       
                    acc_sel_in <= '0';         
                    acc_en_in <= '0';          
                    acc_en_bus_out <= '0';     
                    acc_clr <= '0';            
                    status_en <= '0';          
                    status_clr <= '0';         
                    cout_nbout <= '0';         
                    mar_en <= '0';             
                    mar_clr <= '0';            
                    ram_nr_w <= '0';           
                    ram_en_in <= '0';          
                    ram_en_out <= '0';         
                    ram_clr <= '0';            
                    mdr_sel_in <= '0';         
                    mdr_en_in <= '0';          
                    mdr_sel_out <= '0';        
                    mdr_en_out <= '0';         
                    mdr_clr <= '0';            
                when counter_5 =>
                    if opcode = opcode_values(20) then
                        acc_sel_in <= '1';
                        acc_en_in <= '1';
                    end if;

                    if opcode = opcode_values(0) or opcode = opcode_values(2) or opcode = opcode_values(4) 
                    or opcode = opcode_values(8) or opcode = opcode_values(12) or opcode = opcode_values(13) 
                    or opcode = opcode_values(20) or opcode = opcode_values(21) or opcode = opcode_values(22) 
                    or opcode = opcode_values(26) or opcode = opcode_values(30) then
                        lower_bus_out <= addrs_or_literal;
                        alu_en <= '1';
                        status_en <= '1';
                    else
                        lower_bus_out <= (others => 'Z');
                    end if;

                    if opcode = opcode_values(11) or opcode = opcode_values(15) or opcode = opcode_values(16)
                    or opcode = opcode_values(17) or opcode = opcode_values(18) or opcode = opcode_values(19) then
                        alu_en <= '1';
                        status_en <= '1';
                    end if;
                    
                    if opcode = opcode_values(1) or opcode = opcode_values(3) or opcode = opcode_values(5) 
                    or opcode = opcode_values(6) or opcode = opcode_values(7) or opcode = opcode_values(9) 
                    or opcode = opcode_values(10) or opcode = opcode_values(14) or opcode = opcode_values(23) then
                        alu_en <= '1';
                        status_en <= '1';
                        if input_output_selector = input_output_selector_values(0) then
                            acc_en_bus_out <= '1';
                        end if;
                        if input_output_selector = input_output_selector_values(1) then
                            reg_0_en_out <= '1';
                        end if;
                        if input_output_selector = input_output_selector_values(2) then
                            reg_1_en_out <= '1';
                        end if;
                        if input_output_selector = input_output_selector_values(3) then
                            reg_2_en_out <= '1';
                        end if;
                        if input_output_selector = input_output_selector_values(4) then
                            reg_3_en_out <= '1';
                        end if;
                        if input_output_selector = input_output_selector_values(5) then
                            reg_4_en_out <= '1';
                        end if;
                        if input_output_selector = input_output_selector_values(6) then
                            input_port_en_out <= '1';
                        end if;
                    end if;
                    
                    if opcode = opcode_values(0) or opcode = opcode_values(1) or opcode = opcode_values(2) 
                    or opcode = opcode_values(3) or opcode = opcode_values(4) or opcode = opcode_values(5)
                    or opcode = opcode_values(6) or opcode = opcode_values(7) or opcode = opcode_values(8) 
                    or opcode = opcode_values(9) or opcode = opcode_values(10) or opcode = opcode_values(11)
                    or opcode = opcode_values(12) or opcode = opcode_values(13) or opcode = opcode_values(14) 
                    or opcode = opcode_values(15) or opcode = opcode_values(16) or opcode = opcode_values(17) 
                    or opcode = opcode_values(18) or opcode = opcode_values(19) or opcode = opcode_values(20)
                    or opcode = opcode_values(23) then
                        acc_en_in <= '1';
                    end if;

                    if opcode = opcode_values(13) or opcode = opcode_values(14) then
                        alu_sub <= '1';
                    end if;

                    if opcode = opcode_values(13) or opcode = opcode_values(14) or status_cout_nbout = '1' then
                        cout_nbout <= '1';
                    end if;

                    if opcode = opcode_values(26) then
                        pc_load <= '1';
                    end if;

                    if opcode = opcode_values(21) or opcode = opcode_values(22) then
                        mar_en <= '1';
                    end if;

                    reg_0_en_in <= '0';
                    reg_0_clr <= '0';
                    reg_1_en_in <= '0';
                    reg_1_clr <= '0';
                    reg_2_en_in <= '0';
                    reg_2_clr <= '0';
                    reg_3_en_in <= '0';         
                    reg_3_clr <= '0';          
                    reg_4_en_in <= '0';        
                    reg_4_clr <= '0';          
                    output_port_en_in <= '0';  
                    pc_count <= '0';           
                    pc_en_out <= '0';          
                    pc_reset <= '0';           
                    ir_en_in <= '0';           
                    ir_en_out <= '0';          
                    ir_clr <= '0';             
                    alu_a_in_en <= '0';        
                    alu_a_in_clr <= '0';       
                    alu_opcode <= (others => '0');       
                    acc_clr <= '0';            
                    status_clr <= '0';         
                    mar_clr <= '0';            
                    ram_nr_w <= '0';           
                    ram_en_in <= '0';          
                    ram_en_out <= '0';         
                    ram_clr <= '0';            
                    mdr_sel_in <= '0';         
                    mdr_en_in <= '0';          
                    mdr_sel_out <= '0';        
                    mdr_en_out <= '0';         
                    mdr_clr <= '0';            
                when counter_6 =>
                    if opcode = opcode_values(22) then
                        ram_en_in <= '1';
                    end if;

                    if opcode = opcode_values(0) or opcode = opcode_values(2) or opcode = opcode_values(4) 
                    or opcode = opcode_values(8) or opcode = opcode_values(11) or opcode = opcode_values(12) 
                    or opcode = opcode_values(13) or opcode = opcode_values(15) or opcode = opcode_values(16) 
                    or opcode = opcode_values(17) or opcode = opcode_values(18) or opcode = opcode_values(19) 
                    or opcode = opcode_values(20) or opcode = opcode_values(30) then
                        acc_en_bus_out <= '1';
                        if input_output_selector = input_output_selector_values(1) then
                            reg_0_en_in <= '1';
                        end if;
                        if input_output_selector = input_output_selector_values(2) then
                            reg_1_en_in <= '1';
                        end if;
                        if input_output_selector = input_output_selector_values(3) then
                            reg_2_en_in <= '1';
                        end if;
                        if input_output_selector = input_output_selector_values(4) then
                            reg_3_en_in <= '1';
                        end if;
                        if input_output_selector = input_output_selector_values(5) then
                            reg_4_en_in <= '1';
                        end if;
                        if input_output_selector = input_output_selector_values(7) then
                            output_port_en_in <= '1';
                        end if;
                    end if;

                    if opcode = opcode_values(21) and input_output_selector = input_output_selector_values(0) then
                        acc_en_bus_out <= '1';
                    end if;

                    if opcode = opcode_values(21) and input_output_selector = input_output_selector_values(1) then
                        reg_0_en_out <= '1';
                    end if;
                    if opcode = opcode_values(21) and input_output_selector = input_output_selector_values(2) then
                        reg_1_en_out <= '1';
                    end if;
                    if opcode = opcode_values(21) and input_output_selector = input_output_selector_values(3) then
                        reg_2_en_out <= '1';
                    end if;
                    if opcode = opcode_values(21) and input_output_selector = input_output_selector_values(4) then
                        reg_3_en_out <= '1';
                    end if;
                    if opcode = opcode_values(21) and input_output_selector = input_output_selector_values(5) then
                        reg_4_en_out <= '1';
                    end if;
                    if opcode = opcode_values(21) and input_output_selector = input_output_selector_values(6) then
                        input_port_en_out <= '1';
                    end if;

                    if opcode = opcode_values(21) or opcode = opcode_values(22) then
                        mdr_en_in <= '1';
                    end if;

                    if opcode = opcode_values(22) then
                        mdr_sel_in <= '1';
                    end if;

                    ram_en_out <= '1';

                    if opcode = opcode_values(27) and status_n = '1' then
                        pc_count <= '1';
                    end if;
                    if opcode = opcode_values(28) and status_z = '1' then
                        pc_count <= '1';
                    end if;
                    if opcode = opcode_values(29) and status_z = '0' then
                        pc_count <= '1';
                    end if;

                    reg_0_clr <= '0';
                    reg_1_clr <= '0';
                    reg_2_clr <= '0';
                    reg_3_clr <= '0';          
                    reg_4_clr <= '0';          
                    pc_load <= '0';            
                    pc_en_out <= '0';          
                    pc_reset <= '0';           
                    ir_en_in <= '0';           
                    ir_en_out <= '0';          
                    ir_clr <= '0';             
                    lower_bus_out <= (others => 'Z');     
                    alu_a_in_en <= '0';        
                    alu_a_in_clr <= '0';       
                    alu_en <= '0';             
                    alu_sub <= '0';            
                    alu_opcode <= (others => '0');       
                    acc_sel_in <= '0';
                    acc_en_in <= '0';
                    acc_clr <= '0';            
                    status_en <= '0';          
                    status_clr <= '0';         
                    cout_nbout <= '0';         
                    mar_en <= '0';             
                    mar_clr <= '0';            
                    ram_nr_w <= '0';           
                    ram_clr <= '0';            
                    mdr_sel_out <= '0';        
                    mdr_en_out <= '0';         
                    mdr_clr <= '0';            
                when counter_7 =>
                    if opcode = opcode_values(22) then
                        acc_sel_in <= '1';
                    end if;

                    if opcode = opcode_values(22) and input_output_selector = input_output_selector_values(0) then
                        acc_en_in <= '1';
                    end if;

                    if opcode = opcode_values(21) then
                        ram_en_in <= '1';
                        ram_nr_w <= '1';
                        mdr_sel_out <= '1';
                    end if;

                    if opcode = opcode_values(22) then
                        mdr_en_out <= '1';
                        if input_output_selector = input_output_selector_values(1) then
                            reg_0_en_in <= '1';
                        end if;
                        if input_output_selector = input_output_selector_values(2) then
                            reg_1_en_in <= '1';
                        end if;
                        if input_output_selector = input_output_selector_values(3) then
                            reg_2_en_in <= '1';
                        end if;
                        if input_output_selector = input_output_selector_values(4) then
                            reg_3_en_in <= '1';
                        end if;
                        if input_output_selector = input_output_selector_values(5) then
                            reg_4_en_in <= '1';
                        end if;
                        if input_output_selector = input_output_selector_values(7) then
                            output_port_en_in <= '1';
                        end if;
                    end if;

                    reg_0_en_out <= '0';
                    reg_0_clr <= '0';
                    reg_1_en_out <= '0';
                    reg_1_clr <= '0';
                    reg_2_en_out <= '0';
                    reg_2_clr <= '0';
                    reg_3_en_out <= '0';       
                    reg_3_clr <= '0';          
                    reg_4_en_out <= '0';       
                    reg_4_clr <= '0';          
                    input_port_en_out <= '0';  
                    pc_load <= '0';            
                    pc_count <= '0';           
                    pc_en_out <= '0';          
                    pc_reset <= '0';           
                    ir_en_in <= '0';           
                    ir_en_out <= '0';          
                    ir_clr <= '0';             
                    lower_bus_out <= (others => 'Z');     
                    alu_a_in_en <= '0';        
                    alu_a_in_clr <= '0';       
                    alu_en <= '0';             
                    alu_sub <= '0';            
                    alu_opcode <= (others => '0');       
                    acc_en_bus_out <= '0';     
                    acc_clr <= '0';            
                    status_en <= '0';          
                    status_clr <= '0';         
                    cout_nbout <= '0';         
                    mar_en <= '0';             
                    mar_clr <= '0';            
                    ram_en_out <= '0';         
                    ram_clr <= '0';            
                    mdr_sel_in <= '0';         
                    mdr_en_in <= '0';          
                    mdr_clr <= '0';            
                when others =>
                    reg_0_en_in <= '0';
                    reg_0_en_out <= '0';
                    reg_0_clr <= '1';
                    reg_1_en_in <= '0';
                    reg_1_en_out <= '0';
                    reg_1_clr <= '1';
                    reg_2_en_in <= '0';
                    reg_2_en_out <= '0';
                    reg_2_clr <= '1';
                    reg_3_en_in <= '0';         
                    reg_3_en_out <= '0';       
                    reg_3_clr <= '1';          
                    reg_4_en_in <= '0';        
                    reg_4_en_out <= '0';       
                    reg_4_clr <= '1';          
                    input_port_en_out <= '0';  
                    output_port_en_in <= '0';  
                    pc_load <= '0';            
                    pc_count <= '0';           
                    pc_en_out <= '0';          
                    pc_reset <= '1';           
                    ir_en_in <= '0';           
                    ir_en_out <= '0';          
                    ir_clr <= '1';             
                    lower_bus_out <= (others => 'Z');     
                    alu_a_in_en <= '0';        
                    alu_a_in_clr <= '1';       
                    alu_en <= '0';             
                    alu_sub <= '0';            
                    alu_opcode <= (others => '0');       
                    acc_sel_in <= '0';         
                    acc_en_bus_out <= '0';     
                    acc_clr <= '1';            
                    status_en <= '0';          
                    status_clr <= '1';         
                    cout_nbout <= '0';         
                    halt <= '0';               
                    mar_en <= '0';             
                    mar_clr <= '1';            
                    ram_nr_w <= '0';           
                    ram_en_in <= '0';          
                    ram_en_out <= '0';         
                    ram_clr <= '1';            
                    mdr_sel_in <= '0';         
                    mdr_en_in <= '0';          
                    mdr_sel_out <= '0';        
                    mdr_en_out <= '0';         
                    mdr_clr <= '1';            
                    opcode <= (others => '0');              
                    input_output_selector <= (others => '0');
                    addrs_or_literal <= (others => '0');     
            end case;
        else
            reg_0_clr <= '0';
            reg_1_clr <= '0';
            reg_2_clr <= '0';
            reg_3_clr <= '0';
            reg_4_clr <= '0';
            ir_clr <= '0';
            alu_a_in_clr <= '0';
            acc_clr <= '0';
            status_clr <= '0';
            mar_clr <= '0';
            ram_clr <= '0';
            mdr_clr <= '0';
        end if;

    end process;

    process (clk, master_reset)
    begin

        if master_reset = '1' then
            next_state <= counter_0;
        elsif clk'event and clk = '1' then
            case current_state is
                when counter_0 =>
                    next_state <= counter_1;
                when counter_1 =>
                    next_state <= counter_2;
                when counter_2 =>
                    next_state <= counter_3;
                when counter_3 =>
                    next_state <= counter_4;
                when counter_4 =>
                    next_state <= counter_5;
                when counter_5 =>
                    next_state <= counter_6;
                when counter_6 =>
                    next_state <= counter_7;
                when counter_7 =>
                    next_state <= counter_0;
                when others =>
                    next_state <= counter_0;
            end case;
        end if;

    end process;

    process (clk, master_reset)
    begin

        if master_reset = '1' then
            current_state <= counter_0;
        elsif clk'event and clk = '0' then
            current_state <= next_state;
        end if;

    end process;

end behav;
