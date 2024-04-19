-- -------------------------------------------------------------
-- 
-- File Name: /home/matt/OPV_TX_abraxas3d/preamble-HDL/hdlsrc/opv_pluto_transmitter_HDL_coder_input/opv_modul_ip_src_preamble_sample_and_hold.vhd
-- Created: 2024-04-19 02:57:39
-- 
-- Generated by MATLAB 9.14 and HDL Coder 4.1
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: opv_modul_ip_src_preamble_sample_and_hold
-- Source Path: opv_pluto_transmitter_HDL_coder_input/preamble/preamble sample and hold
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY opv_modul_ip_src_preamble_sample_and_hold IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_307200_0                    :   IN    std_logic;
        input                             :   IN    std_logic;
        reset_1                           :   IN    std_logic;
        trigger                           :   IN    std_logic;
        output                            :   OUT   std_logic
        );
END opv_modul_ip_src_preamble_sample_and_hold;


ARCHITECTURE rtl OF opv_modul_ip_src_preamble_sample_and_hold IS

  -- Signals
  SIGNAL sample_held                      : std_logic;
  SIGNAL output_held_value                : std_logic;
  SIGNAL sample_held_next                 : std_logic;
  SIGNAL output_held_value_next           : std_logic;

BEGIN
  preamble_sample_and_hold_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      sample_held <= '0';
      output_held_value <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_307200_0 = '1' THEN
        sample_held <= sample_held_next;
        output_held_value <= output_held_value_next;
      END IF;
    END IF;
  END PROCESS preamble_sample_and_hold_process;

  preamble_sample_and_hold_output : PROCESS (input, output_held_value, reset_1, sample_held, trigger)
    VARIABLE index : signed(31 DOWNTO 0);
    VARIABLE index_0 : signed(31 DOWNTO 0);
    VARIABLE result : std_logic;
    VARIABLE result_0 : std_logic;
    VARIABLE result_1 : std_logic;
    VARIABLE result_2 : std_logic;
  BEGIN
    index_0 := to_signed(16#00000000#, 32);
    result_0 := '0';
    result_1 := '0';
    result_2 := '0';
    output_held_value_next <= output_held_value;
    sample_held_next <= sample_held;
    --Resettable Sample and Hold Circuit
    -- This was written because S&H within Resettable Subsystems in Simulink
    -- is not supported by HDL Coder. We needed this functionality, so this
    -- custom function was written. 
    result :=  NOT reset_1;
    IF result = '1' THEN 
      index := to_signed(16#00000000#, 32);
    ELSE 
      result_0 := reset_1;
      IF result_0 = '1' THEN 
        index := to_signed(16#00000001#, 32);
      ELSE 
        index := X"FFFFFFFF";
      END IF;
    END IF;
    CASE index IS
      WHEN "00000000000000000000000000000000" =>
        -- not in reset
        result_1 :=  NOT trigger;
        IF result_1 = '1' THEN 
          index_0 := to_signed(16#00000000#, 32);
        ELSE 
          result_2 := trigger;
          IF result_2 = '1' THEN 
            index_0 := to_signed(16#00000001#, 32);
          ELSE 
            index_0 := X"FFFFFFFF";
          END IF;
        END IF;
        CASE index_0 IS
          WHEN "00000000000000000000000000000000" =>
            output <= output_held_value;
          WHEN "00000000000000000000000000000001" =>
            IF ( NOT sample_held) = '1' THEN 
              output_held_value_next <= input;
              output <= input;
              sample_held_next <= '1';
            ELSE 
              output <= output_held_value;
            END IF;
          WHEN OTHERS => 
            output <= '0';
        END CASE;
      WHEN "00000000000000000000000000000001" =>
        -- reset signal received
        output <= '0';
        sample_held_next <= '0';
        output_held_value_next <= '0';
      WHEN OTHERS => 
        output <= '0';
    END CASE;
  END PROCESS preamble_sample_and_hold_output;


END rtl;

