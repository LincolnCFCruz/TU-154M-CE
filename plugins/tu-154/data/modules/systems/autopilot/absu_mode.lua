-- this is ABSU modes logic

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

defineProperty("hydro_ra56_rud_1", globalPropertyi("tu-154/switchers/eng/hydro_ra56_rud_1")) -- RA-56 yaw hydraulic supply
defineProperty("hydro_ra56_rud_2", globalPropertyi("tu-154/switchers/eng/hydro_ra56_rud_2")) -- RA-56 yaw hydraulic supply
defineProperty("hydro_ra56_rud_3", globalPropertyi("tu-154/switchers/eng/hydro_ra56_rud_3")) -- RA-56 yaw hydraulic supply

defineProperty("hydro_ra56_ail_1", globalPropertyi("tu-154/switchers/eng/hydro_ra56_ail_1")) -- RA-56 roll hydraulic supply
defineProperty("hydro_ra56_ail_2", globalPropertyi("tu-154/switchers/eng/hydro_ra56_ail_2")) -- RA-56 roll hydraulic supply
defineProperty("hydro_ra56_ail_3", globalPropertyi("tu-154/switchers/eng/hydro_ra56_ail_3")) -- RA-56 roll hydraulic supply

defineProperty("hydro_ra56_elev_1", globalPropertyi("tu-154/switchers/eng/hydro_ra56_elev_1")) -- RA-56 pitch hydraulic supply
defineProperty("hydro_ra56_elev_2", globalPropertyi("tu-154/switchers/eng/hydro_ra56_elev_2")) -- RA-56 pitch hydraulic supply
defineProperty("hydro_ra56_elev_3", globalPropertyi("tu-154/switchers/eng/hydro_ra56_elev_3")) -- RA-56 pitch hydraulic supply

defineProperty("sau_stu_on", globalPropertyi("tu-154/switchers/ovhd/sau_stu_on"))  -- SAU/STU switch

--defineProperty("tro_comm_1", globalProperty("sim/flightmodel/engine/ENGN_thro[0]"))
--defineProperty("tro_comm_2", globalProperty("sim/flightmodel/engine/ENGN_thro[1]"))
--defineProperty("tro_comm_3", globalProperty("sim/flightmodel/engine/ENGN_thro[2]"))

defineProperty("tro_comm_1", globalPropertyf("tu-154/SC/engine/ENGN_thro_0")) 
defineProperty("tro_comm_2", globalPropertyf("tu-154/SC/engine/ENGN_thro_1")) 
defineProperty("tro_comm_3", globalPropertyf("tu-154/SC/engine/ENGN_thro_2"))



-- buttons
defineProperty("absu_zk", globalPropertyi("tu-154/buttons/console/absu_zk")) -- selected heading (ZK) button on the ABSU panel
defineProperty("absu_reset", globalPropertyi("tu-154/buttons/console/absu_reset")) -- programme reset button on the ABSU panel
defineProperty("absu_nvu", globalPropertyi("tu-154/buttons/console/absu_nvu")) -- NVU button on the ABSU panel
defineProperty("absu_az1", globalPropertyi("tu-154/buttons/console/absu_az1")) -- AZ 1 button on the ABSU panel
defineProperty("absu_az2", globalPropertyi("tu-154/buttons/console/absu_az2")) -- AZ 2 button on the ABSU panel
defineProperty("absu_az1_arm", globalPropertyi("tu-154/buttons/console/absu_az1_arm"))
defineProperty("absu_az2_arm", globalPropertyi("tu-154/buttons/console/absu_az2_arm"))
defineProperty("absu_nvu_arm", globalPropertyi("tu-154/buttons/console/absu_nvu_arm"))
defineProperty("absu_app", globalPropertyi("tu-154/buttons/console/absu_app")) -- approach button on the ABSU panel
defineProperty("absu_gs", globalPropertyi("tu-154/buttons/console/absu_gs")) -- glideslope button on the ABSU panel
defineProperty("absu_stab_m", globalPropertyi("tu-154/buttons/console/absu_stab_m")) -- button M on the ABSU panel
defineProperty("absu_stab_v", globalPropertyi("tu-154/buttons/console/absu_stab_v")) -- button V on the ABSU panel
defineProperty("absu_stab_h", globalPropertyi("tu-154/buttons/console/absu_stab_h")) -- button H on the ABSU panel
defineProperty("absu_stab", globalPropertyi("tu-154/buttons/console/absu_stab")) -- STAB button on the ABSU panel

defineProperty("absu_arrest", globalPropertyi("tu-154/buttons/console/absu_arrest")) -- MGV caging buttons
defineProperty("absu_speed_test_1", globalPropertyi("tu-154/buttons/console/absu_speed_test_1")) -- lower STU test button
defineProperty("absu_speed_test_2", globalPropertyi("tu-154/buttons/console/absu_speed_test_2")) -- upper STU test button

defineProperty("absu_stab_speed", globalPropertyi("tu-154/buttons/console/absu_stab_speed")) -- button C on the ABSU panel
defineProperty("absu_throt_off_1", globalPropertyi("tu-154/buttons/console/absu_throt_off_1")) -- G1 disconnect button on the ABSU panel
defineProperty("absu_throt_off_2", globalPropertyi("tu-154/buttons/console/absu_throt_off_2")) -- G2 disconnect button on the ABSU panel
defineProperty("absu_throt_off_3", globalPropertyi("tu-154/buttons/console/absu_throt_off_3")) -- G3 disconnect button on the ABSU panel

