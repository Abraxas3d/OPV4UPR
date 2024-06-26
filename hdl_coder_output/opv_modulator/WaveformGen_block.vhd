-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj/hdlsrc/opv_pluto_transmitter_HDL_coder_input/WaveformGen_block.vhd
-- Created: 2024-04-16 02:31:51
-- 
-- Generated by MATLAB 9.14 and HDL Coder 4.1
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: WaveformGen_block
-- Source Path: opv_pluto_transmitter_HDL_coder_input/opv_modulator/carrier/WaveformGen
-- Hierarchy Level: 2
-- 
-- Wave form Generation Component
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY WaveformGen_block IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_271_0                       :   IN    std_logic;
        phaseIdx                          :   IN    std_logic_vector(18 DOWNTO 0);  -- ufix19_E13
        sine                              :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
        cosine                            :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En15
        );
END WaveformGen_block;


ARCHITECTURE rtl OF WaveformGen_block IS

  -- Component Declarations
  COMPONENT SinLookUpTableGen_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_271_0                     :   IN    std_logic;
          lutaddr                         :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
          lutSine                         :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En15
          );
  END COMPONENT;

  COMPONENT CosLookUpTableGen_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_271_0                     :   IN    std_logic;
          lutaddr                         :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
          lutCosine                       :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En15
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : SinLookUpTableGen_block
    USE ENTITY work.SinLookUpTableGen_block(rtl);

  FOR ALL : CosLookUpTableGen_block
    USE ENTITY work.CosLookUpTableGen_block(rtl);

  -- Signals
  SIGNAL phaseIdx_unsigned                : unsigned(18 DOWNTO 0);  -- ufix19_E13
  SIGNAL phaseIdxReg                      : unsigned(18 DOWNTO 0);  -- ufix19_E13
  SIGNAL msb1                             : std_logic;  -- ufix1
  SIGNAL sineSignSelRegComp_reg           : std_logic_vector(0 TO 2);  -- ufix1 [3]
  SIGNAL sineSignSelReg                   : std_logic;  -- ufix1
  SIGNAL lutaddr1                         : unsigned(16 DOWNTO 0);  -- ufix17
  SIGNAL sin45Sel                         : std_logic;  -- ufix1
  SIGNAL sin45SelRegComp_reg              : std_logic_vector(0 TO 2);  -- ufix1 [3]
  SIGNAL sin45SelReg                      : std_logic;  -- ufix1
  SIGNAL msb2                             : std_logic;  -- ufix1
  SIGNAL msb3                             : std_logic;  -- ufix1
  SIGNAL lutSel                           : std_logic;  -- ufix1
  SIGNAL lutSelRegComp_reg                : std_logic_vector(0 TO 2);  -- ufix1 [3]
  SIGNAL lutSelReg                        : std_logic;  -- ufix1
  SIGNAL lutaddrmax                       : unsigned(17 DOWNTO 0);  -- ufix18
  SIGNAL lutaddr2                         : unsigned(16 DOWNTO 0);  -- ufix17
  SIGNAL lutaddr                          : unsigned(16 DOWNTO 0);  -- ufix17
  SIGNAL lutaddrO                         : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL lutoutsin                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL lutoutsin_signed                 : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL lutoutcos                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL lutoutcos_signed                 : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL lutselsin                        : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL octantVal                        : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL fullsinmag                       : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL uminus_cast                      : signed(16 DOWNTO 0);  -- sfix17_En15
  SIGNAL uminus_cast_1                    : signed(16 DOWNTO 0);  -- sfix17_En15
  SIGNAL inverseSin                       : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL sine_tmp                         : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL signSel                          : std_logic;  -- ufix1
  SIGNAL signSelRegComp_reg               : std_logic_vector(0 TO 2);  -- ufix1 [3]
  SIGNAL signSelReg                       : std_logic;  -- ufix1
  SIGNAL lutselcos                        : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL fullcosmag                       : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL uminus_cast_2                    : signed(16 DOWNTO 0);  -- sfix17_En15
  SIGNAL uminus_cast_3                    : signed(16 DOWNTO 0);  -- sfix17_En15
  SIGNAL inverseCos                       : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL cosine_tmp                       : signed(15 DOWNTO 0);  -- sfix16_En15

