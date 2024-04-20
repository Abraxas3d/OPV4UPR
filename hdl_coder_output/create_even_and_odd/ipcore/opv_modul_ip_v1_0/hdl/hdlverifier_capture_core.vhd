
-- ----------------------------------------------
-- File Name: hdlverifier_capture_core.vhd
-- Created:   20-Apr-2024 21:15:45
-- Copyright  2024 MathWorks, Inc.
-- ----------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all;

entity hdlverifier_capture_core is
  generic(
    DATA_WIDTH: integer := 8;
    ADDR_WIDTH: integer := 4;
    TRIG_WIDTH: integer := 22;
	WINDOW_SIZE: integer := 20;
    JTAG_ID: integer := 2);
  port (
    clk : in std_logic;
    clk_enable : in std_logic;
    data : in std_logic_vector(DATA_WIDTH - 1 downto 0);
	current_stage : in std_logic_vector(3 downto 0); 
	stage_reset : in std_logic_vector(3 downto 0);
    seq_reset : in std_logic;
    start : out std_logic;
	ready_to_capture : out std_logic;
    trigger : in std_logic;
    buffer_enable : in std_logic;
    trigger_setting : out std_logic_vector(TRIG_WIDTH - 1 downto 0)
  );
end entity; 


architecture rtl of hdlverifier_capture_core is
  signal data_d1 : std_logic_vector(DATA_WIDTH - 1 downto 0);  
  signal data_d2 : std_logic_vector(DATA_WIDTH - 1 downto 0);  
  signal capture_data : std_logic_vector(DATA_WIDTH - 1 downto 0);  
  signal flag_full : std_logic;  
  signal has_clk   : std_logic;  
  signal reg_addr  : std_logic_vector(4 downto 0);  
  signal reg_rdata : std_logic_vector(31 downto 0);  
  signal reg_wdata : std_logic_vector(31 downto 0);  
  signal reg_write : std_logic;  
  signal reset_clk : std_logic;  
  signal reset_reg : std_logic;  
  signal reset_tck : std_logic;  
  signal shift_in_data : std_logic;  
  signal shift_in_en : std_logic;  
  signal shift_in_state : std_logic;  
  signal shift_out_data : std_logic;  
  signal shift_out_en : std_logic;  
  signal shift_out_state : std_logic;  											   
  signal status_register : std_logic_vector(31 downto 0);  
  signal tck : std_logic;  
  signal trig_shift_counter : std_logic_vector(19 downto 0);  
  signal trigger_pos : std_logic_vector(ADDR_WIDTH - 1 downto 0);  
  signal trigger_shifter : std_logic_vector(TRIG_WIDTH - 1 downto 0);  
  signal user_data_out0_tck : std_logic_vector(31 downto 0);  
  signal user_data_out0 : std_logic_vector(31 downto 0);  
  signal user_data_out1 : std_logic_vector(31 downto 0);  
  signal user_data_out2 : std_logic_vector(31 downto 0);  
  signal user_data_out3 : std_logic_vector(31 downto 0);  
  signal captured_window_count : std_logic_vector(ADDR_WIDTH - 1 downto 0);  
  signal number_of_windows : std_logic_vector(ADDR_WIDTH - 1 downto 0);  
  signal chunk_size : std_logic_vector(ADDR_WIDTH - 1 downto 0);
  signal newChunk : std_logic;
  signal rd_data : std_logic_vector(DATA_WIDTH - 1 downto 0);
  signal raddr : std_logic_vector(ADDR_WIDTH - 1 downto 0);
  signal rd : std_logic;
  signal rdy_send : std_logic;
  signal jtag_rd_reset : std_logic;
  signal start_d1 : std_logic;
  signal reset_fdc : std_logic;
  signal current_eval_stage : std_logic_vector(3 downto 0);
  signal trigger_met_rem : std_logic; 							   
  
  component hdlverifier_jtag_register is
   port (
      addr : in std_logic_vector(4 downto 0);
      clk : in std_logic;
      rdata : out std_logic_vector(31 downto 0);
      reset : in std_logic;
      tck : in std_logic;
      user_data_in0 : in std_logic_vector(31 downto 0);
      user_data_in1 : in std_logic_vector(31 downto 0);
      user_data_in2 : in std_logic_vector(31 downto 0);
      user_data_in3 : in std_logic_vector(31 downto 0);
      user_data_out0_tck : out std_logic_vector(31 downto 0);
      user_data_out0 : out std_logic_vector(31 downto 0); --{trigger_pos(31:3),enable_capture_control(2),capture_data(1),start(0)}
      user_data_out1 : out std_logic_vector(31 downto 0); --number_of_windows
      user_data_out2 : out std_logic_vector(31 downto 0); -- chunk_size,newChunk
      user_data_out3 : out std_logic_vector(31 downto 0);
      wdata : in std_logic_vector(31 downto 0);
      write : in std_logic
    );
  end component;
  
   component hdlverifier_capture_data is
   GENERIC(
      DATA_WIDTH:integer;
      ADDR_WIDTH:integer);
   port (
      clk : in std_logic;
      clk_enable : in std_logic;
      data : in std_logic_vector(DATA_WIDTH - 1 downto 0);
      flag_full : out std_logic;
      reset : in std_logic;
      run : in std_logic;
      run_tck : in std_logic;
      immediate : in std_logic;
      enable_capture_ctrl : in std_logic;
      has_clk : out std_logic;
      tck : in std_logic;
      trigger : in std_logic;
      buffer_enable : in std_logic;
      trigger_pos : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
	  ready_to_capture : out std_logic;
      captured_window_count : out std_logic_vector(ADDR_WIDTH - 1 downto 0);
      number_of_windows : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
	  rd : in std_logic;
	  raddr : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
	  rd_data : out std_logic_vector(DATA_WIDTH - 1 downto 0)
);
  end component;
  
  component hdlverifier_capture_jtag_core is
    generic(JTAG_ID: natural);
    port (
      reg_addr : out std_logic_vector(4 downto 0);
      reg_rdata : in std_logic_vector(31 downto 0);
      reg_wdata : out std_logic_vector(31 downto 0);
      reg_write : out std_logic;
      reset : out std_logic;
      shift_in_data : out std_logic;
      shift_in_en : out std_logic;
      shift_in_state : out std_logic;
      shift_out_data : in std_logic;
      shift_out_en : out std_logic;
      shift_out_state : out std_logic;
      tck : out std_logic
    );
  end component;

   component hdlverifier_data_jtag_rd is
   generic(
      DATA_WIDTH:integer;
      ADDR_WIDTH:integer);
   port (
    clk : in std_logic;
	reset : in std_logic;
	shift_out_data : out std_logic;
	shift_out_en : in std_logic;
	newChunk : in std_logic;
	chunkSize : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
	shift_out_state : in std_logic;
	rd : out std_logic;
	rd_data : in std_logic_vector(DATA_WIDTH - 1 downto 0);
	raddr : out std_logic_vector(ADDR_WIDTH - 1 downto 0);
	rdy_send : out std_logic
  );
  end component;
  
  component hdlverifier_synchronizer is
    generic(WIDTH:integer);
    port (
      clk : in std_logic;
      data_in : in std_logic_vector(WIDTH - 1 downto 0);
      data_out : out std_logic_vector(WIDTH - 1 downto 0)
    );
  end component;
  
  constant MAJOR_VER: std_logic_vector(7 downto 0) := X"01";
  constant MINOR_VER: std_logic_vector(3 downto 0) := X"2";
  constant APP_TYPE : std_logic_vector(3 downto 0)  := X"A";
  constant ADDR_WPOW: std_logic_vector(4 downto 0)  := conv_std_logic_vector(ADDR_WIDTH,5);
  constant DATA_WIDTH_BYTE: std_logic_vector(10 downto 0)  := conv_std_logic_vector(DATA_WIDTH/8,11);
  
  
  signal CAPTURE_IP_ID0 : std_logic_vector(31 downto 0); 

