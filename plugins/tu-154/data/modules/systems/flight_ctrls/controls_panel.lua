

-- controls
defineProperty("stab_man_cap", globalPropertyi("tu-154/controll/stab_man_cap")) -- stabiliser control cover
defineProperty("stab_manual", globalPropertyi("tu-154/controll/stab_manual")) -- stabiliser control. 0 - neutral, +1 - nose up
defineProperty("stab_setting", globalPropertyi("tu-154/controll/stab_setting")) -- CG position for the stabiliser. 0 = aft, 1 = mid, 2 = fwd	1
defineProperty("ail_trimm_sw", globalPropertyi("tu-154/controll/ail_trimm_sw")) -- aileron trim switch
defineProperty("rudd_trimm_sw", globalPropertyi("tu-154/controll/rudd_trimm_sw")) -- rudder trim switch
defineProperty("contr_force_cap", globalPropertyi("tu-154/controll/contr_force_cap")) -- elevator/rudder feel unit switch cover
defineProperty("contr_force_set", globalPropertyi("tu-154/controll/contr_force_set")) -- elevator/rudder feel unit selector. -1 = flight, 0 = auto, +1 = takeoff-landing

defineProperty("nosewheel_turn_enable", globalPropertyi("tu-154/switchers/nosewheel_turn_enable")) -- nosewheel steering switch on the control wheel
defineProperty("nosewheel_turn_sel", globalPropertyi("tu-154/switchers/nosewheel_turn_sel")) -- nosewheel steering angle selector. 0 = 10, 1 = 63
defineProperty("nosewheel_turn_cap", globalPropertyi("tu-154/switchers/nosewheel_turn_cap")) -- steering angle selector cover
defineProperty("slat_man", globalPropertyi("tu-154/switchers/slat_man")) -- manual slat control. -1 - retract, 0 off, +1 - extend
defineProperty("slat_man_cap", globalPropertyi("tu-154/switchers/slat_man_cap")) -- manual slat control cover
defineProperty("flaps_sel", globalPropertyi("tu-154/switchers/flaps_sel")) -- flap operating mode selection. -1 - off, 0 - auto, +1 - manual
defineProperty("flaps_sel_cap", globalPropertyi("tu-154/switchers/flaps_sel_cap")) -- flap operation selection cover
defineProperty("gears_retr_lock", globalPropertyi("tu-154/switchers/gears_retr_lock")) -- gear retraction lock
defineProperty("gears_retr_lock_cap", globalPropertyi("tu-154/switchers/gears_retr_lock_cap")) -- landing gear retraction lock cover
defineProperty("gears_ext_3GS", globalPropertyi("tu-154/switchers/gears_ext_3GS")) -- gear extension from hydraulic system 3
defineProperty("gears_ext_3GS_cap", globalPropertyi("tu-154/switchers/gears_ext_3GS_cap")) -- cover for gear extension from hydraulic system 3

defineProperty("buster_on_1", globalPropertyi("tu-154/switchers/console/buster_on_1")) -- booster switch
defineProperty("buster_on_2", globalPropertyi("tu-154/switchers/console/buster_on_2")) -- booster switch
defineProperty("buster_on_3", globalPropertyi("tu-154/switchers/console/buster_on_3")) -- booster switch
defineProperty("busters_cap", globalPropertyi("tu-154/switchers/console/busters_cap")) -- booster switch guard

defineProperty("elev_trimm_switcher", globalPropertyi("tu-154/controll/elev_trimm_switcher")) -- elevator trim control. -1 = nose down, 0 = neutral, +1 = nose up

defineProperty("emerg_elev_trimm", globalPropertyi("tu-154/switchers/console/emerg_elev_trimm")) -- emergency trim control
defineProperty("emerg_elev_trimm_cap", globalPropertyi("tu-154/switchers/console/emerg_elev_trimm_cap")) -- emergency trim control

defineProperty("lamp_test", globalPropertyi("tu-154/buttons/lamp_test_front")) -- lamp test button
defineProperty("lamp_test_eng", globalPropertyi("tu-154/buttons/lamp_test_upper_gear")) -- lamp test button


defineProperty("flaps_lever", globalPropertyf("tu-154/controll/flaps_lever")) -- sim flaps ratio control. use for axis and commands
defineProperty("gear_lever", globalPropertyi("tu-154/controll/gear_lever")) -- landing gear lever. -1 = up, 0 = neutral, +1 = down

