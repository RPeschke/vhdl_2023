library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;
    use work.data_stream.all;

entity filter_for_negative_numbers is port(
    clk: in STD_LOGIC;
    data: in STD_LOGIC_VECTOR (15 downto 0);
    data_stream_out: out data_stream_t 
);
end entity;

architecture rtl of filter_for_negative_numbers is 
signal i_data: signed (15 downto 0) := (others => '0');



begin
process(clk) is
begin
    if rising_edge(clk) then
        data_stream_out <= data_stream_t_null;
        if (signed(data)<0) then 
            data_stream_out.data <= data;
            data_stream_out.valid <= '1';
        end if; 
    end if;
end process;
end architecture;