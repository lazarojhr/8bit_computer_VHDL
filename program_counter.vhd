library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is

    port (
        clk         : in    std_logic;
        reset       : in    std_logic;
        load        : in    std_logic;
        count       : in    std_logic;
        en_output   : in    std_logic;
        address_in  : in    std_logic_vector (7 downto 0);
        address_out : out   std_logic_vector (7 downto 0)
    );

end program_counter;

architecture behav of program_counter is

    signal counter : std_logic_vector (5 downto 0) := (others => '0');

begin

    process (clk, reset)
    begin

        if reset = '1' then
            counter <= (others => '0');
        elsif clk'event and clk = '1' then
            if count = '1' and load = '0' then
                counter <= std_logic_vector(unsigned(counter) + "1");
            elsif count = '0' and load = '1' then
		counter <= (
		    5 => address_in(5),
		    4 => address_in(4),
                    3 => address_in(3),
   	     	    2 => address_in(2),
		    1 => address_in(1),
   		    0 => address_in(0)
		);
            end if;
        end if;

    end process;

    process (load, count, en_output, address_in, counter)
    begin

        if en_output = '1' then
            address_out <= (
		5 => counter(5),
		4 => counter(4),
		3 => counter(3),
		2 => counter(2),
		1 => counter(1),
		0 => counter(0),
		others => '0'
	    );
        elsif en_output = '0' then
            address_out <= (others => 'Z');
        end if;

    end process;

end behav;
