-- control panel for KSKV system

-- controls on panel
defineProperty("cabin_sel", globalPropertyi("tu-154/switchers/airbleed/cabin_sel")) -- cabin selection
defineProperty("cockpit_temp_set", globalPropertyi("tu-154/switchers/airbleed/cockpit_temp_set")) -- cockpit temperature setting
defineProperty("cabin1_temp_set", globalPropertyi("tu-154/switchers/airbleed/cabin1_temp_set")) -- cabin temperature setting
defineProperty("cabin2_temp_set", globalPropertyi("tu-154/switchers/airbleed/cabin2_temp_set")) -- cabin temperature setting
defineProperty("cockpit_mode_set", globalPropertyi("tu-154/switchers/airbleed/cockpit_mode_set")) -- heating mode setting. 0 - neutral. 1 - auto, 2 - cold, 3 - hot
defineProperty("cabin1_mode_set", globalPropertyi("tu-154/switchers/airbleed/cabin1_mode_set")) -- heating mode setting
defineProperty("cabin2_mode_set", globalPropertyi("tu-154/switchers/airbleed/cabin2_mode_set")) -- heating mode setting
defineProperty("heat_close", globalPropertyi("tu-154/switchers/airbleed/heat_close")) -- heating stopped
defineProperty("heat_close_cap", globalPropertyi("tu-154/switchers/airbleed/heat_close_cap")) -- heating stopped

defineProperty("left_sys_temp_set", globalPropertyi("tu-154/switchers/airbleed/left_sys_temp_set")) -- left duct temperature setting
defineProperty("right_sys_temp_set", globalPropertyi("tu-154/switchers/airbleed/right_sys_temp_set")) -- right duct temperature setting
defineProperty("left_sys_mode_set", globalPropertyi("tu-154/switchers/airbleed/left_sys_mode_set")) -- left duct mode setting
defineProperty("right_sys_mode_set", globalPropertyi("tu-154/switchers/airbleed/right_sys_mode_set")) -- right duct mode setting
defineProperty("ground_cond_on", globalPropertyi("tu-154/switchers/airbleed/ground_cond_on")) -- ground air conditioning
defineProperty("ground_cond_on_cap", globalPropertyi("tu-154/switchers/airbleed/ground_cond_on_cap")) -- ground air conditioning
defineProperty("skv_faster_work", globalPropertyi("tu-154/switchers/airbleed/skv_faster_work")) -- cabin cooling, 0 - off, +1 - accelerated heating modes
defineProperty("skv_faster_work_cap", globalPropertyi("tu-154/switchers/airbleed/skv_faster_work_cap")) -- cabin cooling, cover
defineProperty("sys_temp_select", globalPropertyi("tu-154/switchers/airbleed/sys_temp_select")) -- thermometer source selection. 0 - door heating, 1 - crew, 2 - cabin 1, 3 - cabin 2, 4 - left duct, 5 - right duct

defineProperty("psvp_left_on", globalPropertyi("tu-154/switchers/airbleed/psvp_left_on")) -- PSVP left
defineProperty("psvp_right_on", globalPropertyi("tu-154/switchers/airbleed/psvp_right_on")) -- PSVP right
defineProperty("psvp_left_on_cap", globalPropertyi("tu-154/switchers/airbleed/psvp_left_on_cap")) -- PSVP left
defineProperty("psvp_right_on_cap", globalPropertyi("tu-154/switchers/airbleed/psvp_right_on_cap")) -- PSVP right
defineProperty("air_valve_left", globalPropertyi("tu-154/switchers/airbleed/air_valve_left")) -- pressurisation valves. -1 = closed, 0 = neutral, +1 = open
defineProperty("air_valve_right", globalPropertyi("tu-154/switchers/airbleed/air_valve_right")) -- pressurisation valves. -1 = closed, 0 = neutral, +1 = open
defineProperty("air_valve_both", globalPropertyi("tu-154/switchers/airbleed/air_valve_both")) -- pressurisation valves. -1 = closed, 0 = neutral, +1 = open
defineProperty("emerg_decompress", globalPropertyi("tu-154/switchers/airbleed/emerg_decompress")) -- pressure release
defineProperty("emerg_decompress_cap", globalPropertyi("tu-154/switchers/airbleed/emerg_decompress_cap")) -- pressure release
defineProperty("eng_valve_1", globalPropertyi("tu-154/switchers/airbleed/eng_valve_1")) -- engine bleed air
defineProperty("eng_valve_2", globalPropertyi("tu-154/switchers/airbleed/eng_valve_2")) -- engine bleed air
defineProperty("eng_valve_3", globalPropertyi("tu-154/switchers/airbleed/eng_valve_3")) -- engine bleed air
defineProperty("dubler_on", globalPropertyi("tu-154/switchers/airbleed/dubler_on")) -- standby
defineProperty("dubler_on_cap", globalPropertyi("tu-154/switchers/airbleed/dubler_on_cap")) -- standby


