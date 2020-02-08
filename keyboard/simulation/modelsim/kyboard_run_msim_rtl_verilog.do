transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+H:/my_design_fpga/keyboard {H:/my_design_fpga/keyboard/ps2_keyboard.v}

vlog -vlog01compat -work work +incdir+H:/my_design_fpga/keyboard/simulation/modelsim {H:/my_design_fpga/keyboard/simulation/modelsim/ps2_keyboard.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  ps2_keyboard_vlg_tst

add wave *
view structure
view signals
run -all