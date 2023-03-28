library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;



use work.axiStream.all;


entity data_Source is
    
    port (
        clk : in std_logic ;
        dataOut_m2s : out axiStream_m2s;
        dataOut_s2m : in axiStream_s2m
    );
end entity;  


architecture rtl of data_Source is 
Signal dataOut : axiStream_master := axiStream_master_null;
Signal counter : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
begin
dataOut_m2s <= dataOut.m2s;
dataOut.s2m <= dataOut_s2m;  
process(clk) is 
begin
    if rising_edge(clk) then 
        pull(dataOut);
        counter <= STD_LOGIC_VECTOR( unsigned (counter) + 1);
        if isReady(dataOut) then
            send_Data(dataOut, counter );
        end if;      
    end if ;
end process;
end architecture;