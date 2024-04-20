
-- ----------------------------------------------
-- File Name: hdlverifier_capture_trigger_condition.vhd
-- Created:   20-Apr-2024 21:16:04
-- Copyright  2024 MathWorks, Inc.
-- ----------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.ALL;


ENTITY hdlverifier_capture_trigger_condition IS 
PORT (
      clk                             : IN  std_logic;
      clk_enable                      : IN  std_logic;
      trigger_setting                 : IN  std_logic_vector(74 DOWNTO 0);
      bo_bitstream                    : IN  std_logic_vector(15 DOWNTO 0);
      be_bitstream                    : IN  std_logic_vector(15 DOWNTO 0);
      trigger                         : OUT std_logic
);
END hdlverifier_capture_trigger_condition;

ARCHITECTURE rtl of hdlverifier_capture_trigger_condition IS

COMPONENT hdlverifier_capture_comparator IS 
GENERIC (WIDTH: integer := 8
);
PORT (
      clk                             : IN  std_logic;
      clk_enable                      : IN  std_logic;
      data                            : IN  std_logic_vector(WIDTH - 1 DOWNTO 0);
      trigger_setting                 : IN  std_logic_vector(WIDTH - 1 DOWNTO 0);
      trigger_bitmask                 : IN  std_logic_vector(WIDTH - 1 DOWNTO 0);
      trigger_comparison_operator     : IN  std_logic_vector(2 DOWNTO 0);
      trigger_signed                  : IN  std_logic;
      trigger                         : OUT std_logic
);
END COMPONENT;

COMPONENT hdlverifier_capture_trigger_combine IS 
GENERIC (WIDTH: integer := 8
);
PORT (
      clk                             : IN  std_logic;
      clk_enable                      : IN  std_logic;
      trigger_in                      : IN  std_logic_vector(WIDTH - 1 DOWNTO 0);
      trigger_enable                  : IN  std_logic_vector(WIDTH - 1 DOWNTO 0);
      trigger_combination_rule        : IN  std_logic;
      trigger_out                     : OUT std_logic
);
END COMPONENT;

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

u_hdlverifier_capture_comparator: hdlverifier_capture_comparator 
GENERIC MAP (WIDTH => 16
)
PORT MAP(
        clk                  => clk,
        clk_enable           => clk_enable,
        data                 => bo_bitstream,
        trigger              => trigger_out1,
        trigger_setting      => trigger_setting1,
        trigger_bitmask      => trigBitMask1,
        trigger_comparison_operator => trigger_comparison_operator1,
        trigger_signed       => trigger_signed1
);

u_hdlverifier_capture_comparator_inst1: hdlverifier_capture_comparator 
GENERIC MAP (WIDTH => 16
)
PORT MAP(
        clk                  => clk,
        clk_enable           => clk_enable,
        data                 => be_bitstream,
        trigger              => trigger_out2,
        trigger_setting      => trigger_setting2,
        trigger_bitmask      => trigBitMask2,
        trigger_comparison_operator => trigger_comparison_operator2,
        trigger_signed       => trigger_signed2
);

u_hdlverifier_capture_trigger_combine: hdlverifier_capture_trigger_combine 
GENERIC MAP (WIDTH => 2
)
PORT MAP(
        clk                  => clk,
        clk_enable           => clk_enable,
        trigger_in           => trigger_stage1,
        trigger_enable       => trigger_enable,
        trigger_out          => trigger,
        trigger_combination_rule => trigger_combine_rule
);

trigger_stage1 <= trigger_out1 & trigger_out2;
trigger_enable <= trigger_setting(73 DOWNTO 72);
trigger_setting1 <= trigger_setting(15 DOWNTO 0);
trigBitMask1 <= trigger_setting(31 DOWNTO 16);
trigger_comparison_operator1 <= trigger_setting(34 DOWNTO 32);
trigger_signed1 <= trigger_setting(35);
trigger_setting2 <= trigger_setting(51 DOWNTO 36);
trigBitMask2 <= trigger_setting(67 DOWNTO 52);
trigger_comparison_operator2 <= trigger_setting(70 DOWNTO 68);
trigger_signed2 <= trigger_setting(71);
trigger_combine_rule <= trigger_setting(74);

END;
