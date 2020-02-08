transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep8/ep8_2 {F:/FPGA Project/ep8/ep8_2/my_clock.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep8/ep8_2 {F:/FPGA Project/ep8/ep8_2/keyboard.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep8/ep8_2 {F:/FPGA Project/ep8/ep8_2/ASCII.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep8/ep8_2 {F:/FPGA Project/ep8/ep8_2/ROM1.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep8/ep8_2 {F:/FPGA Project/ep8/ep8_2/ROM2.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep8/ep8_2 {F:/FPGA Project/ep8/ep8_2/count.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep8/ep8_2 {F:/FPGA Project/ep8/ep8_2/code.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep8/ep8_2 {F:/FPGA Project/ep8/ep8_2/ep8_2.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep8/ep8_2 {F:/FPGA Project/ep8/ep8_2/ps2_keyboard.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep8/ep8_2 {F:/FPGA Project/ep8/ep8_2/my_hex.v}

vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep8/ep8_2/simulation/modelsim {F:/FPGA Project/ep8/ep8_2/simulation/modelsim/ep8_2.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  ep8_2_vlg_tst

add wave *
view structure
view signals
run -all