-- power
defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left")) -- 27 V bus voltage
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right")) -- 27 V bus voltage

defineProperty("bus115_1_volt", globalPropertyf("tu-154/elec/bus115_1_volt")) -- 115 V bus voltage
defineProperty("bus115_3_volt", globalPropertyf("tu-154/elec/bus115_3_volt")) -- 115 V bus voltage

defineProperty("bus36_volt_left", globalPropertyf("tu-154/elec/bus36_volt_left")) -- 36 V left bus voltage
defineProperty("bus36_volt_right", globalPropertyf("tu-154/elec/bus36_volt_right")) -- 36 V right bus voltage
defineProperty("bus36_volt_pts250_1", globalPropertyf("tu-154/elec/bus36_volt_pts250_1")) -- 36 V bus voltage, PTS 1
defineProperty("bus36_volt_pts250_2", globalPropertyf("tu-154/elec/bus36_volt_pts250_2")) -- 36 V bus voltage, PTS 2

defineProperty("absu_power_cc", globalPropertyf("tu-154/absu_power_cc")) -- ABSU current draw
defineProperty("absu_power_27", globalPropertyf("tu-154/absu_power_27")) -- ABSU current draw

-- other sources
defineProperty("nvu_mode", globalPropertyi("tu-154/nvu/nvu_mode")) -- NVU mode. 0 = off, 1 = ready, 2 = dead reckoning, 3 = correction
defineProperty("freq_1", globalPropertyf("sim/cockpit2/radios/actuators/nav1_frequency_hz"))  -- set the frequency
defineProperty("freq_2", globalPropertyf("sim/cockpit2/radios/actuators/nav2_frequency_hz"))  -- set the frequency

defineProperty("nav_cs_flag_1", globalPropertyi("tu-154/radio/nav1_cs_flag"))
defineProperty("nav_gs_flag_1", globalPropertyi("tu-154/radio/nav1_gs_flag"))
	
defineProperty("nav_cs_flag_2", globalPropertyi("tu-154/radio/nav2_cs_flag"))
defineProperty("nav_gs_flag_2", globalPropertyi("tu-154/radio/nav2_gs_flag"))

defineProperty("nav_gs_1", globalPropertyf("tu-154/radio/nav1_gs")) -- glideslope

defineProperty("svs_on", globalPropertyi("tu-154/switchers/ovhd/svs_on")) -- SVS switch
defineProperty("svs_fail", globalPropertyi("sim/operation/failures/rel_adc_comp"))  -- static fail


defineProperty("rv5_alt", globalPropertyf("tu-154/misc/rv5_alt_left"))  -- altitude on the left altimeter
defineProperty("rv_flag", globalPropertyf("tu-154/gauges/alt/radioalt_flag_left"))  -- RV flag


defineProperty("absu_course_out", globalPropertyi("tu-154/absu_course_out")) -- flying outside the course limits
defineProperty("absu_gs_out", globalPropertyi("tu-154/absu_gs_out")) -- flying outside the course limits

defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time")) -- time of frame

-- Throttles
defineProperty("anim_rud1", globalPropertyf("tu-154/controlls/throttle_1")) -- throttle 1
defineProperty("anim_rud2", globalPropertyf("tu-154/controlls/throttle_2")) -- throttle 2
defineProperty("anim_rud3", globalPropertyf("tu-154/controlls/throttle_3")) -- throttle 3
-- flaps
defineProperty("flap_inn_L", globalPropertyf("sim/flightmodel/controls/wing1l_fla1def")) -- inner flaps left
defineProperty("flap_inn_R", globalPropertyf("sim/flightmodel/controls/wing1r_fla1def")) -- inner flaps right

-- joystick
--defineProperty("joy_pitch", globalPropertyf("sim/cockpit2/controls/yoke_pitch_ratio")) -- pitch position of joytick
--defineProperty("joy_roll", globalPropertyf("sim/cockpit2/controls/yoke_roll_ratio")) -- roll position of joystick
--defineProperty("joy_yaw", globalPropertyf("sim/cockpit2/controls/yoke_heading_ratio")) -- yaw position of joystick

defineProperty("joy_pitch", globalPropertyf("tu-154/SC/yoke_pitch_ratio")) 
defineProperty("joy_roll", globalPropertyf("tu-154/SC/yoke_roll_ratio")) 
defineProperty("joy_yaw", globalPropertyf("tu-154/SC/yoke_heading_ratio")) 


defineProperty("manip_pitch", globalPropertyf("sim/cockpit2/controls/yoke_pitch_ratio")) 
defineProperty("manip_roll", globalPropertyf("sim/cockpit2/controls/yoke_roll_ratio")) 

--sim/cockpit2/controls/yoke_roll_ratio	sim/cockpit2/controls/yoke_pitch_ratio




defineProperty("pkp_fail_left", globalPropertyf("tu-154/gauges/ahz/ahz_flag_L")) -- 
defineProperty("pkp_fail_right", globalPropertyf("tu-154/gauges/ahz/ahz_flag_R")) -- 
defineProperty("mgv_contr_fail", globalPropertyf("tu-154/gyro/mgv_contr_flag")) -- 