defineProperty("sard_disable", globalPropertyi("tu-154/switchers/eng/sard_disable")) -- air dump valve shutoff
defineProperty("sard_disable_cap", globalPropertyi("tu-154/switchers/eng/sard_disable_cap")) -- air dump valve shutoff

defineProperty("door_heat", globalPropertyi("tu-154/switchers/eng/door_heat")) -- door heating


-- buttons
defineProperty("lamp_test_srd", globalPropertyi("tu-154/buttons/lamp_test_srd")) -- lamp test
defineProperty("lamp_test_front", globalPropertyi("tu-154/buttons/lamp_test_front")) -- front panel lamp test button	0
defineProperty("day_night_set", globalPropertyf("tu-154/lights/day_night_set")) -- day/night switch. 0 = day, 1 = night. dims the annunciator lamps.

defineProperty("srd_buzzer_test", globalPropertyf("tu-154/buttons/eng/srd_buzzer_test")) -- SRD siren test


-- lamps
defineProperty("skv_overheat", globalPropertyf("tu-154/lights/small/skv_overheat")) -- SKV overheat
defineProperty("skv_overpress_left", globalPropertyf("tu-154/lights/small/skv_overpress_left")) -- overpressure
defineProperty("skv_overpress_right", globalPropertyf("tu-154/lights/small/skv_overpress_right")) -- overpressure
defineProperty("skv_tail_temp", globalPropertyf("tu-154/lights/small/skv_tail_temp")) -- tail compartment temperature high

defineProperty("skv_bleed_fail_1", globalPropertyf("tu-154/lights/small/skv_bleed_fail_1")) -- bleed air failure
defineProperty("skv_bleed_fail_2", globalPropertyf("tu-154/lights/small/skv_bleed_fail_2")) -- bleed air failure
defineProperty("skv_bleed_fail_3", globalPropertyf("tu-154/lights/small/skv_bleed_fail_3")) -- bleed air failure

defineProperty("skv_bleed_closed_1", globalPropertyf("tu-154/lights/small/skv_bleed_closed_1")) -- bleed air closed
defineProperty("skv_bleed_closed_2", globalPropertyf("tu-154/lights/small/skv_bleed_closed_2")) -- bleed air closed
defineProperty("skv_bleed_closed_3", globalPropertyf("tu-154/lights/small/skv_bleed_closed_3")) -- bleed air closed


defineProperty("srd_low_press", globalPropertyf("tu-154/lights/small/srd_low_press")) -- cabin pressure low
defineProperty("srd_overpress", globalPropertyf("tu-154/lights/small/srd_overpress")) -- cabin overpressure
defineProperty("cockpit_p_low", globalPropertyf("tu-154/lights/cockpit_p_low")) -- Cabin P low




-- gauges
defineProperty("cockpit_temp_gau", globalPropertyf("tu-154/gauges/airbleed/cockpit_temp")) -- cabin temperature
defineProperty("cabin_temp_gau", globalPropertyf("tu-154/gauges/airbleed/cabin_temp")) -- cabin temperature
defineProperty("system_temp", globalPropertyf("tu-154/gauges/airbleed/system_temp")) -- duct temperature
defineProperty("air_flow_1", globalPropertyf("tu-154/gauges/airbleed/air_flow_1")) -- air flow. angle
defineProperty("air_flow_2", globalPropertyf("tu-154/gauges/airbleed/air_flow_2")) -- air flow. angle