defineProperty("anim_rud1", globalPropertyf("tu-154/controlls/throttle_1")) -- throttle 1
defineProperty("anim_rud2", globalPropertyf("tu-154/controlls/throttle_2")) -- throttle 2
defineProperty("anim_rud3", globalPropertyf("tu-154/controlls/throttle_3")) -- throttle 3

-- gauges
defineProperty("stab_ind", globalPropertyf("tu-154/gauges/misc/stab_ind")) -- stabiliser position indicator
defineProperty("elevator_ind", globalPropertyf("tu-154/gauges/misc/elevator_ind")) -- stabiliser position indicator
defineProperty("flap_left_ind", globalPropertyf("tu-154/gauges/misc/flap_left_ind")) -- stabiliser position indicator
defineProperty("flap_right_ind", globalPropertyf("tu-154/gauges/misc/flap_right_ind")) -- stabiliser position indicator

-- lamps
defineProperty("stab_work", globalPropertyf("tu-154/lights/stab_work")) -- stabilisation on
defineProperty("flaps_1_valve", globalPropertyf("tu-154/lights/flaps_1_valve")) -- flaps 1 PK
defineProperty("flaps_2_valve", globalPropertyf("tu-154/lights/flaps_2_valve")) -- flaps 2 PK
defineProperty("spoilers_mid_left", globalPropertyf("tu-154/lights/spoilers_mid_left")) -- mid left spoilers
defineProperty("spoilers_mid_right", globalPropertyf("tu-154/lights/spoilers_mid_right")) -- mid right spoilers
defineProperty("spoilers_inn_left", globalPropertyf("tu-154/lights/spoilers_inn_left")) -- inboard left spoilers
defineProperty("spoilers_inn_right", globalPropertyf("tu-154/lights/spoilers_inn_right")) -- inboard right spoilers

defineProperty("flaps_unsync", globalPropertyf("tu-154/lights/flaps_unsync")) -- flap asymmetry
defineProperty("slats_unsync", globalPropertyf("tu-154/lights/slats_unsync")) -- slat asymmetry
defineProperty("slats_extended", globalPropertyf("tu-154/lights/slats_extended")) -- slats extended

defineProperty("to_rudder", globalPropertyf("tu-154/lights/to_rudder")) -- rudder takeoff/landing
defineProperty("to_elevator", globalPropertyf("tu-154/lights/to_elevator")) -- elevator takeoff/landing
defineProperty("trimm_zero_course", globalPropertyf("tu-154/lights/trimm_zero_course")) -- heading neutral
defineProperty("trimm_zero_roll", globalPropertyf("tu-154/lights/trimm_zero_roll")) -- roll neutral
defineProperty("trimm_zero_pitch", globalPropertyf("tu-154/lights/trimm_zero_pitch")) -- pitch neutral

defineProperty("gears_not_ext", globalPropertyf("tu-154/lights/gears_not_ext")) -- landing gear not extended
defineProperty("gears_red_left", globalPropertyf("tu-154/lights/gears_red_left")) -- landing gear
defineProperty("gears_red_front", globalPropertyf("tu-154/lights/gears_red_front")) -- landing gear
defineProperty("gears_red_right", globalPropertyf("tu-154/lights/gears_red_right")) -- landing gear
defineProperty("gears_green_left", globalPropertyf("tu-154/lights/gears_green_left")) -- landing gear
defineProperty("gears_green_front", globalPropertyf("tu-154/lights/gears_green_front")) -- landing gear
defineProperty("gears_green_right", globalPropertyf("tu-154/lights/gears_green_right")) -- landing gear

defineProperty("gears_red_left_eng", globalPropertyf("tu-154/lights/gears_red_left_eng")) -- landing gear
defineProperty("gears_red_front_eng", globalPropertyf("tu-154/lights/gears_red_front_eng")) -- landing gear
defineProperty("gears_red_right_eng", globalPropertyf("tu-154/lights/gears_red_right_eng")) -- landing gear
defineProperty("gears_green_left_eng", globalPropertyf("tu-154/lights/gears_green_left_eng")) -- landing gear
defineProperty("gears_green_front_eng", globalPropertyf("tu-154/lights/gears_green_front_eng")) -- landing gear
defineProperty("gears_green_right_eng", globalPropertyf("tu-154/lights/gears_green_right_eng")) -- landing gear


