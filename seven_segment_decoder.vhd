library ieee;
use ieee.std_logic_1164.all;

entity seven_segment_decoder is

    port (
        nhigh_low   : in std_logic;
        dc_point    : in std_logic;
        bin_input   : in std_logic_vector (3 downto 0);
        a           : out std_logic;
        b           : out std_logic;
        c           : out std_logic;
        d           : out std_logic;
        e           : out std_logic;
        f           : out std_logic;
        g           : out std_logic;
        dot         : out std_logic
    );

end seven_segment_decoder;

architecture behav of seven_segment_decoder is
begin

    process (nhigh_low, dc_point, bin_input)
    begin

        case bin_input is
            when "0000" =>
                if nhigh_low = '0' then
                    a <= '1';
                    b <= '1';
                    c <= '1';
                    d <= '1';
                    e <= '1';
                    f <= '1';
                    g <= '0';
                elsif nhigh_low = '1' then
                    a <= '0';
                    b <= '0';
                    c <= '0';
                    d <= '0';
                    e <= '0';
                    f <= '0';
                    g <= '1';
                end if;
            when "0001" =>
                if nhigh_low = '0' then
                    a <= '0';
                    b <= '1';
                    c <= '1';
                    d <= '0';
                    e <= '0';
                    f <= '0';
                    g <= '0';
                elsif nhigh_low = '1' then
                    a <= '1';
                    b <= '0';
                    c <= '0';
                    d <= '1';
                    e <= '1';
                    f <= '1';
                    g <= '1';
                end if;
            when "0010" =>
                if nhigh_low = '0' then
                    a <= '1';
                    b <= '1';
                    c <= '0';
                    d <= '1';
                    e <= '1';
                    f <= '0';
                    g <= '1';
                elsif nhigh_low = '1' then
                    a <= '0';
                    b <= '0';
                    c <= '1';
                    d <= '0';
                    e <= '0';
                    f <= '1';
                    g <= '0';
                end if;
            when "0011" =>
                if nhigh_low = '0' then
                    a <= '1';
                    b <= '1';
                    c <= '1';
                    d <= '1';
                    e <= '0';
                    f <= '0';
                    g <= '1';
                elsif nhigh_low = '1' then
                    a <= '0';
                    b <= '0';
                    c <= '0';
                    d <= '0';
                    e <= '1';
                    f <= '1';
                    g <= '0';
                end if;
            when "0100" =>
                if nhigh_low = '0' then
                    a <= '0';
                    b <= '1';
                    c <= '1';
                    d <= '0';
                    e <= '0';
                    f <= '1';
                    g <= '1';
                elsif nhigh_low = '1' then
                    a <= '1';
                    b <= '0';
                    c <= '0';
                    d <= '1';
                    e <= '1';
                    f <= '0';
                    g <= '0';
                end if;
            when "0101" =>
                if nhigh_low = '0' then
                    a <= '1';
                    b <= '0';
                    c <= '1';
                    d <= '1';
                    e <= '0';
                    f <= '1';
                    g <= '1';
                elsif nhigh_low = '1' then
                    a <= '0';
                    b <= '1';
                    c <= '0';
                    d <= '0';
                    e <= '1';
                    f <= '0';
                    g <= '0';
                end if;
            when "0110" =>
                if nhigh_low = '0' then
                    a <= '1';
                    b <= '0';
                    c <= '1';
                    d <= '1';
                    e <= '1';
                    f <= '1';
                    g <= '1';
                elsif nhigh_low = '1' then
                    a <= '0';
                    b <= '1';
                    c <= '0';
                    d <= '0';
                    e <= '0';
                    f <= '0';
                    g <= '0';
                end if;
            when "0111" =>
                if nhigh_low = '0' then
                    a <= '1';
                    b <= '1';
                    c <= '1';
                    d <= '0';
                    e <= '0';
                    f <= '0';
                    g <= '0';
                elsif nhigh_low = '1' then
                    a <= '0';
                    b <= '0';
                    c <= '0';
                    d <= '1';
                    e <= '1';
                    f <= '1';
                    g <= '1';
                end if;
            when "1000" =>
                if nhigh_low = '0' then
                    a <= '1';
                    b <= '1';
                    c <= '1';
                    d <= '1';
                    e <= '1';
                    f <= '1';
                    g <= '1';
                elsif nhigh_low = '1' then
                    a <= '0';
                    b <= '0';
                    c <= '0';
                    d <= '0';
                    e <= '0';
                    f <= '0';
                    g <= '0';
                end if;
            when "1001" =>
                if nhigh_low = '0' then
                    a <= '1';
                    b <= '1';
                    c <= '1';
                    d <= '1';
                    e <= '0';
                    f <= '1';
                    g <= '1';
                elsif nhigh_low = '1' then
                    a <= '0';
                    b <= '0';
                    c <= '0';
                    d <= '0';
                    e <= '1';
                    f <= '0';
                    g <= '0';
                end if;
            when "1010" =>
                if nhigh_low = '0' then
                    a <= '1';
                    b <= '1';
                    c <= '1';
                    d <= '0';
                    e <= '1';
                    f <= '1';
                    g <= '1';
                elsif nhigh_low = '1' then
                    a <= '0';
                    b <= '0';
                    c <= '0';
                    d <= '1';
                    e <= '0';
                    f <= '0';
                    g <= '0';
                end if;
            when "1011" =>
                if nhigh_low = '0' then
                    a <= '0';
                    b <= '0';
                    c <= '1';
                    d <= '1';
                    e <= '1';
                    f <= '1';
                    g <= '1';
                elsif nhigh_low = '1' then
                    a <= '1';
                    b <= '1';
                    c <= '0';
                    d <= '0';
                    e <= '0';
                    f <= '0';
                    g <= '0';
                end if;
            when "1100" =>
                if nhigh_low = '0' then
                    a <= '1';
                    b <= '0';
                    c <= '0';
                    d <= '1';
                    e <= '1';
                    f <= '1';
                    g <= '0';
                elsif nhigh_low = '1' then
                    a <= '0';
                    b <= '1';
                    c <= '1';
                    d <= '0';
                    e <= '0';
                    f <= '0';
                    g <= '1';
                end if;
            when "1101" =>
                if nhigh_low = '0' then
                    a <= '0';
                    b <= '1';
                    c <= '1';
                    d <= '1';
                    e <= '1';
                    f <= '0';
                    g <= '1';
                elsif nhigh_low = '1' then
                    a <= '1';
                    b <= '0';
                    c <= '0';
                    d <= '0';
                    e <= '0';
                    f <= '1';
                    g <= '0';
                end if;
            when "1110" =>
                if nhigh_low = '0' then
                    a <= '1';
                    b <= '0';
                    c <= '0';
                    d <= '1';
                    e <= '1';
                    f <= '1';
                    g <= '1';
                elsif nhigh_low = '1' then
                    a <= '0';
                    b <= '1';
                    c <= '1';
                    d <= '0';
                    e <= '0';
                    f <= '0';
                    g <= '0';
                end if;
            when "1111" =>
                if nhigh_low = '0' then
                    a <= '1';
                    b <= '0';
                    c <= '0';
                    d <= '0';
                    e <= '1';
                    f <= '1';
                    g <= '1';
                elsif nhigh_low = '1' then
                    a <= '0';
                    b <= '1';
                    c <= '1';
                    d <= '1';
                    e <= '0';
                    f <= '0';
                    g <= '0';
                end if;
            when others =>
                a <= '1';
                b <= '1';
                c <= '1';
                d <= '1';
                e <= '1';
                f <= '1';
                g <= '0';
        end case;

        if dc_point = '1' then
            if nhigh_low = '0' then
                dot <= '1';
            elsif nhigh_low = '1' then
                dot <= '0';
            end if;
        elsif dc_point = '0' then
            if nhigh_low = '0' then
                dot <= '0';
            elsif nhigh_low = '1' then
                dot <= '1';
            end if;
        end if;

    end process;

end behav;