-- sources
defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time")) -- flight time

defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right"))

defineProperty("eng_airvalve_1", globalPropertyf("tu-154/bleed/eng_airvalve_1")) -- engine bleed air valve opening
defineProperty("eng_airvalve_2", globalPropertyf("tu-154/bleed/eng_airvalve_2")) -- engine bleed air valve opening
defineProperty("eng_airvalve_3", globalPropertyf("tu-154/bleed/eng_airvalve_3")) -- engine bleed air valve opening

defineProperty("air_usage_L", globalPropertyf("tu-154/bleed/air_usage_L")) -- left air flow
defineProperty("air_usage_R", globalPropertyf("tu-154/bleed/air_usage_R")) -- right air flow

defineProperty("door_heat_tube_t", globalPropertyf("tu-154/bleed/door_heat_tube_t")) -- temperature in the door heating duct
defineProperty("cockpit_tube_t", globalPropertyf("tu-154/bleed/cockpit_tube_t")) -- temperature in the duct to the cockpit
defineProperty("cabin1_tube_t", globalPropertyf("tu-154/bleed/cabin1_tube_t")) -- temperature in the duct to cabin 1
defineProperty("cabin2_tube_t", globalPropertyf("tu-154/bleed/cabin2_tube_t")) -- temperature in the duct to cabin 2
defineProperty("cold_tube1_t", globalPropertyf("tu-154/bleed/cold_tube1_t")) -- duct 1 temperature
defineProperty("cold_tube2_t", globalPropertyf("tu-154/bleed/cold_tube2_t")) -- duct 2 temperature

defineProperty("cockpit_temp", globalPropertyf("tu-154/bleed/cockpit_temp")) -- cabin temperature
defineProperty("cabin_1_temp", globalPropertyf("tu-154/bleed/cabin_1_temp")) -- cabin 1 temperature
defineProperty("cabin_2_temp", globalPropertyf("tu-154/bleed/cabin_2_temp")) -- cabin 2 temperature

defineProperty("hot_tube_t", globalPropertyf("tu-154/bleed/hot_tube_t")) -- hot air temperature in the duct

defineProperty("actual_cabin_alt", globalPropertyf("sim/cockpit2/pressurization/indicators/cabin_altitude_ft"))
defineProperty("cabin_press_diff", globalPropertyf("sim/cockpit2/pressurization/indicators/pressure_diffential_psi"))


-- failures
defineProperty("airbleed_1", globalPropertyi("tu-154/failures/airbleed_1")) -- engine bleed air failure
defineProperty("airbleed_2", globalPropertyi("tu-154/failures/airbleed_2")) -- engine bleed air failure
defineProperty("airbleed_3", globalPropertyi("tu-154/failures/airbleed_3")) -- engine bleed air failure

defineProperty("main_pressure", globalPropertyi("tu-154/alarm/main_pressure")) -- cabin depressurisation or overpressure


-- sounds
local rotary_sound = loadSample('sounds/plastic_switch.wav')
local switcher_sound = loadSample('sounds/metal_switch.wav')
local cap_sound = loadSample('sounds/cap.wav')
local button_sound = loadSample('sounds/plastic_btn.wav')

-- time
local passed = get(frame_time)


-- engines
defineProperty("eng1_N1", globalProperty("sim/flightmodel/engine/ENGN_N1_[0]")) -- engine 1 rpm
defineProperty("eng2_N1", globalProperty("sim/flightmodel/engine/ENGN_N1_[1]")) -- engine 2 rpm
defineProperty("eng3_N1", globalProperty("sim/flightmodel/engine/ENGN_N1_[2]")) -- engine 3 rpm


local notLoaded = true