-- sources
defineProperty("elevator_L", globalPropertyf("tu-154/controlls/elev_L_phys")) -- Degrees, positive is trailing-edge down.
defineProperty("stab_pos", globalPropertyf("sim/flightmodel2/controls/elevator_trim")) -- sim pitch trimmer
defineProperty("flap_inn_L", globalPropertyf("sim/flightmodel/controls/wing1l_fla1def")) -- inner flaps left
defineProperty("flap_inn_R", globalPropertyf("sim/flightmodel/controls/wing1r_fla1def")) -- inner flaps right
defineProperty("slats", globalPropertyf("sim/flightmodel2/controls/slat1_deploy_ratio")) -- slats position. this one works too

defineProperty("spd_brk_inn_L", globalPropertyf("sim/flightmodel/controls/wing1l_spo1def")) -- inner speedbrake left Degrees
defineProperty("spd_brk_inn_R", globalPropertyf("sim/flightmodel/controls/wing1r_spo1def")) -- inner speedbrake right Degrees

defineProperty("spd_brk_mid_L", globalPropertyf("sim/flightmodel/controls/wing2l_spo2def")) -- middle speedbrake left Degrees
defineProperty("spd_brk_mid_R", globalPropertyf("sim/flightmodel/controls/wing2r_spo2def")) -- middle speedbrake right Degrees

defineProperty("int_pitch_trim", globalPropertyf("tu-154/trimmers/int_pitch_trim")) -- elevator trim position
defineProperty("int_roll_trim", globalPropertyf("tu-154/trimmers/int_roll_trim")) -- aileron trim position
defineProperty("int_yaw_trim", globalPropertyf("tu-154/trimmers/int_yaw_trim")) -- rudder trim position

defineProperty("control_force_pos", globalPropertyf("tu-154/controls/control_force_pos")) -- elevator feel unit position. 0 - disconnected, 1 - connected
defineProperty("control_force_pos_rud", globalPropertyf("tu-154/controls/control_force_pos_rud")) -- rudder feel unit position. 0 - disconnected, 1 - connected

defineProperty("gear1_deploy", globalProperty("sim/aircraft/parts/acf_gear_deploy[0]"))  -- deploy of front gear
defineProperty("gear2_deploy", globalProperty("sim/aircraft/parts/acf_gear_deploy[1]"))  -- deploy of right gear
defineProperty("gear3_deploy", globalProperty("sim/aircraft/parts/acf_gear_deploy[2]"))  -- deploy of left gear

defineProperty("deflection_mtr_2", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]"))
defineProperty("deflection_mtr_3", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]"))


defineProperty("indicated_airspeed", globalPropertyf("sim/flightmodel/position/indicated_airspeed")) -- indicated airspeed
defineProperty("machno", globalPropertyf("sim/flightmodel/misc/machno")) -- Mach number

defineProperty("anim_rud1", globalPropertyf("tu-154/controlls/throttle_1")) -- throttle 1
defineProperty("anim_rud2", globalPropertyf("tu-154/controlls/throttle_2")) -- throttle 2
defineProperty("anim_rud3", globalPropertyf("tu-154/controlls/throttle_3")) -- throttle 3

-- power
defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left")) -- 27 V bus voltage
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right")) -- 27 V bus voltage

defineProperty("bus115_1_volt", globalPropertyf("tu-154/elec/bus115_1_volt")) -- 115 V bus voltage
defineProperty("bus115_3_volt", globalPropertyf("tu-154/elec/bus115_3_volt")) -- 115 V bus voltage

defineProperty("bus36_volt_left", globalPropertyf("tu-154/elec/bus36_volt_left")) -- 36 V left bus voltage
defineProperty("bus36_volt_right", globalPropertyf("tu-154/elec/bus36_volt_right")) -- 36 V right bus voltage
defineProperty("bus36_volt_pts250_1", globalPropertyf("tu-154/elec/bus36_volt_pts250_1")) -- 36 V bus voltage, PTS 1
defineProperty("bus36_volt_pts250_2", globalPropertyf("tu-154/elec/bus36_volt_pts250_2")) -- 36 V bus voltage, PTS 2


-- engines
defineProperty("eng1_N1", globalProperty("sim/flightmodel/engine/ENGN_N1_[0]")) -- engine 1 rpm
defineProperty("eng2_N1", globalProperty("sim/flightmodel/engine/ENGN_N1_[1]")) -- engine 2 rpm
defineProperty("eng3_N1", globalProperty("sim/flightmodel/engine/ENGN_N1_[2]")) -- engine 3 rpm

-- other datarefs
defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))

-- control surfaces