BEGIN
  u_Sin_Wave_inst : SinLookUpTableGen_block
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_271_0 => enb_1_271_0,
              lutaddr => std_logic_vector(lutaddrO),  -- ufix16
              lutSine => lutoutsin  -- sfix16_En15
              );

  u_Cos_Wave_inst : CosLookUpTableGen_block
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_271_0 => enb_1_271_0,
              lutaddr => std_logic_vector(lutaddrO),  -- ufix16
              lutCosine => lutoutcos  -- sfix16_En15
              );

  phaseIdx_unsigned <= unsigned(phaseIdx);

  phaseIdxRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      phaseIdxReg <= to_unsigned(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_271_0 = '1' THEN
        phaseIdxReg <= phaseIdx_unsigned;
      END IF;
    END IF;
  END PROCESS phaseIdxRegister_process;


  -- Sine sign selection signal
  msb1 <= phaseIdxReg(18);

  sineSignSelRegComp_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      sineSignSelRegComp_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_271_0 = '1' THEN
        sineSignSelRegComp_reg(0) <= msb1;
        sineSignSelRegComp_reg(1 TO 2) <= sineSignSelRegComp_reg(0 TO 1);
      END IF;
    END IF;
  END PROCESS sineSignSelRegComp_process;

  sineSignSelReg <= sineSignSelRegComp_reg(2);

  lutaddr1 <= phaseIdxReg(16 DOWNTO 0);

  -- 45 degree address
  
  sin45Sel <= '1' WHEN lutaddr1 = to_unsigned(16#10000#, 17) ELSE
      '0';

  sin45SelRegComp_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      sin45SelRegComp_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_271_0 = '1' THEN
        sin45SelRegComp_reg(0) <= sin45Sel;
        sin45SelRegComp_reg(1 TO 2) <= sin45SelRegComp_reg(0 TO 1);
      END IF;
    END IF;
  END PROCESS sin45SelRegComp_process;

  sin45SelReg <= sin45SelRegComp_reg(2);

  msb2 <= phaseIdxReg(17);

  msb3 <= phaseIdxReg(16);

  -- LUT selection signal
  lutSel <= msb2 XOR msb3;

  lutSelRegComp_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      lutSelRegComp_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_271_0 = '1' THEN
        lutSelRegComp_reg(0) <= lutSel;
        lutSelRegComp_reg(1 TO 2) <= lutSelRegComp_reg(0 TO 1);
      END IF;
    END IF;
  END PROCESS lutSelRegComp_process;

  lutSelReg <= lutSelRegComp_reg(2);

  -- Map LUT address in correct phase
  lutaddrmax <= to_unsigned(16#20000#, 18);

  lutaddr2 <= resize(resize(lutaddrmax, 19) - resize(lutaddr1, 19), 17);

  
  lutaddr <= lutaddr1 WHEN msb3 = '0' ELSE
      lutaddr2;

  lutaddrO <= lutaddr(15 DOWNTO 0);

  lutoutsin_signed <= signed(lutoutsin);

  lutoutcos_signed <= signed(lutoutcos);

  -- Select sine output LUT
  
  lutselsin <= lutoutsin_signed WHEN lutSelReg = '0' ELSE
      lutoutcos_signed;

  octantVal <= to_signed(16#5A82#, 16);

  -- Assign sine pi/4 value
  
  fullsinmag <= lutselsin WHEN sin45SelReg = '0' ELSE
      octantVal;

  uminus_cast <= resize(fullsinmag, 17);
  uminus_cast_1 <=  - (uminus_cast);
  inverseSin <= uminus_cast_1(15 DOWNTO 0);

  -- Select sign of sine output
  
  sine_tmp <= fullsinmag WHEN sineSignSelReg = '0' ELSE
      inverseSin;

  sine <= std_logic_vector(sine_tmp);

  -- Cosine sign selection signal
  signSel <= msb1 XOR msb2;

  signSelRegComp_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      signSelRegComp_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_271_0 = '1' THEN
        signSelRegComp_reg(0) <= signSel;
        signSelRegComp_reg(1 TO 2) <= signSelRegComp_reg(0 TO 1);
      END IF;
    END IF;
  END PROCESS signSelRegComp_process;

  signSelReg <= signSelRegComp_reg(2);

  -- Select cosine output LUT
  
  lutselcos <= lutoutcos_signed WHEN lutSelReg = '0' ELSE
      lutoutsin_signed;

  -- Assign cosine pi/4 value
  
  fullcosmag <= lutselcos WHEN sin45SelReg = '0' ELSE
      octantVal;

  uminus_cast_2 <= resize(fullcosmag, 17);
  uminus_cast_3 <=  - (uminus_cast_2);
  inverseCos <= uminus_cast_3(15 DOWNTO 0);

  -- Select sign of cosine ouptput
  
  cosine_tmp <= fullcosmag WHEN signSelReg = '0' ELSE
      inverseCos;

  cosine <= std_logic_vector(cosine_tmp);

END rtl;

