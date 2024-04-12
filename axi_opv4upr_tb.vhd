----------------------------------------------------------------------------------
-- Company: Open Research Institute, Inc.
-- Engineer: Skunkwrx and Abraxas3d
--
-- Design Name:
-- Module Name: axi_opv4upr_tb - Behavioral
-- Project Name: Opulent Voice for University of Puerto Rico
-- Target Devices: pluto sdr
-- Tool Versions: Vivado 2022.2
-- Description:
--
-- Dependencies:
--
-- Additional Comments:
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
-- In order to read test vectors in from a file
use std.textio.all;
use ieee.std_logic_textio.all;

entity axi_opv4upr_tb is
--  Port ( );
end axi_opv4upr_tb;

architecture Behavioral of axi_opv4upr_tb is
    component axi_opv4upr is
        port(
           s_axis_aclk : in STD_LOGIC;
           reset       : in STD_LOGIC;
           m_axis_data : out STD_LOGIC_VECTOR (63 downto 0);
           s_axis_data : in STD_LOGIC_VECTOR (63 downto 0);
           s_axis_ready : out STD_LOGIC;
           s_axis_valid : in STD_LOGIC;
           m_axis_valid : out STD_LOGIC;
           m_axis_ready : in STD_LOGIC;
           s_axis_strb  : in STD_LOGIC_VECTOR (7 downto 0);
           s_axis_keep  : in STD_LOGIC_VECTOR (7 downto 0);
           s_axis_user  : in STD_LOGIC_VECTOR (0 downto 0);
           s_axis_id    : in STD_LOGIC_VECTOR (7 downto 0);
           s_axis_dest  : in STD_LOGIC_VECTOR (3 downto 0);
           s_axis_last  : in STD_LOGIC);
    end component axi_opv4upr;
    
    signal s_axis_aclk  :  STD_LOGIC;
    signal reset        :  STD_LOGIC;
    signal m_axis_data  :  STD_LOGIC_VECTOR (63 downto 0);
    signal s_axis_data  :  STD_LOGIC_VECTOR (63 downto 0);
    signal s_axis_ready :  STD_LOGIC;
    signal s_axis_valid :  STD_LOGIC;
    signal m_axis_valid :  STD_LOGIC;
    signal m_axis_ready :  STD_LOGIC;
    signal s_axis_strb  :  STD_LOGIC_VECTOR (7 downto 0);
    signal s_axis_keep  :  STD_LOGIC_VECTOR (7 downto 0);
    signal s_axis_user  :  STD_LOGIC_VECTOR (0 downto 0);
    signal s_axis_id    :  STD_LOGIC_VECTOR (7 downto 0);
    signal s_axis_dest  :  STD_LOGIC_VECTOR (3 downto 0);
    signal s_axis_last  :  STD_LOGIC;
    
    begin
    DUT : axi_opv4upr
    port map( s_axis_aclk => s_axis_aclk,
        reset => reset,
        m_axis_data => m_axis_data,
        s_axis_data => s_axis_data,
        s_axis_ready => s_axis_ready,
        s_axis_valid => s_axis_valid,
        m_axis_valid => m_axis_valid,
        m_axis_ready => m_axis_ready,
        s_axis_strb => s_axis_strb,
        s_axis_keep => s_axis_keep,
        s_axis_user => s_axis_user,
        s_axis_id => s_axis_id,
        s_axis_dest => s_axis_dest, 
        s_axis_last => s_axis_last);
        
        
-- please visit the friendly people at
-- https://surf-vhdl.com/read-from-file-in-vhdl-using-textio-library/
-- for helpful examples

p_read : process
--------------------------------------------------------------------------------------------------
file test_vector                : text open read_mode is "block-test.txt";
--file test_vector                : text open read_mode is "kb5mu-cobs-test";
--file test_vector                : text open read_mode is "COBS_dec-tv-in-b4f69311";
--file test_vector                : text open read_mode is "COBS_dec-tv-in-67c041aa"
--file test_vector                : text open read_mode is "COBS_dec-tv-in-6dc71d1e";
--file test_vector                : text open read_mode is "COBS_dec-tv-in-d98b7d1e";
--file test_vector                : text open read_mode is "COBS_dec-tv-in-d38ef41e";
variable row                    : line;
variable v_data_read            : integer := 0;
variable validity               : integer := 0;
variable readiness              : integer := 0;
variable resetting              : integer := 0;
file output_vector              : text open write_mode is "block-test-output.txt";
variable output_row             : line;

begin
-- read from input file in "row" variable
-- s_axis_data, s_axi_valid, m_axi_ready, reset
    while not endfile(test_vector) 
    loop
    readline(test_vector, row);
    -- Skip empty lines and single-line comments
    if row.all'length = 0 or row.all(1) = '-' then
        next;
    end if;
    
    read(row,v_data_read);
    s_axis_data <= STD_LOGIC_VECTOR(TO_UNSIGNED(v_data_read,64));    
    
    read(row, validity);
    s_axis_valid <= to_unsigned(validity,1)(0);
    
    read(row, readiness);
    m_axis_ready <= to_unsigned(readiness,1)(0);    
    
    read(row, resetting);
    reset <= to_unsigned(resetting,1)(0);    
    
    s_axis_aclk <= '1';
    wait for 1 NS;
    s_axis_aclk <= '0';
    wait for 1 NS;
    
    -- make a header for the output file whenever we get a reset signal    
    
    if reset = '1' then
        write(output_row, string'("-- reset s_axis_data s_axis_valid s_axis_ready m_axis_data m_axis_valid m_axis_ready"));
        writeline(output_vector, output_row);
    end if;
    
-- things we write to our output file
--    signal reset        : STD_LOGIC;
--    signal s_axis_data  : STD_LOGIC_VECTOR (63 downto 0);
--    signal s_axis_valid : STD_LOGIC := '1';
--    signal s_axis_ready : STD_LOGIC;
--    signal m_axis_data  : STD_LOGIC_VECTOR (63 downto 0);
--    signal m_axis_valid : STD_LOGIC;
--    signal m_axis_ready : STD_LOGIC;    write(output_row, reset, right, 2);
    write(output_row, s_axis_data, right, 65);
    write(output_row, s_axis_valid, right, 2);
    write(output_row, s_axis_ready, right, 2);
    write(output_row, m_axis_data, right, 65);
    write(output_row, m_axis_valid, right, 2);
    write(output_row, m_axis_ready, right, 2);
    writeline(output_vector, output_row);    
    end loop;
    end process p_read;
end Behavioral;