defineProperty("slats", globalPropertyf("sim/flightmodel2/controls/slat1_deploy_ratio")) -- slats position. this one works too

defineProperty("rv5_alt_L", globalPropertyf("tu-154/misc/rv5_alt_left"))  -- altitude on the left altimeter
defineProperty("rv5_alt_R", globalPropertyf("tu-154/misc/rv5_alt_right"))  -- altitude on the left altimeter


-- alarm
defineProperty("main_gear_flaps", globalPropertyi("tu-154/alarm/main_gear_flaps")) -- flaps not in the takeoff position or gear not extended

-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control

defineProperty("elev_coeff", globalPropertyf("tu-154/controlls/elev_coeff"))


-- sounds
local rotary_sound = loadSample('sounds/plastic_switch.wav')
local switcher_sound = loadSample('sounds/metal_switch.wav')
local cap_sound = loadSample('sounds/cap.wav')

local passed = get(frame_time)

local notLoaded = true

local function reset_switchers()
	if get(eng1_N1) < 5 and get(eng2_N1) < 5 and get(eng3_N1) < 5 then
		set(buster_on_1, 0)
		set(buster_on_2, 0)
		set(buster_on_3, 0)
		
		set(busters_cap, 1)
		
		set(nosewheel_turn_sel, 1)
		set(nosewheel_turn_cap, 1)
		
	end
	
	notLoaded = false
end


local stab_work_lit = false
local stab_work_timer = 0
local stab_pos_last = get(stab_pos)

local forcer_lit = false
local forcer_timer = 0

local forcer_rud_lit = false
local forcer_timer_rud = 0

local flap_L_pos_last = 0
local flap_R_pos_last = 0

local slats_lit = false
local slats_timer = 0
local slats_last = 0

local gear_timer = 0

local ind_tbl = {
{-20, -20},
{-15, -15},
{-10, -10},
{-5, -5},
{0, 0},
{5, 5},
{10, 10},
{15, 14}, -- fail
{20, 16},
{25, 17.8}, 
{30, 20},
{100, 20}}