local function reset_switchers()
	if get(eng1_N1) < 5 and get(eng2_N1) < 5 and get(eng3_N1) < 5 then
		set(cockpit_mode_set, 0)
		set(cabin1_mode_set, 0)
		set(cabin2_mode_set, 0)
		set(left_sys_mode_set, 0)
		set(right_sys_mode_set, 0)
		set(psvp_left_on, 0)
		set(psvp_right_on, 0)
		set(eng_valve_1, 0)
		set(eng_valve_2, 0)
		set(eng_valve_3, 0)
		
	end
	
	notLoaded = false
end


local lamp_test_srd_last = get(lamp_test_srd)

local cab_P_counter = 0
local cab_P_lit = 0

local cab_high_counter = 0
local cab_high_lit = 0

local function lamps()
	-- make sound for button
	local test_btn = get(lamp_test_srd)
	if test_btn ~= lamp_test_srd_last then playSample(button_sound, false) end
	lamp_test_srd_last = test_btn
	
	local day_night = 1 - get(day_night_set) * 0.25
	
	test_btn = test_btn * math.max((get(bus27_volt_right) - 10) / 18.5, 0)
	
	local test_btn_frnt = get(lamp_test_front)
	
	local power27_L = get(bus27_volt_left)
	local power27_R = get(bus27_volt_right)
	
	local lamps_brt = math.max((math.max(power27_L, power27_R) - 10) / 18.5, 0)
	
	local skv_overheat_brt = 0
	if get(cold_tube1_t) > 75 or get(cold_tube2_t) > 75 then skv_overheat_brt = 1 end
	skv_overheat_brt = math.max(skv_overheat_brt * lamps_brt, test_btn)
	set(skv_overheat, skv_overheat_brt)
	
	local skv_overpress_left_brt = math.max(0, test_btn) -- fake for now
	set(skv_overpress_left, skv_overpress_left_brt)	
	
	local skv_overpress_right_brt = math.max(0, test_btn) -- fake for now
	set(skv_overpress_right, skv_overpress_right_brt)	
	
	local skv_tail_temp_brt = math.max(0, test_btn) -- fake for now
	set(skv_tail_temp, skv_tail_temp_brt)	

	
	
	local skv_bleed_fail_1_brt = 0
	if get(eng_valve_1) == 1 and get(airbleed_1) == 1 and power27_L > 10 then skv_bleed_fail_1_brt = 1 end
	skv_bleed_fail_1_brt = math.max(skv_bleed_fail_1_brt * lamps_brt , test_btn)
	set(skv_bleed_fail_1, skv_bleed_fail_1_brt)	
	
	
	local skv_bleed_fail_2_brt = 0
	if get(eng_valve_2) == 1 and get(airbleed_2) == 1 and power27_R > 10 then skv_bleed_fail_2_brt = 1 end
	skv_bleed_fail_2_brt = math.max(skv_bleed_fail_2_brt * lamps_brt, test_btn) 
	set(skv_bleed_fail_2, skv_bleed_fail_2_brt)	

	local skv_bleed_fail_3_brt = 0
	if get(eng_valve_3) == 1 and get(airbleed_3) == 1 and power27_R > 10 then skv_bleed_fail_3_brt = 1 end
	skv_bleed_fail_3_brt = math.max(skv_bleed_fail_3_brt * lamps_brt, test_btn)
	set(skv_bleed_fail_3, skv_bleed_fail_3_brt)		

	
	
	local skv_bleed_closed_1_brt = 0
	if get(eng_airvalve_1) < 0.5 and power27_L > 10 then skv_bleed_closed_1_brt = 1 end
	skv_bleed_closed_1_brt = math.max(skv_bleed_closed_1_brt * lamps_brt, test_btn) 
	set(skv_bleed_closed_1, skv_bleed_closed_1_brt)	

	local skv_bleed_closed_2_brt = 0
	if get(eng_airvalve_2) < 0.5 and power27_R > 10 then skv_bleed_closed_2_brt = 1 end
	skv_bleed_closed_2_brt = math.max(skv_bleed_closed_2_brt * lamps_brt, test_btn) 
	set(skv_bleed_closed_2, skv_bleed_closed_2_brt)	
	
	local skv_bleed_closed_3_brt = 0
	if get(eng_airvalve_3) < 0.5 and power27_R > 10 then skv_bleed_closed_3_brt = 1 end
	skv_bleed_closed_3_brt = math.max(skv_bleed_closed_3_brt * lamps_brt, test_btn) 
	set(skv_bleed_closed_3, skv_bleed_closed_3_brt)	
	
	
	-- other lamps
	local buzz_test = get(srd_buzzer_test)
	local low_cab_P = get(actual_cabin_alt) * 0.3048 > 3300 or buzz_test == 1
	
	if low_cab_P then cab_P_counter = cab_P_counter + passed
	else 
		cab_P_counter = 0 
		cab_P_lit = 0	
	end
	
	if low_cab_P and cab_P_counter > 0.3 then
		cab_P_lit = math.abs(1 - cab_P_lit)
		cab_P_counter = 0
	end
	
	
	local high_cab_P = get(cabin_press_diff) * 0.0778 > 0.72 or buzz_test == 1

	if high_cab_P then cab_high_counter = cab_high_counter + passed
	else 
		cab_high_counter = 0 
		cab_high_lit = 0	
	end
	
	if high_cab_P and cab_high_counter > 0.3 then
		cab_high_lit = math.abs(1 - cab_high_lit)
		cab_high_counter = 0
	end	
	
	set(main_pressure, bool2int(low_cab_P or high_cab_P))
	
	
	
	local srd_low_press_brt = math.max(cab_P_lit * lamps_brt, 0)
	set(srd_low_press, srd_low_press_brt)
	
	local srd_overpress_brt = math.max(cab_high_lit * lamps_brt, 0)
	set(srd_overpress, srd_overpress_brt)
	
	local cockpit_p_low_brt = math.max(cab_P_lit * lamps_brt * day_night, test_btn_frnt)
	set(cockpit_p_low, cockpit_p_low_brt)
	
	
	
