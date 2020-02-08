transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/TEST {F:/FPGA Project/TEST/my_first.v}

vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/TEST/simulation/modelsim {F:/FPGA Project/TEST/simulation/modelsim/my_first.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  my_first_vlg_tst

add wave *
view structure
view signals
run -all