local function lamps()
	local test_btn = get(lamp_test) * math.max((get(bus27_volt_right) - 10) / 18.5, 0)
	local test_btn_eng = get(lamp_test_eng) * math.max((get(bus27_volt_right) - 10) / 18.5, 0)
	local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0)
	
	local stab_work_brt = 0
	local stab_pos_now = get(stab_pos)
	
	if math.abs(stab_pos_now - stab_pos_last) > 0.01 * passed then 
		stab_work_timer = stab_work_timer + passed
		if stab_work_timer > 0.5 then
			stab_work_timer = 0
			stab_work_lit = not stab_work_lit
		end
	else
		stab_work_timer = 0
		stab_work_lit = false
	end
	if stab_work_lit then stab_work_brt = 1 end
	stab_work_brt = math.max(stab_work_brt * lamps_brt, test_btn)
	if get(ismaster) ~= 1 then set(stab_work, stab_work_brt) end

	stab_pos_last = stab_pos_now
	
	--  - get(flap_inn_R)
	local flap_pos_now_L = get(flap_inn_L)
	local flap_pos_now_R = get(flap_inn_R)
	
	local flaps_1_valve_brt = 0--math.min(1, get(flap_inn_L))
	if flap_L_pos_last ~= flap_pos_now_L then flaps_1_valve_brt = 1 end
	flaps_1_valve_brt = math.max(flaps_1_valve_brt * lamps_brt, test_btn)
	if get(ismaster) ~= 1 then set(flaps_1_valve, flaps_1_valve_brt) end
	
	local flaps_2_valve_brt = 0--math.min(1, get(flap_inn_R))
	if flap_R_pos_last ~= flap_pos_now_R then flaps_2_valve_brt = 1 end
	flaps_2_valve_brt = math.max(flaps_2_valve_brt * lamps_brt, test_btn)
	if get(ismaster) ~= 1 then set(flaps_2_valve, flaps_2_valve_brt) end
	
	flap_L_pos_last = flap_pos_now_L
	flap_R_pos_last = flap_pos_now_R
		
	local spoilers_mid_left_brt = math.min(1, get(spd_brk_mid_L))
	spoilers_mid_left_brt = math.max(spoilers_mid_left_brt * lamps_brt, test_btn)
	set(spoilers_mid_left, spoilers_mid_left_brt)	

	local spoilers_mid_right_brt = math.min(1, get(spd_brk_mid_R))
	spoilers_mid_right_brt = math.max(spoilers_mid_right_brt * lamps_brt, test_btn) 
	set(spoilers_mid_right, spoilers_mid_right_brt)	

	local spoilers_inn_left_brt = math.min(1, get(spd_brk_inn_L))
	spoilers_inn_left_brt = math.max(spoilers_inn_left_brt * lamps_brt, test_btn) 
	set(spoilers_inn_left, spoilers_inn_left_brt)	

	local spoilers_inn_right_brt = math.min(1, get(spd_brk_inn_R))
	spoilers_inn_right_brt = math.max(spoilers_inn_right_brt * lamps_brt, test_btn)
	set(spoilers_inn_right, spoilers_inn_right_brt)		
	
	
	local flaps_unsync_brt = 0
	if math.abs(flap_pos_now_L - flap_pos_now_R) >= 3 then flaps_unsync_brt = 1 end
	flaps_unsync_brt = math.max(flaps_unsync_brt * lamps_brt, test_btn)
	set(flaps_unsync, flaps_unsync_brt)	

	local slats_unsync_brt = 0
	slats_unsync_brt = math.max(slats_unsync_brt * lamps_brt, test_btn)
	set(slats_unsync, slats_unsync_brt)	

	local slats_extended_brt = 0
	local slats_now = get(slats)
	if math.abs(slats_now - slats_last) ~= 0 then 
		slats_timer = slats_timer + passed
		if slats_timer > 0.5 then
			slats_timer = 0
			slats_lit = not slats_lit
		end
	elseif slats_now > 0.1 then
			slats_timer = 0
			slats_lit = true	
	else
		stab_work_timer = 0
		slats_lit = false
	end
	if slats_lit then slats_extended_brt = 1 end

	slats_last = slats_now
	slats_extended_brt = math.max(slats_extended_brt * lamps_brt, test_btn)
	if get(ismaster) ~= 1 then set(slats_extended, slats_extended_brt) end	
	

	local to_rudder_brt = 0
	local to_elevator_brt = 0
	
	-- elevator forcer
	local forcer_pos = get(control_force_pos)	
	if forcer_pos < 1 and forcer_pos > 0 then 
		forcer_timer = forcer_timer + passed 
		if forcer_timer > 0.5 then
			forcer_timer = 0
			forcer_lit = not forcer_lit
		end
	elseif forcer_pos == 0 then
		forcer_lit = true
	else 
		forcer_lit = false
	end
	
	if forcer_lit then 
		to_elevator_brt = 1
	end	
	
	-- rudder forcer
	local forcer_rud_pos = get(control_force_pos_rud)
	if forcer_rud_pos < 1 and forcer_rud_pos > 0 then 
		forcer_timer_rud = forcer_timer_rud + passed 
		if forcer_timer_rud > 0.5 then
			forcer_timer_rud = 0
			forcer_rud_lit = not forcer_rud_lit
		end
	elseif forcer_rud_pos == 0 then
		forcer_rud_lit = true
	else 
		forcer_rud_lit = false
	end
	
	if forcer_rud_lit then 
		to_rudder_brt = 1 
	end		
	
	
	to_rudder_brt = math.max(to_rudder_brt * lamps_brt, test_btn)
	set(to_rudder, to_rudder_brt)	
	
	to_elevator_brt = math.max(to_elevator_brt * lamps_brt, test_btn)
	set(to_elevator, to_elevator_brt)	

	local trimm_zero_course_brt = 0
	if math.abs(get(int_yaw_trim)) < 0.002 then trimm_zero_course_brt = 1 end
	trimm_zero_course_brt = math.max(trimm_zero_course_brt * lamps_brt, test_btn)
	set(trimm_zero_course, trimm_zero_course_brt)	

	local trimm_zero_roll_brt = 0
	if math.abs(get(int_roll_trim)) < 0.002 then trimm_zero_roll_brt = 1 end
	trimm_zero_roll_brt = math.max(trimm_zero_roll_brt * lamps_brt, test_btn)
	set(trimm_zero_roll, trimm_zero_roll_brt)	

	local trimm_zero_pitch_brt = 0
	if math.abs(get(int_pitch_trim)) < 0.004 then trimm_zero_pitch_brt = 1 end
	trimm_zero_pitch_brt = math.max(trimm_zero_pitch_brt * lamps_brt, test_btn)
	set(trimm_zero_pitch, trimm_zero_pitch_brt)		

	local gear_F_pos = get(gear1_deploy)
	local gear_L_pos = get(gear2_deploy)
	local gear_R_pos = get(gear3_deploy)
	
	local gear_not_ext = (gear_F_pos < 0.99 or gear_L_pos < 0.99 or gear_R_pos < 0.99) and (get(indicated_airspeed) * 1.852 < 325 and math.min(get(rv5_alt_L), get(rv5_alt_R)) < 250)
	gear_not_ext = gear_not_ext and (get(anim_rud1) + get(anim_rud2) + get(anim_rud3) < 2 and get(gear_lever) <= 0) 
	-- any gear not on lock, speed less than 325 and throttles set les than 90%
	
	
	if gear_not_ext then
		gear_timer = gear_timer + passed
	else
		gear_timer = 0
	end
	
	if gear_timer > 0.6 then gear_timer = 0 end
	
	
	local gears_not_ext_brt = math.max(bool2int(gear_timer > 0.3) * lamps_brt, test_btn) 
	
	
	set(gears_not_ext, gears_not_ext_brt)	
	
	local gears_red_left_brt = bool2int(gear_L_pos < 0.99 and gear_L_pos > 0.01)
	gears_red_left_brt = math.max(gears_red_left_brt * lamps_brt, test_btn)
	set(gears_red_left, gears_red_left_brt)
	
	local gears_red_front_brt = bool2int(gear_F_pos < 0.99 and gear_F_pos > 0.01)
	gears_red_front_brt = math.max(gears_red_front_brt * lamps_brt, test_btn)
	set(gears_red_front, gears_red_front_brt)
	
	local gears_red_right_brt = bool2int(gear_R_pos < 0.99 and gear_R_pos > 0.01)
	gears_red_right_brt = math.max(gears_red_right_brt * lamps_brt, test_btn)
	set(gears_red_right, gears_red_right_brt)
	
	local gears_green_left_brt = bool2int(gear_L_pos >= 0.99)
	gears_green_left_brt = math.max(gears_green_left_brt * lamps_brt, test_btn)
	set(gears_green_left, gears_green_left_brt)
	
	local gears_green_front_brt = bool2int(gear_F_pos >= 0.99)
	gears_green_front_brt = math.max(gears_green_front_brt * lamps_brt, test_btn)
	set(gears_green_front, gears_green_front_brt)
	
	local gears_green_right_brt = bool2int(gear_L_pos >= 0.99)
	gears_green_right_brt = math.max(gears_green_right_brt * lamps_brt, test_btn)
	set(gears_green_right, gears_green_right_brt)
	
	
	local gears_red_left_eng_brt = bool2int(gear_L_pos < 0.99 and gear_L_pos > 0.01)
	gears_red_left_eng_brt = math.max(gears_red_left_eng_brt * lamps_brt, test_btn_eng)
	set(gears_red_left_eng, gears_red_left_eng_brt)
	
	local gears_red_front_eng_brt = bool2int(gear_F_pos < 0.99 and gear_F_pos > 0.01)
	gears_red_front_eng_brt = math.max(gears_red_front_eng_brt * lamps_brt, test_btn_eng)
	set(gears_red_front_eng, gears_red_front_eng_brt)
	
	local gears_red_right_eng_brt = bool2int(gear_R_pos < 0.99 and gear_R_pos > 0.01)
	gears_red_right_eng_brt = math.max(gears_red_right_eng_brt * lamps_brt, test_btn_eng)
	set(gears_red_right_eng, gears_red_right_eng_brt)
	
	local gears_green_left_eng_brt = bool2int(gear_L_pos >= 0.99)
	gears_green_left_eng_brt = math.max(gears_green_left_eng_brt * lamps_brt, test_btn_eng)
	set(gears_green_left_eng, gears_green_left_eng_brt)
	
	local gears_green_front_eng_brt = bool2int(gear_F_pos >= 0.99)
	gears_green_front_eng_brt = math.max(gears_green_front_eng_brt * lamps_brt, test_btn_eng)
	set(gears_green_front_eng, gears_green_front_eng_brt)
	
	local gears_green_right_eng_brt = bool2int(gear_L_pos >= 0.99)
	gears_green_right_eng_brt = math.max(gears_green_right_eng_brt * lamps_brt, test_btn_eng)
	set(gears_green_right_eng, gears_green_right_eng_brt)	
	
	
	-- alarm
	local sound_alarm = gear_not_ext or ((flap_pos_now_L < 14 or flap_pos_now_R < 14 or slats_now < 0.5) and (get(anim_rud1)+get(anim_rud2)+get(anim_rud3))/3 > 0.7 and math.max(get(deflection_mtr_2), get(deflection_mtr_3)) > 0.05)
	
	set(main_gear_flaps, bool2int(sound_alarm))
	
	
