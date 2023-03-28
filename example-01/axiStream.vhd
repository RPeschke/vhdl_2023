library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

package axiStream is 
 type axiStream_m2s is record 
    data: STD_LOGIC_VECTOR (15 downto 0);
    valid: STD_LOGIC;
 end record;
 type axiStream_s2m is record 
    ready: STD_LOGIC;
 end record;
 
 
 constant axiStream_m2s_null: axiStream_m2s := (
    data => (others => '0'),
    valid => '0'
 );
 constant axiStream_s2m_null: axiStream_s2m := (
    ready => '0'
 );

  constant axiStream_m2s_z: axiStream_m2s := (
    data => (others => 'Z'),
    valid => 'Z'
 );
 constant axiStream_s2m_z: axiStream_s2m := (
    ready => 'Z'
 );

 type axiStream_master is record 
    m2s: axiStream_m2s;
    s2m: axiStream_s2m;
 end record;

 constant axiStream_master_null: axiStream_master := (
    m2s => axiStream_m2s_null,
    s2m => axiStream_s2m_null
 );


function isReady(self: axiStream_master) return boolean;
procedure send_Data(Signal self: inout axiStream_master; data: STD_LOGIC_VECTOR);
procedure pull(Signal self: inout axiStream_master);


type axiStream_slave is record 
    m2s: axiStream_m2s;
    s2m: axiStream_s2m;
    internal: axiStream_m2s;
 end record;

  constant axiStream_slave_null: axiStream_slave := (
    m2s => axiStream_m2s_null,
    s2m => axiStream_s2m_null,
    internal => axiStream_m2s_null
 );

function isReady(self: axiStream_slave) return boolean;
procedure read_Data(Signal self: inout axiStream_slave; data: out STD_LOGIC_VECTOR);
procedure pull(Signal self: inout axiStream_slave);

end package;
package body axiStream is 
    function isReady(self: axiStream_master) return boolean is
    begin 
        return self.s2m.ready = '1' or self.m2s.valid = '0';
    end function;

    procedure send_Data(Signal self: inout axiStream_master; data: STD_LOGIC_VECTOR) is 
    begin
        self.m2s.data <= data;
        self.m2s.valid <= '1';
        self.s2m.ready <= 'Z';

    end procedure;


    procedure pull(Signal self: inout axiStream_master) is 
    begin
        if self.s2m.ready = '1' then
            self.m2s.valid <= '0';
        end if;
        self.s2m.ready <= 'Z';
    end procedure;


    function isReady(self: axiStream_slave) return boolean is
    begin 
        return (self.s2m.ready = '1' and self.m2s.valid = '1' ) or self.internal.valid = '1';
    end function;

    procedure read_Data(Signal self: inout axiStream_slave; data: out STD_LOGIC_VECTOR) is
    begin
        self.m2s <= axiStream_m2s_z;
        self.s2m.ready <= '1';
        self.internal <= axiStream_m2s_null;
        if self.s2m.ready = '1' and self.m2s.valid = '1' then
            data := self.m2s.data;           
        else
            data := self.internal.data;      
        end if;
    end procedure;

    procedure pull(Signal self: inout axiStream_slave) is 
    begin

        self.m2s <= axiStream_m2s_z;
        if self.internal.valid = '0' then 
           self.s2m.ready  <= '1'; 
        end if;

        if self.s2m.ready = '1' and self.m2s.valid = '1' then
            self.internal <= self.m2s;
            self.s2m.ready <= '0';
        end if;
    end procedure;
end package body;
