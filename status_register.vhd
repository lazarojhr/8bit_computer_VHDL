library ieee;
use ieee.std_logic_1164.all;

entity status_register is

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

end status_register;

architecture behav of status_register is
begin

    process (clk, reset)
    begin

        if reset = '1' then
            cout_nbout_out <= '0';
            z_out <= '1';
            n_out <= '0';
        elsif clk'event and clk = '1' then
            if en_status = '1' then
                cout_nbout_out <= cout_nbout_in;
                z_out <= z_in;
                n_out <= n_in;
            end if;
        end if;

    end process;

end behav;
