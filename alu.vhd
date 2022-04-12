library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is

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

end alu;

architecture behav of alu is

    function convert_to_8bits (value : in std_logic_vector (8 downto 0)) return std_logic_vector is

        variable temp   : std_logic_vector (7 downto 0);

    begin

        temp := ( 
            7 => value(7), 6 => value(6), 5 => value(5), 4 => value(4),
            3 => value(3), 2 => value(2), 1 => value(1), 0 => value(0)
        );

        return temp;

    end convert_to_8bits;

    function get_carry_out (value : in std_logic_vector (8 downto 0); option : in std_logic) return std_logic is

        variable temp   : std_logic;

    begin

        if option = '1' then
            temp := value(8);
        else
            temp := '0';
        end if;

        return temp;

    end get_carry_out;

    function get_zero_out (value : in std_logic_vector (8 downto 0)) return std_logic is

        variable temp   : std_logic;
        variable data   : std_logic_vector (7 downto 0);
        variable zero   : std_logic_vector (7 downto 0) := (others => '0');

    begin

        data := convert_to_8bits(value);

        if data = zero then
            temp := '1';
        else
            temp := '0';
        end if;

        return temp;

    end get_zero_out;

    function get_negative_out (value : in std_logic_vector (8 downto 0); option : in std_logic) return std_logic is

        variable temp   : std_logic;
        variable data   : std_logic_vector (7 downto 0);

    begin

        if option = '1' then
            data := convert_to_8bits(value);
            if data(7) = '1' then
                temp := '1';
            else
                temp := '0';
            end if;
        else
            temp := '0';
        end if;

        return temp;

    end get_negative_out;

    function shift_rotate_left_right (value : in std_logic_vector (7 downto 0); option : in std_logic_vector (1 downto 0)) return std_logic_vector is

        variable shifted_value  : std_logic_vector (7 downto 0);
        variable shft_left      : std_logic_vector (1 downto 0) := "00";
        variable shft_right     : std_logic_vector (1 downto 0) := "01";
        variable rot_left       : std_logic_vector (1 downto 0) := "10";
        variable rot_right      : std_logic_vector (1 downto 0) := "11";

    begin

        if option = shft_left then
            -- shift left
            shifted_value := (
                        7 => value(6), 6 => value(5), 5 => value(4), 4 => value(3), 
                        3 => value(2), 2 => value(1), 1 => value(0), 0 => '0'
            );
        elsif option = shft_right then
            -- shift right
            shifted_value := (
                        7 => '0', 6 => value(7), 5 => value(6), 4 => value(5), 
                        3 => value(4), 2 => value(3), 1 => value(2), 0 => value(1)
            );
        elsif option = rot_left then
            -- rotate left
            shifted_value := (
                        7 => value(6), 6 => value(5), 5 => value(4), 4 => value(3), 
                        3 => value(2), 2 => value(1), 1 => value(0), 0 => value(7)
            );
        elsif option = rot_right then
            -- rotate right
            shifted_value := (
                        7 => value(0), 6 => value(7), 5 => value(6), 4 => value(5), 
                        3 => value(4), 2 => value(3), 1 => value(2), 0 => value(1)
            );
        end if;

        return shifted_value;

    end shift_rotate_left_right;

