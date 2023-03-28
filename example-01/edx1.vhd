library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;


entity example1 is port 
    (
        clk: in STD_LOGIC;
        data: in STD_LOGIC_VECTOR (15 downto 0);
        data_out: out STD_LOGIC_VECTOR (15 downto 0)
    );
end entity;

architecture rtl of example1 is 
signal i_data_old: STD_LOGIC_VECTOR (15 downto 0) := (others => '0'); 
begin
process(clk) is
    begin
        if rising_edge(clk) then
            i_data_old <= data;
            data_out <=  STD_LOGIC_VECTOR( signed( data ) - signed (i_data_old));
            
        end if; 
end process;
end architecture;

