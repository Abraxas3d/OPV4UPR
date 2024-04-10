----------------------------------------------------------------------------------
-- Company: Open Research Institute, Inc.
-- Engineer: Ken Easton, Abraxas3d, Paul Williamson, Rose Easton
--
-- Create Date: 04/06/2024 11:46:41 PM
-- Design Name: OPV4UPR
-- Module Name: passthrough - Behavioral
-- Project Name: Opulent Voice for University of Puerto Rico
-- Target Devices: PLUTO SDR etc.
-- Tool Versions: 2022.2
-- Description: a block inserted into the transmit chain that makes modifications
-- to the stream of IQ values coming from DMA
--
-- Dependencies:
--
-- Revision:
-- controlled in Git
-- Additional Comments:
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity axi_opv4upr is
    Port ( s_axis_aclk : in STD_LOGIC;
           reset       : in STD_LOGIC;
           m_axis_data : out STD_LOGIC_VECTOR (63 downto 0);
           s_axis_data : in STD_LOGIC_VECTOR (63 downto 0);
           s_axis_ready : out STD_LOGIC;
           s_axis_valid : in STD_LOGIC;
           m_axis_valid : out STD_LOGIC;
           m_axis_ready : in STD_LOGIC);
-- additional ports coming from DMAC are listed here.
-- we don't use them but we have to match them.
           s_axis_strb  : in STD_LOGIC_VECTOR (7 downto 0);
           s_axis_keep  : in STD_LOGIC_VECTOR (7 downto 0);
           s_axis_user  : in STD_LOGIC_VECTOR (0 downto 0);
           s_axis_id    : in STD_LOGIC_VECTOR (7 downto 0);
           s_axis_dest  : in STD_LOGIC_VECTOR (3 downto 0);
           s_axis_last  : in STD_LOGIC);
end axi_opv4upr;

architecture Behavioral of axi_opv4upr is
-- internal copies of the signals we are going to use
           signal output_data    :  STD_LOGIC_VECTOR (63 downto 0);
           signal input_data     :  STD_LOGIC_VECTOR (63 downto 0);
           signal s_axis_valid_i :  STD_LOGIC;
           signal m_axis_valid_i :  STD_LOGIC;
  -- constant 64 bit value of all zeros
           signal all_zeros      : STD_LOGIC_VECTOR(input_data'range) := (others => '0');
           signal all_ones       : STD_LOGIC_VECTOR(input_data'range) := (others => '1');
begin
-- asynchronous assignments
-- pass along the data
    m_axis_data <= output_data;
    input_data <= s_axis_data;
    -- get the axis_ready signal we get from upack and pass it along to DMA
    s_axis_ready <= m_axis_ready;
    -- receive axis_valid on our slave port
    s_axis_valid_i <= s_axis_valid;
    -- present our axis_valid on our master port
    m_axis_valid <= m_axis_valid_i;    
-- processes    
pass_data : process (reset, s_axis_aclk)
    begin
        if reset = '1' then
            m_axis_valid_i <= '0';
        elsif rising_edge(s_axis_aclk) then
            if s_axis_valid_i = '0' then
            -- clock signal happens and invalid data at input
            -- pass the input data through to the output.
                output_data <= input_data;
        -- and then send the input data to the output data
                m_axis_valid_i <= '0';
        -- indicate to the channel unpacker that this is invalid data (just for fun)
            else
                    -- clock signal happens and valid data at input
        -- overwrite the fetched value from DMA with all 1s.
                output_data <= all_ones;
        -- and then send the input data to the output data
                m_axis_valid_i <= '1';
        -- indicate to the channel unpacker we have valid data
            end if;
        end if;
    end process pass_data;
end Behavioral;
