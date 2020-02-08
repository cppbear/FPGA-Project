transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep9/ep9_2 {F:/FPGA Project/ep9/ep9_2/picture.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep9/ep9_2 {F:/FPGA Project/ep9/ep9_2/ROM.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep9/ep9_2 {F:/FPGA Project/ep9/ep9_2/ep9_2.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep9/ep9_2 {F:/FPGA Project/ep9/ep9_2/clkgen.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep9/ep9_2 {F:/FPGA Project/ep9/ep9_2/vga_ctrl.v}

vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep9/ep9_2/simulation/modelsim {F:/FPGA Project/ep9/ep9_2/simulation/modelsim/ep9_2.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  ep9_2_vlg_tst

add wave *
view structure
view signals
run -all
