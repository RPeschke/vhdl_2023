library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;

package data_stream is 
 type data_stream_t is record 
    data: STD_LOGIC_VECTOR (15 downto 0);
    valid: STD_LOGIC;
 end record;
 constant data_stream_t_null: data_stream_t := (
    data => (others => '0'),
    valid => '0'
 );
end package;

