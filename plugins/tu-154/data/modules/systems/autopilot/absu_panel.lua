-- this is ABSU panel script
-- createGlobalPropertyf("tu-154/controlls/absu_debug1", 0)
-- defineProperty("absu_debug1", globalPropertyf("tu-154/controlls/absu_debug1")) 

defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time")) -- time of frame

-- gauges
defineProperty("absu_roll_mode", globalPropertyi("tu-154/gauges/console/absu_roll_mode")) -- ABSU operating mode. 0 = off, 1 = control-wheel steering, 2 = stabilisation
defineProperty("absu_pitch_mode", globalPropertyi("tu-154/gauges/console/absu_pitch_mode")) -- ABSU operating mode. 0 = off, 1 = control-wheel steering, 2 = stabilisation

-- controls
defineProperty("absu_zpu_sel", globalPropertyi("tu-154/switchers/console/absu_zpu_sel")) -- desired-track (ZPU) selector. left - right
defineProperty("absu_nav_on", globalPropertyi("tu-154/switchers/console/absu_nav_on")) -- navigation needles
defineProperty("absu_landing_on", globalPropertyi("tu-154/switchers/console/absu_landing_on")) -- landing needles
defineProperty("absu_needles_on", globalPropertyi("tu-154/switchers/console/absu_needles_on")) -- needles
defineProperty("absu_speed_mode", globalPropertyi("tu-154/switchers/console/absu_speed_mode")) -- STU mode. 0 - off, 1 - nvu, 2 - az1, 3 - az2, 4 - landing
defineProperty("absu_speed_change", globalPropertyi("tu-154/switchers/console/absu_speed_change")) -- speed change knob.
defineProperty("absu_speed_off", globalPropertyi("tu-154/switchers/console/absu_speed_off")) -- 1 and 2 disconnect
defineProperty("absu_speed_prepare", globalPropertyi("tu-154/switchers/console/absu_speed_prepare")) -- preparation
defineProperty("absu_speed_us_right_left", globalPropertyi("tu-154/switchers/console/absu_speed_us_right_left")) -- preparation

defineProperty("absu_roll_ch_on", globalPropertyi("tu-154/switchers/console/absu_roll_ch_on")) -- roll channel switch
defineProperty("absu_pitch_ch_on", globalPropertyi("tu-154/switchers/console/absu_pitch_ch_on")) -- pitch channel switch
defineProperty("absu_smooth_on", globalPropertyi("tu-154/switchers/console/absu_smooth_on")) -- turbulence ("v boltanku") switch

defineProperty("absu_turn_handle", globalPropertyi("tu-154/switchers/console/absu_turn_handle")) -- turn knob
defineProperty("absu_pitch_wheel", globalPropertyf("tu-154/switchers/console/absu_pitch_wheel")) -- descend/climb thumbwheel
defineProperty("absu_pitch_wheel_dir", globalPropertyi("tu-154/switchers/console/absu_pitch_wheel_dir")) -- descend/climb thumbwheel


defineProperty("hydro_ra56_rud_1", globalPropertyi("tu-154/switchers/eng/hydro_ra56_rud_1")) -- RA-56 yaw hydraulic supply
defineProperty("hydro_ra56_rud_2", globalPropertyi("tu-154/switchers/eng/hydro_ra56_rud_2")) -- RA-56 yaw hydraulic supply
defineProperty("hydro_ra56_rud_3", globalPropertyi("tu-154/switchers/eng/hydro_ra56_rud_3")) -- RA-56 yaw hydraulic supply

defineProperty("hydro_ra56_ail_1", globalPropertyi("tu-154/switchers/eng/hydro_ra56_ail_1")) -- RA-56 roll hydraulic supply
defineProperty("hydro_ra56_ail_2", globalPropertyi("tu-154/switchers/eng/hydro_ra56_ail_2")) -- RA-56 roll hydraulic supply
defineProperty("hydro_ra56_ail_3", globalPropertyi("tu-154/switchers/eng/hydro_ra56_ail_3")) -- RA-56 roll hydraulic supply

defineProperty("hydro_ra56_elev_1", globalPropertyi("tu-154/switchers/eng/hydro_ra56_elev_1")) -- RA-56 pitch hydraulic supply
defineProperty("hydro_ra56_elev_2", globalPropertyi("tu-154/switchers/eng/hydro_ra56_elev_2")) -- RA-56 pitch hydraulic supply
defineProperty("hydro_ra56_elev_3", globalPropertyi("tu-154/switchers/eng/hydro_ra56_elev_3")) -- RA-56 pitch hydraulic supply


defineProperty("hydro_circuit_auto_man", globalPropertyi("tu-154/switchers/eng/hydro_circuit_auto_man")) -- crossfeed auto - manual
defineProperty("hydro_long_control", globalPropertyi("tu-154/switchers/eng/hydro_long_control")) -- longitudinal controllability

defineProperty("hydro_circuit_auto_man_cap", globalPropertyi("tu-154/switchers/eng/hydro_circuit_auto_man_cap")) -- crossfeed auto - manual
defineProperty("hydro_long_control_cap", globalPropertyi("tu-154/switchers/eng/hydro_long_control_cap")) -- longitudinal controllability

defineProperty("ZK_select", globalPropertyi("tu-154/switchers/ZK_select")) -- 
defineProperty("nav_select", globalPropertyi("tu-154/switchers/nav_select")) -- 
defineProperty("vbe_select", globalPropertyi("tu-154/switchers/vbe_select")) -- 


