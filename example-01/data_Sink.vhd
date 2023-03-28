library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.axiStream.all;


entity data_Sink is
    
    port (
        clk : in std_logic ;
        dataIn_m2s : in axiStream_m2s;
        dataIn_s2m : out axiStream_s2m
    );
end entity;  

architecture rtl of data_Sink is
Signal dataIn : axiStream_slave := axiStream_slave_null;
Signal rand: STD_LOGIC := '0';
SIGNAL i_dataBuffer : STD_LOGIC_VECTOR (15 downto 0);
begin 

dataIn.m2s <= dataIn_m2s;
dataIn_s2m <= dataIn.s2m;

process(clk) is 
variable dataBuffer : STD_LOGIC_VECTOR (15 downto 0);
begin
    if rising_edge(clk) then 
        pull(dataIn);
        rand <= not rand;
        if isReady(dataIn) and rand = '1' then
            read_Data(dataIn, dataBuffer);
        end if;
		i_dataBuffer <= dataBuffer;
    end if ;
end process;

end architecture;