defineProperty("pressure_ind_1", globalPropertyf("tu-154/gauges/hydro/pressure_ind_1")) -- hydraulic system 1 pressure indicator
defineProperty("pressure_ind_2", globalPropertyf("tu-154/gauges/hydro/pressure_ind_2")) -- hydraulic system 2 pressure indicator
defineProperty("pressure_ind_3", globalPropertyf("tu-154/gauges/hydro/pressure_ind_3")) -- hydraulic system 3 pressure indicator

defineProperty("gs_press_1", globalPropertyf("tu-154/hydro/gs_press_1")) -- hydraulic system 1 pressure
defineProperty("gs_press_2", globalPropertyf("tu-154/hydro/gs_press_2")) -- hydraulic system 2 pressure
defineProperty("gs_press_3", globalPropertyf("tu-154/hydro/gs_press_3")) -- hydraulic system 3 pressure
defineProperty("gs_press_4", globalPropertyf("tu-154/hydro/gs_press_4")) -- hydraulic system 4 pressure

defineProperty("tks_fail_left", globalPropertyi("tu-154/tks/fail_left")) -- failure flag
defineProperty("tks_fail_right", globalPropertyi("tu-154/tks/fail_right")) -- failure flag

defineProperty("outer_marker", globalPropertyi("sim/cockpit/misc/outer_marker_lit"))


-- results
defineProperty("roll_main_mode", globalPropertyi("tu-154/absu/roll_main_mode")) -- ABSU main roll mode. 0 = off, 1 = control-wheel steering, 2 = stabilisation
defineProperty("pitch_main_mode", globalPropertyi("tu-154/absu/pitch_main_mode")) -- ABSU main pitch mode. 0 = off, 1 = control-wheel steering, 2 = stabilisation

defineProperty("roll_sub_mode", globalPropertyi("tu-154/absu/roll_sub_mode")) -- ABSU roll mode. 0 - off, 1 - stab, 2 - ZK, 3 - NVU, 4 - AZ1, 5 - AZ2, 6 - approach, 7 - go-around, 10 armed approach
defineProperty("pitch_sub_mode", globalPropertyi("tu-154/absu/pitch_sub_mode")) -- ABSU pitch mode. 0 - off, 1 - stab, 2 - V, 3 - M, 4 - H, 5 - glideslope, 6 - go-around, 10 - armed glideslope

defineProperty("absu_pnp_mode_1", globalPropertyi("tu-154/absu/absu_pnp_mode_1")) -- PNP display mode. 0 = off, 1 = NVU, 2 = VOR1, 3 = VOR2, 4 = landing system
defineProperty("absu_pnp_mode_2", globalPropertyi("tu-154/absu/absu_pnp_mode_2")) -- PNP display mode. 0 = off, 1 = NVU, 2 = VOR1, 3 = VOR2, 4 = landing system


defineProperty("autopilot_mode", globalPropertyi("sim/cockpit/autopilot/autopilot_mode")) -- autopilot in the sim

defineProperty("toga_command", globalPropertyi("tu-154/absu/toga_comm")) -- 	GO-AROUND mode


defineProperty("absu_use_second_nav", globalPropertyi("tu-154/absu_use_second_nav")) -- the ABSU uses the second Kurs-MP



defineProperty("damp_roll_lamp", globalPropertyi("tu-154/absu/damp_roll_lamp")) -- 
defineProperty("damp_pitch_lamp", globalPropertyi("tu-154/absu/damp_pitch_lamp")) -- 
defineProperty("damp_yaw_lamp", globalPropertyi("tu-154/absu/damp_yaw_lamp")) -- 
defineProperty("roll_contr_lamp", globalPropertyi("tu-154/absu/roll_contr_lamp")) -- 
defineProperty("pitch_contr_lamp", globalPropertyi("tu-154/absu/pitch_contr_lamp")) -- 
defineProperty("man_roll_lamp", globalPropertyi("tu-154/absu/man_roll_lamp")) -- 
defineProperty("man_pitch_lamp", globalPropertyi("tu-154/absu/man_pitch_lamp")) -- 
defineProperty("man_toga_lamp", globalPropertyi("tu-154/absu/man_toga_lamp")) -- 
defineProperty("triangle_lamp_signal", globalPropertyi("tu-154/absu/triangle_lamp_signal")) -- 






-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control



-- failures
defineProperty("absu_ra56_roll_fail", globalPropertyi("tu-154/failures/absu_ra56_roll_fail")) -- RA-56 failure
defineProperty("absu_ra56_pitch_fail", globalPropertyi("tu-154/failures/absu_ra56_pitch_fail")) -- RA-56 failure
defineProperty("absu_ra56_yaw_fail", globalPropertyi("tu-154/failures/absu_ra56_yaw_fail")) -- RA-56 failure

