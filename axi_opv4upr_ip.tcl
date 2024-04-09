# ***************************************************************************
# ***************************************************************************
# Copyright 2018 (c) Analog Devices, Inc. All rights reserved.
#
# Each core or library found in this collection may have its own licensing terms.
# The user should keep this in in mind while exploring these cores.
#
# Redistribution and use in source and binary forms,
# with or without modification of this file, are permitted under the terms of either
#  (at the option of the user):
#
#   1. The GNU General Public License version 2 as published by the
#      Free Software Foundation, which can be found in the top level directory, or at:
# https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html
#
# OR
#
#   2.  An ADI specific BSD license as noted in the top level directory, or on-line at:
# https://github.com/analogdevicesinc/hdl/blob/dev/LICENSE
#
# ***************************************************************************
# ***************************************************************************

source ../../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip_xilinx.tcl

adi_ip_create axi_opv4upr


adi_ip_files axi_opv4upr [list \
	"axi_opv4upr.vhd"]

# use this command if we have AXI lite for register controls
#adi_ip_properties axi_opv4upr

# use this command if we do not use AXI for register control
adi_ip_properties_lite axi_opv4upr


adi_add_bus "s_axis" "slave" \
        "xilinx.com:interface:axis_rtl:1.0" \
        "xilinx.com:interface:axis:1.0" \
        [list \
		{"s_axis_ready" "TREADY"} \
          	{"s_axis_valid" "TVALID"} \
          	{"s_axis_data" "TDATA"} \
          	{"s_axis_strb" "TSTRB"} \
          	{"s_axis_keep" "TKEEP"} \
          	{"s_axis_user" "TUSER"} \
          	{"s_axis_id" "TID"} \
          	{"s_axis_dest" "TDEST"} \
          	{"s_axis_last" "TLAST"}\
	]

adi_add_bus_clock "s_axis_aclk" "s_axis"



adi_add_bus "m_axis" "master" \
	"xilinx.com:interface:axis_rtl:1.0" \
  	"xilinx.com:interface:axis:1.0" \
  	[list \
		{"m_axis_ready" "TREADY"} \
    		{"m_axis_valid" "TVALID"} \
    		{"m_axis_data" "TDATA"} \
  	]


set_property name "axi_opv4upr" [ipx::current_core]
set_property display_name "IQ Modification Station" [ipx::current_core]
set_property description "IQ Modification Station" [ipx::current_core]


#set cc [ipx::current_core]

ipx::save_core [ipx::current_core]