begin
  
  status_register(31 downto 28) <= current_eval_stage;
  status_register(1) <= has_clk;
  status_register(0) <= flag_full;
  status_register(21 downto 2) <= (19 downto ADDR_WIDTH => '0') & captured_window_count;
  status_register(22) <= rdy_send;
  status_register(26 downto 23) <= stage_reset;
  status_register(27) <= seq_reset;
  start <= user_data_out0(0);	
  reset_fdc <= user_data_out3(0);	
  trigger_pos <= user_data_out0(ADDR_WIDTH+3 downto 4);
  number_of_windows <= user_data_out1(ADDR_WIDTH - 1 downto 0);
  capture_data <= data when ((user_data_out0(1) = '1') and (user_data_out0(2) = '0')) else data_d2;
  chunk_size <= user_data_out2(ADDR_WIDTH + 7 downto 8);
  jtag_rd_reset <= reset_clk or (user_data_out0(0) and start_d1);
  
  CAPTURE_IP_ID0 <= DATA_WIDTH_BYTE & ADDR_WPOW & APP_TYPE & MAJOR_VER & MINOR_VER;

  register_manager: hdlverifier_jtag_register
    port map (
      addr => reg_addr,
      clk => clk,
      rdata => reg_rdata,
      reset => reset_tck,
      tck => tck,
      user_data_in0 =>  CAPTURE_IP_ID0 ,
      user_data_in1 => X"00000200",
      user_data_in2 => status_register,
      user_data_in3 => X"0000f00f",
      user_data_out0_tck => user_data_out0_tck,
      user_data_out0 => user_data_out0,
      user_data_out1 => user_data_out1,
      user_data_out2 => user_data_out2,
      user_data_out3 => user_data_out3,
      wdata => reg_wdata,
      write => reg_write
    );
  
  
  sync_trigger: hdlverifier_synchronizer
    generic map(WIDTH => TRIG_WIDTH)
    port map (
      clk => clk,
      data_in => trigger_shifter,
      data_out => trigger_setting
    );
  
  
  u_capture: hdlverifier_capture_data
   GENERIC map(
      DATA_WIDTH => DATA_WIDTH,
      ADDR_WIDTH => ADDR_WIDTH)
    port map (
      clk => clk,
      clk_enable => clk_enable,
      data => capture_data,
      flag_full => flag_full,
      reset => reset_clk,
      run => user_data_out0(0),
      run_tck => user_data_out0_tck(0),
      immediate => user_data_out0(1),
      enable_capture_ctrl => user_data_out0(2),
      has_clk => has_clk,			  
      tck => tck,
      trigger => trigger,
      buffer_enable => buffer_enable,
      trigger_pos => trigger_pos,
	  ready_to_capture => ready_to_capture,
      captured_window_count => captured_window_count,
	  number_of_windows => number_of_windows,
	  rd => rd,
	  raddr => raddr,
	  rd_data => rd_data
    );
  
  
  u_jtag_core: hdlverifier_capture_jtag_core
    generic map(
        JTAG_ID=>JTAG_ID
    )
    port map (
      reg_addr => reg_addr,
      reg_rdata => reg_rdata,
      reg_wdata => reg_wdata,
      reg_write => reg_write,
      reset => reset_tck,
      shift_in_data => shift_in_data,
      shift_in_en => shift_in_en,
      shift_in_state => shift_in_state,
      shift_out_data => shift_out_data,
      shift_out_en => shift_out_en,
      shift_out_state => shift_out_state,
      tck => tck
    );
  
   u_jtag_rd: hdlverifier_data_jtag_rd 
   generic map(
      DATA_WIDTH=>DATA_WIDTH,
      ADDR_WIDTH=>ADDR_WIDTH)
   port map(
    clk => tck,
	reset => jtag_rd_reset,
	shift_out_data => shift_out_data,
	shift_out_en => shift_out_en,
	newChunk => newChunk,
	chunkSize => chunk_size,
	shift_out_state => shift_out_state,
	rd => rd,
	rd_data => rd_data,
	raddr => raddr,
	rdy_send => rdy_send
  );
  
					 
  process (clk) is
  begin
	if rising_edge (clk) then
		if(rdy_send =  '1' ) then
			newChunk <= user_data_out2(0);
		end if;
	end if;
  end process;
 
 process (clk, trigger_met_rem) is
  begin
	if rising_edge (clk) then
		if((flag_full = '0') and (trigger_met_rem =  '1') and (user_data_out0(2) = '1')) then
			current_eval_stage <= X"F";
        else
            current_eval_stage <= current_stage;
		end if;
	end if;
  end process;
 
 process (clk) is
  begin
	if rising_edge (clk) then
		start_d1 <= not(user_data_out0(0)); --not of start							
	end if;
  end process;
  
  process (clk) is
  begin
    if rising_edge(clk) then   
		if ((start_d1 = '1') and (user_data_out0(0) = '1')) then
			trigger_met_rem <= '0';
		elsif(trigger = '1') then
			trigger_met_rem <= '1';
		end if;	 
	end if;		
  end process;

  process (tck) is
  begin
    if rising_edge(tck) then
      if shift_in_state = '0' then
        trig_shift_counter <= X"00000";
      end if;
      if ((shift_in_state = '1') and (shift_in_en = '1')) and trig_shift_counter < conv_std_logic_vector(TRIG_WIDTH,20) then
        trigger_shifter <= trigger_shifter(TRIG_WIDTH-2 downto 0) & shift_in_data;
        trig_shift_counter <= trig_shift_counter + '1';
      end if;
    end if;
  end process;
  
  
  process (clk) is
  begin
    if rising_edge(clk)  then
       if (user_data_out3(0) = '1') then
           reset_reg <= '1';
           reset_clk <= '1';
       else 
           reset_reg <= '0';
           reset_clk <= '0';
       end if;
    end if;
  end process;
  
  
  process (clk) is
  begin
    if rising_edge(clk) then
      if clk_enable = '1' then
        data_d1 <= data;
        data_d2 <= data_d1;
      end if;
    end if;
  end process;
end architecture;