end


local cockpit_temp_set_last = get(cockpit_temp_set)
local cabin1_temp_set_last = get(cabin1_temp_set)
local cabin2_temp_set_last = get(cabin2_temp_set)
local left_sys_temp_set_last = get(left_sys_temp_set)
local right_sys_temp_set_last = get(right_sys_temp_set)
local sys_temp_select_last = get(sys_temp_select)

local function rotary_sw()

	local cockpit_temp_set_sw = get(cockpit_temp_set)
	local cabin1_temp_set_sw = get(cabin1_temp_set)
	local cabin2_temp_set_sw = get(cabin2_temp_set)
	local left_sys_temp_set_sw = get(left_sys_temp_set)
	local right_sys_temp_set_sw = get(right_sys_temp_set)
	local sys_temp_select_sw = get(sys_temp_select)
	
	local change = cockpit_temp_set_sw + cabin1_temp_set_sw + cabin2_temp_set_sw + left_sys_temp_set_sw + right_sys_temp_set_sw + sys_temp_select_sw
	change = change - cockpit_temp_set_last - cabin1_temp_set_last - cabin2_temp_set_last - left_sys_temp_set_last - right_sys_temp_set_last - sys_temp_select_last
	
	if change ~= 0 then playSample(rotary_sound, false) end
	
	
	cockpit_temp_set_last = cockpit_temp_set_sw
	cabin1_temp_set_last = cabin1_temp_set_sw
	cabin2_temp_set_last = cabin2_temp_set_sw
	left_sys_temp_set_last = left_sys_temp_set_sw
	right_sys_temp_set_last = right_sys_temp_set_sw
	sys_temp_select_last = sys_temp_select_sw


end

local air_gau_tbl = {{ -100000, -160 },    -- bugs walkaround
                  {  0, -160 }, -- 0.0
				  { 300, -145 },   --
				  { 400, -136 }, -- 
				  { 600, -107 }, -- 
				  { 700, -90 }, -- 
				  { 900, -45 }, -- 
				  { 1200, 48 }, --
				  { 1300, 86 }, --
				  { 1500, 160 }, -- 
				  { 1600, 190 }, -- 
          	      { 10000000, 190 }}    -- bugs walkaround

