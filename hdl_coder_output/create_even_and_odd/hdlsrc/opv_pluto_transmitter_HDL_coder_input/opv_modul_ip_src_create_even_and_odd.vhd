-- -------------------------------------------------------------
-- 
-- File Name: /home/matt/OPV_TX_abraxas3d/create-even-and-odd-HDL/hdlsrc/opv_pluto_transmitter_HDL_coder_input/opv_modul_ip_src_create_even_and_odd.vhd
-- Created: 2024-04-20 21:15:00
-- 
-- Generated by MATLAB 9.14 and HDL Coder 4.1
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 6.00592e-11
-- Target subsystem base rate: 3.69004e-05
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: opv_modul_ip_src_create_even_and_odd
-- Source Path: opv_pluto_transmitter_HDL_coder_input/create even and odd
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY opv_modul_ip_src_create_even_and_odd IS
  PORT( In1_0                             :   IN    std_logic_vector(8 DOWNTO 0);  -- ufix9
        In1_1                             :   IN    std_logic_vector(8 DOWNTO 0);  -- ufix9
        bo_bitstream                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
        be_bitstream                      :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En15
        );
END opv_modul_ip_src_create_even_and_odd;


ARCHITECTURE rtl OF opv_modul_ip_src_create_even_and_odd IS

  -- Signals
  SIGNAL bo_input_bits                    : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL switch_compare_1                 : std_logic;
  SIGNAL bo_negative_one_out1             : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL bo_positive_one_out1             : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL bo_bitstream_tmp                 : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL be_input_bits                    : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL switch_compare_1_1               : std_logic;
  SIGNAL be_negative_one_out1             : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL be_positive_one_out1             : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL be_bitstream_tmp                 : signed(15 DOWNTO 0);  -- sfix16_En15

BEGIN
  bo_input_bits <= unsigned(In1_0);

  
  switch_compare_1 <= '1' WHEN bo_input_bits > to_unsigned(16#000#, 9) ELSE
      '0';

  bo_negative_one_out1 <= to_signed(-16#8000#, 16);

  bo_positive_one_out1 <= to_signed(16#7FFF#, 16);

  
  bo_bitstream_tmp <= bo_negative_one_out1 WHEN switch_compare_1 = '0' ELSE
      bo_positive_one_out1;

  bo_bitstream <= std_logic_vector(bo_bitstream_tmp);

  be_input_bits <= unsigned(In1_1);

  
  switch_compare_1_1 <= '1' WHEN be_input_bits > to_unsigned(16#000#, 9) ELSE
      '0';

  be_negative_one_out1 <= to_signed(-16#8000#, 16);

  be_positive_one_out1 <= to_signed(16#7FFF#, 16);

  
  be_bitstream_tmp <= be_negative_one_out1 WHEN switch_compare_1_1 = '0' ELSE
      be_positive_one_out1;

  be_bitstream <= std_logic_vector(be_bitstream_tmp);

END rtl;

