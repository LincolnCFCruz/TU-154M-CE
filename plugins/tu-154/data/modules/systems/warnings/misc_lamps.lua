-- Lamps that read state from more than one system, so they don't belong to
-- any single system's own module.

-- power and test buttons

defineProperty("lamp_test", globalPropertyi("tu-154/buttons/lamp_test_front")) -- front panel lamp test button	0
defineProperty("day_night_set", globalPropertyf("tu-154/lights/day_night_set")) -- day/night switch. 0 = day, 1 = night. dims the annunciator lamps.

defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right"))


-- lamps
defineProperty("dh_lamp", globalPropertyf("tu-154/lights/decision_height")) -- decision height H
defineProperty("to_not_ready", globalPropertyf("tu-154/lights/to_not_ready")) -- not ready for takeoff
defineProperty("fuel_less_2500", globalPropertyf("tu-154/lights/fuel_less_2500")) -- fuel remaining 2500
defineProperty("sso_danger", globalPropertyf("tu-154/lights/sso_danger")) -- SSO danger
defineProperty("sso_connect", globalPropertyf("tu-154/lights/sso_connect")) -- SSO comms
defineProperty("speed_high", globalPropertyf("tu-154/lights/speed_high")) -- speed limit
--
defineProperty("damper_course", globalPropertyf("tu-154/lights/damper_course")) -- yaw damper
defineProperty("damper_roll", globalPropertyf("tu-154/lights/damper_roll")) -- roll damper
defineProperty("damper_pitch", globalPropertyf("tu-154/lights/damper_pitch")) -- pitch damper

defineProperty("no_reserve_c", globalPropertyf("tu-154/lights/no_reserve_c")) -- no K standby
defineProperty("no_reserve_g", globalPropertyf("tu-154/lights/no_reserve_g")) -- no G (hydraulic) standby

defineProperty("msg_lamp", globalPropertyf("tu-154/lights/msg_lamp")) -- MSG
defineProperty("wpt_lamp", globalPropertyf("tu-154/lights/wpt_lamp")) -- WPT
defineProperty("stuard_call", globalPropertyf("tu-154/lights/stuard_call")) -- flight attendant call

defineProperty("sns_lamp", globalPropertyf("tu-154/lights/sns_lamp")) -- SNS


-- sources
defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time")) -- time of frame

-- DH

defineProperty("rv5_dh_signal_left", globalPropertyi("tu-154/misc/rv5_dh_signal_left"))
defineProperty("rv5_dh_signal_right", globalPropertyi("tu-154/misc/rv5_dh_signal_right"))


-- TakeOff ready
defineProperty("nosewheel_steer_on", globalPropertyi("sim/cockpit2/controls/nosewheel_steer_on"))
defineProperty("nosewheel_turn_sel", globalPropertyi("tu-154/switchers/nosewheel_turn_sel")) -- nosewheel steering angle selector. 0 = 10, 1 = 63

defineProperty("cargo_1", globalPropertyf("tu-154/anim/cargo_1")) -- cargo door 1 position. 0 = closed, 1 = open
defineProperty("cargo_2", globalPropertyf("tu-154/anim/cargo_2")) -- cargo door 1 position. 0 = closed, 1 = open
defineProperty("pax_door_1", globalPropertyf("tu-154/anim/pax_door_1")) -- front passenger door position
defineProperty("pax_door_2", globalPropertyf("tu-154/anim/pax_door_2")) -- middle passenger door position
defineProperty("pax_door_3", globalPropertyf("tu-154/anim/pax_door_3")) -- right emergency door position

defineProperty("busters_cap", globalPropertyi("tu-154/switchers/console/busters_cap")) -- booster switch guard

defineProperty("spd_brk_inn_L", globalPropertyf("sim/flightmodel/controls/wing1l_spo1def")) -- inner speedbrake left Degrees
defineProperty("spd_brk_inn_R", globalPropertyf("sim/flightmodel/controls/wing1r_spo1def")) -- inner speedbrake right Degrees
defineProperty("slats", globalPropertyf("sim/flightmodel2/controls/slat1_deploy_ratio")) -- slats position. this one works too

defineProperty("gear2_deflect", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]"))  -- vertical deflection of left gear
defineProperty("gear3_deflect", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]"))  -- vertical deflection of right gear

-- fuel 2500
defineProperty("tank1_w", globalProperty("sim/flightmodel/weight/m_fuel[0]")) -- fuel weight

