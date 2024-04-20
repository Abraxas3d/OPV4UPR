
-- ----------------------------------------------
-- File Name: hdlverifier_data_jtag_rd.vhd
-- Created:   20-Apr-2024 21:15:45
-- Copyright  2024 MathWorks, Inc.
-- ----------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all;

entity hdlverifier_data_jtag_rd is
   GENERIC(
      DATA_WIDTH:integer := 8;
      ADDR_WIDTH:integer := 5);
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
end entity;  
  
architecture rtl of hdlverifier_data_jtag_rd is
	signal bitcount : std_logic_vector(15 downto 0);  
	signal shift_reg : std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal stop_addr : std_logic_vector(ADDR_WIDTH - 1 downto 0);
	signal newChunk_d1: std_logic;
	signal rd_int: std_logic;
	signal rd_int_d1: std_logic;
	signal rd_int_d2: std_logic;
	signal rd_int_d3: std_logic;
    signal raddr_int :  std_logic_vector(ADDR_WIDTH - 1 downto 0) := (others=>'0');
    signal rdy_send_int : std_logic;
    
begin	
	shift_out_data <= shift_reg(0) when (shift_out_en = '1' and rd_int_d2 = '1') else '0';
	rd <= rd_int;
	raddr <= raddr_int;
	rdy_send <= rdy_send_int;
	
	process (clk) is
	begin
		if rising_edge(clk) then
			newChunk_d1 <= newChunk;
		end if;
	end process;
	
	process (clk) is
	begin
		if rising_edge(clk) then
			if(reset = '1') then
				rd_int_d1 <= '0';
                rd_int_d2 <= '0';
                rd_int_d3 <= '0';
			else
				rd_int_d1 <= rd_int;
                rd_int_d2 <= rd_int_d1;
                rd_int_d3 <= rd_int_d2;
            end if;
	    end if;
	end process;
	
	process (clk) is
	begin
	if rising_edge(clk) then
		if(reset = '1') then
			rd_int <= '0';
		else
			if ( newChunk = '1' and newChunk_d1 = '0') then
				rd_int <= '1';
				stop_addr <= raddr_int + chunkSize - 1; 
			elsif((stop_addr = raddr_int) and (bitcount = (DATA_WIDTH-1))) then
				rd_int <= '0';
			end if;
		end if;
	end if;
	end process;
	
	process (clk) is
	begin
		if rising_edge(clk) then
			if(reset = '1') then
				rdy_send_int <= '0';
			else
				if(rd_int_d3 = '0') then
					rdy_send_int <= '1';
				else
					rdy_send_int <= '0';
				end if;
			end if;
		end if;
	end process;
	
	
	-- transferring captured data to JTAG 
	process (clk) is
	begin
	if rising_edge(clk) then
		if (reset = '1') then
		  bitcount <= X"0000";
		  shift_reg <= conv_std_logic_vector(0, DATA_WIDTH);
		  raddr_int <= conv_std_logic_vector(0, ADDR_WIDTH);
		end if;  
		if (rdy_send_int = '1') then
			shift_reg <= conv_std_logic_vector(0, DATA_WIDTH);
			bitcount <= X"0000";
		else
			if (shift_out_en = '1' and (rd_int = '1' or rd_int_d2 = '1')) then
				if bitcount = X"0000" then
					shift_reg <= '0' & shift_reg(DATA_WIDTH-1 downto 1);
					bitcount <= bitcount + '1';
					else
					if bitcount = X"0001" then
					  bitcount <= bitcount + '1';
					  shift_reg <= rd_data;
					else
						if bitcount = conv_std_logic_vector(DATA_WIDTH-1, 16) then
							bitcount <= X"0000";
							raddr_int <= raddr_int + '1';
							shift_reg <= '0' & shift_reg(DATA_WIDTH-1 downto 1);
						else
							bitcount <= bitcount + '1';
							shift_reg <= '0' & shift_reg(DATA_WIDTH-1 downto 1);
						end if;
					end if;
				end if;
			end if;
		end if;
	end if;
    end process;

end architecture;