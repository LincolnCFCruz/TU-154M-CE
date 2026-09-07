-- this is TCAS root
size = {2048, 2048}


components = {
	
	tcas_panel {
		position = {0, 0, size[1], size[2]},
	},

	so72_panel {
		position = {23, 1046, 440, 167},
	},
	
	tcas_logic {
		position = {0, 0, size[1], size[2]},
	},
	
	tcas_gau {
		position = {11, 11, 482, 530},
	},

	tcas_gau {
		position = {518, 11, 482, 530},
		var_on = globalPropertyi("tu-154/switchers/ovhd/var_right"),  -- overhead. left variometer
		bus27_volt = globalPropertyf("tu-154/elec/bus27_volt_right"), -- 27 V bus voltage
		bus115_volt = globalPropertyf("tu-154/elec/bus115_3_volt"), -- 115 V bus voltage
		vsi_brt = globalPropertyf("tu-154/gauges/vsi/vsi_brt_right"),  -- brightness
		vvi_int = globalPropertyf("tu-154/gauges/vvi_right"), -- VVI
		vvi_fail = globalPropertyi("sim/operation/failures/rel_cop_vvi"), -- fail
	},
	
	
	

}