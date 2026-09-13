

components = {

	km5 {}, -- mag-corr gauge 1
	
	km5 { -- mag-corr gauge 2
		-- power
		bus27_volt = globalPropertyf("tu-154/elec/bus27_volt_right"),  -- 27 V bus voltage
		bus36_volt = globalPropertyf("tu-154/elec/bus36_volt_right"), -- 36 V bus voltage
		-- controls
		km5_knob = globalPropertyf("tu-154/gauges/eng/km5_knob_2"), -- KM-5 knob
		fail = globalPropertyf("tu-154/failures/tks_km2_fail"),
		-- results
		km5_scale = globalPropertyf("tu-154/gauges/eng/km5_scale_2"), -- KM-5 scale rotation
		km5_needle = globalPropertyf("tu-154/gauges/eng/km5_needle_2"), -- KM5 needle

		course_mk = globalPropertyf("tu-154/tks/course_mk_2"), -- heading on MK5
		
		km5_cc = globalPropertyf("tu-154/tks/km5_2_cc"), -- KM-5 current draw
	},
	
	gyro {}, -- both gyros
	ush3 {}, -- big compas gauge
	bgmk {}, -- gyro-magnetic unit
	tks_panel {}, -- panel
	tks_fails {},
	
}