local air_temp_tbl = {{ -100000, -105 },    -- bugs walkaround
                  {  -65, -105 }, -- 0.0
				  {  -60, -100 }, -- 0.0
				  { -30, -48 },   --
				  { 0, 0 }, -- 
				  { 30, 48 }, -- 
				  { 60, 82 }, -- 
				  { 70, 92 }, -- 
				  { 100, 100 }, -- 
          	      { 10000000, 100 }}    -- bugs walkaround
				  
local flow_angle_L_act = -160
local flow_angle_R_act = -160

local cocpit_t_ang_act = -105
local cabin_t_ang_act = -105

local sys_t_act = -70

local function gauges()
	-- air flow
	local angle_L = interpolate(air_gau_tbl, get(air_usage_L))
	local angle_R = interpolate(air_gau_tbl, get(air_usage_R))
	
	if angle_L - flow_angle_L_act < 0 then
		flow_angle_L_act = flow_angle_L_act + sign(angle_L - flow_angle_L_act) * math.min(math.abs(angle_L - flow_angle_L_act), 20) * passed * 4
	else
		flow_angle_L_act = flow_angle_L_act + sign(angle_L - flow_angle_L_act) * math.min(math.abs(angle_L - flow_angle_L_act), 10) * passed * 2
	end
	
	if angle_R - flow_angle_R_act < 0 then
		flow_angle_R_act = flow_angle_R_act + sign(angle_R - flow_angle_R_act) * math.min(math.abs(angle_R - flow_angle_R_act), 20) * passed * 4
	else
		flow_angle_R_act = flow_angle_R_act + sign(angle_R - flow_angle_R_act) * math.min(math.abs(angle_R - flow_angle_R_act), 10) * passed * 2
	end
	
	set(air_flow_1, flow_angle_L_act)
	set(air_flow_2, flow_angle_R_act)

	-----------------
	-- cabins temp
	local cockpit_t_ang = -105
	local cabin_t_ang = -105
	
	if get(bus27_volt_right) > 13 then
		cockpit_t_ang = interpolate(air_temp_tbl, get(cockpit_temp))
	
		if get(cabin_sel) == 1 then
			cabin_t_ang = interpolate(air_temp_tbl, get(cabin_1_temp))
		else
			cabin_t_ang = interpolate(air_temp_tbl, get(cabin_2_temp))
		end
	end
	
	cocpit_t_ang_act = cocpit_t_ang_act + (cockpit_t_ang - cocpit_t_ang_act) * passed * 2
	cabin_t_ang_act = cabin_t_ang_act + (cabin_t_ang - cabin_t_ang_act) * passed * 2
	
	
	set(cockpit_temp_gau, cocpit_t_ang_act)
	set(cabin_temp_gau, cabin_t_ang_act)
	
	-- tubes temp
	local system_t = -75
	local system_gau_sel = get(sys_temp_select)
	
	if get(bus27_volt_right) > 13 then
		if system_gau_sel == 0 then
			system_t = get(door_heat_tube_t)
		elseif system_gau_sel == 1 then
			system_t = get(cockpit_tube_t)
		elseif system_gau_sel == 2 then
			system_t = get(cabin1_tube_t)
		elseif system_gau_sel == 3 then
			system_t = get(cabin2_tube_t)
		elseif system_gau_sel == 4 then
			system_t = get(cold_tube1_t)
		else
			system_t = get(cold_tube2_t)
		end
	end
	if system_t < -75 then system_t = -75
	elseif system_t > 155 then system_t = 155 end
	
	sys_t_act = sys_t_act + (system_t - sys_t_act) * passed * 2
	
	set(system_temp, sys_t_act)
	
	
end

local cabin_sel_last = get(cabin_sel)
local heat_close_last = get(heat_close)
local ground_cond_on_last = get(ground_cond_on)
local skv_faster_work_last = get(skv_faster_work)
local psvp_left_on_last = get(psvp_left_on)
local psvp_right_on_last = get(psvp_right_on)
local air_valve_left_last = get(air_valve_left)
local air_valve_right_last = get(air_valve_right)
local emerg_decompress_last = get(emerg_decompress)
local eng_valve_1_last = get(eng_valve_1)
local eng_valve_2_last = get(eng_valve_2)
local eng_valve_3_last = get(eng_valve_3)
local dubler_on_last = get(dubler_on)

