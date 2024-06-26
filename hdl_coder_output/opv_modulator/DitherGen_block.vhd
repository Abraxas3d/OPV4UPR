-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj/hdlsrc/opv_pluto_transmitter_HDL_coder_input/DitherGen_block.vhd
-- Created: 2024-04-16 02:31:51
-- 
-- Generated by MATLAB 9.14 and HDL Coder 4.1
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: DitherGen_block
-- Source Path: opv_pluto_transmitter_HDL_coder_input/opv_modulator/carrier/DitherGen
-- Hierarchy Level: 2
-- 
-- Internal Dither Generation Component
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY DitherGen_block IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_271_0                       :   IN    std_logic;
        validIn                           :   IN    std_logic;
        dither                            :   OUT   std_logic_vector(12 DOWNTO 0)  -- ufix13
        );
END DitherGen_block;


ARCHITECTURE rtl OF DitherGen_block IS

  -- Signals
  SIGNAL pn_newvalue12                    : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL pn_newvaluesf12                  : unsigned(17 DOWNTO 0);  -- ufix18
  SIGNAL bit0_12                          : std_logic;  -- ufix1
  SIGNAL bit14_12                         : std_logic;  -- ufix1
  SIGNAL bit17_12                         : std_logic;  -- ufix1
  SIGNAL pn_newvalue11                    : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL pn_newvaluesf11                  : unsigned(17 DOWNTO 0);  -- ufix18
  SIGNAL bit0_11                          : std_logic;  -- ufix1
  SIGNAL bit14_11                         : std_logic;  -- ufix1
  SIGNAL bit17_11                         : std_logic;  -- ufix1
  SIGNAL pn_newvalue10                    : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL pn_newvaluesf10                  : unsigned(17 DOWNTO 0);  -- ufix18
  SIGNAL bit0_10                          : std_logic;  -- ufix1
  SIGNAL bit14_10                         : std_logic;  -- ufix1
  SIGNAL bit17_10                         : std_logic;  -- ufix1
  SIGNAL pn_newvalue9                     : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL pn_newvaluesf9                   : unsigned(17 DOWNTO 0);  -- ufix18
  SIGNAL bit0_9                           : std_logic;  -- ufix1
  SIGNAL bit14_9                          : std_logic;  -- ufix1
  SIGNAL bit17_9                          : std_logic;  -- ufix1
  SIGNAL pn_newvalue8                     : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL pn_newvaluesf8                   : unsigned(17 DOWNTO 0);  -- ufix18
  SIGNAL bit0_8                           : std_logic;  -- ufix1
  SIGNAL bit14_8                          : std_logic;  -- ufix1
  SIGNAL bit17_8                          : std_logic;  -- ufix1
  SIGNAL pn_newvalue7                     : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL pn_newvaluesf7                   : unsigned(17 DOWNTO 0);  -- ufix18
  SIGNAL bit0_7                           : std_logic;  -- ufix1
  SIGNAL bit14_7                          : std_logic;  -- ufix1
  SIGNAL bit17_7                          : std_logic;  -- ufix1
  SIGNAL pn_newvalue6                     : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL pn_newvaluesf6                   : unsigned(17 DOWNTO 0);  -- ufix18
  SIGNAL bit0_6                           : std_logic;  -- ufix1
  SIGNAL bit14_6                          : std_logic;  -- ufix1
  SIGNAL bit17_6                          : std_logic;  -- ufix1
  SIGNAL pn_newvalue5                     : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL pn_newvaluesf5                   : unsigned(17 DOWNTO 0);  -- ufix18
  SIGNAL bit0_5                           : std_logic;  -- ufix1
  SIGNAL bit14_5                          : std_logic;  -- ufix1
  SIGNAL bit17_5                          : std_logic;  -- ufix1
  SIGNAL pn_newvalue4                     : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL pn_newvaluesf4                   : unsigned(17 DOWNTO 0);  -- ufix18
  SIGNAL bit0_4                           : std_logic;  -- ufix1
  SIGNAL bit14_4                          : std_logic;  -- ufix1
  SIGNAL bit17_4                          : std_logic;  -- ufix1
  SIGNAL pn_newvalue3                     : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL pn_newvaluesf3                   : unsigned(17 DOWNTO 0);  -- ufix18
  SIGNAL bit0_3                           : std_logic;  -- ufix1
  SIGNAL bit14_3                          : std_logic;  -- ufix1
  SIGNAL bit17_3                          : std_logic;  -- ufix1
  SIGNAL pn_newvalue2                     : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL pn_newvaluesf2                   : unsigned(17 DOWNTO 0);  -- ufix18
  SIGNAL bit0_2                           : std_logic;  -- ufix1
  SIGNAL bit14_2                          : std_logic;  -- ufix1
  SIGNAL bit17_2                          : std_logic;  -- ufix1
  SIGNAL pn_newvalue1                     : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL pn_newvaluesf1                   : unsigned(17 DOWNTO 0);  -- ufix18
  SIGNAL bit0_1                           : std_logic;  -- ufix1
  SIGNAL bit14_1                          : std_logic;  -- ufix1
  SIGNAL bit17_1                          : std_logic;  -- ufix1
  SIGNAL pn_reg                           : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL pn_newvaluesf0                   : unsigned(17 DOWNTO 0);  -- ufix18
  SIGNAL bit14_0                          : std_logic;  -- ufix1
  SIGNAL bit17_0                          : std_logic;  -- ufix1
  SIGNAL bit18_0                          : std_logic;  -- ufix1
  SIGNAL bit0_0                           : std_logic;  -- ufix1
  SIGNAL xorout0                          : std_logic;  -- ufix1
  SIGNAL bit18_1                          : std_logic;  -- ufix1
  SIGNAL xorout1                          : std_logic;  -- ufix1
  SIGNAL bit18_2                          : std_logic;  -- ufix1
  SIGNAL xorout2                          : std_logic;  -- ufix1
  SIGNAL bit18_3                          : std_logic;  -- ufix1
  SIGNAL xorout3                          : std_logic;  -- ufix1
  SIGNAL bit18_4                          : std_logic;  -- ufix1
  SIGNAL xorout4                          : std_logic;  -- ufix1
  SIGNAL bit18_5                          : std_logic;  -- ufix1
  SIGNAL xorout5                          : std_logic;  -- ufix1
  SIGNAL bit18_6                          : std_logic;  -- ufix1
  SIGNAL xorout6                          : std_logic;  -- ufix1
  SIGNAL bit18_7                          : std_logic;  -- ufix1
  SIGNAL xorout7                          : std_logic;  -- ufix1
  SIGNAL bit18_8                          : std_logic;  -- ufix1
  SIGNAL xorout8                          : std_logic;  -- ufix1
  SIGNAL bit18_9                          : std_logic;  -- ufix1
  SIGNAL xorout9                          : std_logic;  -- ufix1
  SIGNAL bit18_10                         : std_logic;  -- ufix1
  SIGNAL xorout10                         : std_logic;  -- ufix1
  SIGNAL bit18_11                         : std_logic;  -- ufix1
  SIGNAL xorout11                         : std_logic;  -- ufix1
  SIGNAL bit18_12                         : std_logic;  -- ufix1
  SIGNAL xorout12                         : std_logic;  -- ufix1
  SIGNAL pn_newvalue13                    : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL dither_tmp                       : unsigned(12 DOWNTO 0);  -- ufix13