-- failures
defineProperty("absu_damp_roll_fail", globalPropertyi("tu-154/failures/absu_damp_roll_fail")) -- roll damper failure
defineProperty("absu_damp_pitch_fail", globalPropertyi("tu-154/failures/absu_damp_pitch_fail")) -- pitch damper failure
defineProperty("absu_damp_yaw_fail", globalPropertyi("tu-154/failures/absu_damp_yaw_fail")) -- yaw damper failure
defineProperty("absu_contr_roll_fail", globalPropertyi("tu-154/failures/absu_contr_roll_fail")) -- lateral control failure
defineProperty("absu_contr_pitch_fail", globalPropertyi("tu-154/failures/absu_contr_pitch_fail")) -- longitudinal control failure
defineProperty("absu_calc_toga_fail", globalPropertyi("tu-154/failures/absu_calc_toga_fail")) -- go-around computer failure
defineProperty("absu_calc_roll_fail", globalPropertyi("tu-154/failures/absu_calc_roll_fail")) -- STU lateral channel failure
defineProperty("absu_calc_pitch_fail", globalPropertyi("tu-154/failures/absu_calc_pitch_fail")) -- STU longitudinal channel failure

defineProperty("absu_fail_signal", globalPropertyi("tu-154/absu/absu_fail_signal")) -- signal to the siren

defineProperty("absu_ra1_roll_fail", globalPropertyi("tu-154/failures/absu_ra1_roll_fail"))
defineProperty("absu_ra2_roll_fail", globalPropertyi("tu-154/failures/absu_ra2_roll_fail"))
defineProperty("absu_ra3_roll_fail", globalPropertyi("tu-154/failures/absu_ra3_roll_fail"))
defineProperty("absu_ra1_pitch_fail", globalPropertyi("tu-154/failures/absu_ra1_pitch_fail"))
defineProperty("absu_ra2_pitch_fail", globalPropertyi("tu-154/failures/absu_ra2_pitch_fail"))
defineProperty("absu_ra3_pitch_fail", globalPropertyi("tu-154/failures/absu_ra3_pitch_fail"))
defineProperty("absu_ra1_yaw_fail", globalPropertyi("tu-154/failures/absu_ra1_yaw_fail"))
defineProperty("absu_ra2_yaw_fail", globalPropertyi("tu-154/failures/absu_ra2_yaw_fail"))
defineProperty("absu_ra3_yaw_fail", globalPropertyi("tu-154/failures/absu_ra3_yaw_fail"))

defineProperty("yoke_offset", globalPropertyf("tu-154/controlls/yoke_offset"))


local TOGA_mode = false
local TOGA_button = false
local AP_button = false

local roll_mode_main = 1
local pitch_mode_main = 1

local signal_timer = 0

TOGA_COMM = findCommand("sim/engines/TOGA_power")

local thro_last_1 = get(tro_comm_1)
local thro_last_2 = get(tro_comm_2)
local thro_last_3 = get(tro_comm_3)

local NVU_mode_arm=0
local AZ1_mode_arm=0
local AZ2_mode_arm=0


function TOGA_comm_hnd(phase)
	if 1 == phase then
		TOGA_mode = true
		TOGA_button = true
		set(toga_command, 1)
	else
		set(toga_command, 0)
		TOGA_button = false
		--set(tro_comm_1, thro_last_1)
		--set(tro_comm_2, thro_last_2)
		--set(tro_comm_3, thro_last_3)
	end
	
	return 0
end

registerCommandHandler(TOGA_COMM, 0, TOGA_comm_hnd)

local AP_toggle = findCommand("sim/autopilot/fdir_toggle")

function AP_toggle_hnd(phase)
	if 0 == phase then
		if get(roll_main_mode) == 2 then set(roll_main_mode, 1) end
		if get(pitch_main_mode) == 2 then set(pitch_main_mode, 1) end
		AP_button = true
	elseif 1 == phase then
		AP_button = true
	else 
		AP_button = false
		--TOGA_mode = false
	end
	return 0
end

registerCommandHandler(AP_toggle, 0, AP_toggle_hnd)





local roll_submode = 1
local pitch_submode = 1

local sau_sw_last = get(sau_stu_on) == 1

local pitch_wheel_last = get(absu_pitch_wheel)


local land_sw_last = get(absu_landing_on) == 1

local power_counter = 0
local state_checked = false

local yoke_reset = false

local elev_fail_timer=0
local ail_fail_timer=0
local rud_fail_timer=0
local fail_time=0.5 --Delay for automatic control channel cutout from ra-56 fail

function update()
	
	
	thro_last_1 = get(tro_comm_1)
	thro_last_2 = get(tro_comm_2)
	thro_last_3 = get(tro_comm_3)
	
	set(autopilot_mode, 0)
	
