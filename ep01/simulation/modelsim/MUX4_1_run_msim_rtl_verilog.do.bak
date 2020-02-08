transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep01 {F:/FPGA Project/ep01/MUX4_1.v}

vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep01/simulation/modelsim {F:/FPGA Project/ep01/simulation/modelsim/MUX4_1.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  MUX4_1_vlg_tst

add wave *
view structure
view signals
run -all
