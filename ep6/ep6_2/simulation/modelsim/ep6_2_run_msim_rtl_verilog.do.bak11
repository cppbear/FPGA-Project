transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep6/ep6_2 {F:/FPGA Project/ep6/ep6_2/my_clock.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep6/ep6_2 {F:/FPGA Project/ep6/ep6_2/my_hex.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep6/ep6_2 {F:/FPGA Project/ep6/ep6_2/LFSR.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep6/ep6_2 {F:/FPGA Project/ep6/ep6_2/ep6_2.v}

vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep6/ep6_2/simulation/modelsim {F:/FPGA Project/ep6/ep6_2/simulation/modelsim/ep6_2.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  ep6_2_vlg_tst

add wave *
view structure
view signals
run -all