local MASTER = get(ismaster) ~= 1	
if MASTER then	
	
	-- initial variables
	-- sync
	roll_mode_main = get(roll_main_mode)
	pitch_mode_main = get(pitch_main_mode)
	
	roll_submode = get(roll_sub_mode)
	pitch_submode = get(pitch_sub_mode)
	
	
	
	local sau_sw = get(sau_stu_on) == 1
	
	local power = get(bus27_volt_left) > 13 and get(bus27_volt_right) > 13 and get(bus115_3_volt) > 110 and get(bus36_volt_left) > 30 and get(bus36_volt_right) > 30 and get(bus36_volt_pts250_1) > 30 and sau_sw
	local power27 =get(bus27_volt_left) > 13 and get(bus27_volt_right) > 13 and sau_sw
	
	local passed = get(frame_time)
	
	
	local stab_btn = get(absu_stab) == 1
	
	if stab_btn and not yoke_reset then
		ykoff=get(yoke_offset)
		set(manip_pitch, -ykoff)
		set(manip_roll, 0)
		yoke_reset = true
	else
		yoke_reset = false
	end
	
	
	local pitch_sw = get(absu_pitch_ch_on) == 1
	local roll_sw = get(absu_roll_ch_on) == 1
	
	local ail_hyd_sw = get(absu_ra1_roll_fail) + get(absu_ra2_roll_fail) + get(absu_ra3_roll_fail) < 2 
	
	local elev_hyd_sw = get(absu_ra1_pitch_fail) + get(absu_ra2_pitch_fail) + get(absu_ra3_pitch_fail) < 2
	
	local rud_hyd_sw = get(absu_ra1_yaw_fail) + get(absu_ra2_yaw_fail) + get(absu_ra3_yaw_fail) < 2 
	
	--fail delay 
	if not ail_hyd_sw then
		ail_fail_timer=ail_fail_timer+passed
	else
		ail_fail_timer=ail_fail_timer-passed
	end

	if not elev_hyd_sw then
		elev_fail_timer=elev_fail_timer+passed
	else
		elev_fail_timer=elev_fail_timer-passed
	end
	
	if not rud_hyd_sw then
		rud_fail_timer=rud_fail_timer+passed
	else
		rud_fail_timer=rud_fail_timer-passed
	end
	if ail_fail_timer>fail_time then
		ail_fail_timer=fail_time
	elseif ail_fail_timer<0 then
		ail_fail_timer=0
	end
	
	if elev_fail_timer>fail_time then
		elev_fail_timer=fail_time
	elseif elev_fail_timer<0 then
		elev_fail_timer=0
	end
	
	if rud_fail_timer>fail_time then
		rud_fail_timer=fail_time
	elseif rud_fail_timer<0 then
		rud_fail_timer=0
	end
	
	
	local roll_handle = get(absu_turn_handle)
	
	local rud_toga = get(anim_rud1) + get(anim_rud2) + get(anim_rud3) > 0.99 * 3
	
	local nav_prep = get(absu_nav_on) == 1
	local land_prep = get(absu_landing_on) == 1
	
	local flaps = (get(flap_inn_L) + get(flap_inn_R)) / 2
	
	local reset_but = get(absu_reset) == 1
	
		
	-- conditions, when ABSU can work
	local absu_work_logic = true-- get(pkp_fail_left) + get(pkp_fail_right) + get(mgv_contr_fail) < 2
	--absu_work_logic = absu_work_logic --and bool2int(get(gs_press_1) > 100) + bool2int(get(gs_press_2) > 100) + bool2int(get(gs_press_3) > 100) >= 2
	--absu_work_logic = absu_work_logic -- and sau_sw and get(tks_fail_left) + get(tks_fail_right) == 0
	
	local ahz_work = get(pkp_fail_left) + get(pkp_fail_right) + get(mgv_contr_fail) < 2
	
	-- general yoke mode enable
	if sau_sw ~= sau_sw_last and sau_sw then -- need to extend conditions
		if ail_hyd_sw and rud_hyd_sw and absu_work_logic then 
			roll_mode_main = 1 
			--roll_submode = 1
		end
		if elev_hyd_sw and absu_work_logic then 
			pitch_mode_main = 1 
			--pitch_submode = 1
		end
	end
	--reactivate roll
	if sau_sw and absu_work_logic and roll_mode_main == 0 and ail_fail_timer==0 and rud_fail_timer==0 then 
		roll_mode_main = 1 
	end
	
	-- reactivate pitch
	if sau_sw and absu_work_logic and pitch_mode_main == 0 and elev_fail_timer==0 then 
		pitch_mode_main = 1 
	end
	sau_sw_last = sau_sw
	
	-- roll part
	-- set stab mode
	if roll_mode_main == 1 and stab_btn and roll_sw then
		roll_mode_main = 2
		--roll_submode = 1
	end
	
	-- set yoke mode

	--if roll_mode_main == 2 and (math.abs(get(joy_roll)) > 0.2 or math.abs(get(joy_yaw)) > 0.2 or math.abs(get(joy_pitch)) > 0.2) then
	if roll_mode_main == 2 and math.abs(get(joy_roll)) > 0.2 then --or get(absu_contr_roll_fail) == 1) then
		roll_mode_main = 1
		--pitch_mode_main = 1
	end
	if pitch_mode_main == 2 and math.abs(get(joy_pitch)+get(yoke_offset)) > 0.2 then --or get(absu_contr_pitch_fail) == 1) then
		--roll_mode_main = 1
		pitch_mode_main = 1
		if pitch_submode >= 2 and pitch_submode <= 4 then pitch_submode = 1 end
	end
	
	
	if roll_mode_main == 2 and (not roll_sw or not ahz_work) then
		roll_mode_main = 1
		--pitch_mode_main = 1
	end
	
	-- check mode for once, after loading the acf
	power_counter = power_counter + passed
	
	if power_counter > 15 and not state_checked then
		if power and pitch_mode_main == 0 and roll_mode_main == 0 then 
			pitch_mode_main = 1
			roll_mode_main = 1
		end
		state_checked = true
	end
	
	
	-- reset mode, when no power or hydraulics
	if not power or ail_fail_timer==fail_time or rud_fail_timer==fail_time or not absu_work_logic then
		roll_mode_main = 0
	end

	if not power or elev_fail_timer==fail_time or not absu_work_logic then
		pitch_mode_main = 0
	end
	
		-- if not power or not ail_hyd_sw or not rud_hyd_sw or not absu_work_logic then
		-- roll_mode_main = 0
	-- end

	-- if not power or not elev_hyd_sw or not absu_work_logic then
		-- pitch_mode_main = 0
	-- end
	
	
	-- check if ABSU should use second NAV
	set(absu_use_second_nav, bool2int(get(nav_cs_flag_1) == 1 and isILS(get(freq_2)) and get(nav_cs_flag_2) == 0))
	
	
	
	-- submodes
	if roll_mode_main > 0 then -- need to define cases more clearly
		if roll_submode == 0 then roll_submode = 1 end
		
		if get(absu_zk) == 1 and roll_mode_main == 2 then -- ZK mode
			roll_submode = 2
			NVU_mode_arm=0
			AZ1_mode_arm=0
			AZ2_mode_arm=0			
		elseif (get(absu_nvu) == 1 or NVU_mode_arm==1) and get(nvu_mode) >= 1 and nav_prep and not land_prep and math.abs(roll_handle)< 1 then -- NVU mode
			roll_submode = 3
			
		elseif (get(absu_az1) == 1 or AZ1_mode_arm==1) and nav_prep and not land_prep and math.abs(roll_handle)< 1 then -- AZ mode. works only with VOR freq.
			roll_submode = 4
			
		elseif (get(absu_az2) == 1 or AZ2_mode_arm==1) and nav_prep and not land_prep and math.abs(roll_handle)< 1 then -- AZ mode. works only with VOR freq.
			roll_submode = 5
			
		elseif get(absu_app) == 1 and land_prep and ((isILS(get(freq_1)) and get(nav_cs_flag_1) == 0) or get(absu_use_second_nav) == 1) and math.abs(roll_handle)< 1 then -- APP mode. works only with ILS freq
			roll_submode = 6
			
		elseif get(absu_app) == 1 and land_prep and math.abs(roll_handle)< 1 then -- fake APP mode
			roll_submode = 10
			
		elseif roll_submode == 10 and land_prep and ((isILS(get(freq_1)) and get(nav_cs_flag_1) == 0) or get(absu_use_second_nav) == 1) and math.abs(roll_handle)< 1 then -- switch to APP mode, when ILS established
			roll_submode = 6
			
		elseif reset_but or math.abs(roll_handle)> 1 then -- reset mode
			if reset_but or roll_mode_main>1 then
				NVU_mode_arm=0
				AZ1_mode_arm=0
				AZ2_mode_arm=0
			end
			roll_submode = 1
		elseif roll_submode>2 and roll_submode<6 and not nav_prep then
			roll_submode = 1
		elseif (roll_submode == 6 or roll_submode == 10) and roll_mode_main >= 1 and pitch_mode_main >= 1 and (rud_toga or TOGA_mode) then -- TOGA mode
			roll_mode_main = 2
			pitch_mode_main = 2
			roll_submode = 1
			pitch_submode = 6
		end
	
	else
		roll_submode = 0
	end
	
	
	
	-- reset cases for ROLL modes
	if roll_submode == 4 and roll_mode_main == 2 and (isILS(get(freq_1)) or get(nav_cs_flag_1) == 1) then -- AZ1
		roll_submode = 1
		--TOGA_mode = false
	elseif roll_submode == 5 and roll_mode_main == 2 and (isILS(get(freq_2)) or get(nav_cs_flag_2) == 1) then -- AZ2
		roll_submode = 1
		--TOGA_mode = false
	elseif roll_submode == 6 and (not isILS(get(freq_1)) or get(nav_cs_flag_1) == 1 or not land_prep) and pitch_submode == 5 and roll_mode_main == 2 then -- APP and GS
		roll_submode = 1
		roll_mode_main = 1
		--print("OOPS")
		if get(nav_cs_flag_1) == 1 or not isILS(get(freq_1)) then
			set(man_roll_lamp, 1)
			set(absu_fail_signal, 1)
		end
		--TOGA_mode = false
	elseif roll_submode == 6 and (not isILS(get(freq_1)) or get(nav_cs_flag_1) == 1 or not land_prep) and roll_mode_main == 2 then -- APP
		roll_submode = 1
		if get(nav_cs_flag_1) == 1 or not isILS(get(freq_1)) then
			set(man_roll_lamp, 1)
			set(absu_fail_signal, 1)
		end
		--TOGA_mode = false
		
	end
	
	
	
	
	-- pitch part
	-- set stab mode
	if pitch_mode_main == 1 and stab_btn and pitch_sw then
		pitch_mode_main = 2
		--pitch_submode = 1
	end
	
	-- set yoke mode
	if pitch_mode_main == 2 and (not pitch_sw or not ahz_work) then
		--roll_mode_main = 1
		pitch_mode_main = 1
		if pitch_submode >= 2 and pitch_submode <= 4 then
			pitch_submode = 1
			--roll_submode = 1
		end
	end
	
	local putch_wheel = get(absu_pitch_wheel)
	
	-- submodes
	if pitch_mode_main > 0 then
		if pitch_submode == 0 then pitch_submode = 1 end
		
		local svs = get(svs_on) == 1

		if get(absu_stab_v) == 1 and pitch_mode_main == 2 and svs then -- Stab V mode
			pitch_submode = 2
		
		elseif get(absu_stab_m) == 1 and pitch_mode_main == 2 and svs then -- Stab M mode
			pitch_submode = 3
			
		elseif get(absu_stab_h) == 1 and pitch_mode_main == 2 and svs then -- Stab H mode
			pitch_submode = 4
			
		elseif get(absu_gs) == 1 and land_prep and ((isILS(get(freq_1)) and get(nav_gs_flag_1) == 0) or (get(absu_use_second_nav) == 1) and get(nav_gs_flag_2) == 0) then -- GS mode
			pitch_submode = 5
			
		elseif land_prep and get(nav_gs_flag_1) == 0 and roll_submode == 6 and math.abs(get(nav_gs_1)) < 0.02 and flaps > 31 then -- auto GS mode
			pitch_submode = 5
			
		elseif get(absu_gs) == 1 and land_prep then -- fake GS mode
			pitch_submode = 10
			
		elseif pitch_submode == 10 and land_prep and ((isILS(get(freq_1)) and get(nav_gs_flag_1) == 0) or (get(absu_use_second_nav) == 1) and get(nav_gs_flag_2) == 0) then --switch to GS mode after ILS established
			pitch_submode = 5
			
		elseif pitch_wheel_last ~= putch_wheel or (reset_but and pitch_submode >= 5) then -- reset. wheel or reset button on GS and TOGA modes
			pitch_submode = 1
		
		elseif pitch_mode_main == 1 and (pitch_submode == 2 or pitch_submode == 3 or pitch_submode == 4) then -- reset V M H modes, when MAN mode
			pitch_submode = 1
		
			
		end
	
	else 
		pitch_submode = 0
	end
	
	
	if reset_but then -- reset mode
		roll_submode = 1
		if pitch_submode < 2 or pitch_submode > 4 then
			pitch_submode = 1
		end
	end
	
	-- reset TOGA mode
	if pitch_submode ~= 6 then
		TOGA_mode = false
	end
	
	--print(TOGA_mode, "  ", pitch_submode, "  ", roll_submode)
	

	pitch_wheel_last = putch_wheel
	
	-- reset some modes
	if pitch_mode_main == 2 and (not isILS(get(freq_1)) or not land_prep or get(nav_gs_flag_1) == 1) and pitch_submode == 5 then -- GS mode
		pitch_submode = 1
		pitch_mode_main = 1
		
		if get(nav_gs_flag_1) == 1 or not isILS(get(freq_1)) then
			set(man_pitch_lamp, 1)
			set(absu_fail_signal, 1)
		end
		
	end
	
	
	
	
	
	
	
	-- lamp signals
	set(damp_roll_lamp, bool2int(power27 and (roll_mode_main == 0 or ail_fail_timer==fail_time)))
	set(damp_pitch_lamp, bool2int(power27 and (pitch_mode_main == 0 or elev_fail_timer==fail_time)))
	set(damp_yaw_lamp, bool2int(power27 and (roll_mode_main == 0 or rud_fail_timer==fail_time)))
	set(roll_contr_lamp, bool2int(power and get(absu_contr_roll_fail) == 1))
	set(pitch_contr_lamp, bool2int(power and get(absu_contr_pitch_fail) == 1))
	
	
	
	-- roll lamp
	if power and roll_mode_main == 2 then
		if get(absu_damp_roll_fail) == 1 or get(absu_contr_roll_fail) == 1 or (get(absu_calc_toga_fail) == 1 and pitch_submode == 6) or (get(absu_calc_roll_fail) == 1 and roll_submode > 1 and roll_submode ~= 10) 
		then
			set(man_roll_lamp, 1)
			set(absu_fail_signal, 1)
		end
	end
	
	if power and roll_mode_main == 2 then
		if (get(tks_fail_left) + get(tks_fail_right) == 2 and roll_submode > 1 and roll_submode ~= 10) or
			(get(nav_cs_flag_1) == 1 and (roll_submode == 4 or roll_submode == 6) )
		then
			roll_submode = 1
			set(man_roll_lamp, 1)
			set(absu_fail_signal, 1)
		end
	end
	
	
	
	-- pitch lamp
	if power and pitch_mode_main == 2 then
		if get(absu_damp_pitch_fail) == 1 or get(absu_contr_pitch_fail) == 1 or 
			(get(absu_calc_toga_fail) == 1 and pitch_submode == 6) or 
			(get(absu_calc_pitch_fail) == 1 and pitch_submode > 1) 
		then
			pitch_mode_main = 1
			
			pitch_submode = 1
			
			set(man_pitch_lamp, 1)
			set(absu_fail_signal, 1)
		end	
	end
	
	if power and pitch_mode_main == 2 then
		if ((get(svs_fail) == 6 or get(svs_on) == 0) and (pitch_submode == 2 or pitch_submode == 3 or pitch_submode == 4)) or
			((pitch_submode == 5) and get(nav_gs_flag_1) == 1)
			then
			pitch_submode = 1
			pitch_mode_main = 1
			set(man_pitch_lamp, 1)
			set(absu_fail_signal, 1)
		end
	end
	
	
	
	
	-- roll and pitch lamps on RV fail
	if power and pitch_mode_main == 2 then
		if get(rv_flag) == 1 and get(outer_marker) == 1 and roll_submode == 6 and pitch_submode == 5 then
			pitch_mode_main = 1
			roll_submode = 1
			pitch_submode = 1
			set(man_roll_lamp, 1)
			set(man_pitch_lamp, 1)
			set(absu_fail_signal, 1)
		end
	
	end
	
	-- TOGA lamp
	if power and pitch_submode == 6 then
		if get(absu_calc_toga_fail) == 1 or get(absu_damp_pitch_fail) == 1 then
			set(man_toga_lamp, 1)
			set(man_pitch_lamp, 1)
			set(man_roll_lamp, 1)
			set(absu_fail_signal, 1)
		end
	end
	
	
	-- triangle lamp
	if get(rv5_alt) < 60 and power and roll_submode == 6 and pitch_submode == 5 and (get(man_pitch_lamp) == 1 or get(man_roll_lamp) == 1 or get(absu_course_out) == 1 or get(absu_gs_out) == 1) then
		set(triangle_lamp_signal, 1)
	end
	
	
	

	
	-- end alarm
	if (get(absu_fail_signal) == 1 and signal_timer > 8) then
		set(absu_fail_signal, 0)
		signal_timer = 0
	end
	
	if get(absu_fail_signal) == 0 then
		signal_timer = 0
	end
	
	-- reset lamps and alarm
	if not power or TOGA_button or AP_button then
		set(absu_fail_signal, 0)
		set(man_roll_lamp, 0)
		set(man_pitch_lamp, 0)
		set(man_toga_lamp, 0)
		set(triangle_lamp_signal, 0)
		signal_timer = 0
		--print("reset" .. passed)
	end
	
	-- fail alarm logic
	if get(absu_fail_signal) == 1 then
		signal_timer = signal_timer + passed
	else signal_timer = 0
	end
	

	

	
	
	-- reset modes on failures or turned off sources
	if get(absu_damp_roll_fail) == 1 then roll_mode_main = 0 end -- roll damper fail
	if get(absu_damp_pitch_fail) == 1 then pitch_mode_main = 0 end -- roll damper fail
	if get(absu_contr_roll_fail) == 1 and roll_mode_main == 2 then roll_mode_main = 1 end -- roll controls fail
	if get(absu_contr_pitch_fail) == 1 and pitch_mode_main == 2 then pitch_mode_main = 1 end -- pitch controls fail
	if get(absu_calc_toga_fail) == 1 and roll_mode_main >=1 and pitch_mode_main >= 1 and pitch_submode == 6 then roll_mode_main = 1 pitch_mode_main = 1 end -- TOGA calc fail
	if get(absu_calc_roll_fail) == 1 and roll_mode_main >= 1 then roll_submode = 1 end -- STU roll fail
	if get(absu_calc_pitch_fail) == 1 and pitch_mode_main >= 1 then pitch_submode = 1 end -- STU pitch fail
	
	
	
	
	
	
	
	
	
	
	
	
	-----------------------
	-- full disable ABSU --
	if not sau_sw then 
		roll_mode_main = 0
		roll_submode = 0
	end
	
	if not sau_sw then
		pitch_mode_main = 0
		pitch_submode = 0
	end


	-- indication modes


	
	set(absu_pnp_mode_2, get(absu_speed_mode) * bool2int(power)) -- set Co-Pilot PNP right away.
	
	-- Captain PNP
	
	
	if reset_but or not power then
		set(absu_pnp_mode_1, 0) -- off mode
		NVU_mode_arm=0
		AZ1_mode_arm=0
		AZ2_mode_arm=0
	elseif land_prep ~= land_sw_last and land_prep then
		set(absu_pnp_mode_1, 4) -- landing mode
	elseif get(absu_nvu) == 1 then
		set(absu_pnp_mode_1, 1) -- NAV mode
		NVU_mode_arm=1
		AZ1_mode_arm=0
		AZ2_mode_arm=0
	elseif get(absu_az1) == 1 then
		set(absu_pnp_mode_1, 2) -- VOR 
		NVU_mode_arm=0
		AZ1_mode_arm=1
		AZ2_mode_arm=0
	elseif get(absu_az2) == 1 then
		set(absu_pnp_mode_1, 3) -- VOR 
		NVU_mode_arm=0
		AZ1_mode_arm=0
		AZ2_mode_arm=1
	end
	

	land_sw_last = land_prep
	
	
	
	
	


	-- set results
	set(roll_main_mode, roll_mode_main)
	set(pitch_main_mode, pitch_mode_main)

	set(roll_sub_mode, roll_submode)
	set(pitch_sub_mode, pitch_submode)
	
	--set(toga_command, bool2int(TOGA_mode))


	
	set(absu_power_cc, bool2int(power))
	set(absu_power_27, bool2int(power27))
	set(absu_nvu_arm,NVU_mode_arm)
	set(absu_az1_arm,AZ1_mode_arm)
	set(absu_az2_arm,AZ2_mode_arm)

end

end



