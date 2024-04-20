
-- ----------------------------------------------
-- File Name: hdlverifier_synchronizer.vhd
-- Created:   20-Apr-2024 21:15:45
-- Copyright  2024 MathWorks, Inc.
-- ----------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hdlverifier_synchronizer is
  generic(WIDTH: integer:=10);
  port (
    clk : in std_logic;
    data_in : in std_logic_vector(WIDTH-1 downto 0);
    data_out : out std_logic_vector(WIDTH-1 downto 0)
  );
end entity; 

architecture rtl of hdlverifier_synchronizer is
  signal data_reg : std_logic_vector(WIDTH-1 downto 0);  
begin
  
  process (clk) is
  begin
    if rising_edge(clk) then
      data_reg <= data_in;
      data_out <= data_reg;
    end if;
  end process;
end architecture;