-- buttons
defineProperty("absu_zk", globalPropertyi("tu-154/buttons/console/absu_zk")) -- selected heading (ZK) button on the ABSU panel
defineProperty("absu_reset", globalPropertyi("tu-154/buttons/console/absu_reset")) -- programme reset button on the ABSU panel
defineProperty("absu_nvu", globalPropertyi("tu-154/buttons/console/absu_nvu")) -- NVU button on the ABSU panel
defineProperty("absu_az1", globalPropertyi("tu-154/buttons/console/absu_az1")) -- AZ 1 button on the ABSU panel
defineProperty("absu_az2", globalPropertyi("tu-154/buttons/console/absu_az2")) -- AZ 2 button on the ABSU panel
defineProperty("absu_app", globalPropertyi("tu-154/buttons/console/absu_app")) -- approach button on the ABSU panel
defineProperty("absu_gs", globalPropertyi("tu-154/buttons/console/absu_gs")) -- glideslope button on the ABSU panel
defineProperty("absu_stab_m", globalPropertyi("tu-154/buttons/console/absu_stab_m")) -- button M on the ABSU panel
defineProperty("absu_stab_v", globalPropertyi("tu-154/buttons/console/absu_stab_v")) -- button V on the ABSU panel
defineProperty("absu_stab_h", globalPropertyi("tu-154/buttons/console/absu_stab_h")) -- button H on the ABSU panel
defineProperty("absu_stab", globalPropertyi("tu-154/buttons/console/absu_stab")) -- STAB button on the ABSU panel

defineProperty("absu_az1_arm", globalPropertyi("tu-154/buttons/console/absu_az1_arm"))
defineProperty("absu_az2_arm", globalPropertyi("tu-154/buttons/console/absu_az2_arm"))
defineProperty("absu_nvu_arm", globalPropertyi("tu-154/buttons/console/absu_nvu_arm"))

defineProperty("absu_arrest", globalPropertyi("tu-154/buttons/console/absu_arrest")) -- MGV caging buttons
defineProperty("absu_speed_test_1", globalPropertyi("tu-154/buttons/console/absu_speed_test_1")) -- lower STU test button
defineProperty("absu_speed_test_2", globalPropertyi("tu-154/buttons/console/absu_speed_test_2")) -- upper STU test button

defineProperty("absu_stab_speed", globalPropertyi("tu-154/buttons/console/absu_stab_speed")) -- button C on the ABSU panel
defineProperty("absu_throt_off_1", globalPropertyi("tu-154/buttons/console/absu_throt_off_1")) -- G1 disconnect button on the ABSU panel
defineProperty("absu_throt_off_2", globalPropertyi("tu-154/buttons/console/absu_throt_off_2")) -- G2 disconnect button on the ABSU panel
defineProperty("absu_throt_off_3", globalPropertyi("tu-154/buttons/console/absu_throt_off_3")) -- G3 disconnect button on the ABSU panel


-- caps
defineProperty("absu_arrest_cap", globalPropertyi("tu-154/buttons/console/absu_arrest_cap")) -- upper STU test button
defineProperty("absu_smooth_on_cap", globalPropertyi("tu-154/switchers/console/absu_smooth_on_cap")) -- turbulence ("v boltanku") switch
defineProperty("absu_speed_prepare_cap", globalPropertyi("tu-154/switchers/console/absu_speed_prepare_cap")) -- preparation
defineProperty("absu_speed_off_cap", globalPropertyi("tu-154/switchers/console/absu_speed_off_cap")) -- 1 and 2 disconnect

-- lamps
defineProperty("absu_zk_lamp", globalPropertyf("tu-154/lights/button/absu_zk")) -- ABSU selected heading (ZK)
defineProperty("absu_reset_lamp", globalPropertyf("tu-154/lights/button/absu_reset")) -- ABSU selected heading (ZK)
defineProperty("absu_nvu_lamp", globalPropertyf("tu-154/lights/button/absu_nvu")) -- ABSU selected heading (ZK)
defineProperty("absu_az1_lamp", globalPropertyf("tu-154/lights/button/absu_az1")) -- ABSU selected heading (ZK)
defineProperty("absu_az2_lamp", globalPropertyf("tu-154/lights/button/absu_az2")) -- ABSU selected heading (ZK)
defineProperty("absu_app_lamp", globalPropertyf("tu-154/lights/button/absu_app")) -- ABSU selected heading (ZK)
defineProperty("absu_gz_lamp", globalPropertyf("tu-154/lights/button/absu_gz")) -- ABSU selected heading (ZK)
defineProperty("absu_stab_m_lamp", globalPropertyf("tu-154/lights/button/absu_stab_m")) -- ABSU selected heading (ZK)
defineProperty("absu_stab_v_lamp", globalPropertyf("tu-154/lights/button/absu_stab_v")) -- ABSU selected heading (ZK)
defineProperty("absu_stab_h_lamp", globalPropertyf("tu-154/lights/button/absu_stab_h")) -- ABSU selected heading (ZK)
defineProperty("absu_stab_lamp", globalPropertyf("tu-154/lights/button/absu_stab")) -- ABSU selected heading (ZK)
defineProperty("absu_stab_spd_lamp", globalPropertyf("tu-154/lights/button/absu_stab_spd")) -- ABSU selected heading (ZK)
defineProperty("absu_thro1_lamp", globalPropertyf("tu-154/lights/button/absu_thro1")) -- ABSU selected heading (ZK)
defineProperty("absu_thro2_lamp", globalPropertyf("tu-154/lights/button/absu_thro2")) -- ABSU selected heading (ZK)
defineProperty("absu_thro3_lamp", globalPropertyf("tu-154/lights/button/absu_thro3")) -- ABSU selected heading (ZK)

defineProperty("stu_roll_lamp", globalPropertyf("tu-154/lights/small/stu_roll")) -- roll
defineProperty("stu_pitch_lamp", globalPropertyf("tu-154/lights/small/stu_pitch")) -- pitch
defineProperty("stu_toga_lamp", globalPropertyf("tu-154/lights/small/stu_toga")) -- GO-AROUND

