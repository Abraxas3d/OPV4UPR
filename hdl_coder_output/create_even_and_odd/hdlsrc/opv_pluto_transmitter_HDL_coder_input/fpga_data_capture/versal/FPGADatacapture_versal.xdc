# Automatically generated constaint file for FPGA Data Capture IP
# Add this file to your Vivado project
create_clock -period 30.000 -name versal_tck -waveform {0.000 15.000} [get_nets */FPGADataCapture/inst/u_hdlverifier_capture_core_versal/register_manager/t2/versal_tck]
set_clock_groups -asynchronous -group [get_clocks */FPGADataCapture/inst/clk] -group [get_clocks versal_tck]
