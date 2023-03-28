


library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.type_conversions_pgk.all;
use work.CSV_UtilityPkg.all;



use work.example1_IO_pgk.all;


entity example1_reader_et  is
    generic (
        FileName : string 
    );
    port (
        clk : in std_logic ;
        data : out example1_reader_rec
    );
end entity;   

architecture Behavioral of example1_reader_et is 

  constant  NUM_COL    : integer := 2;
  signal    csv_r_data : c_integer_array(NUM_COL -1 downto 0)  := (others=>0)  ;
begin

  csv_r :entity  work.csv_read_file 
    generic map (
        FileName =>  FileName, 
        NUM_COL => NUM_COL,
        HeaderLines =>  2
    ) port map (
        clk => clk,
        Rows => csv_r_data
    );

  csv_from_integer(csv_r_data(0), data.clk);
  csv_from_integer(csv_r_data(1), data.data);


end architecture;
---------------------------------------------------------------------------------------------------
    


library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.type_conversions_pgk.all;
use work.CSV_UtilityPkg.all;



use work.example1_IO_pgk.all;

entity example1_writer_et  is
    generic ( 
        FileName : string 
    ); port (
        clk : in std_logic ;
        data : in example1_writer_rec
    );
end entity;

architecture Behavioral of example1_writer_et is 
  constant  NUM_COL : integer := 4;
  signal data_int   : c_integer_array(NUM_COL - 1 downto 0)  := (others=>0);
begin

    csv_w : entity  work.csv_write_file 
        generic map (
            FileName => FileName,
            HeaderLines=> "clk, data, data_out",
            NUM_COL =>   NUM_COL 
        ) port map(
            clk => clk, 
            Rows => data_int
        );


  csv_to_integer(data.clk, data_int(0) );
  csv_to_integer(data.data, data_int(1) );
  csv_to_integer(data.data_out, data_int(2) );


end architecture;
---------------------------------------------------------------------------------------------------
    

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.type_conversions_pgk.all;
use work.CSV_UtilityPkg.all;


use work.example1_IO_pgk.all;

entity example1_tb_csv is 
end entity;

architecture behavior of example1_tb_csv is 
  signal clk : std_logic := '0';
  signal data_in : example1_reader_rec;
  signal data_out : example1_writer_rec;

begin 

  clk_gen : entity work.ClockGenerator generic map ( CLOCK_period => 10 ns) port map ( clk => clk );

  csv_read : entity work.example1_reader_et 
    generic map (
        FileName => "./example1_tb_csv.csv" 
    ) port map (
        clk => clk ,data => data_in
    );
 
  csv_write : entity work.example1_writer_et
    generic map (
        FileName => "./example1_tb_csv_out.csv" 
    ) port map (
        clk => clk ,data => data_out
    );
  

  data_out.clk <=clk;
  data_out.data <= data_in.data;


DUT :  entity work.example1  port map(

  clk => clk,
    data => data_out.data,
  data_out => data_out.data_out
    );

end architecture;
---------------------------------------------------------------------------------------------------
    