defineProperty("at_1_lamp", globalPropertyf("tu-154/lights/small/at_1")) -- AT 1
defineProperty("at_2_lamp", globalPropertyf("tu-154/lights/small/at_2")) -- AT 2

defineProperty("course_lim", globalPropertyf("tu-154/lights/course_lim")) -- course deviation beyond limits
defineProperty("gs_lim", globalPropertyf("tu-154/lights/gs_lim")) -- glideslope deviation beyond limits




-- forward panel lamps
defineProperty("wrong_trimm", globalPropertyf("tu-154/lights/wrong_trimm")) -- false trim
defineProperty("controll_roll", globalPropertyf("tu-154/lights/controll_roll")) -- control the roll
defineProperty("controll_pitch", globalPropertyf("tu-154/lights/controll_pitch")) -- control the pitch
defineProperty("yoke_sign", globalPropertyf("tu-154/lights/yoke_sign")) -- go-around annunciation in manual mode
defineProperty("triangle", globalPropertyf("tu-154/lights/triangle")) -- integral warning light
defineProperty("controll_thrust", globalPropertyf("tu-154/lights/controll_thrust")) -- control the thrust

defineProperty("toga", globalPropertyf("tu-154/lights/toga")) -- go-around

defineProperty("course", globalPropertyf("tu-154/lights/course")) -- HEADING
defineProperty("glideslope", globalPropertyf("tu-154/lights/glideslope")) -- GLIDESLOPE
defineProperty("zk_lamp", globalPropertyf("tu-154/lights/zk_lamp")) -- ZK
defineProperty("thrust_automat", globalPropertyf("tu-154/lights/thrust_automat")) -- autothrottle
defineProperty("stab_roll", globalPropertyf("tu-154/lights/stab_roll")) -- lateral stabilisation
defineProperty("stab_pitch", globalPropertyf("tu-154/lights/stab_pitch")) -- longitudinal stabilisation
defineProperty("nvu_lamp", globalPropertyf("tu-154/lights/nvu_lamp")) -- NVU
defineProperty("vor_lamp", globalPropertyf("tu-154/lights/vor_lamp")) -- VOR

defineProperty("stab_h", globalPropertyf("tu-154/lights/stab_h")) -- stab H
defineProperty("stab_v", globalPropertyf("tu-154/lights/stab_v")) -- stab V
defineProperty("stab_m", globalPropertyf("tu-154/lights/stab_m")) -- stab M

defineProperty("pitch_control_fail", globalPropertyf("tu-154/lights/pitch_control_fail")) -- longitudinal control
defineProperty("roll_control_fail", globalPropertyf("tu-154/lights/roll_control_fail")) -- lateral control

defineProperty("absu_work", globalPropertyf("tu-154/lights/absu_work")) -- ABSU healthy

defineProperty("sns_lamp", globalPropertyf("tu-154/lights/sns_lamp")) -- SNS lamp



-- eng panel lamps
defineProperty("ra56_roll_fail_1", globalPropertyf("tu-154/lights/ra56_roll_fail_1")) -- RA-56 roll failure
defineProperty("ra56_roll_fail_2", globalPropertyf("tu-154/lights/ra56_roll_fail_2")) -- RA-56 roll failure
defineProperty("ra56_roll_fail_3", globalPropertyf("tu-154/lights/ra56_roll_fail_3")) -- RA-56 roll failure

defineProperty("ra56_pitch_fail_1", globalPropertyf("tu-154/lights/ra56_pitch_fail_1")) -- RA-56 pitch failure
defineProperty("ra56_pitch_fail_2", globalPropertyf("tu-154/lights/ra56_pitch_fail_2")) -- RA-56 pitch failure
defineProperty("ra56_pitch_fail_3", globalPropertyf("tu-154/lights/ra56_pitch_fail_3")) -- RA-56 pitch failure

defineProperty("ra56_course_fail_1", globalPropertyf("tu-154/lights/ra56_course_fail_1")) -- RA-56 yaw failure
defineProperty("ra56_course_fail_2", globalPropertyf("tu-154/lights/ra56_course_fail_2")) -- RA-56 yaw failure
defineProperty("ra56_course_fail_3", globalPropertyf("tu-154/lights/ra56_course_fail_3")) -- RA-56 yaw failure

defineProperty("eng_at_on_lamp", globalPropertyf("tu-154/lights/engines/eng_at_on")) -- AT engaged

-- other sources
defineProperty("lamp_test", globalPropertyi("tu-154/buttons/lamp_test_front")) -- front panel lamp test button	0
defineProperty("day_night_set", globalPropertyf("tu-154/lights/day_night_set")) -- day/night switch. 0 = day, 1 = night. dims the annunciator lamps.

defineProperty("lamp_test_eng", globalPropertyi("tu-154/buttons/lamp_test_pa56")) -- lamp test button on the	flight engineer's panel


-- 

defineProperty("roll_main_mode", globalPropertyi("tu-154/absu/roll_main_mode")) -- ABSU main roll mode. 0 = off, 1 = control-wheel steering, 2 = stabilisation
defineProperty("pitch_main_mode", globalPropertyi("tu-154/absu/pitch_main_mode")) -- ABSU main pitch mode. 0 = off, 1 = control-wheel steering, 2 = stabilisation

defineProperty("roll_sub_mode", globalPropertyi("tu-154/absu/roll_sub_mode")) -- ABSU roll mode. 0 - off, 1 - stab, 2 - ZK, 3 - NVU, 4 - AZ1, 5 - AZ2, 6 - approach
defineProperty("pitch_sub_mode", globalPropertyi("tu-154/absu/pitch_sub_mode")) -- ABSU pitch mode. 0 - off, 1 - stab, 2 - V, 3 - M, 4 - H, 5 - glideslope, 6 - go-around

