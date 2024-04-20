
-- ----------------------------------------------
-- File Name: FPGADataCapture_versal.vhd
-- Created:   20-Apr-2024 21:16:04
-- Copyright  2024 MathWorks, Inc.
-- ----------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.ALL;


ENTITY FPGADataCapture_versal IS 
PORT (
      clk                             : IN  std_logic;
      clk_enable                      : IN  std_logic;
      versal_capture                  : IN  std_logic;
      versal_jtag_reset               : IN  std_logic;
      versal_sel                      : IN  std_logic;
      versal_shift                    : IN  std_logic;
      versal_tck                      : IN  std_logic;
      versal_tdi                      : IN  std_logic;
      versal_update                   : IN  std_logic;
      bo_bitstream                    : IN  std_logic_vector(15 DOWNTO 0);
      be_bitstream                    : IN  std_logic_vector(15 DOWNTO 0);
      ready_to_capture                : OUT std_logic;
      versal_tdo                      : OUT std_logic
);
END FPGADataCapture_versal;

ARCHITECTURE rtl of FPGADataCapture_versal IS

COMPONENT hdlverifier_capture_core_versal IS 
GENERIC (DATA_WIDTH: integer := 8;
ADDR_WIDTH: integer := 7;
TRIG_WIDTH: integer := 9;
JTAG_ID: integer := 5
);
PORT (
      clk                             : IN  std_logic;
      clk_enable                      : IN  std_logic;
      data                            : IN  std_logic_vector(DATA_WIDTH - 1 DOWNTO 0);
      trigger                         : IN  std_logic;
      versal_capture                  : IN  std_logic;
      versal_jtag_reset               : IN  std_logic;
      versal_sel                      : IN  std_logic;
      versal_shift                    : IN  std_logic;
      versal_tck                      : IN  std_logic;
      versal_tdi                      : IN  std_logic;
      versal_update                   : IN  std_logic;
      start                           : OUT std_logic;
      ready_to_capture                : OUT std_logic;
      trigger_setting                 : OUT std_logic_vector(TRIG_WIDTH - 1 DOWNTO 0);
      versal_tdo                      : OUT std_logic
);
END COMPONENT;

COMPONENT hdlverifier_capture_trigger_condition IS 
PORT (
      clk                             : IN  std_logic;
      clk_enable                      : IN  std_logic;
      trigger_setting                 : IN  std_logic_vector(74 DOWNTO 0);
      bo_bitstream                    : IN  std_logic_vector(15 DOWNTO 0);
      be_bitstream                    : IN  std_logic_vector(15 DOWNTO 0);
      trigger                         : OUT std_logic
);
END COMPONENT;

  SIGNAL all_data                         : std_logic_vector(39 DOWNTO 0); -- std40
  SIGNAL pad_zero                         : std_logic_vector(7 DOWNTO 0); -- std8
  SIGNAL trigger_setting                  : std_logic_vector(95 DOWNTO 0); -- std96
  SIGNAL trigger_1                        : std_logic; -- boolean
  SIGNAL start_flag                       : std_logic; -- boolean
  SIGNAL trigger_setting_cond1            : std_logic_vector(74 DOWNTO 0); -- std75
  SIGNAL trigger_stage1                   : std_logic_vector(1 DOWNTO 0); -- std2
  SIGNAL trigger_enable                   : std_logic_vector(1 DOWNTO 0); -- std2
  SIGNAL trigger_out1                     : std_logic; -- boolean
  SIGNAL trigger_setting1                 : std_logic_vector(15 DOWNTO 0); -- std16
  SIGNAL trigBitMask1                     : std_logic_vector(15 DOWNTO 0); -- std16
  SIGNAL trigger_comparison_operator1     : std_logic_vector(2 DOWNTO 0); -- std3
  SIGNAL trigger_signed1                  : std_logic; -- std1
  SIGNAL trigger_out2                     : std_logic; -- boolean
  SIGNAL trigger_setting2                 : std_logic_vector(15 DOWNTO 0); -- std16
  SIGNAL trigBitMask2                     : std_logic_vector(15 DOWNTO 0); -- std16
  SIGNAL trigger_comparison_operator2     : std_logic_vector(2 DOWNTO 0); -- std3
  SIGNAL trigger_signed2                  : std_logic; -- std1
  SIGNAL trigger_combine_rule             : std_logic; -- boolean

BEGIN

u_hdlverifier_capture_core_versal: hdlverifier_capture_core_versal 
GENERIC MAP (DATA_WIDTH => 40,
ADDR_WIDTH => 7,
TRIG_WIDTH => 96,
JTAG_ID => 2
)
PORT MAP(
        clk                  => clk,
        clk_enable           => clk_enable,
        start                => start_flag,
        ready_to_capture     => ready_to_capture,
        data                 => all_data,
        trigger              => trigger_1,
        trigger_setting      => trigger_setting,
        versal_capture       => versal_capture,
        versal_jtag_reset    => versal_jtag_reset,
        versal_sel           => versal_sel,
        versal_shift         => versal_shift,
        versal_tck           => versal_tck,
        versal_tdi           => versal_tdi,
        versal_update        => versal_update,
        versal_tdo           => versal_tdo
);

u_hdlverifier_capture_trigger_condition: hdlverifier_capture_trigger_condition 
PORT MAP(
        clk                  => clk,
        clk_enable           => clk_enable,
        trigger              => trigger_1,
        trigger_setting      => trigger_setting_cond1,
        bo_bitstream         => bo_bitstream,
        be_bitstream         => be_bitstream
);

all_data <= pad_zero & be_bitstream & bo_bitstream;
pad_zero <= (others => '0');
trigger_setting_cond1 <= trigger_setting(74 DOWNTO 0);

END;
