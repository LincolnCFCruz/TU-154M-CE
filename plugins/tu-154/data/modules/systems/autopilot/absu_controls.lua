

defineProperty("joy_pitch", globalPropertyf("tu-154/SC/yoke_pitch_ratio")) 
defineProperty("joy_roll", globalPropertyf("tu-154/SC/yoke_roll_ratio")) 
defineProperty("joy_yaw", globalPropertyf("tu-154/SC/yoke_heading_ratio")) 


defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time")) -- time of frame

-- hydraulics
defineProperty("gs_press_1", globalPropertyf("tu-154/hydro/gs_press_1")) -- hydraulic system 1 pressure
defineProperty("gs_press_2", globalPropertyf("tu-154/hydro/gs_press_2")) -- hydraulic system 2 pressure
defineProperty("gs_press_3", globalPropertyf("tu-154/hydro/gs_press_3")) -- hydraulic system 3 pressure


-- controls
defineProperty("hydro_ra56_rud_1", globalPropertyi("tu-154/switchers/eng/hydro_ra56_rud_1")) -- RA-56 yaw hydraulic supply
defineProperty("hydro_ra56_rud_2", globalPropertyi("tu-154/switchers/eng/hydro_ra56_rud_2")) -- RA-56 yaw hydraulic supply
defineProperty("hydro_ra56_rud_3", globalPropertyi("tu-154/switchers/eng/hydro_ra56_rud_3")) -- RA-56 yaw hydraulic supply

defineProperty("hydro_ra56_ail_1", globalPropertyi("tu-154/switchers/eng/hydro_ra56_ail_1")) -- RA-56 roll hydraulic supply
defineProperty("hydro_ra56_ail_2", globalPropertyi("tu-154/switchers/eng/hydro_ra56_ail_2")) -- RA-56 roll hydraulic supply
defineProperty("hydro_ra56_ail_3", globalPropertyi("tu-154/switchers/eng/hydro_ra56_ail_3")) -- RA-56 roll hydraulic supply

defineProperty("hydro_ra56_elev_1", globalPropertyi("tu-154/switchers/eng/hydro_ra56_elev_1")) -- RA-56 pitch hydraulic supply
defineProperty("hydro_ra56_elev_2", globalPropertyi("tu-154/switchers/eng/hydro_ra56_elev_2")) -- RA-56 pitch hydraulic supply
defineProperty("hydro_ra56_elev_3", globalPropertyi("tu-154/switchers/eng/hydro_ra56_elev_3")) -- RA-56 pitch hydraulic supply

defineProperty("absu_turn_handle", globalPropertyi("tu-154/switchers/console/absu_turn_handle")) -- turn knob
defineProperty("absu_pitch_wheel", globalPropertyf("tu-154/switchers/console/absu_pitch_wheel")) -- descend/climb thumbwheel

defineProperty("absu_zpu_sel", globalPropertyi("tu-154/switchers/console/absu_zpu_sel")) -- desired-track (ZPU) selector. left - right
defineProperty("ZK_select", globalPropertyi("tu-154/switchers/ZK_select")) -- "ZK entry" toggle on the front panel. 0-left, 1-right	0

defineProperty("absu_smooth_on", globalPropertyi("tu-154/switchers/console/absu_smooth_on")) -- "turbulence on" toggle

defineProperty("absu_nav_on", globalPropertyi("tu-154/switchers/console/absu_nav_on")) -- navigation needles
defineProperty("absu_landing_on", globalPropertyi("tu-154/switchers/console/absu_landing_on")) -- landing needles
defineProperty("absu_needles_on", globalPropertyi("tu-154/switchers/console/absu_needles_on")) -- needles

defineProperty("nav_select", globalPropertyi("tu-154/switchers/nav_select")) -- NVU-SNS toggle 0 - NVU, 1 - SNS


defineProperty("absu_speed_test_1", globalPropertyi("tu-154/buttons/console/absu_speed_test_1")) -- lower STU test button
defineProperty("absu_speed_test_2", globalPropertyi("tu-154/buttons/console/absu_speed_test_2")) -- upper STU test button


defineProperty("absu_use_second_nav", globalPropertyi("tu-154/absu_use_second_nav")) -- the ABSU uses the second Kurs-MP


-- PNP
defineProperty("pkp_course_L", globalPropertyf("tu-154/gauges/compas/pkp_helper_course_L")) -- heading set by the yellow needle on the PKP
defineProperty("pkp_course_R", globalPropertyf("tu-154/gauges/compas/pkp_helper_course_R")) -- heading set by the yellow needle on the PKP

defineProperty("pkp_gyro_course_L", globalPropertyf("tu-154/gauges/compas/pkp_gyro_course_L")) -- PKP gyro heading
defineProperty("pkp_gyro_course_R", globalPropertyf("tu-154/gauges/compas/pkp_gyro_course_R")) -- PKP gyro heading


defineProperty("pkp_obs_1", globalPropertyf("tu-154/gauges/compas/pkp_obs_L")) -- flight heading on the PKP
defineProperty("pkp_obs_2", globalPropertyf("tu-154/gauges/compas/pkp_obs_R")) -- flight heading on the PKP
-- angular speeds
defineProperty("roll_rate", globalPropertyf("sim/flightmodel/position/P")) -- deg/sec	The roll rotation rates (relative to the flight)
defineProperty("pitch_rate", globalPropertyf("sim/flightmodel/position/Q")) -- deg/sec	The pitch rotation rates (relative to the flight)
defineProperty("yaw_rate", globalPropertyf("sim/flightmodel/position/R")) -- deg/sec	The yaw rotation rates (relative to the flight)

defineProperty("roll_acc", globalPropertyf("sim/flightmodel/position/P_dot")) -- deg/sec2	The roll angular acceleration (relative to the flight)
defineProperty("pitch_acc", globalPropertyf("sim/flightmodel/position/Q_dot")) -- deg/sec2 The pitch angular acceleration (relative to the flight)
defineProperty("yaw_acc", globalPropertyf("sim/flightmodel/position/R_dot")) -- deg/sec2 The yaw angular acceleration rates (relative to the flight)

defineProperty("slip", globalPropertyf("sim/cockpit2/gauges/indicators/sideslip_degrees"))


-- SVS
defineProperty("mach_svs", globalPropertyf("tu-154/svs/machno")) -- Mach number
defineProperty("alt_svs", globalPropertyf("tu-154/svs/altitude")) -- Altitude by 1013 hpa