defineProperty("stu_mode", globalPropertyi("tu-154/absu/stu_mode")) -- autothrottle modes. 0 = off, 1 = on, 2 = armed, 3 = stabilisation, 4 = go-around
defineProperty("absu_speed_off", globalPropertyi("tu-154/switchers/console/absu_speed_off")) -- 1 and 2 disconnect

defineProperty("absu_throt_off_1", globalPropertyi("tu-154/buttons/console/absu_throt_off_1")) -- G1 disconnect button on the ABSU panel
defineProperty("absu_throt_off_2", globalPropertyi("tu-154/buttons/console/absu_throt_off_2")) -- G2 disconnect button on the ABSU panel
defineProperty("absu_throt_off_3", globalPropertyi("tu-154/buttons/console/absu_throt_off_3")) -- G3 disconnect button on the ABSU panel


defineProperty("absu_pnp_mode_1", globalPropertyi("tu-154/absu/absu_pnp_mode_1")) -- PNP display mode. 0 = off, 1 = NVU, 2 = VOR1, 3 = VOR2, 4 = landing system
defineProperty("absu_pnp_mode_2", globalPropertyi("tu-154/absu/absu_pnp_mode_2")) -- PNP display mode. 0 = off, 1 = NVU, 2 = VOR1, 3 = VOR2, 4 = landing system

defineProperty("absu_course_out", globalPropertyi("tu-154/absu_course_out")) -- flying outside the course limits
defineProperty("absu_gs_out", globalPropertyi("tu-154/absu_gs_out")) -- flying outside the course limits


defineProperty("pkp_fail_left", globalPropertyf("tu-154/gauges/ahz/ahz_flag_L")) -- 
defineProperty("pkp_fail_right", globalPropertyf("tu-154/gauges/ahz/ahz_flag_R")) -- 
defineProperty("mgv_contr_fail", globalPropertyf("tu-154/gyro/mgv_contr_flag")) -- 


defineProperty("pressure_ind_1", globalPropertyf("tu-154/gauges/hydro/pressure_ind_1")) -- hydraulic system 1 pressure indicator
defineProperty("pressure_ind_2", globalPropertyf("tu-154/gauges/hydro/pressure_ind_2")) -- hydraulic system 2 pressure indicator
defineProperty("pressure_ind_3", globalPropertyf("tu-154/gauges/hydro/pressure_ind_3")) -- hydraulic system 3 pressure indicator

defineProperty("sau_stu_on", globalPropertyi("tu-154/switchers/ovhd/sau_stu_on"))  -- SAU/STU switch

defineProperty("tks_fail_left", globalPropertyi("tu-154/tks/fail_left")) -- failure flag
defineProperty("tks_fail_right", globalPropertyi("tu-154/tks/fail_right")) -- failure flag


defineProperty("elev_trimm_switcher", globalPropertyi("tu-154/controll/elev_trimm_switcher")) -- elevator trim control. -1 = nose down, 0 = neutral, +1 = nose up
defineProperty("emerg_elev_trimm", globalPropertyi("tu-154/switchers/console/emerg_elev_trimm")) -- emergency trim control


-- power
defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right"))

defineProperty("int_pitch_trim", globalPropertyf("tu-154/trimmers/int_pitch_trim")) -- elevator trim position
defineProperty("absu_pitch_trimm", globalPropertyi("tu-154/absu/absu_pitch_trimm")) -- trim command from the ABSU. +1 = up, -1 = down


-- engines
defineProperty("eng1_N1", globalProperty("sim/flightmodel/engine/ENGN_N1_[0]")) -- engine 1 rpm
defineProperty("eng2_N1", globalProperty("sim/flightmodel/engine/ENGN_N1_[1]")) -- engine 2 rpm
defineProperty("eng3_N1", globalProperty("sim/flightmodel/engine/ENGN_N1_[2]")) -- engine 3 rpm


defineProperty("damp_roll_lamp", globalPropertyi("tu-154/absu/damp_roll_lamp")) -- 
defineProperty("damp_pitch_lamp", globalPropertyi("tu-154/absu/damp_pitch_lamp")) -- 
defineProperty("damp_yaw_lamp", globalPropertyi("tu-154/absu/damp_yaw_lamp")) -- 
defineProperty("roll_contr_lamp", globalPropertyi("tu-154/absu/roll_contr_lamp")) -- 
defineProperty("pitch_contr_lamp", globalPropertyi("tu-154/absu/pitch_contr_lamp")) -- 
defineProperty("man_roll_lamp", globalPropertyi("tu-154/absu/man_roll_lamp")) -- 
defineProperty("man_pitch_lamp", globalPropertyi("tu-154/absu/man_pitch_lamp")) -- 
defineProperty("man_toga_lamp", globalPropertyi("tu-154/absu/man_toga_lamp")) -- 
defineProperty("triangle_lamp_signal", globalPropertyi("tu-154/absu/triangle_lamp_signal")) -- 


-- failures
defineProperty("absu_ra56_roll_fail", globalPropertyi("tu-154/failures/absu_ra56_roll_fail")) -- RA-56 failure
defineProperty("absu_ra56_pitch_fail", globalPropertyi("tu-154/failures/absu_ra56_pitch_fail")) -- RA-56 failure
defineProperty("absu_ra56_yaw_fail", globalPropertyi("tu-154/failures/absu_ra56_yaw_fail")) -- RA-56 failure

defineProperty("absu_at1_fail", globalPropertyi("tu-154/failures/absu_at1_fail")) -- autothrottle failure
defineProperty("absu_at2_fail", globalPropertyi("tu-154/failures/absu_at2_fail")) -- autothrottle failure

