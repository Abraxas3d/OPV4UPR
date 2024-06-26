-- -------------------------------------------------------------
-- 
-- File Name: /home/matt/OPV_TX_abraxas3d/preamble-HDL/hdlsrc/opv_pluto_transmitter_HDL_coder_input/opv_modul_ip_SimpleDualPortRAM_singlebit.vhd
-- Created: 2024-04-19 04:49:27
-- 
-- Generated by MATLAB 9.14 and HDL Coder 4.1
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: opv_modul_ip_SimpleDualPortRAM_singlebit
-- Source Path: opv_modul_ip/opv_modul_ip_axi4/opv_modul_ip_axi4_module/opv_modul_ip_rdfifo_last/opv_modul_ip_rdfifo_last_classic/opv_modul_ip_SimpleDualPortRAM_singlebit
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY opv_modul_ip_SimpleDualPortRAM_singlebit IS
  GENERIC( AddrWidth                      : integer := 1;
           DataWidth                      : integer := 1
           );
  PORT( clk                               :   IN    std_logic;
        enb                               :   IN    std_logic;
        wr_din                            :   IN    std_logic;  -- ufix1
        wr_addr                           :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
        wr_en                             :   IN    std_logic;  -- ufix1
        rd_addr                           :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
        rd_dout                           :   OUT   std_logic  -- ufix1
        );
END opv_modul_ip_SimpleDualPortRAM_singlebit;


ARCHITECTURE rtl OF opv_modul_ip_SimpleDualPortRAM_singlebit IS

  -- Local Type Definitions
  TYPE ram_type IS ARRAY (2**AddrWidth - 1 DOWNTO 0) of std_logic;

  -- Signals
  SIGNAL ram                              : ram_type := (OTHERS => '0');
  SIGNAL data_int                         : std_logic := '0';
  SIGNAL wr_addr_unsigned                 : unsigned(AddrWidth - 1 DOWNTO 0);  -- generic width
  SIGNAL rd_addr_unsigned                 : unsigned(AddrWidth - 1 DOWNTO 0);  -- generic width

BEGIN
  wr_addr_unsigned <= unsigned(wr_addr);

  rd_addr_unsigned <= unsigned(rd_addr);

  opv_modul_ip_SimpleDualPortRAM_singlebit_process: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF enb = '1' THEN
        IF wr_en = '1' THEN
          ram(to_integer(wr_addr_unsigned)) <= wr_din;
        END IF;
        data_int <= ram(to_integer(rd_addr_unsigned));
      END IF;
    END IF;
  END PROCESS opv_modul_ip_SimpleDualPortRAM_singlebit_process;

  rd_dout <= data_int;

END rtl;