defineProperty("ias", globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot")) -- indicated airspeed in KTS

-- NVU
defineProperty("nvu_res_course", globalPropertyf("tu-154/nvu/nvu_res_course")) -- flight heading from the NVU
defineProperty("nvu_res_z", globalPropertyf("tu-154/nvu/nvu_res_z")) -- offset from the NVU flight track

-- ABSU modes
defineProperty("roll_main_mode", globalPropertyi("tu-154/absu/roll_main_mode")) -- ABSU main roll mode. 0 = off, 1 = control-wheel steering, 2 = stabilisation
defineProperty("pitch_main_mode", globalPropertyi("tu-154/absu/pitch_main_mode")) -- ABSU main pitch mode. 0 = off, 1 = control-wheel steering, 2 = stabilisation

defineProperty("roll_sub_mode", globalPropertyi("tu-154/absu/roll_sub_mode")) -- ABSU roll mode. 0 - off, 1 - stab, 2 - ZK, 3 - NVU, 4 - AZ1, 5 - AZ2, 6 - approach
defineProperty("pitch_sub_mode", globalPropertyi("tu-154/absu/pitch_sub_mode")) -- ABSU pitch mode. 0 - off, 1 - stab, 2 - V, 3 - M, 4 - H, 5 - glideslope, 6 - go-around


-- BKK
defineProperty("bkk_pitch", globalPropertyf("tu-154/bkk/bkk_pitch")) -- resulting pitch from the BKK
defineProperty("bkk_roll", globalPropertyf("tu-154/bkk/bkk_roll")) -- resulting pitch from the BKK

-- TKS
defineProperty("course_gpk", globalPropertyf("tu-154/tks/course_gpk")) -- resulting TKS heading - GPK
defineProperty("course_gmk", globalPropertyf("tu-154/tks/course_gmk")) -- resulting TKS heading - GMK
defineProperty("tks_fail_left", globalPropertyi("tu-154/tks/fail_left")) -- failure flag
defineProperty("tks_fail_right", globalPropertyi("tu-154/tks/fail_right")) -- failure flag


-- DISS
defineProperty("diss_groundspeed", globalPropertyf("tu-154/nvu/diss_groundspeed")) -- ground speed from the DISS
defineProperty("diss_slip_angle", globalPropertyf("tu-154/nvu/diss_slip_angle")) -- drift angle from the DISS

-- Course MP
defineProperty("nav_cs_1", globalPropertyf("tu-154/radio/nav1_cs")) -- course plank
defineProperty("nav_cs_2", globalPropertyf("tu-154/radio/nav2_cs")) -- course plank
defineProperty("nav_gs_1", globalPropertyf("tu-154/radio/nav1_gs")) -- glideslope
defineProperty("nav_gs_2", globalPropertyf("tu-154/radio/nav2_gs")) -- glideslope

defineProperty("freq_1", globalPropertyf("sim/cockpit2/radios/actuators/nav1_frequency_hz"))  -- set the frequency
defineProperty("freq_2", globalPropertyf("sim/cockpit2/radios/actuators/nav2_frequency_hz"))  -- set the frequency

defineProperty("nav_cs_flag_1", globalPropertyi("tu-154/radio/nav1_cs_flag"))
defineProperty("nav_gs_flag_1", globalPropertyi("tu-154/radio/nav1_gs_flag"))

defineProperty("nav_cs_flag_2", globalPropertyi("tu-154/radio/nav2_cs_flag"))
defineProperty("nav_gs_flag_2", globalPropertyi("tu-154/radio/nav2_gs_flag"))



-- KLN
defineProperty("kln_course", globalPropertyf("tu-154/kln90/kln_course")) -- desired track (LZP) from the KLN
defineProperty("kln_dev", globalPropertyf("tu-154/kln90/kln_dev")) -- cross-track deviation from the desired track, nm


defineProperty("show_gns", globalPropertyi("tu-154/anim/show_gns"))
defineProperty("show_RXP",globalPropertyi("tu-154/anim/RXP"))


-- RXP
defineProperty("RXP_course", globalPropertyf("RXP/radios/indicators/gps_course_degtm")) -- desired track (LZP) from the KLN
defineProperty("RXP_dev", globalPropertyf("RXP/radios/indicators/gps_cross_track_nm")) -- cross-track deviation from the desired track, nm

-- GNS
defineProperty("GNS430_dtk", globalPropertyf("tu-154/SC/GNS430_dtk")) -- heading on the GNS
defineProperty("GNS430_dev", globalPropertyf("tu-154/SC/GNS430_dev")) -- cross-track deviation from the GNS


-- RV
defineProperty("rv5_alt", globalPropertyf("tu-154/misc/rv5_alt_left"))  -- altitude on the left altimeter

defineProperty("dh_set", globalPropertyf("tu-154/gauges/alt/radioalt_dh_left"))  -- DH angle
defineProperty("rv_angle", globalPropertyf("tu-154/gauges/alt/radioalt_needle_left"))  -- RV needle

-- Landing Gears
defineProperty("gear1_deploy", globalProperty("sim/aircraft/parts/acf_gear_deploy[0]"))  -- deploy of front gear
defineProperty("gear2_deploy", globalProperty("sim/aircraft/parts/acf_gear_deploy[1]"))  -- deploy of right gear
defineProperty("gear3_deploy", globalProperty("sim/aircraft/parts/acf_gear_deploy[2]"))  -- deploy of left gear

-- flaps
defineProperty("flap_inn_L", globalPropertyf("sim/flightmodel/controls/wing1l_fla1def")) -- inner flaps left
defineProperty("flap_inn_R", globalPropertyf("sim/flightmodel/controls/wing1r_fla1def")) -- inner flaps right

-- ailerons 20, rudder 25, elevator 25-20


-- results
defineProperty("absu_roll_ind", globalPropertyf("tu-154/absu/absu_roll_ind")) -- roll director indication
defineProperty("absu_pitch_ind", globalPropertyf("tu-154/absu/absu_pitch_ind")) -- pitch director indication

defineProperty("absu_roll_flag", globalPropertyi("tu-154/absu/absu_roll_flag")) --	roll director flag
defineProperty("absu_pitch_flag", globalPropertyi("tu-154/absu/absu_pitch_flag")) -- pitch director flag

-- result ABSU controls
defineProperty("absu_contr_pitch", globalPropertyf("tu-154/absu/cmd_pitch")) -- RA-56 pitch actuator rod travel
defineProperty("absu_contr_roll", globalPropertyf("tu-154/absu/cmd_roll")) -- RA-56 roll actuator rod travel
defineProperty("absu_contr_yaw", globalPropertyf("tu-154/absu/cmd_yaw")) -- RA-56 yaw actuator rod travel

defineProperty("absu_pitch_trimm", globalPropertyi("tu-154/absu/absu_pitch_trimm")) -- trim command from the ABSU. +1 = up, -1 = down

defineProperty("absu_course_out", globalPropertyi("tu-154/absu_course_out")) -- flying outside the course limits
defineProperty("absu_gs_out", globalPropertyi("tu-154/absu_gs_out")) -- flying outside the course limits


-- failures
defineProperty("absu_damp_roll_fail", globalPropertyi("tu-154/failures/absu_damp_roll_fail")) -- roll damper failure
defineProperty("absu_damp_pitch_fail", globalPropertyi("tu-154/failures/absu_damp_pitch_fail")) -- pitch damper failure
defineProperty("absu_damp_yaw_fail", globalPropertyi("tu-154/failures/absu_damp_yaw_fail")) -- yaw damper failure
defineProperty("absu_contr_roll_fail", globalPropertyi("tu-154/failures/absu_contr_roll_fail")) -- lateral control failure
defineProperty("absu_contr_pitch_fail", globalPropertyi("tu-154/failures/absu_contr_pitch_fail")) -- longitudinal control failure
defineProperty("absu_calc_toga_fail", globalPropertyi("tu-154/failures/absu_calc_toga_fail")) -- go-around computer failure
defineProperty("absu_calc_roll_fail", globalPropertyi("tu-154/failures/absu_calc_roll_fail")) -- STU lateral channel failure
defineProperty("absu_calc_pitch_fail", globalPropertyi("tu-154/failures/absu_calc_pitch_fail")) -- STU longitudinal channel failure


defineProperty("man_roll_lamp", globalPropertyi("tu-154/absu/man_roll_lamp")) 
defineProperty("man_pitch_lamp", globalPropertyi("tu-154/absu/man_pitch_lamp")) 


-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control

--for ABSU MAN mode
defineProperty("yoke_pitch", globalPropertyf("tu-154/controlls/yoke_pitch")) -- control wheel pitch travel
defineProperty("int_pitch_trim", globalPropertyf("tu-154/trimmers/int_pitch_trim")) -- elevator trim position
defineProperty("hydro_long_control", globalPropertyi("tu-154/switchers/eng/hydro_long_control")) -- longitudinal controllability
defineProperty("tks_course_set", globalPropertyi("tu-154/switchers/ovhd/tks_course_set")) -- heading selector

defineProperty("absu_ra1_roll_fail", globalPropertyi("tu-154/failures/absu_ra1_roll_fail"))
defineProperty("absu_ra2_roll_fail", globalPropertyi("tu-154/failures/absu_ra2_roll_fail"))
defineProperty("absu_ra3_roll_fail", globalPropertyi("tu-154/failures/absu_ra3_roll_fail"))
defineProperty("absu_ra1_pitch_fail", globalPropertyi("tu-154/failures/absu_ra1_pitch_fail"))
defineProperty("absu_ra2_pitch_fail", globalPropertyi("tu-154/failures/absu_ra2_pitch_fail"))
defineProperty("absu_ra3_pitch_fail", globalPropertyi("tu-154/failures/absu_ra3_pitch_fail"))
defineProperty("absu_ra1_yaw_fail", globalPropertyi("tu-154/failures/absu_ra1_yaw_fail"))
defineProperty("absu_ra2_yaw_fail", globalPropertyi("tu-154/failures/absu_ra2_yaw_fail"))
defineProperty("absu_ra3_yaw_fail", globalPropertyi("tu-154/failures/absu_ra3_yaw_fail"))


local pitch_act = 0
local roll_act = 0
local yaw_act = 0

local pitch_now = get(bkk_pitch)
local roll_now = get(bkk_roll)

local mach = get(mach_svs)

local flap_coef = 0.025

local pitch_stab_roll_coef = 0.00175 * 2

local gear_down = get(gear1_deploy) + get(gear2_deploy) + get(gear3_deploy) > 0.05
local flaps = (get(flap_inn_L) + get(flap_inn_R)) / 2


local passed = get(frame_time)

-- manual pitch
local pitch_coef = 0.3

local elev_lim = 0.345
local ail_lim = 0.4


-- PU
pitch_whl_last = 0
PU_pitch = pitch_now

-- V
local V_stab = get(ias) / 1.852
local V_smth = V_stab
local V_last = V_stab
local I_V = 0


-- M
local M_stab = get(mach_svs)
local M_smth = M_stab
local I_M = 0
local M_last = M_stab


-- H
local H_stab = get(alt_svs)
local H_last = H_stab
local I_H = 0

-- GS
local GS_last = 0
local GS_smth = 0
local GS_est = 0

-- TOGA
local toga_alt = get(alt_svs)

-- ROLL
local roll_coef = 0.5

-- handle mode
local course_stab_timer = 0
local course_stab_act = get(course_gpk)

-- NVU
local nvu_z_last = 0
local nvu_side_last = 0
local nvu_spd_last = 0
local nvu_course_last = 0

-- KLN
local kln_frame_timer = 0
local kln_Z_last = 0
local kln_spd = 0

local course_change_timer = 0

-- VOR
local vor_slip_act = 0
local vor_dev_lim = 4
local vor_dev_act = 0


-- APP
local dev_last = 0
local ILS_spd_smth = 0
local ILS_dev_smth = 0
local ILS_spd_last = 0


local roll_ail_tbl = {
{0, 1},
{0.2, 1},
{0.3, 0.5},
{0.4, -0.1},
{0.6, -0.2},
{0.8, -0.4},
{1, -0.6}

}

local pitch_elev_tbl = {
{0, 0.5},
{0.2, 0.5},
{0.3, 0.3},
{0.4, 0.2},
{0.6, 0},
{0.8, -0.1},
{1, -0.2}

}


local flaps_tbl = {
{0, 0},
{15, 5},
{28, 7},
{36, 8},
{45, 10},
{50, 10}
}

local pitch_coeff_red_table = {
{-100, 1}, -- bugs workaround
{0, 1},
{300, 1},
{400, 0.45},
{450, 0.25},
{700, 0.25}
}

local pitch_need = get(bkk_pitch)
local roll_need = get(bkk_roll)

local roll_need_smth = roll_need
local pitch_need_smth = pitch_need

local pitch_show = pitch_need
local roll_show = roll_need

local HS1 = math.max(math.min((get(gs_press_1) - 10) / 70, 1), 0)
local HS2 = math.max(math.min((get(gs_press_2) - 10) / 70, 1), 0)
local HS3 = math.max(math.min((get(gs_press_3) - 10) / 70, 1), 0)

local gps_Z_smooth = 0

local absu_roll_damp=0
local absu_roll_gain=0
local roll_W_prev=0
local absu_roll_damp_K=0

local absu_yaw_damp=0
local yaw_W_prev=0


local pitch_res_need = 0
local roll_res_need = 0
local yaw_res_need = 0

local MASTER = get(ismaster) ~= 1

-- functions will be defined later
local function pitch_holder(pitch_hold)
end

local function roll_holder(roll_hold)
end

local function yaw_holder(mode)
end


function update()
	
	passed = get(frame_time)
	
	MASTER = get(ismaster) ~= 1	
	
	local secondNav = get(absu_use_second_nav) == 1
	
	local roll_mode = get(roll_main_mode) -- 0 - off, 1 - control wheel - 2 - stab
	local pitch_mode = get(pitch_main_mode) -- 0 - off, 1 - control wheel - 2 - stab
	
	local roll_submode = get(roll_sub_mode) -- 0 - off, 1 - stab, 2 - ZK, 3 - NVU, 4 - AZ1, 5 - AZ2, 6 - approach
	local pitch_submode = get(pitch_sub_mode) -- 0 - off, 1 - stab, 2 - V, 3 - M, 4 - H, 5 - glideslope, 6 - go-around
	
	pitch_now = get(bkk_pitch)
	roll_now = get(bkk_roll)
	
	
	local roll_W = get(roll_rate)
	local pitch_W = get(pitch_rate)
	local yaw_W = -get(slip)
	
	local roll_W2 = get(roll_acc)
	local pitch_W2 = get(pitch_acc)
	local yaw_W2 = get(yaw_acc)
	
	if get(absu_damp_roll_fail) == 1 then
		roll_W = 0
		roll_W2 = 0
	end
	
	if get(absu_damp_pitch_fail) == 1 then
		pitch_W = 0
		pitch_W2 = 0
	end
	
	if get(absu_damp_yaw_fail) == 1 then
		yaw_W = 0
		yaw_W2 = 0
	end
	
	
	local pitch_cmd = get(joy_pitch)
	local roll_cmd = get(joy_roll)
	local yaw_cmd = get(joy_yaw)
	
	mach = get(mach_svs)
	local airspeed = get(ias) * 1.852
	local gnd_spd = get(diss_groundspeed)
	local alt = get(alt_svs)
	local gs_dev = get(nav_gs_1) * 10
	
	-- switch GS source to second CoursMP
	if secondNav then gs_dev = get(nav_gs_2) * 10 end
	
	local RV_alt = get(rv5_alt)
	
	gear_down = get(gear1_deploy) + get(gear2_deploy) + get(gear3_deploy) > 0.05
	flaps = (get(flap_inn_L) + get(flap_inn_R)) / 2
	
	local nav_on = get(absu_nav_on) == 1
	local app_on = get(absu_landing_on) == 1
	local needles_on = get(absu_needles_on) == 1
	
	HS1 = math.max(math.min((get(gs_press_1) - 10) / 70, 1), 0)
	HS2 = math.max(math.min((get(gs_press_2) - 10) / 70, 1), 0)
	HS3 = math.max(math.min((get(gs_press_3) - 10) / 70, 1), 0)
	
	
	-----------------------------------
	-- pitch part --
	-----------------------------------
	
	-- new logic
	-- calculate needed pitch, 
	-- put it into pitch holding logic, wich will use PID regulators, flaps and roll parts with trimmer and damper
	
	
	local absu_smooth = get(absu_smooth_on)
	
	if pitch_mode >= 1 then -- SAU pitch part
	
		if pitch_submode == 1 or pitch_submode == 10 then -- PU mode
			
			-- PU part			
			local pitch_whl = get(absu_pitch_wheel)
			local pitch_diff = pitch_whl - pitch_whl_last
			
			
			while pitch_diff > 1 do pitch_diff = pitch_diff - 20 end
			while pitch_diff < -1 do pitch_diff = pitch_diff + 20 end
			
			pitch_whl_last = pitch_whl
			
			
			PU_pitch = PU_pitch + pitch_diff * 0.2
			
			if PU_pitch > 17 then PU_pitch = 17
			elseif PU_pitch < -17 then PU_pitch = -17 end
			
					
			pitch_need = PU_pitch -- save the pitch for controls and needles
			
			V_stab = airspeed
			V_smth = V_stab
			
			M_stab = mach
			M_smth = M_stab
			toga_alt = alt
			H_stab = alt					
			
			
		elseif pitch_submode == 2 then -- stab V mode
			
			-- PID part
			
			-- smooth airspeed to prevent turb effect
			V_smth = V_smth + (airspeed - V_smth) * passed * 1
			
			-- P
			local P_V = V_smth - V_stab
			
			-- I
			I_V = I_V + P_V * passed * 0.005
			
			I_V = I_V - sign(I_V) * passed * 0.02
			
			if I_V > 1 then I_V = 1
			elseif I_V < -1 then I_V = -1 end
			
			
			-- D
			local D_V = 0
			if passed ~= 0 then
				D_V = (V_smth - V_last) / passed
			end
			
			
			local K_PV = 0.5
			local K_DV = 2 * (1 - absu_smooth) * 0.5
			
			
			local PID_part = P_V * K_PV + D_V * K_DV + I_V
			
			
			pitch_need = PID_part + PU_pitch
			
			if pitch_need > 17 * 1 then pitch_need = 17 * 1
			elseif pitch_need < -17 * 0.5 then pitch_need = -17 * 0.5 end
			
			
			PU_pitch = PU_pitch + (pitch_now - PU_pitch) * passed * 0.3
			M_stab = mach
			M_smth = M_stab
			toga_alt = alt
			H_stab = alt					
			
		elseif pitch_submode == 3 then -- stab M mode
			
			-- PID part
			
			-- smooth airspeed to prevent turb effect
			M_smth = M_smth + (mach - M_smth) * passed * 1
			
			-- P
			local P_M = M_smth - M_stab
			
			-- I
			I_M = I_M + P_M * passed * 0.05
			
			I_M = I_M - sign(I_M) * passed * 0.2
			
			if I_M > 1 then I_M = 1
			elseif I_M < -1 then I_M = -1 end
			
			
			-- D
			local D_M = 0
			if passed ~= 0 then
				D_M = (M_smth - M_last) / passed
			end
			
			
			local K_PM = 300
			local K_DM = 500 * (1 - absu_smooth * 0.5)
			
			
			local PID_part = P_M * K_PM + D_M * K_DM + I_V
			
			
			pitch_need = PID_part + PU_pitch
			
			if pitch_need > 17 * 0.8 then pitch_need = 17 * 0.8
			elseif pitch_need < -17 * 0.5 then pitch_need = -17 * 0.5 end
			
			
			PU_pitch = PU_pitch + (pitch_now - PU_pitch) * passed * 0.3
			
			V_stab = airspeed
			V_smth = V_stab
			
			toga_alt = alt
			H_stab = alt			
			
		elseif pitch_submode == 4 then -- stab H mode
			
			-- PID part
			-- P
			local P_H = alt - H_stab
			
			if P_H > 100 then P_H = 100
			elseif P_H < -100 then P_H = -100 end
			
			-- I
			I_H = I_H + P_H * passed * 0.00001
			
			
			if I_H > 0.1 then I_H = 0.1
			elseif I_H < -0.1 then I_H = -0.1 end
			
			
			-- D
			local D_H = 0
			if passed ~= 0 then
				D_H = (alt - H_last) / passed
			end
			
			-- near ground coefs
			local K_PH = line(mach, 0.3, 0.1, 0.8, 0.05) --0.1
			local K_DH = line(mach, 0.3, 0.3, 0.8, 0.15) * (1 - absu_smooth * 0.5)--0.3 * (1 - absu_smooth * 0.5)
			
			
			local PID_part = P_H * K_PH + D_H * K_DH + I_H
			
		
			pitch_need = -PID_part + PU_pitch
			
			
			if pitch_need > 17 * 0.5 then pitch_need = 17 * 0.5
			elseif pitch_need < -17 * 0.5 then pitch_need = -17 * 0.5 end
			
			
			PU_pitch = PU_pitch + (pitch_now - PU_pitch) * passed * 0.3

			
			V_stab = airspeed
			V_smth = V_stab
			
			M_stab = mach
			M_smth = M_stab
			toga_alt = alt
		
		elseif pitch_submode == 5 then -- GS mode
		
			-- coursMP part
			GS_smth = GS_smth + (gs_dev - GS_smth) * passed * 5
			
						
			local gs_spd = 0
			if passed ~= 0 then
				gs_spd = (GS_smth - GS_last) / passed
			end
			
			
			local K_P_GS = 2
			local K_GSspd = 5
			
			if RV_alt <= 250 then
				K_P_GS = 1
				K_GSspd = 2.5
			end
			
			local GS_part = GS_smth * K_P_GS + gs_spd * K_GSspd
			
			pitch_need = -GS_part + PU_pitch
			
			if pitch_need > 17 * 0.4 then pitch_need = 17 * 0.4
			elseif pitch_need < -17 * 0.5 then pitch_need = -17 * 0.5 end
			
			-- correct pitch when GS is caught
			if math.abs(GS_smth) < 1 then GS_est = 1
			elseif math.abs(GS_smth) > 6 then GS_est = 0
			end
			
			
			PU_pitch = PU_pitch + (pitch_now - PU_pitch) * passed * 0.1
			
			V_stab = airspeed
			V_smth = V_stab
			
			M_stab = mach
			M_smth = M_stab
			
			H_stab = alt		
			
			toga_alt = alt

			-- lamps logic
			if RV_alt <= 100 and math.abs(GS_smth) > 4 then
				set(absu_gs_out, 1)
			end
			
		
		elseif pitch_submode == 6 and get(absu_calc_toga_fail) == 0 then -- TOGA mode
			

			-- calculate V stab
			if flaps >= 40 then V_stab = 290
			elseif flaps < 40 and flaps >= 25 then V_stab = 345
			else V_stab = 400 end
			
			-- PID part
			
			-- smooth airspeed to prevent turb effect
			V_smth = V_smth + (airspeed - V_smth) * passed * 1
			
			-- P
			local P_V = V_smth - V_stab
			
			
			if P_V > 3 then P_V = 3
			elseif P_V < -3 then P_V = -3 end
			
			
			-- I
			I_V = I_V + P_V * passed * 0.005
			
			I_V = I_V - sign(I_V) * passed * 0.02
			
			if I_V > 1 then I_V = 1
			elseif I_V < -1 then I_V = -1 end
			
			
			-- D
			local D_V = 0
			if passed ~= 0 then
				D_V = (V_smth - V_last) / passed
			end
			
			
			local K_PV = 0.5
			local K_DV = 2 * (1 - absu_smooth) * 0.5
			
			
			local PID_part = P_V * K_PV + D_V * K_DV + I_V
			
			
			-- limit descend
			if alt < toga_alt then 
				pitch_need = pitch_need + passed * 2
			else -- hold speed
				pitch_need = PID_part + PU_pitch
			end
			
			if pitch_need > 17 then pitch_need = 17
			elseif pitch_need < 0 then pitch_need = 0 end
			

			PU_pitch = PU_pitch + (pitch_now - PU_pitch) * passed * 0.2
			M_stab = mach
			M_smth = M_stab
			
			H_stab = alt			
			toga_alt = alt
			
		else
			PU_pitch = pitch_now
			
			V_stab = airspeed
			V_smth = V_stab
			
			M_stab = mach
			M_smth = M_stab
			
			H_stab = alt			
			
		
		end
		
		-- save last values
		V_last = V_smth
		M_last = M_smth
		H_last = alt
		GS_last = GS_smth
		
		
		-- controll the elevator and trimmer
		if pitch_mode == 1 then -- manual mode
			local absu_k=math.max(2.125*get(int_pitch_trim)+0.1667,-0.4) -- ABSU Pitch constant as function of trimmed position
			local elev_need = (get(yoke_pitch)-get(int_pitch_trim)) * absu_k * get(hydro_long_control) - pitch_W * 1/30 -- yoke plus damper, K_damp=1 as per literature
			if elev_need > elev_lim then elev_need = elev_lim
			elseif elev_need < -elev_lim then elev_need = -elev_lim end
			
			if MASTER then set(absu_pitch_trimm, 0) end
			
			V_stab = airspeed
			V_smth = V_stab
			
			M_stab = mach
			M_smth = M_stab
			
			H_stab = alt
			
			PU_pitch = pitch_now
			pitch_need_smth = pitch_now
			
			pitch_res_need = elev_need
			
		elseif pitch_mode == 2 then -- stab mode
			
			if get(absu_calc_pitch_fail) == 0 then pitch_res_need = pitch_holder(pitch_need) end

		end
		
		pitch_show = pitch_need
		
	else
			pitch_need_smth = 0
			
			pitch_res_need = 0
		
	end
	
	-- results pitch position --
	if MASTER then
		set(absu_contr_pitch,pitch_res_need)
	end
	------------------------------
	-- roll part --
	------------------------------
	
	local course_now = get(course_gpk)
	
	
	if roll_mode >= 1 then -- SAU roll part
		
		
		-- save or reset course handling in RESET mode
		local roll_handle = get(get(absu_turn_handle))
		
		
		if math.abs(roll_handle) <= 1 and roll_mode == 2 and roll_submode == 1 then 
			course_stab_timer = course_stab_timer + passed -- roll the timer to hold course
		else 
			course_stab_timer = 0
			course_stab_act = course_now
		end
		
		
		if roll_submode == 1 or roll_submode == 10 then -- stab mode
		
			
			if course_stab_timer > 0 and course_stab_timer < 8 then
				local diff = course_now - course_stab_act
				if diff > 180 then diff = diff - 360
				elseif diff < -180 then diff = diff + 360 end
				
				course_stab_act = course_stab_act + diff * passed * 3
			end
		
			if get(tks_course_set)~=0 then
				course_stab_act = course_now
			end			
			local course_diff = course_stab_act - course_now
			
			if course_diff > 180 then course_diff = course_diff - 360
			elseif course_diff < -180 then course_diff = course_diff + 360 end
			

			if course_stab_timer > 8 then -- course part
				roll_need = course_diff * 1.5
			else 
				if math.abs(roll_handle) <= 1 then 
					roll_need = 0 
				else roll_need = roll_handle * 0.6
				end
				
			end
			
			-- limit the roll
			if roll_need > 30 then roll_need = 30
			elseif roll_need < -30 then roll_need = -30 end
		
			
			roll_show = 0
			
			ILS_dev_smth = 0

			
		elseif roll_submode == 2 then -- ZK mode
			
			local zk_course = get(pkp_course_L)
			
			course_now = get(pkp_gyro_course_L)
			
			if get(ZK_select) == 1 then 
				zk_course = get(pkp_course_R) 
				course_now = get(pkp_gyro_course_R)
			end
			
			local course_diff = zk_course - course_now
			if course_diff > 180 then course_diff = course_diff - 360
			elseif course_diff < -180 then course_diff = course_diff + 360 end
			
			roll_need = course_diff * 2
			
			-- limit the roll
			if roll_need > 25 then roll_need = 25
			elseif roll_need < -25 then roll_need = -25 end
			
			roll_show = 0
			
			ILS_dev_smth = 0
			
			
		elseif roll_submode == 3 then -- NVU mode	
		
			local nvu_course = get(nvu_res_course)
			local nvu_z = get(nvu_res_z)
			
			local kln_mode = get(nav_select) == 1
			
			local KZ = 0.02 -- deg roll / m
			local KPZ = 0.6 -- deg roll / m/s
			
			-- KLN source
			if kln_mode then
				nvu_course = get(kln_course)
				nvu_z = -get(kln_dev) * 1.852 -- km
			end
			
			
			-- GNS430 source
			if get(show_gns) == 1 and get(show_RXP) == 0 and kln_mode then
				nvu_course = get(GNS430_dtk)
				local Z = -get(GNS430_dev) * 1.852 * 0.8 -- km
				gps_Z_smooth = gps_Z_smooth - (gps_Z_smooth - Z) * passed
				nvu_z = gps_Z_smooth
				
			end

			-- RXP source
			if get(show_gns) == 1 and get(show_RXP) == 1 and kln_mode then
				nvu_course = get(RXP_course)
				local Z = -get(RXP_dev) * 1.852 -- km
				gps_Z_smooth = gps_Z_smooth - (gps_Z_smooth - Z) * passed
				nvu_z = gps_Z_smooth
				
			end
			
			
			local side_lim = 2400 -- m
			local side_spd_lim = 160 -- m/s
			
			
			local side = nvu_z * 1000 -- meters
			
			if side > side_lim then side = side_lim
			elseif side < -side_lim then side = -side_lim end	
			
			-- PID
			local PZ = 0
			
			if not kln_mode or (get(show_gns) >= 1 and kln_mode) then -- NVU or GNS mode
				if passed ~= 0 then PZ = (nvu_z - nvu_z_last) / passed end
			else -- KLN mode
				if nvu_z ~= nvu_z_last then -- new data arrived
					if kln_frame_timer ~= 0 then
						kln_spd = (nvu_z - kln_Z_last) / kln_frame_timer 
					end
					
					kln_Z_last = nvu_z
					kln_frame_timer = 0
				else
					kln_frame_timer = kln_frame_timer + passed
				end
				PZ = kln_spd
				
			end
			
			
			nvu_z_last = nvu_z
			
	
			local side_spd = PZ * 1000 -- meters/sec
			
			if side_spd > side_spd_lim then side_spd = side_spd_lim
			elseif side_spd < -side_spd_lim then side_spd = -side_spd_lim end
			
			
			-- fix turns
			if math.abs(nvu_course - nvu_course_last) > 0.5 then course_change_timer = 0 end
			nvu_course_last = nvu_course
			
			if course_change_timer < 3 then -- course changing. hold previous parameters to prevent wrong roll command
				side = 0 --nvu_side_last
				side_spd = 0 -- nvu_spd_last
			end
						
			course_change_timer = course_change_timer + passed
			
			
			course_now = get(pkp_gyro_course_L)
			
			--
			if math.abs(nvu_z) > 3.5 then
				local new_course = nvu_course - 30 * sign(nvu_z)
				if new_course < 0 then new_course = new_course + 360 
				elseif new_course > 360 then new_course = new_course - 360 end
				
				local course_diff = new_course - course_now
			
				if course_diff > 180 then course_diff = course_diff - 360
				elseif course_diff < -180 then course_diff = course_diff + 360 end
			
				roll_need = course_diff * 2
			else
				roll_need = -side * KZ - side_spd * KPZ
			end
			
			
			if roll_need > 25 then roll_need = 25
			elseif roll_need < -25 then roll_need = -25 end
			
			-- fix rapid course changing
			local course_delta = nvu_course - course_now
			while course_delta > 180 do course_delta = course_delta - 360 end
			while course_delta < -180 do course_delta = course_delta + 360 end
			
			if math.abs(course_delta) > 90 then
				roll_need = sign(course_delta) * 25
			end
			
			
			roll_show = roll_need
			
			if not nav_on then roll_need = 0 end
			
			ILS_dev_smth = 0
			
		
		elseif roll_submode == 4 or roll_submode == 5 then -- AZ1 and AZ2 modes
		
			local slip_angle = get(diss_slip_angle)
			local course_now = get(course_gpk)
			
			local course_dev = get(nav_cs_1) * 10 -- deg from given radial
			
			if roll_submode == 5 then
				course_dev = get(nav_cs_2) * 10 -- deg from given radial
			end
			
			local pnp_course = get(pkp_obs_1)
			if get(absu_zpu_sel) == 1 then pnp_course = get(pkp_obs_2) end -- change course source
			
			
			vor_slip_act = vor_slip_act + (slip_angle - vor_slip_act) * passed * 0.5 -- DISS angle
			
			--limit the VOR signal			
			if course_dev > vor_dev_lim then course_dev = vor_dev_lim
			elseif course_dev < -vor_dev_lim then course_dev = -vor_dev_lim end
			
			
			vor_dev_act = vor_dev_act + (course_dev - vor_dev_act) * passed * 0.5 -- VOR deviation
			
			local course_diff = pnp_course - course_now
			if course_diff > 180 then course_diff = course_diff - 360
			elseif course_diff < -180 then course_diff = course_diff + 360 end
			
			roll_need = (course_diff - vor_slip_act) * 1.5 + vor_dev_act * 10
			
			
			if roll_need > 25 then roll_need = 25
			elseif roll_need < -25 then roll_need = -25 end
			
			roll_show = roll_need
			
			if not nav_on then roll_need = 0 end
			

			course_stab_act = course_now
			course_stab_timer = 0
			
			ILS_dev_smth = 0
			
		
		elseif roll_submode == 6 then -- APP mode

			local course_dev = get(nav_cs_1) * 10 -- deg from runway course
			local pnp_course = get(pkp_obs_1)
			
			if secondNav then course_dev = get(nav_cs_2) * 10 end
			
			if get(absu_zpu_sel) == 1 then -- change course source
				pnp_course = get(pkp_obs_2)
			end -- change course source
			
			local rv_alt = get(rv5_alt)
			
			local above250 = bool2int(rv_alt > 250)
			
			ILS_dev_smth = ILS_dev_smth + (course_dev - ILS_dev_smth) * passed * 10
			
			local dev_spd = 0
			if passed ~= 0 then dev_spd = (ILS_dev_smth - dev_last) end
			
			
			dev_last = ILS_dev_smth
			
			if math.abs(course_dev) > 9 then -- calculate course to get to the runway
				
				local new_course = pnp_course + 30 * sign(course_dev)
				if new_course < 0 then new_course = new_course + 360 
				elseif new_course > 360 then new_course = new_course - 360 end
				
				local course_diff = new_course - course_now
				
				if course_diff > 180 then course_diff = course_diff - 360
				elseif course_diff < -180 then course_diff = course_diff + 360 end
				
				roll_need = course_diff * 1.3
				
				-- limit roll
				if roll_need > 10 * (1 + above250) then roll_need = 10 * (1 + above250)
				elseif roll_need < -10 * (1 + above250) then roll_need = -10 * (1 + above250) end
				
				roll_show = roll_need
				
			else
				
				-- PID for course
				-- course deviation
				local K_ILS = 2.5 * (1 + above250)
				local ILS_lim = 25
				
				local ILS_dev_limited = ILS_dev_smth * K_ILS
				
				if ILS_dev_limited > ILS_lim then ILS_dev_limited = ILS_lim
				elseif ILS_dev_limited < -ILS_lim then ILS_dev_limited = -ILS_lim end
				
				-- deviation speed
				local K_ILS_spd = 1600 * (1 + above250)
				local ILS_spd_lim = 50
				
				local ILS_spd_limited = dev_spd * K_ILS_spd
				
				if ILS_spd_limited > ILS_spd_lim then ILS_spd_limited = ILS_spd_lim
				elseif ILS_spd_limited < -ILS_spd_lim then ILS_spd_limited = -ILS_spd_lim end
				
				
				-- fix hard turns
				if math.abs(ILS_spd_last - dev_spd) > 1 then -- keep previous roll
					ILS_spd_limited = 0
					ILS_dev_limited = 0
				else
					local roll_calc = ILS_dev_limited + ILS_spd_limited
					roll_need = roll_need + (roll_calc - roll_need) * passed
				end
				
				ILS_spd_last = dev_spd
				
				-- limit roll
				if roll_need > 10 * (1 + above250) then roll_need = 10 * (1 + above250)
				elseif roll_need < -10 * (1 + above250) then roll_need = -10 * (1 + above250) end
				
				roll_show = roll_need
				
				
			end
			
			course_stab_timer = 0
						
			local diff = course_now - course_stab_act
			if diff > 180 then diff = diff - 360
			elseif diff < -180 then diff = diff + 360 end
				
			course_stab_act = course_stab_act + diff * passed * 3
			
			-- lamps logic
			if RV_alt <= 100 and math.abs(ILS_dev_smth) > 3 then
				set(absu_course_out, 1)
			end
			
			
		elseif roll_submode == 7 and get(absu_calc_toga_fail) == 0 then -- TOGA mode
			
			local course_diff = course_stab_act - course_now
			
			if course_diff > 180 then course_diff = course_diff - 360
			elseif course_diff < -180 then course_diff = course_diff + 360 end
			

			roll_need = course_diff * 1.5

			if roll_need > 20 then roll_need = 20
			elseif roll_need < -20 then roll_need = -20 end
			
			roll_show = roll_need
			
			ILS_dev_smth = 0
			

		else 
			course_stab_timer = 0
			course_stab_act = course_now
			ILS_dev_smth = 0
			
			roll_show = 0

			
		end	
		
		
		-- set the ailerons	
		
		if roll_mode == 1 then -- manual control
			
			absu_roll_damp=1.6/(1.6+passed)*absu_roll_damp+1.6/(1.6+passed)*(roll_W-roll_W_prev)
			absu_roll_damp_K=math.abs(absu_roll_damp/roll_W);
			roll_W_prev=roll_W
			absu_roll_gain=absu_roll_gain-(absu_roll_gain-roll_cmd)/0.4*passed
			local ail_need = -1.5/20*absu_roll_damp+absu_roll_gain
			if ail_need > ail_lim then ail_need = ail_lim
			elseif ail_need < -ail_lim then ail_need = -ail_lim end
			
			
			roll_res_need = ail_need
			
			roll_need_smth = roll_now
			
		elseif roll_mode == 2 then -- stab mode
			
			if roll_need - roll_need_smth > 2 then roll_need_smth = roll_need_smth + passed * 3
			elseif roll_need - roll_need_smth < -2 then roll_need_smth = roll_need_smth - passed * 3
			else roll_need_smth = roll_need_smth + (roll_need - roll_need_smth) * passed * 3
			end
			
			
			if get(absu_calc_roll_fail) == 0 then roll_res_need = roll_holder(roll_need_smth) end
			
			
		end
	
	else
			roll_res_need = 0
			
			roll_need_smth = roll_now
	end
	-- set roll results --
	if MASTER then
		set(absu_contr_roll, roll_res_need)
	end
	
	
	-------------------------
	-- yaw controls --
	-------------------------
	
	if roll_mode >= 1 then -- SAU roll part
		
		yaw_res_need = yaw_holder()
		
	else
		
			yaw_res_need = 0
	
	end
	
	-- set yaw results --
	if MASTER then
	set(absu_contr_yaw, yaw_res_need)
	end
	-----------------------------------
	-- set pitch and roll indicators
	-----------------------------------
	
	local flag_roll = bool2int((not nav_on and not app_on) or (get(absu_speed_test_2) == 1 and nav_on and app_on)) -- need to enhance this logic
	local flag_pitch = bool2int((not nav_on and not app_on) or (get(absu_speed_test_2) == 1 and nav_on and app_on))
	
	local nav_1_cs_flag = get(nav_cs_flag_1) == 1
	local nav_2_cs_flag = get(nav_cs_flag_2) == 1
	
	local nav_1_gs_flag = get(nav_gs_flag_1) == 1
	local nav_2_gs_flag = get(nav_gs_flag_2) == 1
	
	local nav_1_fr = get(freq_1)
	local nav_2_fr = get(freq_2)
	
	
	-- app_on 
	
	if roll_submode == 1 or roll_submode == 2 then -- reset or ZK modes
		
		if not needles_on then
			roll_show = 25
			pitch_show = 10
		elseif not app_on then
			roll_show = 0
			pitch_show = 0
		elseif app_on then
			
			if (not isILS(nav_1_fr) or nav_1_cs_flag) and not secondNav then -- no signal
				roll_show = 0
			else roll_show = 0
			end
			pitch_show = 0
		
		end
		
	
	elseif roll_submode == 3 then -- NVU mode
		
		if not needles_on then
			roll_show = 25
			pitch_show = 10
		elseif nav_on then
			roll_show = roll_show - roll_now
			pitch_show = 0
		elseif not nav_on then
			roll_show = 0
			pitch_show = 0
		end

	elseif roll_submode == 4 then -- AZ1 mode
		
		if not needles_on then
			roll_show = 25
			pitch_show = 10
		elseif not nav_on then
			roll_show = 0
			pitch_show = 0
		elseif nav_on then 
			
			if isILS(nav_1_fr) or nav_1_cs_flag then -- no signal
				roll_show = 0
			else
				roll_show = roll_show - roll_now
			end
			
			pitch_show = 0
			
		end	
	
	elseif roll_submode == 5 then -- AZ2 mode
		
		if not needles_on then
			roll_show = 25
			pitch_show = 10
		elseif not nav_on then
			roll_show = 0
			pitch_show = 0
		elseif nav_on then 
			
			if isILS(nav_2_fr) or nav_2_cs_flag then -- no signal
				roll_show = 0
			else
				roll_show = roll_show - roll_now
			end
			
			pitch_show = 0
			
		end			
		
	elseif roll_submode == 6 and pitch_submode == 5 then -- GS mode
		
		if not needles_on then
			roll_show = 25
			pitch_show = 10
		elseif not app_on then
			roll_show = 0
			pitch_show = 0
		elseif app_on then 
			
			if (not isILS(nav_1_fr) or nav_1_cs_flag) and not secondNav then -- no signal
				roll_show = 0
			else
				roll_show = roll_show - roll_now
			end
			
			if (not isILS(nav_1_fr) or nav_1_gs_flag) and nav_2_gs_flag then -- no signal
				pitch_show = 0
			else
				pitch_show = pitch_show - pitch_now
			end
			
		end		

	elseif roll_submode == 6 then -- APP mode
		
		if not needles_on then
			roll_show = 25
			pitch_show = 10
		elseif not app_on then
			roll_show = 0
			pitch_show = 0
		elseif app_on then 
			
			if (not isILS(nav_1_fr) or nav_1_cs_flag) and not secondNav then -- no signal
				roll_show = 0
			else
				roll_show = roll_show - roll_now
			end
			
			pitch_show = 0
			
		end		
	
		
	elseif roll_submode == 7 and pitch_submode == 6 then -- TOGA mode
		
		if not needles_on then
			roll_show = 25
			pitch_show = 10
		elseif not app_on then
			roll_show = 0
			pitch_show = 0
		elseif app_on then 
			
			if not isILS(nav_1_fr) or nav_1_cs_flag then -- no signal
				roll_show = 0
			else
				roll_show = 0
			end
			
			pitch_show = 0
			
		end	
	
		
	else
		
		roll_show = 25
		pitch_show = 10
		
	end
	

	-- roll failures
	if get(man_roll_lamp) == 1 and 
		(get(absu_calc_roll_fail) == 1 or nav_1_cs_flag or nav_2_cs_flag or get(tks_fail_left) + get(tks_fail_right) == 2 or get(man_pitch_lamp) == 1) or get(absu_speed_test_2) == 1 then
		flag_roll = 1
		roll_show = 25
	end
	
	-- pitch failures
	if get(man_pitch_lamp) == 1 and (get(absu_calc_pitch_fail) == 1 or nav_1_gs_flag or get(man_roll_lamp) == 1) or get(absu_speed_test_2) == 1 then
		flag_pitch = 1
		pitch_show = 10
	end
	
	
	-- lamps
	if get(rv_angle) <= get(dh_set) or RV_alt > 100 then
		set(absu_gs_out, 0)
		set(absu_course_out, 0)
	end
	
	
if MASTER then	
	set(absu_roll_ind, roll_show)
	set(absu_pitch_ind, pitch_show)

	set(absu_roll_flag, flag_roll)
	set(absu_pitch_flag, flag_pitch)
	
	
end	
	

end


------------------
-- functions --
------------------

function pitch_holder(pitch_hold) -- manipulates the elevator and trimmer by given pitch angle
	
	
	local P = (pitch_hold - pitch_now)
	local D = get(pitch_rate) * (1 - get(absu_damp_pitch_fail))
	
	local PID_part = P * 0.1* interpolate(pitch_coeff_red_table,get(ias)*1.852) - D * 0.15 * interpolate(pitch_coeff_red_table,get(ias)*1.852)

	
	-- flaps and gear part
	if gear_down then
		pitch_stab_roll_coef = 0.00425 * 2
	else
	end
	

	-- roll part
	local roll_part = math.abs(roll_now) * pitch_stab_roll_coef * line(mach, 0.4, 1.3, 0.8, 0.8)*0.15
	

	local elev_pos = PID_part + roll_part-- + flaps_part
	
	-- limit elevator
	if elev_pos > elev_lim then elev_pos = elev_lim
	elseif elev_pos < -elev_lim then elev_pos = -elev_lim end
	

	pitch_act = pitch_act + (elev_pos - pitch_act) * passed * 5
	
	
if MASTER then
	-- set trimmer
	if pitch_act > 0.01 then set(absu_pitch_trimm, 1)
	elseif pitch_act < -0.01 then set(absu_pitch_trimm, -1)
	else set(absu_pitch_trimm, 0) end
end
	
	
	return pitch_act


end


function roll_holder(roll_hold) -- manipulates the elerons by given roll angle

	-- PID part

	local P = (roll_hold - roll_now)
	
	local roll_W = get(roll_rate)
	local roll_W2 = get(roll_acc)
	
	if get(absu_damp_roll_fail) == 1 then
		roll_W = 0
		roll_W2 = 0
	end
	
	
	local roll_stab_coef = 0.1
	if mach < 0.5 then roll_stab_coef = line(mach, 0.5, 0.1, 0, 0.2) end
	
	local PID = P * roll_stab_coef - roll_W * 0.08 * (0.5 + 0.01 * math.abs(roll_W2) / (0.01 * math.abs(roll_W2) + 1))
	
	-- set smooth
	roll_act = roll_act + (PID - roll_act) * passed * 5
	-- set limit
	if roll_act > ail_lim then roll_act = ail_lim
	elseif roll_act < -ail_lim then roll_act = -ail_lim end	
	
	
	return roll_act
	

end


function yaw_holder()
	
	
	local yaw_W = get(yaw_rate)
	absu_yaw_damp=2.5/(2.5+passed)*absu_yaw_damp+2.5/(2.5+passed)*(yaw_W-yaw_W_prev)
	yaw_W_prev=yaw_W
	yaw_act = -2.5/25*absu_yaw_damp - 4.5/25*yaw_W*bool2int(get(pitch_sub_mode)==5 and get(pitch_main_mode)==2)
	
	
	if yaw_act > 0.4 then yaw_act = 0.4
	elseif yaw_act < -0.4 then yaw_act = -0.4 end	
	
	
	return yaw_act

end