end


local stab_ind_act = 0
local elev_ind_act = 0
local flap_ind_L_act = 0
local flap_ind_R_act = 0


local function gauges()
	-- add power here
	local stabil_ind = 0
	local elev_ind = 0
	local flap_ind_L = 0
	local flap_ind_R = 0
	
	
	if get(bus36_volt_left) > 30 then
		stabil_ind = get(stab_pos) * 5.5
		elev_ind = -get(elevator_L)
		flap_ind_L = get(flap_inn_L)
		flap_ind_R = get(flap_inn_R)
	end
	
	-- calculate correction for elevator
	local ias = get(indicated_airspeed) * 1.852
	local mach = get(machno)
	
	
	stab_ind_act = stab_ind_act + (stabil_ind - stab_ind_act) * passed * 10
	elev_ind_act = elev_ind_act + (elev_ind - elev_ind_act) * passed * 10
	flap_ind_L_act = flap_ind_L_act + (flap_ind_L - flap_ind_L_act) * passed * 10
	flap_ind_R_act = flap_ind_R_act + (flap_ind_R - flap_ind_R_act) * passed * 10
	
	
	set(stab_ind, stab_ind_act)
	set(elevator_ind, interpolate(ind_tbl, elev_ind_act))
	set(flap_left_ind, flap_ind_L_act)
	set(flap_right_ind, flap_ind_R_act)
	
