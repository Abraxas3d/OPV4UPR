-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj/hdlsrc/opv_pluto_transmitter_HDL_coder_input/opv_modulator_tb.vhd
-- Created: 2024-04-16 02:45:33
-- 
-- Generated by MATLAB 9.14 and HDL Coder 4.1
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 6.00592e-11
-- Target subsystem base rate: 1.6276e-08
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: opv_modulator_tb
-- Source Path: 
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_textio.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY STD;
USE STD.textio.ALL;
LIBRARY work;
USE work.opv_modulator_pkg.ALL;
USE work.opv_modulator_tb_pkg.ALL;

ENTITY opv_modulator_tb IS
END opv_modulator_tb;


ARCHITECTURE rtl OF opv_modulator_tb IS

  -- Component Declarations
  COMPONENT opv_modulator
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          clk_enable                      :   IN    std_logic;
          bo_t_bitstream                  :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          be_t_bitstream_delayed          :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          ce_out                          :   OUT   std_logic;
          check_bo_t                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          tx_I                            :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          tx_q                            :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          check_be_t                      :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En15
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : opv_modulator
    USE ENTITY work.opv_modulator(rtl);

  -- Signals
  SIGNAL clk                              : std_logic;
  SIGNAL reset                            : std_logic;
  SIGNAL clk_enable                       : std_logic;
  SIGNAL check_be_t_done                  : std_logic;  -- ufix1
  SIGNAL rdEnb                            : std_logic;
  SIGNAL check_be_t_done_enb              : std_logic;  -- ufix1
  SIGNAL check_bo_t_addr                  : unsigned(21 DOWNTO 0);  -- ufix22
  SIGNAL check_be_t_lastAddr              : std_logic;  -- ufix1
  SIGNAL resetn                           : std_logic;
  SIGNAL check4_done                      : std_logic;  -- ufix1
  SIGNAL tx_q_done                        : std_logic;  -- ufix1
  SIGNAL tx_q_done_enb                    : std_logic;  -- ufix1
  SIGNAL tx_q_lastAddr                    : std_logic;  -- ufix1
  SIGNAL check3_done                      : std_logic;  -- ufix1
  SIGNAL tx_I_done                        : std_logic;  -- ufix1
  SIGNAL tx_I_done_enb                    : std_logic;  -- ufix1
  SIGNAL tx_I_lastAddr                    : std_logic;  -- ufix1
  SIGNAL check2_done                      : std_logic;  -- ufix1
  SIGNAL check_bo_t_done                  : std_logic;  -- ufix1
  SIGNAL check_bo_t_done_enb              : std_logic;  -- ufix1
  SIGNAL check_bo_t_active                : std_logic;  -- ufix1
  SIGNAL Rate_Transition1_out1_addr       : unsigned(21 DOWNTO 0);  -- ufix22
  SIGNAL Rate_Transition2_out1_addr_delay_1 : unsigned(21 DOWNTO 0);  -- ufix22
  SIGNAL tb_enb_delay                     : std_logic;
  SIGNAL rawData_be_t_bitstream_delayed   : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL holdData_be_t_bitstream_delayed  : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL be_t_bitstream_delayed_offset    : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL be_t_bitstream_delayed           : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL be_t_bitstream_delayed_1         : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Rate_Transition1_out1_active     : std_logic;  -- ufix1
  SIGNAL Rate_Transition1_out1_enb        : std_logic;  -- ufix1
  SIGNAL Rate_Transition1_out1_addr_delay_1 : unsigned(21 DOWNTO 0);  -- ufix22
  SIGNAL rawData_bo_t_bitstream           : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL holdData_bo_t_bitstream          : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL bo_t_bitstream_offset            : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL bo_t_bitstream                   : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL bo_t_bitstream_1                 : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL snkDone                          : std_logic;
  SIGNAL snkDonen                         : std_logic;
  SIGNAL tb_enb                           : std_logic;
  SIGNAL ce_out                           : std_logic;
  SIGNAL check_bo_t                       : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL tx_I                             : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL tx_q                             : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL check_be_t                       : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL check_bo_t_enb                   : std_logic;  -- ufix1
  SIGNAL check_bo_t_lastAddr              : std_logic;  -- ufix1
  SIGNAL check1_done                      : std_logic;  -- ufix1
  SIGNAL check_bo_t_signed                : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL check_bo_t_addr_delay_1          : unsigned(21 DOWNTO 0);  -- ufix22
  SIGNAL check_bo_t_expected              : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL check_bo_t_ref                   : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL check_bo_t_testFailure           : std_logic;  -- ufix1
  SIGNAL tx_I_signed                      : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL tx_I_addr_delay_1                : unsigned(21 DOWNTO 0);  -- ufix22
  SIGNAL tx_I_expected                    : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL tx_I_ref                         : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL tx_I_testFailure                 : std_logic;  -- ufix1
  SIGNAL tx_q_signed                      : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL tx_q_addr_delay_1                : unsigned(21 DOWNTO 0);  -- ufix22
  SIGNAL tx_q_expected                    : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL tx_q_ref                         : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL tx_q_testFailure                 : std_logic;  -- ufix1
  SIGNAL check_be_t_signed                : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL check_be_t_addr_delay_1          : unsigned(21 DOWNTO 0);  -- ufix22
  SIGNAL check_be_t_expected              : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL check_be_t_ref                   : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL check_be_t_testFailure           : std_logic;  -- ufix1
  SIGNAL testFailure                      : std_logic;  -- ufix1

