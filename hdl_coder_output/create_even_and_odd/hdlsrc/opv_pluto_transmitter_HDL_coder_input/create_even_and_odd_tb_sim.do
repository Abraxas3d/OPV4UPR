onbreak resume
onerror resume
vsim -voptargs=+acc work.create_even_and_odd_tb

add wave sim:/create_even_and_odd_tb/u_create_even_and_odd/In1_0
add wave sim:/create_even_and_odd_tb/u_create_even_and_odd/In1_1
add wave sim:/create_even_and_odd_tb/u_create_even_and_odd/bo_bitstream
add wave sim:/create_even_and_odd_tb/bo_bitstream_ref
add wave sim:/create_even_and_odd_tb/u_create_even_and_odd/be_bitstream
add wave sim:/create_even_and_odd_tb/be_bitstream_ref
run -all