end


local stab_man_cap_last = get(stab_man_cap)
local contr_force_cap_last = get(contr_force_cap)
local nosewheel_turn_cap_last = get(nosewheel_turn_cap)
local slat_man_cap_last = get(slat_man_cap)
local gears_retr_lock_cap_last = get(gears_retr_lock_cap)
local gears_ext_3GS_cap_last = get(gears_ext_3GS_cap)
local busters_cap_last = get(busters_cap)
local flaps_sel_cap_last = get(flaps_sel_cap)
local emerg_elev_trimm_cap_last = get(emerg_elev_trimm_cap)

local function caps_check()

	local stab_man_cap_sw = get(stab_man_cap)
	local contr_force_cap_sw = get(contr_force_cap)
	local nosewheel_turn_cap_sw = get(nosewheel_turn_cap)
	local slat_man_cap_sw = get(slat_man_cap)
	local gears_retr_lock_cap_sw = get(gears_retr_lock_cap)
	local gears_ext_3GS_cap_sw = get(gears_ext_3GS_cap)
	local busters_cap_sw = get(busters_cap)
	local flaps_sel_cap_sw = get(flaps_sel_cap)
	local emerg_elev_trimm_cap_sw = get(emerg_elev_trimm_cap)
	
	if busters_cap_sw == 0 and get(buster_on_1) * get(buster_on_2) * get(buster_on_3) == 0 then 
		set(busters_cap, 1) 
		busters_cap_sw = 1
	end
	
	local changes = stab_man_cap_sw + contr_force_cap_sw + nosewheel_turn_cap_sw + slat_man_cap_sw + gears_retr_lock_cap_sw + gears_ext_3GS_cap_sw + busters_cap_sw + flaps_sel_cap_sw + emerg_elev_trimm_cap_sw
	
	changes = changes - stab_man_cap_last - contr_force_cap_last - nosewheel_turn_cap_last - slat_man_cap_last - gears_retr_lock_cap_last - gears_ext_3GS_cap_last - busters_cap_last - flaps_sel_cap_last - emerg_elev_trimm_cap_last
	
	if changes ~= 0 then playSample(cap_sound, false) end
	

	stab_man_cap_last = stab_man_cap_sw
	contr_force_cap_last = contr_force_cap_sw
	nosewheel_turn_cap_last = nosewheel_turn_cap_sw
	slat_man_cap_last = slat_man_cap_sw
	gears_retr_lock_cap_last = gears_retr_lock_cap_sw
	gears_ext_3GS_cap_last = gears_ext_3GS_cap_sw
	busters_cap_last = busters_cap_sw
	flaps_sel_cap_last = flaps_sel_cap_sw
	emerg_elev_trimm_cap_last = emerg_elev_trimm_cap_sw
	
	-- set switchers under caps
	if nosewheel_turn_cap_sw == 0 then set(nosewheel_turn_sel, 0) end
	if contr_force_cap_sw == 0 then set(contr_force_set, 0) end
	if gears_retr_lock_cap_sw == 0 then set(gears_retr_lock, 0) end
	if flaps_sel_cap_sw == 0 then set(flaps_sel, 0) end
	if gears_ext_3GS_cap_sw == 0 then set(gears_ext_3GS, 0) end