defineProperty("absu_damp_roll_fail", globalPropertyi("tu-154/failures/absu_damp_roll_fail")) -- roll damper failure
defineProperty("absu_damp_pitch_fail", globalPropertyi("tu-154/failures/absu_damp_pitch_fail")) -- pitch damper failure
defineProperty("absu_damp_yaw_fail", globalPropertyi("tu-154/failures/absu_damp_yaw_fail")) -- yaw damper failure
defineProperty("absu_contr_roll_fail", globalPropertyi("tu-154/failures/absu_contr_roll_fail")) -- lateral control failure
defineProperty("absu_contr_pitch_fail", globalPropertyi("tu-154/failures/absu_contr_pitch_fail")) -- longitudinal control failure
defineProperty("absu_calc_toga_fail", globalPropertyi("tu-154/failures/absu_calc_toga_fail")) -- go-around computer failure
defineProperty("absu_calc_roll_fail", globalPropertyi("tu-154/failures/absu_calc_roll_fail")) -- STU lateral channel failure
defineProperty("absu_calc_pitch_fail", globalPropertyi("tu-154/failures/absu_calc_pitch_fail")) -- STU longitudinal channel failure
-- RA56 failures
defineProperty("absu_ra1_roll_fail", globalPropertyi("tu-154/failures/absu_ra1_roll_fail"))
defineProperty("absu_ra2_roll_fail", globalPropertyi("tu-154/failures/absu_ra2_roll_fail"))
defineProperty("absu_ra3_roll_fail", globalPropertyi("tu-154/failures/absu_ra3_roll_fail"))
defineProperty("absu_ra1_pitch_fail", globalPropertyi("tu-154/failures/absu_ra1_pitch_fail"))
defineProperty("absu_ra2_pitch_fail", globalPropertyi("tu-154/failures/absu_ra2_pitch_fail"))
defineProperty("absu_ra3_pitch_fail", globalPropertyi("tu-154/failures/absu_ra3_pitch_fail"))
defineProperty("absu_ra1_yaw_fail", globalPropertyi("tu-154/failures/absu_ra1_yaw_fail"))
defineProperty("absu_ra2_yaw_fail", globalPropertyi("tu-154/failures/absu_ra2_yaw_fail"))
defineProperty("absu_ra3_yaw_fail", globalPropertyi("tu-154/failures/absu_ra3_yaw_fail"))

defineProperty("absu_power", globalPropertyi("tu-154/absu_power_27"))


-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control





local passed = get(frame_time)
local notLoaded = true
local start_timer = 0

local function sw_reset()

	if get(eng1_N1) < 5 and get(eng2_N1) < 5 and get(eng3_N1) < 5 then
		set(absu_needles_on, 0)
		set(absu_nav_on, 0)
		set(absu_speed_prepare, 0)
		
		set(absu_roll_ch_on, 0)
		set(absu_pitch_ch_on, 0)
		
		--[[
		set(hydro_ra56_rud_1, 0)
		set(hydro_ra56_rud_2, 0)
		set(hydro_ra56_rud_3, 0)
		
		set(hydro_ra56_ail_1, 0)
		set(hydro_ra56_ail_2, 0)
		set(hydro_ra56_ail_3, 0)
		
		set(hydro_ra56_elev_1, 0)
		set(hydro_ra56_elev_2, 0)
		set(hydro_ra56_elev_3, 0)
		--]]
		
	end
	
	notLoaded = false

end




-- sounds
local switcher_sound = loadSample('sounds/metal_switch.wav')
local button_sound = loadSample('sounds/plastic_btn.wav')
local cap_sound = loadSample('sounds/cap.wav')


local button_summ_last = 0

local function buttons()

	local summ = get(absu_zk) + get(absu_reset) + get(absu_nvu) + get(absu_az1) + get(absu_az2) + get(absu_app)
	summ = summ + get(absu_gs) + get(absu_stab_m) + get(absu_stab_v) + get(absu_stab_h) + get(absu_stab)
	summ = summ + get(absu_arrest) + get(absu_speed_test_1) + get(absu_speed_test_2)
	summ = summ + get(absu_stab_speed) + get(absu_throt_off_1) + get(absu_throt_off_2) + get(absu_throt_off_3) + get(lamp_test_eng)
	
	if button_summ_last ~= summ then playSample(button_sound, false) end
	
	button_summ_last = summ

end


local switchers_summ = 0

local function switchers()

	local summ = get(absu_zpu_sel) + get(absu_nav_on) + get(absu_landing_on) + get(absu_needles_on) + get(absu_speed_mode)
	summ = summ + get(absu_speed_change) + get(absu_speed_off) + get(absu_speed_prepare) + get(absu_speed_us_right_left)
	summ = summ + get(absu_roll_ch_on) + get(absu_pitch_ch_on) + get(absu_smooth_on)
	summ = summ + get(hydro_ra56_rud_1) + get(hydro_ra56_rud_2) + get(hydro_ra56_rud_3)
	summ = summ + get(hydro_ra56_ail_1) + get(hydro_ra56_ail_2) + get(hydro_ra56_ail_3)
	summ = summ + get(hydro_ra56_elev_1) + get(hydro_ra56_elev_2) + get(hydro_ra56_elev_3)
	summ = summ + get(hydro_circuit_auto_man) + get(hydro_long_control)
	summ = summ + get(ZK_select) + get(nav_select) + get(vbe_select)
	
	if switchers_summ ~= summ then playSample(switcher_sound, false) end
	
	switchers_summ = summ
	
	-- pitch wheel

	local wheel = get(absu_pitch_wheel) 
	wheel = wheel + get(absu_pitch_wheel_dir) * get(frame_time) * 10
	
	while wheel > 20 do wheel = wheel - 20 end
	while wheel < -20 do wheel = wheel + 20 end 
	

	set(absu_pitch_wheel, wheel)
	
	-- turn handle
	
	if math.abs(get(absu_turn_handle)) <= 1 then set(absu_turn_handle, 0) end
	
	
	
end


local caps_summ = 0