local cockpit_mode_set_last = get(cockpit_mode_set)
local cabin1_mode_set_last = get(cabin1_mode_set)
local cabin2_mode_set_last = get(cabin2_mode_set)
local left_sys_mode_set_last = get(left_sys_mode_set)
local right_sys_mode_set_last = get(right_sys_mode_set)

local sard_disable_last = get(sard_disable)
local door_heat_last = get(door_heat)

local air_valve_both_last = get(air_valve_both)

local function check_switchers()

	local cabin_sel_sw = get(cabin_sel)
	local heat_close_sw = get(heat_close)
	local ground_cond_on_sw = get(ground_cond_on)
	local skv_faster_work_sw = get(skv_faster_work)
	local psvp_left_on_sw = get(psvp_left_on)
	local psvp_right_on_sw = get(psvp_right_on)
	local air_valve_left_sw = get(air_valve_left)
	local air_valve_right_sw = get(air_valve_right)
	local emerg_decompress_sw = get(emerg_decompress)
	local eng_valve_1_sw = get(eng_valve_1)
	local eng_valve_2_sw = get(eng_valve_2)
	local eng_valve_3_sw = get(eng_valve_3)
	local dubler_on_sw = get(dubler_on)

	local cockpit_mode_set_sw = get(cockpit_mode_set)
	local cabin1_mode_set_sw = get(cabin1_mode_set)
	local cabin2_mode_set_sw = get(cabin2_mode_set)
	local left_sys_mode_set_sw = get(left_sys_mode_set)
	local right_sys_mode_set_sw = get(right_sys_mode_set)
	
	local sard_disable_sw = get(sard_disable)
	local door_heat_sw = get(door_heat)
	
	local change = cabin_sel_sw + heat_close_sw + ground_cond_on_sw + skv_faster_work_sw + psvp_left_on_sw + psvp_right_on_sw
	change = change + air_valve_left_sw + air_valve_right_sw + emerg_decompress_sw + eng_valve_1_sw + eng_valve_2_sw + eng_valve_3_sw + dubler_on_sw
	change = change + cockpit_mode_set_sw + cabin1_mode_set_sw + cabin2_mode_set_sw + left_sys_mode_set_sw + right_sys_mode_set_sw
	change = change + sard_disable_sw + door_heat_sw
	
	change = change - cabin_sel_last - heat_close_last - ground_cond_on_last - skv_faster_work_last - psvp_left_on_last - psvp_right_on_last
	change = change - air_valve_left_last - air_valve_right_last - emerg_decompress_last - eng_valve_1_last - eng_valve_2_last - eng_valve_3_last - dubler_on_last
	change = change - cockpit_mode_set_last - cabin1_mode_set_last - cabin2_mode_set_last - left_sys_mode_set_last - right_sys_mode_set_last
	change = change - sard_disable_last - door_heat_last
	
	if change ~= 0 then playSample(switcher_sound, false) end
	
	
	cabin_sel_last = cabin_sel_sw
	heat_close_last = heat_close_sw
	ground_cond_on_last = ground_cond_on_sw
	skv_faster_work_last = skv_faster_work_sw
	psvp_left_on_last = psvp_left_on_sw
	psvp_right_on_last = psvp_right_on_sw
	air_valve_left_last = air_valve_left_sw
	air_valve_right_last = air_valve_right_sw
	emerg_decompress_last = emerg_decompress_sw
	eng_valve_1_last = eng_valve_1_sw
	eng_valve_2_last = eng_valve_2_sw
	eng_valve_3_last = eng_valve_3_sw
	dubler_on_last = dubler_on_sw
	
	cockpit_mode_set_last = cockpit_mode_set_sw
	cabin1_mode_set_last = cabin1_mode_set_sw
	cabin2_mode_set_last = cabin2_mode_set_sw
	left_sys_mode_set_last = left_sys_mode_set_sw
	right_sys_mode_set_last = right_sys_mode_set_sw
	
	sard_disable_last = sard_disable_sw
	door_heat_last = door_heat_sw
	
	local air_valve_both_sw = get(air_valve_both)
	
	if air_valve_both_sw == 1 then 
		set(air_valve_left, 1)
		set(air_valve_right, 1)
	elseif air_valve_both_sw == -1 then
		set(air_valve_left, -1)
		set(air_valve_right, -1)
	elseif air_valve_both_last ~= air_valve_both_sw and air_valve_both_sw == 0 then
		set(air_valve_left, 0)
		set(air_valve_right, 0)	
	end
	
	air_valve_both_last = air_valve_both_sw
	
	