end


local stab_manual_last = get(stab_manual)
local stab_setting_last = get(stab_setting)
local ail_trimm_sw_last = get(ail_trimm_sw)
local rudd_trimm_sw_last = get(rudd_trimm_sw)
local contr_force_set_last = get(contr_force_set)
local nosewheel_turn_enable_last = get(nosewheel_turn_enable)
local nosewheel_turn_sel_last = get(nosewheel_turn_sel)
local slat_man_last = get(slat_man)
local flaps_sel_last = get(flaps_sel)
local gears_retr_lock_last = get(gears_retr_lock)
local gears_ext_3GS_last = get(gears_ext_3GS)
local buster_on_1_last = get(buster_on_1)
local buster_on_2_last = get(buster_on_2)
local buster_on_3_last = get(buster_on_3)
local emerg_elev_trimm_last = get(emerg_elev_trimm)

local function swichers_check()

	local stab_manual_sw = get(stab_manual)
	local stab_setting_sw = get(stab_setting)
	local ail_trimm_sw_sw = get(ail_trimm_sw)
	local rudd_trimm_sw_sw = get(rudd_trimm_sw)
	local contr_force_set_sw = get(contr_force_set)
	local nosewheel_turn_enable_sw = get(nosewheel_turn_enable)
	local nosewheel_turn_sel_sw = get(nosewheel_turn_sel)
	local slat_man_sw = get(slat_man)
	local flaps_sel_sw = get(flaps_sel)
	local gears_retr_lock_sw = get(gears_retr_lock)
	local gears_ext_3GS_sw = get(gears_ext_3GS)
	local buster_on_1_sw = get(buster_on_1)
	local buster_on_2_sw = get(buster_on_2)
	local buster_on_3_sw = get(buster_on_3)
	local emerg_elev_trimm_sw = get(emerg_elev_trimm)
	
	
	local changes = stab_manual_sw + stab_setting_sw + ail_trimm_sw_sw + rudd_trimm_sw_sw + contr_force_set_sw + nosewheel_turn_enable_sw + emerg_elev_trimm_sw
	changes = changes + nosewheel_turn_sel_sw + slat_man_sw + flaps_sel_sw + gears_retr_lock_sw + gears_ext_3GS_sw + buster_on_1_sw + buster_on_2_sw + buster_on_3_sw
	
	changes = changes - stab_manual_last - stab_setting_last - ail_trimm_sw_last - rudd_trimm_sw_last - contr_force_set_last - nosewheel_turn_enable_last - nosewheel_turn_sel_last
	changes = changes - slat_man_last - flaps_sel_last - gears_retr_lock_last - gears_ext_3GS_last - buster_on_1_last - buster_on_2_last - buster_on_3_last - emerg_elev_trimm_last
	
	if changes ~= 0 then playSample(switcher_sound, false) end

	stab_manual_last = stab_manual_sw
	stab_setting_last = stab_setting_sw
	ail_trimm_sw_last = ail_trimm_sw_sw
	rudd_trimm_sw_last = rudd_trimm_sw_sw
	contr_force_set_last = contr_force_set_sw
	nosewheel_turn_enable_last = nosewheel_turn_enable_sw
	nosewheel_turn_sel_last = nosewheel_turn_sel_sw
	slat_man_last = slat_man_sw
	flaps_sel_last = flaps_sel_sw
	gears_retr_lock_last = gears_retr_lock_sw
	gears_ext_3GS_last = gears_ext_3GS_sw
	buster_on_1_last = buster_on_1_sw
	buster_on_2_last = buster_on_2_sw
	buster_on_3_last = buster_on_3_sw
	emerg_elev_trimm_last = emerg_elev_trimm_sw


end


local sim_start_timer = 0

function update()
	passed = get(frame_time)
	sim_start_timer = sim_start_timer + passed
	
	if sim_start_timer > 0.3 then 
		if notLoaded then reset_switchers() end
	
		swichers_check() -- make them sound
		caps_check() -- make them sound
	end	
	
	gauges()
	lamps()

end

