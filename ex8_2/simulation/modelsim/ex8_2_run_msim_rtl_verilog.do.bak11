transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ex8_2 {F:/FPGA Project/ex8_2/ex8_2.v}

vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ex8_2 {F:/FPGA Project/ex8_2/out_put.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ex8_2 {F:/FPGA Project/ex8_2/ps2_keyboard_model.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ex8_2/simulation/modelsim {F:/FPGA Project/ex8_2/simulation/modelsim/ex8_2.vt}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ex8_2 {F:/FPGA Project/ex8_2/ps2_keyboard.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  ex8_2_vlg_tst

add wave *
view structure
view signals
run -all
