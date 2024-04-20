# Automatically generated TCL script for integration of FPGA Data Capture IP for Versal devices
add_files ./versal
import_files -norecurse ./hdlverifier_capture_comparator.vhd
import_files -norecurse ./hdlverifier_capture_data.vhd
import_files -norecurse ./hdlverifier_capture_trigger_combine.vhd
import_files -norecurse ./hdlverifier_capture_trigger_condition.vhd
import_files -norecurse ./hdlverifier_data_jtag_rd.vhd
import_files -norecurse ./hdlverifier_dcram.vhd
import_files -norecurse ./hdlverifier_jtag_register.vhd
import_files -norecurse ./hdlverifier_synchronizer.vhd
import_files -norecurse ./versal/FPGADatacapture_versal.xdc
# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_1
# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name
# Creating design if needed
set errMsg ""
set nRet 0
set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]
if { ${design_name} eq "" } {
# USE CASES:
#    1) Design_name not set
set errMsg "Please set the variable <design_name> to a non-empty value."
set nRet 1
} elseif { ${cur_design} ne "" } {
if { $cur_design ne $design_name } {
common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
set design_name [get_property NAME $cur_design]
}
common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."
} else {
# USE CASES:
#    8) No opened design, design_name not in project.
#    9) Current opened design, has components, but diff names, design_name not in project.
common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."
create_bd_design $design_name
common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
current_bd_design $design_name
}
# Create interface ports
# Create ports
# Create instance: FPGADataCapture, and set properties
set block_name FPGADataCapture_versal
set block_cell_name FPGADataCapture
set FPGADataCapture [create_bd_cell -type module -reference $block_name $block_cell_name]
# Create instance: versal_cips_0, and set properties
set bd_cells [get_bd_cell *]
for { set a 0}  {$a <= [llength $bd_cells]} {incr a} {
	set bd_cell_vlnv [get_property VLNV [lindex $bd_cells $a] -quiet]
	if { [string match "*xilinx.com:ip:versal_cips:*.*" $bd_cell_vlnv] } {
		break
	}
}
if {$a <= [llength $bd_cells]} {
	set versal_cips_0 [lindex $bd_cells $a]
} else {
	# Create instance: versal_cips_0, and set properties
	set versal_cips_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:versal_cips:*.* versal_cips_0 ]
}
set_property -dict [list CONFIG.PS_PMC_CONFIG { PS_USE_BSCAN_USER2 1 } ] $versal_cips_0 -quiet
# Create port connections
connect_bd_net -net FPGADataCapture_versal_tdo [get_bd_pins FPGADataCapture/versal_tdo] [get_bd_pins $versal_cips_0/BSCAN_USER2_tdo]
connect_bd_net -net versal_cips_0_bscan_user2_usr_capture [get_bd_pins FPGADataCapture/versal_capture] [get_bd_pins $versal_cips_0/BSCAN_USER2_capture]
connect_bd_net -net versal_cips_0_bscan_user2_usr_reset [get_bd_pins FPGADataCapture/versal_jtag_reset] [get_bd_pins $versal_cips_0/BSCAN_USER2_reset]
connect_bd_net -net versal_cips_0_bscan_user2_usr_sel [get_bd_pins FPGADataCapture/versal_sel] [get_bd_pins $versal_cips_0/BSCAN_USER2_sel]
connect_bd_net -net versal_cips_0_bscan_user2_usr_shift [get_bd_pins FPGADataCapture/versal_shift] [get_bd_pins $versal_cips_0/BSCAN_USER2_shift]
connect_bd_net -net versal_cips_0_bscan_user2_usr_tck [get_bd_pins FPGADataCapture/versal_tck] [get_bd_pins $versal_cips_0/BSCAN_USER2_tck]
connect_bd_net -net versal_cips_0_bscan_user2_usr_tdi [get_bd_pins FPGADataCapture/versal_tdi] [get_bd_pins $versal_cips_0/BSCAN_USER2_tdi]
connect_bd_net -net versal_cips_0_bscan_user2_usr_update [get_bd_pins FPGADataCapture/versal_update] [get_bd_pins $versal_cips_0/BSCAN_USER2_update]
# Create address segments
save_bd_design
