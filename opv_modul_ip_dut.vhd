-- -------------------------------------------------------------
-- 
-- File Name: /home/matt/OPV_TX_abraxas3d/preamble-HDL/hdlsrc/opv_pluto_transmitter_HDL_coder_input/opv_modul_ip_dut.vhd
-- Created: 2024-04-19 02:58:28
-- 
-- Generated by MATLAB 9.14 and HDL Coder 4.1
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: opv_modul_ip_dut
-- Source Path: opv_modul_ip/opv_modul_ip_dut
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY opv_modul_ip_dut IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        dut_enable                        :   IN    std_logic;  -- ufix1
        data                              :   IN    std_logic;  -- ufix1
        PTT                               :   IN    std_logic;  -- ufix1
        ce_out                            :   OUT   std_logic;  -- ufix1
        Out1                              :   OUT   std_logic_vector(8 DOWNTO 0)  -- ufix9
        );
END opv_modul_ip_dut;


ARCHITECTURE rtl OF opv_modul_ip_dut IS

  -- Component Declarations
  COMPONENT opv_modul_ip_src_preamble
    PORT( clk                             :   IN    std_logic;
          clk_enable                      :   IN    std_logic;
          reset                           :   IN    std_logic;
          data                            :   IN    std_logic;  -- ufix1
          PTT                             :   IN    std_logic;  -- ufix1
          ce_out                          :   OUT   std_logic;  -- ufix1
          Out1                            :   OUT   std_logic_vector(8 DOWNTO 0)  -- ufix9
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : opv_modul_ip_src_preamble
    USE ENTITY work.opv_modul_ip_src_preamble(rtl);

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL data_sig                         : std_logic;  -- ufix1
  SIGNAL PTT_sig                          : std_logic;  -- ufix1
  SIGNAL ce_out_sig                       : std_logic;  -- ufix1
  SIGNAL Out1_sig                         : std_logic_vector(8 DOWNTO 0);  -- ufix9

BEGIN
  u_opv_modul_ip_src_preamble : opv_modul_ip_src_preamble
    PORT MAP( clk => clk,
              clk_enable => enb,
              reset => reset,
              data => data_sig,  -- ufix1
              PTT => PTT_sig,  -- ufix1
              ce_out => ce_out_sig,  -- ufix1
              Out1 => Out1_sig  -- ufix9
              );

  data_sig <= data;

  PTT_sig <= PTT;

  enb <= dut_enable;

  ce_out <= ce_out_sig;

  Out1 <= Out1_sig;

END rtl;

