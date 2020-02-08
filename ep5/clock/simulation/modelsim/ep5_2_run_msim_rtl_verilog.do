transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep5/clock {F:/FPGA Project/ep5/clock/my_clock.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep5/clock {F:/FPGA Project/ep5/clock/my_hex.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep5/clock {F:/FPGA Project/ep5/clock/clock_second.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep5/clock {F:/FPGA Project/ep5/clock/clock_minute.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep5/clock {F:/FPGA Project/ep5/clock/clock_hour.v}
vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep5/clock {F:/FPGA Project/ep5/clock/ep5_2.v}

vlog -vlog01compat -work work +incdir+F:/FPGA\ Project/ep5/clock/simulation/modelsim {F:/FPGA Project/ep5/clock/simulation/modelsim/ep5_2.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  ep5_2_vlg_tst

add wave *
view structure
view signals
run -all
