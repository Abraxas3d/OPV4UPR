onbreak resume
onerror resume
vsim -voptargs=+acc work.opv_modulator_tb

add wave sim:/opv_modulator_tb/u_opv_modulator/clk
add wave sim:/opv_modulator_tb/u_opv_modulator/reset
add wave sim:/opv_modulator_tb/u_opv_modulator/clk_enable
add wave sim:/opv_modulator_tb/u_opv_modulator/bo_t_bitstream
add wave sim:/opv_modulator_tb/u_opv_modulator/be_t_bitstream_delayed
add wave sim:/opv_modulator_tb/u_opv_modulator/ce_out
add wave sim:/opv_modulator_tb/u_opv_modulator/check_bo_t
add wave sim:/opv_modulator_tb/check_bo_t_ref
add wave sim:/opv_modulator_tb/u_opv_modulator/tx_I
add wave sim:/opv_modulator_tb/tx_I_ref
add wave sim:/opv_modulator_tb/u_opv_modulator/tx_q
add wave sim:/opv_modulator_tb/tx_q_ref
add wave sim:/opv_modulator_tb/u_opv_modulator/check_be_t
add wave sim:/opv_modulator_tb/check_be_t_ref
run -all
