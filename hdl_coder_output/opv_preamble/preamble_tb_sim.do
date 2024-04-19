onbreak resume
onerror resume
vsim -voptargs=+acc work.preamble_tb

add wave sim:/preamble_tb/u_preamble/clk
add wave sim:/preamble_tb/u_preamble/reset
add wave sim:/preamble_tb/u_preamble/clk_enable
add wave sim:/preamble_tb/u_preamble/data
add wave sim:/preamble_tb/u_preamble/PTT
add wave sim:/preamble_tb/u_preamble/ce_out
add wave sim:/preamble_tb/u_preamble/Out1
add wave sim:/preamble_tb/Out1_ref
run -all
