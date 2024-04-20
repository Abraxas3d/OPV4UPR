
/*-- ----------------------------------------------
-- File Name: hdlverifier_jtag_vendor_ip_versal.v
-- Created:   20-Apr-2024 21:16:04
-- Copyright  2024 MathWorks, Inc.
-- ----------------------------------------------*/


/*-- ----------------------------------------------
-- Copyright  2022 MathWorks, Inc.
-- ----------------------------------------------*/

module hdlverifier_jtag_vendor_ip_versal
#(parameter JTAG_ID=2)
(
	output tdi,
	input tdo,
	output tck,
	output jtag_reset,
	output capture_dr,
    output shift_dr,
    output update_dr,
// Versal Bscan signals
    input  versal_capture,
    input  versal_jtag_reset,
    input  versal_sel,
    input  versal_shift,
    input  versal_tck,
    input  versal_tdi,
    input  versal_update,
    output versal_tdo
);

wire sel;
wire cdr;
wire sdr;
wire udr;

assign capture_dr   = sel && cdr;
assign shift_dr     = sel && sdr;
assign update_dr    = sel && udr;

assign sel = versal_sel;
assign cdr = versal_capture;
assign sdr = versal_shift;
assign udr = versal_update;
assign udr = versal_update;
assign jtag_reset = versal_jtag_reset;
assign tdi = versal_tdi;
assign tck = versal_tck;
assign versal_tdo = tdo; 


//versal_cips_0 u_versal_cips (
//  .bscan_user3_usr_capture(cdr),  // output wire bscan_user3_usr_capture
//  .bscan_user3_usr_drck(),        // output wire bscan_user3_usr_drck
//  .bscan_user3_usr_reset(jtag_reset),      // output wire bscan_user3_usr_reset
//  .bscan_user3_usr_runtest(),  // output wire bscan_user3_usr_runtest
//  .bscan_user3_usr_sel(sel),          // output wire bscan_user3_usr_sel
//  .bscan_user3_usr_shift(sdr),      // output wire bscan_user3_usr_shift
//  .bscan_user3_usr_tck(tck),          // output wire bscan_user3_usr_tck
//  .bscan_user3_usr_tdi(tdi),          // output wire bscan_user3_usr_tdi
//  .bscan_user3_usr_tms(),          // output wire bscan_user3_usr_tms
//  .bscan_user3_usr_tdo(tdo),          // input wire bscan_user3_usr_tdo
//  .bscan_user3_usr_update(udr)    // output wire bscan_user3_usr_update
//);

endmodule