-- speed
defineProperty("ias_L", globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot")) -- indicated airspeed in KTS
defineProperty("ias_R", globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_copilot"))

defineProperty("msl_alt", globalPropertyf("sim/flightmodel/position/elevation"))  -- phisical altitude MSL. meters
defineProperty("msl_press", globalPropertyf("sim/weather/region/sealevel_pressure_pas"))  -- sea-level pressure (XP12: pascals)
defineProperty("mach_sim", globalPropertyf("sim/flightmodel/misc/machno")) -- Mach number
defineProperty("rel_pitot", globalPropertyi("sim/operation/failures/rel_pitot")) -- Pitot 1 - Blockage
defineProperty("rel_pitot2", globalPropertyi("sim/operation/failures/rel_pitot2")) -- Pitot 2 - Blockage

-- KLN
defineProperty("WPTalert", globalPropertyi("tu-154/xap/KLN90/WPT"))
defineProperty("MSGalert", globalPropertyi("tu-154/xap/KLN90/MSG"))

defineProperty("speaker_speed", globalPropertyi("tu-154/alarm/speaker_speed")) -- limit speed

-- ABSU
defineProperty("damp_roll_lamp", globalPropertyi("tu-154/absu/damp_roll_lamp"))
defineProperty("damp_pitch_lamp", globalPropertyi("tu-154/absu/damp_pitch_lamp"))
defineProperty("damp_yaw_lamp", globalPropertyi("tu-154/absu/damp_yaw_lamp"))
defineProperty("roll_contr_lamp", globalPropertyi("tu-154/absu/roll_contr_lamp"))
defineProperty("pitch_contr_lamp", globalPropertyi("tu-154/absu/pitch_contr_lamp"))
defineProperty("man_roll_lamp", globalPropertyi("tu-154/absu/man_roll_lamp"))
defineProperty("man_pitch_lamp", globalPropertyi("tu-154/absu/man_pitch_lamp"))
defineProperty("man_toga_lamp", globalPropertyi("tu-154/absu/man_toga_lamp"))

defineProperty("absu_landing_on", globalPropertyi("tu-154/switchers/console/absu_landing_on")) -- landing needles
defineProperty("roll_main_mode", globalPropertyi("tu-154/absu/roll_main_mode")) -- ABSU main roll mode. 0 = off, 1 = control-wheel steering, 2 = stabilisation
defineProperty("pitch_main_mode", globalPropertyi("tu-154/absu/pitch_main_mode")) -- ABSU main pitch mode. 0 = off, 1 = control-wheel steering, 2 = stabilisation


-- CourseMP

defineProperty("nav1_pow_cc", globalPropertyf("tu-154/radio/nav1_pow_cc")) -- Kurs-MP current draw
defineProperty("nav2_pow_cc", globalPropertyf("tu-154/radio/nav2_pow_cc")) -- Kurs-MP current draw
defineProperty("nav1_fail", globalPropertyi("tu-154/failures/nav1_fail"))
defineProperty("nav2_fail", globalPropertyi("tu-154/failures/nav2_fail"))

-- ready
defineProperty("to_ready", globalPropertyi("tu-154/checklist/to_ready")) -- lamp lit


local button_sound = loadSample('sounds/plastic_btn.wav')

local button_last = 0

local DH = 0

local to_not_ready_counter = 0
local to_not_ready_lit = 0

local fuel2500_counter = 0
local fuel2500_lit = 0

local WPT_counter = 0
local WPT_lit = 0

local MSG_counter = 0
local MSG_lit = 0

local TO_notReadyAct = 0


function update()
	
	
	local passed = get(frame_time)
	
	-- power and controlls
	local test_btn = get(lamp_test)-- 
	if button_last ~= test_btn then playSample(button_sound, false) end
	button_last = test_btn
	test_btn = test_btn * math.max((get(bus27_volt_right) - 10) / 18.5, 0)
	
	
	local day_night = 1 - get(day_night_set) * 0.25
	local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0) * day_night
	
	
	-- DH lamp
	DH = math.max(get(rv5_dh_signal_left), get(rv5_dh_signal_right))
	
	
	local dh_lamp_brt = math.max(DH * lamps_brt, test_btn)
	set(dh_lamp, dh_lamp_brt)
	
	
	-- TO not ready
	local TO_ready = get(nosewheel_steer_on) == 1 and get(nosewheel_turn_sel) == 0 and get(busters_cap) == 0
	TO_ready = TO_ready and get(cargo_1) + get(cargo_2) + get(pax_door_1) + get(pax_door_2) + get(pax_door_2) + get(pax_door_3) == 0
	TO_ready = TO_ready and get(spd_brk_inn_L) + get(spd_brk_inn_R) < 1 and get(slats) > 0.9
	TO_ready = TO_ready or (get(gear2_deflect) < 0.05 or get(gear3_deflect) < 0.05)
	
	
	if not TO_ready then
		to_not_ready_counter = to_not_ready_counter + passed
		if to_not_ready_counter > 0.3 then 
			to_not_ready_lit = 1 - to_not_ready_lit
			to_not_ready_counter = 0
		end
		set(to_ready, 1)
	else
		to_not_ready_counter = 0
		to_not_ready_lit = 0
		set(to_ready, 0)
	end
	
	TO_notReadyAct = TO_notReadyAct + (to_not_ready_lit - TO_notReadyAct) * passed * 10
	
	
	local to_not_ready_brt = math.max(TO_notReadyAct * lamps_brt, test_btn)
	set(to_not_ready, to_not_ready_brt)
	
	-- fuel 2500
	if get(tank1_w) < 2500 then 
		fuel2500_counter = fuel2500_counter + passed
		if fuel2500_counter > 0.3 then 
			fuel2500_lit = 1 - fuel2500_lit
			fuel2500_counter = 0
		end
		
	else
		fuel2500_counter = 0
		fuel2500_lit = 0
	end
	
	local fuel_less_2500_brt = math.max(fuel2500_lit * lamps_brt, test_btn)
	set(fuel_less_2500, fuel_less_2500_brt)
	
	-- overspeed
	local msl_press_inhg = get(msl_press) / 3386.389  -- XP12: convert Pa -> inHg
	local alt_std_mtr = (get(msl_alt) * 3.28083 + (29.92 - msl_press_inhg) * 1000) / 3.28083  -- calculate altitude in meters above standart pressure
	
	local ias = get(ias_L) * 1.852 -- km/h
	if get(rel_pitot) == 6 then ias = get(ias_R) * 1.852 end -- temp automatic switch
	
	local mach = get(mach_sim)
	
	-- V max e / M max e, Flight Manual sec. 2.5.4.1 (1), CG 32 % MAC or less:
	--   ground .. 7000 m : 600 km/h IAS
	--   7000 m and above : 575 km/h IAS or M 0.86, whichever comes first
	-- (they cross at about 9960 m; below 7000 m M is never limiting - at
	--  600 km/h IAS / 7000 m the Mach number is only about 0.74)
	local over_spd = (alt_std_mtr < 7000 and ias > 600) or
	                 (alt_std_mtr >= 7000 and (ias > 575 or mach > 0.86))
	
	set(speaker_speed, bool2int(over_spd))
	
	local speed_high_brt = math.max(bool2int(over_spd) * lamps_brt, test_btn)
	set(speed_high, speed_high_brt)
	
	
	-- KLN	
	if get(MSGalert) == 1 then
		MSG_counter = MSG_counter + passed
		if MSG_counter > 0.3 then 
			MSG_lit = 1 - MSG_lit
			MSG_counter = 0
		end
	else
		MSG_counter = 0
		MSG_lit = 0
	end
	
	
	local msg_lamp_brt = math.max(MSG_lit * lamps_brt, test_btn)
	set(msg_lamp, msg_lamp_brt)
	
	
	if get(WPTalert) == 1 then
		WPT_counter = WPT_counter + passed
		if WPT_counter > 0.3 then 
			WPT_lit = 1 - WPT_lit
			WPT_counter = 0
		end
	else
		WPT_counter = 0
		WPT_lit = 0
	end	
	
	
	local wpt_lamp_brt = math.max(WPT_lit * lamps_brt, test_btn)
	set(wpt_lamp, wpt_lamp_brt)
	
	-- dampers
	local damper_course_brt = math.max(get(damp_yaw_lamp) * lamps_brt, test_btn)
	set(damper_course, damper_course_brt)
	
	local damper_roll_brt = math.max(get(damp_roll_lamp) * lamps_brt, test_btn)
	set(damper_roll, damper_roll_brt)
	
	local damper_pitch_brt = math.max(get(damp_pitch_lamp) * lamps_brt, test_btn)
	set(damper_pitch, damper_pitch_brt)
	
	-- CourseMP
	local no_reserve_c_brt = math.max(bool2int(get(absu_landing_on) == 1 and (get(nav1_fail) == 1 or get(nav2_fail) == 1 or get(nav1_pow_cc) == 0 or get(nav2_pow_cc) == 0)) * lamps_brt, test_btn)
	set(no_reserve_c, no_reserve_c_brt)
	
	local no_reserve_g_brt = math.max(bool2int(get(absu_landing_on) == 1 and (get(nav1_fail) == 1 or get(nav2_fail) == 1 or get(nav1_pow_cc) == 0 or get(nav2_pow_cc) == 0)) * lamps_brt, test_btn)
	set(no_reserve_g, no_reserve_g_brt)
	
	
	--------------------------
	-- fake lamps --
	--------------------------
	
	local sso_danger_brt = math.max(0 * lamps_brt, test_btn)
	set(sso_danger, sso_danger_brt)
	
	local sso_connect_brt = math.max(0 * lamps_brt, test_btn)
	set(sso_connect, sso_connect_brt)
	
	local stuard_call_brt = math.max(0 * lamps_brt, test_btn)
	set(stuard_call, stuard_call_brt)
	
	
end