-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj/hdlsrc/opv_pluto_transmitter_HDL_coder_input/alpha4_Tb.vhd
-- Created: 2024-04-16 01:39:27
-- 
-- Generated by MATLAB 9.14 and HDL Coder 4.1
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: alpha4_Tb
-- Source Path: opv_pluto_transmitter_HDL_coder_input/opv_modulator/1//4 Tb
-- Hierarchy Level: 1
-- 
-- NCO
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY alpha4_Tb IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_271_0                       :   IN    std_logic;
        validIn                           :   IN    std_logic;
        sine                              :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
        cosine                            :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En15
        );
END alpha4_Tb;


ARCHITECTURE rtl OF alpha4_Tb IS

  -- Component Declarations
  COMPONENT DitherGen
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_271_0                     :   IN    std_logic;
          validIn                         :   IN    std_logic;
          dither                          :   OUT   std_logic_vector(12 DOWNTO 0)  -- ufix13
          );
  END COMPONENT;

  COMPONENT WaveformGen
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_271_0                     :   IN    std_logic;
          phaseIdx                        :   IN    std_logic_vector(18 DOWNTO 0);  -- ufix19_E13
          sine                            :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          cosine                          :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En15
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : DitherGen
    USE ENTITY work.DitherGen(rtl);

  FOR ALL : WaveformGen
    USE ENTITY work.WaveformGen(rtl);

  -- Signals
  SIGNAL outsel_reg_reg                   : std_logic_vector(0 TO 4);  -- ufix1 [5]
  SIGNAL outsel                           : std_logic;
  SIGNAL outzero                          : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL const0                           : signed(31 DOWNTO 0);  -- sfix32
  SIGNAL pInc                             : signed(31 DOWNTO 0);  -- sfix32
  SIGNAL validPInc                        : signed(31 DOWNTO 0);  -- sfix32
  SIGNAL accphase_reg                     : signed(31 DOWNTO 0);  -- sfix32
  SIGNAL addpInc                          : signed(31 DOWNTO 0);  -- sfix32
  SIGNAL pOffset                          : signed(31 DOWNTO 0);  -- sfix32
  SIGNAL accoffset                        : signed(31 DOWNTO 0);  -- sfix32
  SIGNAL accoffsete_reg                   : signed(31 DOWNTO 0);  -- sfix32
  SIGNAL dither                           : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL dither_unsigned                  : unsigned(12 DOWNTO 0);  -- ufix13
  SIGNAL casteddither                     : signed(31 DOWNTO 0);  -- sfix32
  SIGNAL dither_reg                       : signed(31 DOWNTO 0);  -- sfix32
  SIGNAL accumulator                      : signed(31 DOWNTO 0);  -- sfix32
  SIGNAL accQuantized                     : unsigned(18 DOWNTO 0);  -- ufix19_E13
  SIGNAL outsine                          : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL outcos                           : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL outsine_signed                   : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL validsine                        : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL sine_tmp                         : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL outcos_signed                    : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL validcos                         : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL cosine_tmp                       : signed(15 DOWNTO 0);  -- sfix16_En15

BEGIN
  u_dither_inst : DitherGen
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_271_0 => enb_1_271_0,
              validIn => validIn,
              dither => dither  -- ufix13
              );

  u_Wave_inst : WaveformGen
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_271_0 => enb_1_271_0,
              phaseIdx => std_logic_vector(accQuantized),  -- ufix19_E13
              sine => outsine,  -- sfix16_En15
              cosine => outcos  -- sfix16_En15
              );

  outsel_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      outsel_reg_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_271_0 = '1' THEN
        outsel_reg_reg(0) <= validIn;
        outsel_reg_reg(1 TO 4) <= outsel_reg_reg(0 TO 3);
      END IF;
    END IF;
  END PROCESS outsel_reg_process;

  outsel <= outsel_reg_reg(4);

  outzero <= to_signed(16#0000#, 16);

  -- Constant Zero
  const0 <= to_signed(0, 32);

  pInc <= to_signed(947214, 32);

  
  validPInc <= const0 WHEN validIn = '0' ELSE
      pInc;

  -- Add phase increment
  addpInc <= accphase_reg + validPInc;

  -- Phase increment accumulator register
  AccPhaseRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      accphase_reg <= to_signed(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_271_0 = '1' THEN
        accphase_reg <= addpInc;
      END IF;
    END IF;
  END PROCESS AccPhaseRegister_process;


  pOffset <= to_signed(0, 32);

  -- Add phase offset
  accoffset <= accphase_reg + pOffset;

  -- Phase offset accumulator register
  AccOffsetRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      accoffsete_reg <= to_signed(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_271_0 = '1' THEN
        accoffsete_reg <= accoffset;
      END IF;
    END IF;
  END PROCESS AccOffsetRegister_process;


  dither_unsigned <= unsigned(dither);

  casteddither <= signed(resize(dither_unsigned, 32));

  -- Dither input register
  DitherRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dither_reg <= to_signed(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_271_0 = '1' THEN
        dither_reg <= casteddither;
      END IF;
    END IF;
  END PROCESS DitherRegister_process;


  -- Add dither
  accumulator <= accoffsete_reg + dither_reg;

  -- Phase quantization
  accQuantized <= unsigned(accumulator(31 DOWNTO 13));

  outsine_signed <= signed(outsine);

  
  validsine <= outzero WHEN outsel = '0' ELSE
      outsine_signed;

  -- Output sine register
  OutSineRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      sine_tmp <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_271_0 = '1' THEN
        sine_tmp <= validsine;
      END IF;
    END IF;
  END PROCESS OutSineRegister_process;


  sine <= std_logic_vector(sine_tmp);

  outcos_signed <= signed(outcos);

  
  validcos <= outzero WHEN outsel = '0' ELSE
      outcos_signed;

  -- Output cosine register
  OutCosineRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      cosine_tmp <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_271_0 = '1' THEN
        cosine_tmp <= validcos;
      END IF;
    END IF;
  END PROCESS OutCosineRegister_process;


  cosine <= std_logic_vector(cosine_tmp);

END rtl;

