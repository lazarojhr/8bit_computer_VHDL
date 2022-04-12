library ieee;
use ieee.std_logic_1164.all;

entity mdr is

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

end mdr;

architecture behav of mdr is

    signal upper_data_in    : std_logic_vector (7 downto 0) := (others => '0');
    signal lower_data_in    : std_logic_vector (7 downto 0) := (others => '0');

begin

    process (clk, mdr_clr)
    begin

        if mdr_clr = '1' then
            upper_data_in <= (others => '0');
            lower_data_in <= (others => '0');
        elsif clk'event and clk = '1' then
            if mdr_en_in = '1' then
                upper_data_in <= ram_upper_data_in;
                if mdr_sel_in = '0' then
                    lower_data_in <= bus_data_in;
                elsif mdr_sel_in = '1' then
                    lower_data_in <= ram_lower_data_in;
                end if;
            end if;
        end if;

    end process;

    process (mdr_sel_in, mdr_sel_out, mdr_en_in, mdr_en_out, bus_data_in, ram_upper_data_in, ram_lower_data_in, upper_data_in, lower_data_in)
    begin

        if mdr_en_out = '1' then
            bus_upper_data_out <= upper_data_in;
            if mdr_sel_out = '0' then
                bus_lower_data_out <= lower_data_in;
            elsif mdr_sel_out = '1' then
                bus_lower_data_out <= (others => '0');
            end if;
        elsif mdr_en_out = '0' then
            bus_upper_data_out <= (others => 'Z');
            bus_lower_data_out <= (others => 'Z');
        end if;
        
        if mdr_sel_out = '0' then
            ram_data_out <= (others => '0');
        elsif mdr_sel_out = '1' then
            ram_data_out <= lower_data_in;
        end if;

    end process;

end behav;
