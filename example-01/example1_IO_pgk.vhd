

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;



-- Start Include user packages --

-- End Include user packages --

package example1_IO_pgk is


type example1_writer_rec is record
    clk : std_logic;  
    data : std_logic_vector ( 15 downto 0 );  
    data_out : std_logic_vector ( 15 downto 0 );  

end record;



type example1_reader_rec is record
    clk : std_logic;  
    data : std_logic_vector ( 15 downto 0 );  

end record;


end package;

package body example1_IO_pgk is

end package body example1_IO_pgk;

        