end


local heat_close_cap_last = get(heat_close_cap)
local ground_cond_on_cap_last = get(ground_cond_on_cap)
local skv_faster_work_cap_last = get(skv_faster_work_cap)
local psvp_left_on_cap_last = get(psvp_left_on_cap)
local psvp_right_on_cap_last = get(psvp_right_on_cap)
local emerg_decompress_cap_last = get(emerg_decompress_cap)
local dubler_on_cap_last = get(dubler_on_cap)
local sard_disable_cap_last = get(sard_disable_cap)


local function caps_check()

	local heat_close_cap_sw = get(heat_close_cap)
	local ground_cond_on_cap_sw = get(ground_cond_on_cap)
	local skv_faster_work_cap_sw = get(skv_faster_work_cap)
	local psvp_left_on_cap_sw = get(psvp_left_on_cap)
	local psvp_right_on_cap_sw = get(psvp_right_on_cap)
	local emerg_decompress_cap_sw = get(emerg_decompress_cap)
	local dubler_on_cap_sw = get(dubler_on_cap)
	local sard_disable_cap_sw = get(sard_disable_cap)
	
	
	
	local change = heat_close_cap_sw + ground_cond_on_cap_sw + skv_faster_work_cap_sw + psvp_left_on_cap_sw + psvp_right_on_cap_sw
	change = change + emerg_decompress_cap_sw + dubler_on_cap_sw + sard_disable_cap_sw
	
	change = change - heat_close_cap_last - ground_cond_on_cap_last - skv_faster_work_cap_last - psvp_left_on_cap_last - psvp_right_on_cap_last
	change = change - emerg_decompress_cap_last - dubler_on_cap_last - sard_disable_cap_last

	if change ~= 0 then playSample(cap_sound, false) end

	heat_close_cap_last = heat_close_cap_sw
	ground_cond_on_cap_last = ground_cond_on_cap_sw
	skv_faster_work_cap_last = skv_faster_work_cap_sw
	psvp_left_on_cap_last = psvp_left_on_cap_sw
	psvp_right_on_cap_last = psvp_right_on_cap_sw
	emerg_decompress_cap_last = emerg_decompress_cap_sw
	dubler_on_cap_last = dubler_on_cap_sw
	sard_disable_cap_last = sard_disable_cap_sw
	
	
	-- check switchers position under their caps
	--if skv_faster_work_cap_sw == 0 then set(skv_faster_work, 0) end
	if dubler_on_cap_sw == 0 then set(dubler_on, 0) end
	-- SASL3: set() needs the value; SASL2 silently accepted set(prop) and this
	-- line raised ~900 errors a second. 0 matches the three sibling lines --
	-- a closed cap forces its switch off.
	if emerg_decompress_cap_sw == 0 then set(emerg_decompress, 0) end
	
	if sard_disable_cap_sw == 0 then set(sard_disable, 0) end
	
	

end








local sim_start_timer = 0

function update()
	
	passed = get(frame_time)
	
	-- reset switchers
	sim_start_timer = sim_start_timer + passed
	if sim_start_timer > 0.3 then 
		if notLoaded then reset_switchers() end
		
		rotary_sw()
		check_switchers() -- make them sound
		caps_check() -- make them sound
		lamps()
		
	end
	
	gauges()


end