
-- ----------------------------------------------
-- File Name: hdlverifier_capture_comparator.vhd
-- Created:   20-Apr-2024 21:16:04
-- Copyright  2024 MathWorks, Inc.
-- ----------------------------------------------




library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.and_reduce;



entity hdlverifier_capture_comparator is
  generic(WIDTH:integer := 8);
  port (
    clk : in std_logic;
    clk_enable : in std_logic;
    data : in std_logic_vector(WIDTH-1 downto 0);
    trigger : out std_logic;
    trigger_comparison_operator: in std_logic_vector(2 downto 0);
    trigger_signed: in std_logic;
    trigger_bitmask : in std_logic_vector(WIDTH-1 downto 0);
    trigger_setting : in std_logic_vector(WIDTH-1 downto 0)
  );
end entity; 



architecture rtl of hdlverifier_capture_comparator is

signal trigger_mask_stage1 : std_logic_vector(WIDTH - 1 downto 0); 
signal trigger_mask_stage2 : std_logic_vector(WIDTH - 1 downto 0); 

begin
  process (data, trigger_setting) is
  begin
    trigger_mask_stage1 <= data xnor trigger_setting;
  end process;
  
  process (trigger_mask_stage1, trigger_bitmask) is
  begin
    trigger_mask_stage2 <= trigger_mask_stage1 or trigger_bitmask;
  end process;
  
  --- for floting point 
  --- sign bit not considering, {sign bit + }
  --- {trigger_signed, trigger_comparison_operator}    operation
  --- 4'b0110                                          data < trigger
  --- 4'b0111                                          data > trigger
  --- 4'b1110                                          data <= trigger
  --- 4'b1110                                          data >= trigger
	
  process (clk) is
  variable concatenate : std_logic_vector(3 downto 0);
  begin
    if rising_edge(clk) then
      if clk_enable = '1' then
	  concatenate := trigger_signed & trigger_comparison_operator;
      case concatenate is
	  when "0000" =>
	    if (and_reduce(trigger_mask_stage2)) = '1' then
	      trigger <= '1';
        else
          trigger <= '0';
 	    end if;
	  when "0001" =>
	    if (and_reduce(trigger_mask_stage2)) = '0' then
	      trigger <= '1';
        else
          trigger <= '0';
 	    end if;
	  when "0010" =>
	    if data < trigger_setting then
	      trigger <= '1';
        else
         trigger <= '0';
 	    end if;
	  when "0011" =>
	    if data > trigger_setting then
	      trigger <= '1';
        else
          trigger <= '0';
 	    end if;
	  when "0100" =>
	    if data <= trigger_setting then
	      trigger <= '1';
        else
          trigger <= '0';
 	    end if;
	  when "0101" =>
	    if data >= trigger_setting then
	      trigger <= '1';
        else
          trigger <= '0';
 	    end if;
	  when "1000" =>
	    if (and_reduce(trigger_mask_stage2)) = '1' then
	      trigger <= '1';
        else
          trigger <= '0';
 	    end if;
	  when "1001" =>
	    if (and_reduce(trigger_mask_stage2)) = '0' then
	      trigger <= '1';
        else
          trigger <= '0';
 	    end if;
	  when "1010" =>
	    if signed(data) < signed(trigger_setting) then
	      trigger <= '1';
        else
         trigger <= '0';
 	    end if;
	  when "1011" =>
	    if signed(data) > signed(trigger_setting) then
	      trigger <= '1';
        else
          trigger <= '0';
 	    end if;
	  when "1100" =>
	    if signed(data) <= signed(trigger_setting) then
	      trigger <= '1';
        else
          trigger <= '0';
 	    end if;
	  when "1101" =>
	    if signed(data) >= signed(trigger_setting) then
	      trigger <= '1';
        else
          trigger <= '0';
 	    end if;
	  when "0110" =>
		 if (data(WIDTH-1) = trigger_setting(WIDTH-1)) then
			if (data(WIDTH-1) = '1') then
				if (data(WIDTH-2 downto 0) > trigger_setting(WIDTH-2 downto 0)) then
					trigger <= '1';
				else
					trigger <= '0';
				end if;
			else
			    if (data(WIDTH-2 downto 0) < trigger_setting(WIDTH-2 downto 0)) then
					trigger <= '1';
				else
					trigger <= '0';
				end if;
			end if;
		else
			trigger <= data(WIDTH-1);
		end if;
	  when "0111" =>
		 if (data(WIDTH-1) = trigger_setting(WIDTH-1)) then
			if (data(WIDTH-1) = '1') then
				if (data(WIDTH-2 downto 0) < trigger_setting(WIDTH-2 downto 0)) then
					trigger <=  '1';
				else
					trigger <=  '0';
				end if;
			else
			    if (data(WIDTH-2 downto 0) > trigger_setting(WIDTH-2 downto 0)) then
					trigger <= '1';
				else
					trigger <= '0';
				end if;
			end if;
		else
			trigger <= not(data(WIDTH-1));
		end if;
	  when "1110" =>
		 if (data(WIDTH-1) = trigger_setting(WIDTH-1)) then
			if (data(WIDTH-1) = '1') then
				if (data(WIDTH-2 downto 0) >= trigger_setting(WIDTH-2 downto 0)) then
					trigger <= '1';
				else
					trigger <= '0';
				end if;
			else
				if (data(WIDTH-2 downto 0) <= trigger_setting(WIDTH-2 downto 0)) then
					trigger <= '1';
				else
					trigger <= '0';
				end if;
			end if;
		else
			trigger <= data(WIDTH-1);
		end if;
	  when "1111" =>
		 if (data(WIDTH-1) = trigger_setting(WIDTH-1)) then 
			if (data(WIDTH-1) = '1') then
				if (data(WIDTH-2 downto 0) <= trigger_setting(WIDTH-2 downto 0)) then
					trigger <= '1';
				else
					trigger <= '0';
				end if;
			else
			    if (data(WIDTH-2 downto 0) >= trigger_setting(WIDTH-2 downto 0)) then
					trigger <= '1';
				else
					trigger <= '0';
				end if;
			end if;
		else
			trigger <= not(data(WIDTH-1));
		end if;
	  when others =>
	    trigger <= '0';
    end case;
	
    end if;
  end if;
 end process;
end architecture;
