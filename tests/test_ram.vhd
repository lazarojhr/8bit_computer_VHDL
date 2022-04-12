library ieee;
use ieee.std_logic_1164.all;

entity test_ram is
end test_ram;

architecture test of test_ram is

    component ram

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

    end component;

    signal clk                 : std_logic := '0';
    signal reset               : std_logic := '0';

    signal ram_nr_w            : std_logic;
    signal ram_en              : std_logic;
    signal ram_en_out          : std_logic;
    signal addrs_in_mar        : std_logic_vector (7 downto 0);
    signal data_in_mdr         : std_logic_vector (7 downto 0);
    signal data_in_upper_bus   : std_logic_vector (7 downto 0);
    signal data_out_mdr        : std_logic_vector (7 downto 0);
    signal data_out_upper_bus  : std_logic_vector (7 downto 0);

begin

    clk <= not clk after 5 ns;
    reset <= '1', '0' after 10 ns;

    ram_instance: ram port map (
        clk => clk,
        ram_clr => reset,
        ram_nr_w => ram_nr_w,
        ram_en => ram_en,
        ram_en_out => ram_en_out,
        addrs_in_mar => addrs_in_mar,
        data_in_mdr => data_in_mdr,
        data_in_upper_bus => data_in_upper_bus,
        data_out_mdr => data_out_mdr,
        data_out_upper_bus => data_out_upper_bus
    );

    process
    begin

        assert false report "Starting Simulation" severity note;

        ram_nr_w <= '0';
        ram_en <= '0';
        ram_en_out <= '0';
        addrs_in_mar <= "00000000";
        data_in_mdr <= "00000000";
        data_in_upper_bus <= "ZZZZZZZZ";
        wait for 10 ns;
        -- Write to program space
        addrs_in_mar <= "00000000";
        data_in_mdr <= "10101010";
        data_in_upper_bus <= "11110000";
        ram_nr_w <= '1';
        ram_en <= '1';
        wait for 10 ns;
        ram_nr_w <= '0';
        ram_en <= '0';
        data_in_upper_bus <= "ZZZZZZZZ";
        wait for 10 ns;
        addrs_in_mar <= "00000001";
        data_in_mdr <= "10101011";
        data_in_upper_bus <= "11110001";
        ram_nr_w <= '1';
        ram_en <= '1';
        wait for 10 ns;
        ram_nr_w <= '0';
        ram_en <= '0';
        data_in_upper_bus <= "ZZZZZZZZ";
        wait for 10 ns;
        addrs_in_mar <= "00111111";
        data_in_mdr <= "10101111";
        data_in_upper_bus <= "11110011";
        ram_nr_w <= '1';
        ram_en <= '1';
        wait for 10 ns;
        ram_nr_w <= '0';
        ram_en <= '0';
        data_in_upper_bus <= "ZZZZZZZZ";
        wait for 10 ns;
        -- Write to use space
        addrs_in_mar <= "01000000";
        data_in_mdr <= "11110000";
        ram_nr_w <= '1';
        ram_en <= '1';
        wait for 10 ns;
        ram_nr_w <= '0';
        ram_en <= '0';
        wait for 10 ns;
        addrs_in_mar <= "01000001";
        data_in_mdr <= "10101010";
        ram_nr_w <= '1';
        ram_en <= '1';
        wait for 10 ns;
        ram_nr_w <= '0';
        ram_en <= '0';
        wait for 10 ns;
        addrs_in_mar <= "11111111";
        data_in_mdr <= "11111111";
        ram_nr_w <= '1';
        ram_en <= '1';
        wait for 10 ns;
        ram_nr_w <= '0';
        ram_en <= '0';
        wait for 10 ns;
        -- Read from program space
        addrs_in_mar <= "00000000";
        ram_nr_w <= '0';
        ram_en_out <= '1';
        ram_en <= '1';
        wait for 10 ns;
        assert data_out_upper_bus = "11110000" and data_out_mdr = "10101010" 
            report "ERROR (1)" severity warning;
        wait for 10 ns;
        ram_en_out <= '0';
        ram_en <= '0';
        wait for 10 ns;
        addrs_in_mar <= "00000001";
        ram_nr_w <= '0';
        ram_en_out <= '1';
        ram_en <= '1';
        wait for 10 ns;
        assert data_out_upper_bus = "11110001" and data_out_mdr = "10101011" 
            report "ERROR (2)" severity warning;
        wait for 10 ns;
        ram_en_out <= '0';
        ram_en <= '0';
        wait for 10 ns;
        addrs_in_mar <= "00111111";
        ram_nr_w <= '0';
        ram_en_out <= '1';
        ram_en <= '1';
        wait for 10 ns;
        assert data_out_upper_bus = "11110011" and data_out_mdr = "10101111" 
            report "ERROR (3)" severity warning;
        wait for 10 ns;
        ram_en_out <= '0';
        ram_en <= '0';
        wait for 10 ns;
        -- Read from user space
        addrs_in_mar <= "01000000";
        ram_nr_w <= '0';
        ram_en_out <= '1';
        ram_en <= '1';
        wait for 10 ns;
        assert data_out_mdr = "11110000" report "ERROR (4)" severity warning;
        wait for 10 ns;
        ram_en_out <= '0';
        ram_en <= '0';
        wait for 10 ns;
        addrs_in_mar <= "01000001";
        ram_nr_w <= '0';
        ram_en_out <= '1';
        ram_en <= '1';
        wait for 10 ns;
        assert data_out_mdr = "10101010" report "ERROR (5)" severity warning;
        wait for 10 ns;
        ram_en_out <= '0';
        ram_en <= '0';
        wait for 10 ns;
        addrs_in_mar <= "11111111";
        ram_nr_w <= '0';
        ram_en_out <= '1';
        ram_en <= '1';
        wait for 10 ns;
        assert data_out_mdr = "11111111" report "ERROR (6)" severity warning;
        wait for 10 ns;
        ram_en_out <= '0';
        ram_en <= '0';
        wait for 10 ns;

        assert false report "End of Simulation" severity failure;

    end process;

end test;
