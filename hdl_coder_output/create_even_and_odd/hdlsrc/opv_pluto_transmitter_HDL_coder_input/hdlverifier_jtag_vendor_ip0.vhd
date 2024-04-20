
-- ----------------------------------------------
-- File Name: hdlverifier_jtag_vendor_ip0.vhd
-- Created:   20-Apr-2024 21:15:45
-- Copyright  2024 MathWorks, Inc.
-- ----------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hdlverifier_jtag_vendor_ip0 is
    generic(JTAG_ID: natural := 2);
    port(
        tdo:        in  std_logic;
        tdi:        out std_logic;
        tck:        out std_logic;
        jtag_reset:  out std_logic;
        capture_dr:  out std_logic;
        shift_dr  :  out std_logic;
        update_dr :  out std_logic
    );
end entity hdlverifier_jtag_vendor_ip0;

architecture jtag_vendor_ip0_arch of hdlverifier_jtag_vendor_ip0 is
    signal sel : std_logic;
    signal cdr : std_logic;
    signal sdr : std_logic;
    signal udr : std_logic;
    
component BSCANE2
    generic (JTAG_CHAIN: natural := 1);
    port(
        TDI     : out std_logic;
        RESET   : out std_logic;
        SEL     : out std_logic;
        TCK     : out std_logic;
        CAPTURE : out std_logic;
        TDO     : in std_logic;
        SHIFT   : out std_logic;
        UPDATE  : out std_logic
        );
end component;
     
begin
    capture_dr  <= sel and cdr;
    shift_dr    <= sel and sdr;
    update_dr   <= sel and udr;
    
u_BSCAN: BSCANE2
    generic map(
        JTAG_CHAIN  => JTAG_ID
    )
    port map(
        TDI     =>  tdi,
        RESET   =>  jtag_reset,
        SEL     =>  sel,
        TCK     =>  tck,
        CAPTURE =>  cdr,
        TDO     =>  tdo,
        SHIFT   =>  sdr,
        UPDATE  =>  udr
        );

end jtag_vendor_ip0_arch;