begin

    process (reset, cin_nbin, alu_en, alu_sel, acc_input, lower_bus_in)

        variable result         : std_logic_vector (8 downto 0);
        variable temp_result    : std_logic_vector (7 downto 0);
        variable upper_nibble   : std_logic_vector (3 downto 0);
        variable lower_nibble   : std_logic_vector (3 downto 0);

    begin

        if reset = '1' then
            cout_nbout <= '0';
            z_out <= '1';
            n_out <= '0';
            output <= (others => '0');
        else
            case alu_sel is
                when "00000" | "00001" =>
                    if alu_en = '1' then
                        result := std_logic_vector(unsigned(('0' & acc_input)) + unsigned(('0' & lower_bus_in)));

                        cout_nbout <= get_carry_out(result, '1');
                        z_out <= get_zero_out(result);
                        n_out <= get_negative_out(result, '0');
                        output <= convert_to_8bits(result);
                    end if;
                when "00010" | "00011" =>
                    if alu_en = '1' then
                        result := ('0' & acc_input) and ('0' & lower_bus_in);

                        cout_nbout <= get_carry_out(result, '0');
                        z_out <= get_zero_out(result);
                        n_out <= get_negative_out(result, '0');
                        output <= convert_to_8bits(result);
                    end if;
                when "00100" | "00101" =>
                    if alu_en = '1' then
                        result := ('0' & acc_input) or ('0' & lower_bus_in);

                        cout_nbout <= get_carry_out(result, '0');
                        z_out <= get_zero_out(result);
                        n_out <= get_negative_out(result, '0');
                        output <= convert_to_8bits(result);
                    end if;
                when "00110" =>
                    if alu_en = '1' then
                        result := ('0' & acc_input) nand ('0' & lower_bus_in);

                        cout_nbout <= get_carry_out(result, '0');
                        z_out <= get_zero_out(result);
                        n_out <= get_negative_out(result, '0');
                        output <= convert_to_8bits(result);
                    end if;
                when "00111" =>
                    if alu_en = '1' then
                        result := ('0' & acc_input) nor ('0' & lower_bus_in);

                        cout_nbout <= get_carry_out(result, '0');
                        z_out <= get_zero_out(result);
                        n_out <= get_negative_out(result, '0');
                        output <= convert_to_8bits(result);
                    end if;
                when "01000" | "01001" =>
                    if alu_en = '1' then 
                        result := ('0' & acc_input) xor ('0' & lower_bus_in);

                        cout_nbout <= get_carry_out(result, '0');
                        z_out <= get_zero_out(result);
                        n_out <= get_negative_out(result, '0');
                        output <= convert_to_8bits(result);
                    end if;
                when "01010" =>
                    if alu_en = '1' then
                        result := ('0' & acc_input) xnor ('0' & lower_bus_in);

                        cout_nbout <= get_carry_out(result, '0');
                        z_out <= get_zero_out(result);
                        n_out <= get_negative_out(result, '0');
                        output <= convert_to_8bits(result);
                    end if;
                when "01011" =>
                    if alu_en = '1' then
                        result := not ('0' & acc_input);

                        cout_nbout <= get_carry_out(result, '0');
                        z_out <= get_zero_out(result);
                        n_out <= get_negative_out(result, '0');
                        output <= convert_to_8bits(result);
                    end if;
                when "01100" | "10100" | "10101" | "10110" | "10111" | "11000" | "11001" | "11010" | "11011" | "11100" | "11101" | "11110" =>
                    if alu_en = '1' then
                        result := '0' & acc_input;

                        cout_nbout <= get_carry_out(result, '0');
                        z_out <= get_zero_out(result);
                        n_out <= get_negative_out(result, '0');
                        output <= convert_to_8bits(result);
                    end if;
                when "01101" | "01110" =>
                    if alu_en = '1' then
                        result := std_logic_vector(unsigned(('0' & acc_input)) - unsigned(('0' & lower_bus_in)));

                        cout_nbout <= get_carry_out(result, '1');
                        z_out <= get_zero_out(result);
                        n_out <= get_negative_out(result, '1');
                        output <= convert_to_8bits(result);
                    end if;
                when "01111" =>
                    if alu_en = '1' then
                        upper_nibble := (
                                3 => acc_input(7), 2 => acc_input(6), 1 => acc_input(5), 0 => acc_input(4)
                        );
                        lower_nibble := (
                                3 => acc_input(3), 2 => acc_input(2), 1 => acc_input(1), 0 => acc_input(0)
                        );

                        result := '0' & std_logic_vector(unsigned(upper_nibble) * unsigned(lower_nibble));

                        cout_nbout <= get_carry_out(result, '1');
                        z_out <= get_zero_out(result);
                        n_out <= get_negative_out(result, '0');
                        output <= convert_to_8bits(result);
                    end if;
                when "10000" =>
                    if alu_en = '1' then
                        result := acc_input(7) & acc_input;
                        cout_nbout <= get_carry_out(result, '1');

                        temp_result := shift_rotate_left_right(acc_input, "00");
                        result := '0' & temp_result;
                        z_out <= get_zero_out(result);
                        n_out <= get_negative_out(result, '0');
                        output <= temp_result;
                    end if;
                when "10001" =>
                    if alu_en = '1' then
                        result := acc_input(0) & acc_input;
                        cout_nbout <= get_carry_out(result, '1');

                        temp_result := shift_rotate_left_right(acc_input, "01");
                        result := '0' & temp_result;
                        z_out <= get_zero_out(result);
                        n_out <= get_negative_out(result, '0');
                        output <= temp_result;
                    end if;
                when "10010" =>
                    if alu_en = '1' then
                        result := '0' & shift_rotate_left_right(acc_input, "10");

                        cout_nbout <= get_carry_out(result, '0');
                        z_out <= get_zero_out(result);
                        n_out <= get_negative_out(result, '0');
                        output <= convert_to_8bits(result);
                    end if;
                when "10011" =>
                    if alu_en = '1' then
                        result := '0' & shift_rotate_left_right(acc_input, "11");

                        cout_nbout <= get_carry_out(result, '0');
                        z_out <= get_zero_out(result);
                        n_out <= get_negative_out(result, '0');
                        output <= convert_to_8bits(result);
                    end if;
                when others =>
                    if alu_en = '1' then
                        cout_nbout <= '0';
                        z_out <= '1';
                        n_out <= '0';
                        output <= (others => '0');
                    end if;
            end case;
        end if;

    end process;

end behav;