local function caps()
	
	local summ = get(absu_arrest_cap) + get(absu_smooth_on_cap) + get(absu_speed_prepare_cap) + get(absu_speed_off_cap)
	summ = summ + get(hydro_circuit_auto_man_cap) + get(hydro_long_control_cap)
	
	if caps_summ ~= summ then playSample(cap_sound, false) end
	
	caps_summ = summ
	
	if get(hydro_circuit_auto_man_cap) == 0 then set(hydro_circuit_auto_man, 0) end
	if get(hydro_long_control_cap) == 0 then set(hydro_long_control, 1) end
	


end


local function gauges()

	set(absu_roll_mode, get(roll_main_mode))
	set(absu_pitch_mode, get(pitch_main_mode))



end

local elev_tr_last = get(int_pitch_trim)

local stu_test_1_cntr = 0
local stu_test_2_cntr = 0
local triangle_timer = 0
local triangle_lit = 0

local function lamps()
	local power=bool2int(get(absu_power)>0)
	local test_btn = get(lamp_test) * math.max((get(bus27_volt_right) - 10) / 18.5, 0)
	local day_night = 1 - get(day_night_set) * 0.25
	local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0) * day_night
	local small_lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0) -- small lamps and buttons

	local roll_mode = get(roll_main_mode)
	local pitch_mode = get(pitch_main_mode)
	
	local roll_submode = get(roll_sub_mode)
	local pitch_submode = get(pitch_sub_mode)
	
	
	-- 	button lamps
	local absu_zk_lamp_brt = math.max(bool2int(roll_mode > 0 and roll_submode == 2) * lamps_brt * day_night, 0)
	set(absu_zk_lamp, absu_zk_lamp_brt)
	
	local absu_reset_lamp_brt = math.max(bool2int(roll_mode > 0 and roll_submode == 1 and pitch_submode ~= 6 and get(absu_nvu_arm)+get(absu_az1_arm)+get(absu_az2_arm)==0) * lamps_brt * day_night, 0) 
	set(absu_reset_lamp, absu_reset_lamp_brt)
	
	local absu_nvu_lamp_brt = math.max(bool2int(roll_mode > 0 and (roll_submode == 3 or get(absu_nvu_arm)==1)) * lamps_brt * day_night, 0)
	set(absu_nvu_lamp, absu_nvu_lamp_brt)
	
	local absu_az1_lamp_brt = math.max(bool2int(roll_mode > 0 and (roll_submode == 4 or get(absu_az1_arm)==1)) * lamps_brt * day_night, 0)
	set(absu_az1_lamp, absu_az1_lamp_brt)
	
	local absu_az2_lamp_brt = math.max(bool2int(roll_mode > 0 and (roll_submode == 5 or get(absu_az2_arm)==1)) * lamps_brt * day_night, 0)
	set(absu_az2_lamp, absu_az2_lamp_brt)
	
	local absu_app_lamp_brt = math.max(bool2int(roll_mode > 0 and (roll_submode == 6 or roll_submode == 10)) * lamps_brt * day_night, 0) 
	set(absu_app_lamp, absu_app_lamp_brt)
	
	local absu_gz_lamp_brt = math.max(bool2int(roll_mode > 0 and (pitch_submode == 5 or pitch_submode == 10)) * lamps_brt * day_night, 0) 
	set(absu_gz_lamp, absu_gz_lamp_brt)
	
	local absu_stab_m_lamp_brt = math.max(bool2int(pitch_mode > 0 and pitch_submode == 3) * lamps_brt * day_night, 0) 
	set(absu_stab_m_lamp, absu_stab_m_lamp_brt)
	
	local absu_stab_v_lamp_brt = math.max(bool2int(pitch_mode > 0 and pitch_submode == 2) * lamps_brt * day_night, 0)
	set(absu_stab_v_lamp, absu_stab_v_lamp_brt)
	
	local absu_stab_h_lamp_brt = math.max(bool2int(pitch_mode > 0 and pitch_submode == 4) * lamps_brt * day_night, 0) 
	set(absu_stab_h_lamp, absu_stab_h_lamp_brt)
	
	--local absu_stab_lamp_brt = math.max(bool2int(pitch_mode == 2 or roll_mode == 2) * lamps_brt * day_night, test_btn)
	set(absu_stab_lamp, 0)
	
	local AT_mode = get(stu_mode)
	
	local absu_stab_spd_lamp_brt = math.max(bool2int(AT_mode > 2) * lamps_brt * day_night, 0)
	set(absu_stab_spd_lamp, absu_stab_spd_lamp_brt)
	
	local absu_thro1_lamp_brt = math.max(bool2int(AT_mode > 2 and get(absu_throt_off_1) == 1) * lamps_brt * day_night, 0)
	set(absu_thro1_lamp, absu_thro1_lamp_brt)
	
	local absu_thro2_lamp_brt = math.max(bool2int(AT_mode > 2 and get(absu_throt_off_2) == 1) * lamps_brt * day_night, 0) 
	set(absu_thro2_lamp, absu_thro2_lamp_brt)
	
	local absu_thro3_lamp_brt = math.max(bool2int(AT_mode > 2 and get(absu_throt_off_3) == 1) * lamps_brt * day_night, 0) 
	set(absu_thro3_lamp, absu_thro3_lamp_brt)

	
	local nav_prep = get(absu_nav_on) == 1
	local land_prep = get(absu_landing_on) == 1
	
	local absu_roll_mod = get(roll_main_mode)
	local absu_pitch_mod = get(pitch_main_mode)
	
	if get(absu_speed_test_2) == 1 and (nav_prep or land_prep) then
		stu_test_1_cntr = stu_test_1_cntr + passed
	else
		stu_test_1_cntr = 0
	end
	
	
	local stu_roll_lamp_brt = math.max(bool2int(absu_roll_mod >= 1 and absu_pitch_mod >= 1 and (land_prep) and stu_test_1_cntr < 1 and get(absu_calc_roll_fail) == 0) * lamps_brt * day_night, 0) 
	set(stu_roll_lamp, stu_roll_lamp_brt)
	
	local stu_pitch_lamp_brt = math.max(bool2int(absu_roll_mod >= 1 and absu_pitch_mod >= 1 and land_prep and stu_test_1_cntr < 0.5 and get(absu_calc_pitch_fail) == 0) * lamps_brt * day_night, 0) 
	set(stu_pitch_lamp, stu_pitch_lamp_brt)
	
	local stu_toga_lamp_brt = math.max(bool2int(absu_roll_mod >= 1 and absu_pitch_mod >= 1 and land_prep and stu_test_1_cntr < 0.5 and get(absu_calc_toga_fail) == 0) * lamps_brt * day_night, 0)
	set(stu_toga_lamp, stu_toga_lamp_brt)
	
	
	local at_off = get(absu_speed_off)
	
	if get(absu_speed_test_1) == 1 and AT_mode > 1 then
		stu_test_2_cntr = stu_test_2_cntr + passed
	else
		stu_test_2_cntr = 0
	end
	
	
	local at_1_lamp_brt = math.max(bool2int(AT_mode > 1 and at_off ~= 1 and stu_test_2_cntr < 10 and get(absu_at1_fail) == 0) * lamps_brt * day_night, 0)
	set(at_1_lamp, at_1_lamp_brt)
	
	local at_2_lamp_brt = math.max(bool2int(AT_mode > 1 and at_off ~= -1 and stu_test_2_cntr < 10 and get(absu_at2_fail) == 0) * lamps_brt * day_night, 0)
	set(at_2_lamp, at_2_lamp_brt)
	
	
	
	
	-- panel lamps
	
	local elev_tr_now = get(int_pitch_trim)
	local trim_fail = bool2int(get(pitch_main_mode) == 2 and (get(elev_trimm_switcher) ~= 0 or get(emerg_elev_trimm) ~= 0) or (get(absu_pitch_trimm) ~= 0 and elev_tr_now - elev_tr_last == 0))
	elev_tr_last = elev_tr_now
	
	local wrong_trimm_brt = math.max(trim_fail * lamps_brt * day_night, test_btn)
	
	if get(ismaster) ~= 1 then
	set(wrong_trimm, wrong_trimm_brt)
	end
	
	
	local controll_roll_brt = math.max(get(man_roll_lamp) * lamps_brt * day_night, test_btn) 
	set(controll_roll, controll_roll_brt)
	
	local controll_pitch_brt = math.max(get(man_pitch_lamp) * lamps_brt * day_night, test_btn)
	set(controll_pitch, controll_pitch_brt)
	
	local yoke_sign_brt = math.max(get(man_toga_lamp) * lamps_brt * day_night, test_btn)
	set(yoke_sign, yoke_sign_brt)
	
	if get(triangle_lamp_signal) == 1 then
		triangle_timer = triangle_timer + passed
		if triangle_timer > 0.3 then 
			triangle_lit = 1 - triangle_lit 
			triangle_timer = 0
		end
		
	else
		triangle_lit = 0
		triangle_timer = 0
	end
	
	
	
	
	
	local triangle_brt = math.max(triangle_lit * lamps_brt * day_night, test_btn)
	set(triangle, triangle_brt)
	
	local controll_thrust_brt = math.max(bool2int(AT_mode == -1) * lamps_brt * day_night, test_btn)
	set(controll_thrust, controll_thrust_brt)
	
	local toga_brt = math.max(bool2int(pitch_mode == 2 and pitch_submode == 6) * lamps_brt * day_night, test_btn)
	set(toga, toga_brt)
	
	
	local course_lim_brt = math.max(get(absu_course_out) * lamps_brt * day_night, test_btn) 
	set(course_lim, course_lim_brt)
	
	local gs_lim_brt = math.max(get(absu_gs_out) * lamps_brt * day_night, test_btn)
	set(gs_lim, gs_lim_brt)
	
	
	
	local course_brt = math.max(bool2int(roll_mode == 2 and roll_submode == 6) * lamps_brt * day_night, test_btn)
	set(course, course_brt)
	
	local glideslope_brt = math.max(bool2int(pitch_mode == 2 and pitch_submode == 5) * lamps_brt * day_night, test_btn)
	set(glideslope, glideslope_brt)
	
	local zk_lamp_brt = math.max(bool2int(roll_mode == 2 and roll_submode == 2) * lamps_brt * day_night, test_btn)
	set(zk_lamp, zk_lamp_brt)
	
	local thrust_automat_brt = math.max(bool2int(AT_mode > 2) * lamps_brt * day_night, test_btn)
	set(thrust_automat, thrust_automat_brt)
	
	local stab_roll_brt = math.max(bool2int(roll_mode == 2 and (roll_submode == 1 or roll_submode == 10)) * lamps_brt * day_night, test_btn) 
	set(stab_roll, stab_roll_brt)
	
	local stab_pitch_brt = math.max(bool2int(pitch_mode == 2 and (pitch_submode == 1 or pitch_submode == 10)) * lamps_brt * day_night, test_btn)
	set(stab_pitch, stab_pitch_brt)
	
	local nvu_lamp_brt = math.max(bool2int(roll_mode == 2 and roll_submode == 3) * lamps_brt * day_night, test_btn)
	set(nvu_lamp, nvu_lamp_brt)
	
	local vor_lamp_brt = math.max(bool2int(roll_mode == 2 and (roll_submode == 4 or roll_submode == 5)) * lamps_brt * day_night, test_btn)
	set(vor_lamp, vor_lamp_brt)
	
	local sns_lamp_brt = math.max(bool2int(roll_mode >= 1 and roll_submode == 3 and get(nav_select) == 1) * lamps_brt * day_night, test_btn)
	set(sns_lamp, sns_lamp_brt)
	
	
	local stab_h_brt = math.max(bool2int(pitch_mode == 2 and pitch_submode == 4) * lamps_brt * day_night, test_btn)
	set(stab_h, stab_h_brt)
	
	local stab_v_brt = math.max(bool2int(pitch_mode == 2 and pitch_submode == 2) * lamps_brt * day_night, test_btn)
	set(stab_v, stab_v_brt)
	
	local stab_m_brt = math.max(bool2int(pitch_mode == 2 and pitch_submode == 3) * lamps_brt * day_night, test_btn)
	set(stab_m, stab_m_brt)
	
	local pitch_control_fail_brt = math.max(math.max(get(pitch_contr_lamp),(1-get(hydro_long_control))) * lamps_brt * day_night, test_btn)
	set(pitch_control_fail, pitch_control_fail_brt)
	
	local roll_control_fail_brt = math.max(get(roll_contr_lamp) * lamps_brt * day_night, test_btn) 
	set(roll_control_fail, roll_control_fail_brt)
	
	
	
	local absu_work_logic = get(pkp_fail_left) + get(pkp_fail_right) + get(mgv_contr_fail) < 2
	absu_work_logic = absu_work_logic and bool2int(get(pressure_ind_1) < 100) + bool2int(get(pressure_ind_2) < 100) + bool2int(get(pressure_ind_3) < 100) < 2
	
	local ra56_rud_on = get(absu_ra1_yaw_fail)+get(absu_ra2_yaw_fail)+get(absu_ra3_yaw_fail)==0

	local ra56_ail_on = get(absu_ra1_roll_fail)+get(absu_ra2_roll_fail)+get(absu_ra3_roll_fail)==0
	
	local ra56_elev_on = get(absu_ra1_pitch_fail)+get(absu_ra2_pitch_fail)+get(absu_ra3_pitch_fail)==0
	
	local chan_1_work = get(absu_roll_mode)>0
	local chan_2_work = get(absu_pitch_mode)>0

		
	absu_work_logic = absu_work_logic and (ra56_rud_on and ra56_ail_on and ra56_elev_on)
	absu_work_logic = absu_work_logic and chan_1_work and chan_2_work
	absu_work_logic = absu_work_logic and get(sau_stu_on) == 1 and get(tks_fail_left) + get(tks_fail_right) == 0
	absu_work_logic = absu_work_logic and stu_test_1_cntr < 0.5
	absu_work_logic = absu_work_logic and get(absu_damp_roll_fail) == 0 and get(absu_damp_pitch_fail) == 0 and get(absu_damp_yaw_fail) == 0
	absu_work_logic = absu_work_logic and get(absu_contr_roll_fail) == 0 and get(absu_contr_pitch_fail) == 0
	
	local absu_work_brt = bool2int(absu_work_logic)
	
	
	
	absu_work_brt = math.max(absu_work_brt * lamps_brt * day_night, 0) 
	set(absu_work, absu_work_brt)
	
	
	-- eng panel lamps
	local test_btn_eng = get(lamp_test_eng) * math.max(get(bus27_volt_right) - 10 / 18.5, 0)
	
	local ra56_roll_fail_1_brt = math.max(bool2int(get(absu_ra1_roll_fail) == 1) * lamps_brt * day_night * power, test_btn_eng) 
	set(ra56_roll_fail_1, ra56_roll_fail_1_brt)
	
	local ra56_roll_fail_2_brt = math.max(bool2int(get(absu_ra2_roll_fail) == 1) * lamps_brt * day_night * power, test_btn_eng) 
	set(ra56_roll_fail_2, ra56_roll_fail_2_brt)
	
	local ra56_roll_fail_3_brt = math.max(bool2int(get(absu_ra3_roll_fail) == 1 ) * lamps_brt * day_night * power, test_btn_eng) 
	set(ra56_roll_fail_3, ra56_roll_fail_3_brt)
	
	
	local ra56_pitch_fail_1_brt = math.max(bool2int(get(absu_ra1_pitch_fail) == 1) * lamps_brt * day_night * power, test_btn_eng) 
	set(ra56_pitch_fail_1, ra56_pitch_fail_1_brt)
	
	local ra56_pitch_fail_2_brt = math.max(bool2int(get(absu_ra2_pitch_fail) == 1) * lamps_brt * day_night * power, test_btn_eng) 
	set(ra56_pitch_fail_2, ra56_pitch_fail_2_brt)
	
	local ra56_pitch_fail_3_brt = math.max(bool2int(get(absu_ra3_pitch_fail) == 1) * lamps_brt * day_night * power, test_btn_eng) 
	set(ra56_pitch_fail_3, ra56_pitch_fail_3_brt)
	
	
	local ra56_course_fail_1_brt = math.max(bool2int(get(absu_ra1_yaw_fail) == 1) * lamps_brt * day_night * power, test_btn_eng) 
	set(ra56_course_fail_1, ra56_course_fail_1_brt)
	
	local ra56_course_fail_2_brt = math.max(bool2int(get(absu_ra2_yaw_fail) == 1) * lamps_brt * day_night * power, test_btn_eng) 
	set(ra56_course_fail_2, ra56_course_fail_2_brt)
	
	local ra56_course_fail_3_brt = math.max(bool2int(get(absu_ra3_yaw_fail) == 1) * lamps_brt * day_night * power, test_btn_eng) 
	set(ra56_course_fail_3, ra56_course_fail_3_brt)
	
	
	

end




function update()

	-- [DT] refresh BEFORE the helpers: lamps() integrates `passed` (the STU
	-- test counters and the triangle timer), and refreshing it afterwards fed
	-- those timers the previous frame's delta.
	passed = get(frame_time)

	buttons()
	switchers()
	caps()
	lamps()
	gauges()
	
	start_timer = start_timer + passed
	
	if notLoaded and start_timer > 0.3 then
		sw_reset()
	end

end