BEGIN
  u_opv_modulator : opv_modulator
    PORT MAP( clk => clk,
              reset => reset,
              clk_enable => clk_enable,
              bo_t_bitstream => bo_t_bitstream_1,  -- sfix16_En15
              be_t_bitstream_delayed => be_t_bitstream_delayed_1,  -- sfix16_En15
              ce_out => ce_out,
              check_bo_t => check_bo_t,  -- sfix16_En15
              tx_I => tx_I,  -- sfix16_En15
              tx_q => tx_q,  -- sfix16_En15
              check_be_t => check_be_t  -- sfix16_En15
              );

  check_be_t_done_enb <= check_be_t_done AND rdEnb;

  
  check_be_t_lastAddr <= '1' WHEN check_bo_t_addr >= to_unsigned(16#264000#, 22) ELSE
      '0';

  check_be_t_done <= check_be_t_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_4_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check4_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF check_be_t_done_enb = '1' THEN
        check4_done <= check_be_t_done;
      END IF;
    END IF;
  END PROCESS checkDone_4_process;

  tx_q_done_enb <= tx_q_done AND rdEnb;

  
  tx_q_lastAddr <= '1' WHEN check_bo_t_addr >= to_unsigned(16#264000#, 22) ELSE
      '0';

  tx_q_done <= tx_q_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_3_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check3_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF tx_q_done_enb = '1' THEN
        check3_done <= tx_q_done;
      END IF;
    END IF;
  END PROCESS checkDone_3_process;

  tx_I_done_enb <= tx_I_done AND rdEnb;

  
  tx_I_lastAddr <= '1' WHEN check_bo_t_addr >= to_unsigned(16#264000#, 22) ELSE
      '0';

  tx_I_done <= tx_I_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_2_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check2_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF tx_I_done_enb = '1' THEN
        check2_done <= tx_I_done;
      END IF;
    END IF;
  END PROCESS checkDone_2_process;

  check_bo_t_done_enb <= check_bo_t_done AND rdEnb;

  
  check_bo_t_active <= '1' WHEN check_bo_t_addr /= to_unsigned(16#264000#, 22) ELSE
      '0';

  Rate_Transition2_out1_addr_delay_1 <= Rate_Transition1_out1_addr AFTER 1 ns;

  -- Data source for be_t_bitstream_delayed
  be_t_bitstream_delayed_fileread: PROCESS (Rate_Transition2_out1_addr_delay_1, tb_enb_delay, rdEnb)
    FILE fp: TEXT open READ_MODE is "be_t_bitstream_delayed.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(15 DOWNTO 0);

  BEGIN
    IF tb_enb_delay /= '1' THEN
    ELSIF rdEnb = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    rawData_be_t_bitstream_delayed <= signed(read_data(15 DOWNTO 0));
  END PROCESS be_t_bitstream_delayed_fileread;

  -- holdData reg for Rate_Transition2_out1
  stimuli_Rate_Transition2_out1_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      holdData_be_t_bitstream_delayed <= (OTHERS => 'X');
    ELSIF clk'event AND clk = '1' THEN
      holdData_be_t_bitstream_delayed <= rawData_be_t_bitstream_delayed;
    END IF;
  END PROCESS stimuli_Rate_Transition2_out1_process;

  stimuli_Rate_Transition2_out1_1: PROCESS (rawData_be_t_bitstream_delayed, rdEnb)
  BEGIN
    IF rdEnb = '0' THEN
      be_t_bitstream_delayed_offset <= holdData_be_t_bitstream_delayed;
    ELSE
      be_t_bitstream_delayed_offset <= rawData_be_t_bitstream_delayed;
    END IF;
  END PROCESS stimuli_Rate_Transition2_out1_1;

  be_t_bitstream_delayed <= be_t_bitstream_delayed_offset AFTER 2 ns;

  be_t_bitstream_delayed_1 <= std_logic_vector(be_t_bitstream_delayed);

  
  Rate_Transition1_out1_active <= '1' WHEN Rate_Transition1_out1_addr /= to_unsigned(16#264000#, 22) ELSE
      '0';

  Rate_Transition1_out1_enb <= Rate_Transition1_out1_active AND (rdEnb AND tb_enb_delay);

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 2506752
  RateTransition1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Rate_Transition1_out1_addr <= to_unsigned(16#000000#, 22);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF Rate_Transition1_out1_enb = '1' THEN
        IF Rate_Transition1_out1_addr >= to_unsigned(16#264000#, 22) THEN 
          Rate_Transition1_out1_addr <= to_unsigned(16#000000#, 22);
        ELSE 
          Rate_Transition1_out1_addr <= Rate_Transition1_out1_addr + to_unsigned(16#000001#, 22);
        END IF;
      END IF;
    END IF;
  END PROCESS RateTransition1_process;


  Rate_Transition1_out1_addr_delay_1 <= Rate_Transition1_out1_addr AFTER 1 ns;

  -- Data source for bo_t_bitstream
  bo_t_bitstream_fileread: PROCESS (Rate_Transition1_out1_addr_delay_1, tb_enb_delay, rdEnb)
    FILE fp: TEXT open READ_MODE is "bo_t_bitstream.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(15 DOWNTO 0);

  BEGIN
    IF tb_enb_delay /= '1' THEN
    ELSIF rdEnb = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    rawData_bo_t_bitstream <= signed(read_data(15 DOWNTO 0));
  END PROCESS bo_t_bitstream_fileread;

  -- holdData reg for Rate_Transition1_out1
  stimuli_Rate_Transition1_out1_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      holdData_bo_t_bitstream <= (OTHERS => 'X');
    ELSIF clk'event AND clk = '1' THEN
      holdData_bo_t_bitstream <= rawData_bo_t_bitstream;
    END IF;
  END PROCESS stimuli_Rate_Transition1_out1_process;

  stimuli_Rate_Transition1_out1_1: PROCESS (rawData_bo_t_bitstream, rdEnb)
  BEGIN
    IF rdEnb = '0' THEN
      bo_t_bitstream_offset <= holdData_bo_t_bitstream;
    ELSE
      bo_t_bitstream_offset <= rawData_bo_t_bitstream;
    END IF;
  END PROCESS stimuli_Rate_Transition1_out1_1;

  bo_t_bitstream <= bo_t_bitstream_offset AFTER 2 ns;

  bo_t_bitstream_1 <= std_logic_vector(bo_t_bitstream);

  snkDonen <=  NOT snkDone;

  resetn <=  NOT reset;

  tb_enb <= resetn AND snkDonen;

  -- Delay inside enable generation: register depth 1
  u_enable_delay_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      tb_enb_delay <= '0';
    ELSIF clk'event AND clk = '1' THEN
      tb_enb_delay <= tb_enb;
    END IF;
  END PROCESS u_enable_delay_process;

  
  rdEnb <= tb_enb_delay WHEN snkDone = '0' ELSE
      '0';

  clk_enable <= rdEnb AFTER 2 ns;

  reset_gen: PROCESS 
  BEGIN
    reset <= '1';
    WAIT FOR 20 ns;
    WAIT UNTIL clk'event AND clk = '1';
    WAIT FOR 2 ns;
    reset <= '0';
    WAIT;
  END PROCESS reset_gen;

  clk_gen: PROCESS 
  BEGIN
    clk <= '1';
    WAIT FOR 5 ns;
    clk <= '0';
    WAIT FOR 5 ns;
    IF snkDone = '1' THEN
      clk <= '1';
      WAIT FOR 5 ns;
      clk <= '0';
      WAIT FOR 5 ns;
      WAIT;
    END IF;
  END PROCESS clk_gen;

  check_bo_t_enb <= ce_out AND check_bo_t_active;

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 2506752
  c_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check_bo_t_addr <= to_unsigned(16#000000#, 22);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF check_bo_t_enb = '1' THEN
        IF check_bo_t_addr >= to_unsigned(16#264000#, 22) THEN 
          check_bo_t_addr <= to_unsigned(16#000000#, 22);
        ELSE 
          check_bo_t_addr <= check_bo_t_addr + to_unsigned(16#000001#, 22);
        END IF;
      END IF;
    END IF;
  END PROCESS c_3_process;


  
  check_bo_t_lastAddr <= '1' WHEN check_bo_t_addr >= to_unsigned(16#264000#, 22) ELSE
      '0';

  check_bo_t_done <= check_bo_t_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_1_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check1_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF check_bo_t_done_enb = '1' THEN
        check1_done <= check_bo_t_done;
      END IF;
    END IF;
  END PROCESS checkDone_1_process;

  snkDone <= check4_done AND (check3_done AND (check1_done AND check2_done));

  check_bo_t_signed <= signed(check_bo_t);

  check_bo_t_addr_delay_1 <= check_bo_t_addr AFTER 1 ns;

  -- Data source for check_bo_t_expected
  check_bo_t_expected_fileread: PROCESS (check_bo_t_addr_delay_1, tb_enb_delay, ce_out)
    FILE fp: TEXT open READ_MODE is "check_bo_t_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(15 DOWNTO 0);

  BEGIN
    IF tb_enb_delay /= '1' THEN
    ELSIF ce_out = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    check_bo_t_expected <= signed(read_data(15 DOWNTO 0));
  END PROCESS check_bo_t_expected_fileread;

  check_bo_t_ref <= check_bo_t_expected;

  check_bo_t_signed_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check_bo_t_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND check_bo_t_signed /= check_bo_t_ref THEN
        check_bo_t_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in check_bo_t_signed: Expected " & to_hex(check_bo_t_ref) & (" Actual " & to_hex(check_bo_t_signed))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS check_bo_t_signed_checker;

  tx_I_signed <= signed(tx_I);

  tx_I_addr_delay_1 <= check_bo_t_addr AFTER 1 ns;

  -- Data source for tx_I_expected
  tx_I_expected_fileread: PROCESS (tx_I_addr_delay_1, tb_enb_delay, ce_out)
    FILE fp: TEXT open READ_MODE is "tx_I_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(15 DOWNTO 0);

  BEGIN
    IF tb_enb_delay /= '1' THEN
    ELSIF ce_out = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    tx_I_expected <= signed(read_data(15 DOWNTO 0));
  END PROCESS tx_I_expected_fileread;

  tx_I_ref <= tx_I_expected;

  tx_I_signed_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      tx_I_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND tx_I_signed /= tx_I_ref THEN
        tx_I_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in tx_I_signed: Expected " & to_hex(tx_I_ref) & (" Actual " & to_hex(tx_I_signed))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS tx_I_signed_checker;

  tx_q_signed <= signed(tx_q);

  tx_q_addr_delay_1 <= check_bo_t_addr AFTER 1 ns;

  -- Data source for tx_q_expected
  tx_q_expected_fileread: PROCESS (tx_q_addr_delay_1, tb_enb_delay, ce_out)
    FILE fp: TEXT open READ_MODE is "tx_q_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(15 DOWNTO 0);

  BEGIN
    IF tb_enb_delay /= '1' THEN
    ELSIF ce_out = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    tx_q_expected <= signed(read_data(15 DOWNTO 0));
  END PROCESS tx_q_expected_fileread;

  tx_q_ref <= tx_q_expected;

  tx_q_signed_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      tx_q_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND tx_q_signed /= tx_q_ref THEN
        tx_q_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in tx_q_signed: Expected " & to_hex(tx_q_ref) & (" Actual " & to_hex(tx_q_signed))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS tx_q_signed_checker;

  check_be_t_signed <= signed(check_be_t);

  check_be_t_addr_delay_1 <= check_bo_t_addr AFTER 1 ns;

  -- Data source for check_be_t_expected
  check_be_t_expected_fileread: PROCESS (check_be_t_addr_delay_1, tb_enb_delay, ce_out)
    FILE fp: TEXT open READ_MODE is "check_be_t_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(15 DOWNTO 0);

  BEGIN
    IF tb_enb_delay /= '1' THEN
    ELSIF ce_out = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    check_be_t_expected <= signed(read_data(15 DOWNTO 0));
  END PROCESS check_be_t_expected_fileread;

  check_be_t_ref <= check_be_t_expected;

  check_be_t_signed_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check_be_t_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND check_be_t_signed /= check_be_t_ref THEN
        check_be_t_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in check_be_t_signed: Expected " & to_hex(check_be_t_ref) & (" Actual " & to_hex(check_be_t_signed))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS check_be_t_signed_checker;

  testFailure <= check_be_t_testFailure OR (tx_q_testFailure OR (check_bo_t_testFailure OR tx_I_testFailure));

  completed_msg: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF snkDone = '1' THEN
        IF testFailure = '0' THEN
          ASSERT FALSE
            REPORT "**************TEST COMPLETED (PASSED)**************"
            SEVERITY NOTE;
        ELSE
          ASSERT FALSE
            REPORT "**************TEST COMPLETED (FAILED)**************"
            SEVERITY NOTE;
        END IF;
      END IF;
    END IF;
  END PROCESS completed_msg;

END rtl;