BEGIN
  pn_newvaluesf12 <= pn_newvalue12(18 DOWNTO 1);

  bit0_12 <= pn_newvalue12(0);

  bit14_12 <= pn_newvalue12(14);

  bit17_12 <= pn_newvalue12(17);

  pn_newvaluesf11 <= pn_newvalue11(18 DOWNTO 1);

  bit0_11 <= pn_newvalue11(0);

  bit14_11 <= pn_newvalue11(14);

  bit17_11 <= pn_newvalue11(17);

  pn_newvaluesf10 <= pn_newvalue10(18 DOWNTO 1);

  bit0_10 <= pn_newvalue10(0);

  bit14_10 <= pn_newvalue10(14);

  bit17_10 <= pn_newvalue10(17);

  pn_newvaluesf9 <= pn_newvalue9(18 DOWNTO 1);

  bit0_9 <= pn_newvalue9(0);

  bit14_9 <= pn_newvalue9(14);

  bit17_9 <= pn_newvalue9(17);

  pn_newvaluesf8 <= pn_newvalue8(18 DOWNTO 1);

  bit0_8 <= pn_newvalue8(0);

  bit14_8 <= pn_newvalue8(14);

  bit17_8 <= pn_newvalue8(17);

  pn_newvaluesf7 <= pn_newvalue7(18 DOWNTO 1);

  bit0_7 <= pn_newvalue7(0);

  bit14_7 <= pn_newvalue7(14);

  bit17_7 <= pn_newvalue7(17);

  pn_newvaluesf6 <= pn_newvalue6(18 DOWNTO 1);

  bit0_6 <= pn_newvalue6(0);

  bit14_6 <= pn_newvalue6(14);

  bit17_6 <= pn_newvalue6(17);

  pn_newvaluesf5 <= pn_newvalue5(18 DOWNTO 1);

  bit0_5 <= pn_newvalue5(0);

  bit14_5 <= pn_newvalue5(14);

  bit17_5 <= pn_newvalue5(17);

  pn_newvaluesf4 <= pn_newvalue4(18 DOWNTO 1);

  bit0_4 <= pn_newvalue4(0);

  bit14_4 <= pn_newvalue4(14);

  bit17_4 <= pn_newvalue4(17);

  pn_newvaluesf3 <= pn_newvalue3(18 DOWNTO 1);

  bit0_3 <= pn_newvalue3(0);

  bit14_3 <= pn_newvalue3(14);

  bit17_3 <= pn_newvalue3(17);

  pn_newvaluesf2 <= pn_newvalue2(18 DOWNTO 1);

  bit0_2 <= pn_newvalue2(0);

  bit14_2 <= pn_newvalue2(14);

  bit17_2 <= pn_newvalue2(17);

  pn_newvaluesf1 <= pn_newvalue1(18 DOWNTO 1);

  bit0_1 <= pn_newvalue1(0);

  bit14_1 <= pn_newvalue1(14);

  bit17_1 <= pn_newvalue1(17);

  pn_newvaluesf0 <= pn_reg(18 DOWNTO 1);

  bit14_0 <= pn_reg(14);

  bit17_0 <= pn_reg(17);

  bit18_0 <= pn_reg(18);

  -- Stage1: Compute register output and shift
  xorout0 <= bit0_0 XOR (bit14_0 XOR (bit18_0 XOR bit17_0));

  pn_newvalue1 <= xorout0 & pn_newvaluesf0;

  bit18_1 <= pn_newvalue1(18);

  -- Stage2: Compute register output and shift
  xorout1 <= bit0_1 XOR (bit14_1 XOR (bit18_1 XOR bit17_1));

  pn_newvalue2 <= xorout1 & pn_newvaluesf1;

  bit18_2 <= pn_newvalue2(18);

  -- Stage3: Compute register output and shift
  xorout2 <= bit0_2 XOR (bit14_2 XOR (bit18_2 XOR bit17_2));

  pn_newvalue3 <= xorout2 & pn_newvaluesf2;

  bit18_3 <= pn_newvalue3(18);

  -- Stage4: Compute register output and shift
  xorout3 <= bit0_3 XOR (bit14_3 XOR (bit18_3 XOR bit17_3));

  pn_newvalue4 <= xorout3 & pn_newvaluesf3;

  bit18_4 <= pn_newvalue4(18);

  -- Stage5: Compute register output and shift
  xorout4 <= bit0_4 XOR (bit14_4 XOR (bit18_4 XOR bit17_4));

  pn_newvalue5 <= xorout4 & pn_newvaluesf4;

  bit18_5 <= pn_newvalue5(18);

  -- Stage6: Compute register output and shift
  xorout5 <= bit0_5 XOR (bit14_5 XOR (bit18_5 XOR bit17_5));

  pn_newvalue6 <= xorout5 & pn_newvaluesf5;

  bit18_6 <= pn_newvalue6(18);

  -- Stage7: Compute register output and shift
  xorout6 <= bit0_6 XOR (bit14_6 XOR (bit18_6 XOR bit17_6));

  pn_newvalue7 <= xorout6 & pn_newvaluesf6;

  bit18_7 <= pn_newvalue7(18);

  -- Stage8: Compute register output and shift
  xorout7 <= bit0_7 XOR (bit14_7 XOR (bit18_7 XOR bit17_7));

  pn_newvalue8 <= xorout7 & pn_newvaluesf7;

  bit18_8 <= pn_newvalue8(18);

  -- Stage9: Compute register output and shift
  xorout8 <= bit0_8 XOR (bit14_8 XOR (bit18_8 XOR bit17_8));

  pn_newvalue9 <= xorout8 & pn_newvaluesf8;

  bit18_9 <= pn_newvalue9(18);

  -- Stage10: Compute register output and shift
  xorout9 <= bit0_9 XOR (bit14_9 XOR (bit18_9 XOR bit17_9));

  pn_newvalue10 <= xorout9 & pn_newvaluesf9;

  bit18_10 <= pn_newvalue10(18);

  -- Stage11: Compute register output and shift
  xorout10 <= bit0_10 XOR (bit14_10 XOR (bit18_10 XOR bit17_10));

  pn_newvalue11 <= xorout10 & pn_newvaluesf10;

  bit18_11 <= pn_newvalue11(18);

  -- Stage12: Compute register output and shift
  xorout11 <= bit0_11 XOR (bit14_11 XOR (bit18_11 XOR bit17_11));

  pn_newvalue12 <= xorout11 & pn_newvaluesf11;

  bit18_12 <= pn_newvalue12(18);

  -- Stage13: Compute register output and shift
  xorout12 <= bit0_12 XOR (bit14_12 XOR (bit18_12 XOR bit17_12));

  pn_newvalue13 <= xorout12 & pn_newvaluesf12;

  -- PNgen register
  PNgenRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      pn_reg <= to_unsigned(16#00001#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_271_0 = '1' AND validIn = '1' THEN
        pn_reg <= pn_newvalue13;
      END IF;
    END IF;
  END PROCESS PNgenRegister_process;


  bit0_0 <= pn_reg(0);

  -- Dither Output
  dither_tmp <= unsigned'(bit0_0 & bit0_1 & bit0_2 & bit0_3 & bit0_4 & bit0_5 & bit0_6 & bit0_7 & bit0_8 & bit0_9 & bit0_10 & bit0_11 & bit0_12);

  dither <= std_logic_vector(dither_tmp);

END rtl;

