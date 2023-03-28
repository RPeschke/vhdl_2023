library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity Clock_Generator is 
port(
clk : out STD_LOGIC 
);
end entity;

architecture rtl of Clock_Generator is 
begin 
    process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

end architecture;