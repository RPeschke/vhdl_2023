
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;
    use work.data_stream.all;
	use work.axiStream.all;


entity example01_tb is 
end entity;

architecture rtl of example01_tb is 
signal clk: STD_LOGIC;
signal data: STD_LOGIC_VECTOR (15 downto 0);
signal data_out: STD_LOGIC_VECTOR (15 downto 0);
signal counter: real  := 0.0;
signal s : real := 0.0;
signal filter_out: data_stream_t := data_stream_t_null;
signal dataOut_m2s : axiStream_m2s;
signal dataOut_s2m : axiStream_s2m;


begin 
process(clk) is 
begin 
    if rising_edge(clk) then 
        counter <= counter + 1.0;
        s <= counter * 0.1;
        data <= std_logic_vector( to_signed( natural(10000.0*sin(s)), 16));

    end if;
end process;
dat : entity work.example1 port map(
    clk => clk,
    data => data,
    data_out => data_out
    );
Clock_gen : entity work.Clock_Generator port map(
    clk=> clk   
    );
filter : entity work.filter_for_negative_numbers port map(
    clk => clk,
    data => data,
    data_stream_out => filter_out
    );
source : entity work.data_Source port map(
	clk => clk,
   dataOut_m2s => dataOut_m2s,
   dataOut_s2m => dataOut_s2m

	);
sink : entity work.data_Sink port map(
	clk => clk,
   dataIn_m2s => dataOut_m2s,
   dataIn_s2m => dataOut_s2m

	);
end architecture;