library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram is

    port (
        clk                 : in std_logic;
        ram_clr             : in std_logic;
        ram_nr_w            : in std_logic;
        ram_en              : in std_logic;
        ram_en_out          : in std_logic;
        addrs_in_mar        : in std_logic_vector (7 downto 0);
        data_in_mdr         : in std_logic_vector (7 downto 0);
        data_in_upper_bus   : in std_logic_vector (7 downto 0);
        data_out_mdr        : out std_logic_vector (7 downto 0);
        data_out_upper_bus  : out std_logic_vector (7 downto 0)
    );

end ram;

architecture behav of ram is

    type ram_prog_space is array (0 to 63) of std_logic_vector (7 downto 0);
    type ram_user_space is array (64 to 255) of std_logic_vector (7 downto 0);

    signal ram_prog_space_upper  : ram_prog_space := (others => (others => '0'));
    signal ram_prog_space_lower  : ram_prog_space := (others => (others => '0'));
    signal ram_user              : ram_user_space := (others => (others => '0'));

begin

    process (clk, ram_clr)

        variable index : integer range 0 to 255;

    begin

        if ram_clr = '1' then
            ram_prog_space_upper <= (others => (others => '0'));
            ram_prog_space_lower <= (others => (others => '0'));
            ram_user <= (others => (others => '0'));
        elsif clk'event and clk = '1' then
            if ram_nr_w = '1' and ram_en = '1' then
                index := to_integer(unsigned(addrs_in_mar));
                if index >= 0 and index <= 63 then
                    -- Program Space
                    ram_prog_space_upper(index) <= data_in_upper_bus;
                    ram_prog_space_lower(index) <= data_in_mdr;
                elsif index >= 64 and index <= 255 then
                    -- User Space
                    ram_user(index) <= data_in_mdr;
                end if;
            end if;
        end if;

    end process;

    process (ram_nr_w, ram_en, ram_en_out, addrs_in_mar, data_in_mdr, data_in_upper_bus)
        
        variable index : integer range 0 to 255;

    begin

        if ram_nr_w = '0' and ram_en_out = '1' and ram_en = '1' then
            index := to_integer(unsigned(addrs_in_mar));
            if index >= 0 and index <= 63 then
                -- Program Space
                data_out_upper_bus <= ram_prog_space_upper(index);
                data_out_mdr <= ram_prog_space_lower(index);
            elsif index >= 64 and index <= 255 then
                -- User Space
                data_out_mdr <= ram_user(index);
            end if;
        else
            data_out_upper_bus <= (others => '0');
            data_out_mdr <= (others => '0');
        end if;

    end process;

end behav;
