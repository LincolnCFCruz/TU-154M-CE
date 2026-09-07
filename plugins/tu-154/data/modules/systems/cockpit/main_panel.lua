-- this is actual panel. here will be placed all gauges for panel.png and 2D popup panels

size = { 2048, 2048 }


components = {
	
--[[	
	test_hud {
	
		position = {1600, 0, 400, 400},
	
	},
--]]	
	vers {},
	
	sc_controls {}, -- control through SmartCopilot
	
	achs1 {}, -- clock
	clock24 {}, -- clock on the rear side panel
	mech_aneroid {}, -- diaphragm instruments
	svs {}, -- SVS system
	termo {}, -- thermometers
	uvid_15fk {}, -- feet altimeter
	mach_meters {}, -- Mach meters
	uap14 {}, -- AUASP indicator
	eup53 {}, -- turn indicator
	agr {}, -- standby artificial horizon
	pkp {}, -- left artificial horizon
	pkp { -- right artificial horizon
		pitch_corr_hdl = globalPropertyf("tu-154/gauges/ahz/pitch_corr_R"), -- AGR pitch correction, + right
		pkp_on = globalPropertyi("tu-154/switchers/ovhd/pkp_right_on"), -- switch
		
		pkp_fail = globalPropertyi("tu-154/bkk/pkp_fail_right"), -- signal from the BKK - PKP failure
		bus27_volt = globalPropertyf("tu-154/elec/bus27_volt_right"), -- power
		bus36_volt = globalPropertyf("tu-154/elec/bus36_volt_right"), -- power
		
		res_pitch = globalPropertyf("tu-154/gauges/ahz/pitch_R"), -- AGR pitch, + nose up
		pitch_int = globalPropertyf("tu-154/gyro/ahz_pitch_int_R"), -- AGR pitch, + up
		res_roll = globalPropertyf("tu-154/gauges/ahz/roll_R"), -- AGR roll, + right
		res_roll_bkk = globalPropertyf("tu-154/bkk/pkp_roll_right"), -- bank for the BKK + to the right
		ahz_flag = globalPropertyf("tu-154/gauges/ahz/ahz_flag_R"), -- AGR pitch, + nose up
		
		course_plank = globalPropertyf("tu-154/gauges/ahz/course_plank_R"), -- captain's AGD course bar + to the right
		gs_plank = globalPropertyf("tu-154/gauges/ahz/gs_plank_R"), -- captain's AGD glideslope bar + up
		
		dir_roll = globalPropertyf("tu-154/gauges/ahz/dir_roll_R"), -- captain's AGD roll director + to the right
		dir_pitch = globalPropertyf("tu-154/gauges/ahz/dir_pitch_R"), -- captain's AGD pitch director + up
		
		dir_roll_flag = globalPropertyf("tu-154/gauges/ahz/dir_roll_flag_R"), -- captain's AGD roll director failure flag
		dir_pitch_flag = globalPropertyf("tu-154/gauges/ahz/dir_pitch_flag_R"), -- captain's AGD pitch director failure flag

		
		absu_pnp_mode = globalPropertyi("tu-154/absu/absu_pnp_mode_2"), -- PNP display mode. 0 = off, 1 = NVU, 2 = VOR1, 3 = VOR2, 4 = landing system
		absu_at_dif = globalPropertyf("tu-154/absu_at_dif_right"), -- speed difference for the PKP indication
		speed_plank = globalPropertyf("tu-154/gauges/ahz/speed_plank_R"), -- copilot's AGD rate of change + up
		
		power_cc = globalPropertyf("tu-154/bkk/pkp_right_power_cc"), -- PKP current draw
		fail = globalPropertyi("sim/operation/failures/rel_cop_ahz"),
		
	},
	mgv {}, -- monitoring artificial horizon without any indication output
	bkk {}, -- BKK bank monitoring unit
	
	-- electronic altimeter
	vbe_altimeter { -- left electronic altimeter
		position = {733, 839, 424, 424},
	},
	
	-- electronic altimeter
	vbe_altimeter { -- right electronic altimeter
		position = {1166, 839, 424, 424},
		gauge_num = 1,
		static_fail = globalPropertyi("sim/operation/failures/rel_static2"),
		pressure = globalPropertyf("tu-154/gauges/alt/vbe_press_right"),  -- pressure in hPa
		brt_knob = globalPropertyf("tu-154/gauges/alt/vbe_brt_right"),  -- brightness knob
		press_knob = globalPropertyi("tu-154/gauges/alt/vbe_press_knob_right"),  -- pressure knob
		fl_knob = globalPropertyi("tu-154/gauges/alt/vbe_fl_knob_right"),  -- flight level knob
		mode_button = globalPropertyi("tu-154/gauges/alt/vbe_mode_but_right"),  -- mode button
		bus27_volt = globalPropertyf("tu-154/elec/bus27_volt_right"), -- 27 V bus voltage
		bus115_volt = globalPropertyf("tu-154/elec/bus115_3_volt"), -- 115 V bus voltage
		vbe_on = globalPropertyi("tu-154/switchers/ovhd/vbe_2_on"),  -- power switcher
		vbe_mode = globalPropertyi("tu-154/gauges/alt/vbe_mode_right"),  -- meters/feet mode
		vbe_std = globalPropertyi("tu-154/gauges/alt/vbe_std_right"),  -- standard pressure selection
		alt_mtr = globalPropertyf("tu-154/gauges/alt/vbe_alt_right"),  -- indicated altitude in meters
		vbe_flightlevel = globalPropertyf("tu-154/gauges/alt/vbe_flightlevel_right"),  -- flight level
		fail = globalPropertyi("sim/operation/failures/rel_cop_alt"), -- 
	},
	
	rv5 {},
	
	rv5 {
		altitude = globalPropertyf("sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_copilot"),  -- altitude, measured by gauge
		dh_set = globalPropertyf("tu-154/gauges/alt/radioalt_dh_right"),  -- DH angle
		test_btn = globalPropertyf("tu-154/gauges/alt/radioalt_button_right"),  -- DH angle
		rv_on = globalPropertyf("tu-154/switchers/ovhd/rv5_2_on"),  -- switcher
		bus27_volt = globalPropertyf("tu-154/elec/bus27_volt_right"),
		bus115_volt = globalPropertyf("tu-154/elec/bus115_3_volt"),
		rv_angle = globalPropertyf("tu-154/gauges/alt/radioalt_needle_right"),  -- RV needle
		rv_flag = globalPropertyf("tu-154/gauges/alt/radioalt_flag_right"),  -- RV flag
		rv_lamp = globalPropertyf("tu-154/lights/small/rv5_right_dh"),  -- RV lamp
		rv5_dh_signal = globalPropertyi("tu-154/misc/rv5_dh_signal_right"),
		rv_cc = globalPropertyf("tu-154/elec/rv5_right_cc"),  -- RV current
		rv5_alt = globalPropertyf("tu-154/misc/rv5_alt_right"),  -- altitude on the right altimeter
		rv_fail = globalPropertyi("tu-154/failures/rv2_fail"),  -- fail
	},
	
	
	msrp_clock { -- MSRP clock
		position = {12, 762, 195, 84},
	},
	
	door_panel {}, -- door and hatch indicators
	
	tcas {
		position = {0, 0, 2048, 2048},
	},

	taws {
		position = {1034, 1270, 1000, 770},
	},

	tks {},
	
	pnp {}, -- captain's PNP
	
	pnp { -- copilot's PNP
		gauge_num = 1, -- right
		course_ga = globalPropertyf("tu-154/tks/course_ga_2"), -- heading to the gyro unit
		course_bgmk = globalPropertyf("tu-154/tks/course_bgmk_2"), -- heading on the BGMK
		gyro_fail = globalPropertyi("tu-154/tks/fail_right"), -- failure flag
		
		obs = globalPropertyf("tu-154/gauges/compas/pkp_obs_set_R"),  -- set the course
		obs_side = globalPropertyf("tu-154/gauges/compas/pkp_obs_set_L"),  -- set the course
		
		-- controls
		pnp_mode = globalPropertyi("tu-154/switchers/ovhd/curs_pnp_mode_2"), -- PNP heading mode. 0 = GMK, 1 = GPK
		pkp_obs_knob = globalPropertyf("tu-154/gauges/compas/pkp_obs_knob_R"), -- heading tuning knob

		-- results
		pkp_gyro_course = globalPropertyf("tu-154/gauges/compas/pkp_gyro_course_R"), -- PKP gyro heading
		pkp_obs = globalPropertyf("tu-154/gauges/compas/pkp_obs_R"), -- flight heading on the PKP
		pkp_helper_course = globalPropertyf("tu-154/gauges/compas/pkp_helper_course_R"), -- heading set by the yellow needle on the PKP
		pkp_slip_angle = globalPropertyf("tu-154/gauges/compas/pkp_slip_angle_R"), -- drift angle on the PKP
		pkp_course_plank = globalPropertyf("tu-154/gauges/compas/pkp_course_plank_R"), -- captain's PKP course bar + bar deflected to the right
		pkp_gs_plank = globalPropertyf("tu-154/gauges/compas/pkp_gs_plank_R"), -- captain's PKP glideslope bar + bar deflected up
		pkp_gs_flag = globalPropertyi("tu-154/gauges/compas/pkp_gs_flag_R"), -- glideslope bar failure flag
		pkp_course_flag = globalPropertyi("tu-154/gauges/compas/pkp_course_flag_R"), -- course bar failure flag
		pkp_main_flag = globalPropertyi("tu-154/gauges/compas/pkp_main_flag_R"), -- heading failure flag
		pkp_obs_flag = globalPropertyi("tu-154/gauges/compas/pkp_obs_flag_R"), -- heading counter failure flag
		pkp_obs_one = globalPropertyf("tu-154/gauges/compas/pkp_obs_one_R"), -- heading counter. units
		pkp_obs_ten = globalPropertyf("tu-154/gauges/compas/pkp_obs_ten_R"), -- heading counter. tens
		pkp_obs_hundr = globalPropertyf("tu-154/gauges/compas/pkp_obs_hundr_R"), -- heading counter. hundreds
		
		absu_pnp_mode = globalPropertyi("tu-154/absu/absu_pnp_mode_2"), -- PNP display mode. 0 = off, 1 = NVU, 2 = VOR1, 3 = VOR2, 4 = landing system
		absu_pnp_mode_2 = globalPropertyi("tu-154/absu/absu_pnp_mode_1"), -- PNP display mode. 0 = off, 1 = NVU, 2 = VOR1, 3 = VOR2, 4 = landing system
	
		pnp_sp_lamp = globalPropertyf("tu-154/lights/small/pnp_sp_right"), -- 
		pnp_vor_lamp = globalPropertyf("tu-154/lights/small/pnp_vor_right"), -- 
		pnp_nv_lamp = globalPropertyf("tu-154/lights/small/pnp_nv_right"), -- 
		
		bus27_volt = globalPropertyf("tu-154/elec/bus27_volt_left"),
		bus36_volt = globalPropertyf("tu-154/elec/bus36_volt_right"),
		fail_ga = globalPropertyf("sim/operation/failures/rel_cop_dgy"),
		tks_on = globalPropertyi("tu-154/switchers/ovhd/tks_on_2"), 
	
	}, 
	
	rmi {}, -- radiocompas Cpt
	
	rmi {
	
		-- sources
		course_bgmk = globalPropertyf("tu-154/tks/course_bgmk_1"), -- heading on the BGMK
		-- power
		bus36_volt = globalPropertyf("tu-154/elec/bus36_volt_pts250_2"), -- 36 V bus voltage
		-- results
		radiocomp_scale = globalPropertyf("tu-154/gauges/compas/radiocomp_scale_right"), -- heading scale on the radio compass
		bearing_1 = globalPropertyf("tu-154/gauges/compas/bearing_1_right"), -- radio compass needle 1 direction
		bearing_2 = globalPropertyf("tu-154/gauges/compas/bearing_2_right"), -- radio compass needle 2 direction
		source_1_switch = globalPropertyi("tu-154/gauges/compas/source_1_switch_right"), -- radio compass needle 1 selector. 0 - blank, 1 - ARK1, 2 - ARK2, 3 - VOR1, 4 - VOR2, 5 - RSBN
		source_2_switch = globalPropertyi("tu-154/gauges/compas/source_2_switch_right"), -- radio compass needle 2 selector
	
	},
	
	diss {}, -- dopler's system
	
	usvp {}, -- true and ground speed
	
	rsbn {}, -- short range radio navigatin system
	
	radio { -- radio panel
		position = {0, 0, 2048, 2048},
	
	},
	
	nvu {}, -- navigation calculator
	
	absu {}, -- autopilot
	
	misc_lamps {}, -- various lamps
	
	radar {
		position = {0, 0, 2048, 2048},
	},

	vent {},
	
	water_panel {},
	
	gns430 {},
	
	--ins_test {},
	
	misc_fails {},
	
}