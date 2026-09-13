
-- sources
defineProperty("ias_left", globalPropertyf("tu-154/gauges/speed/ias_left")) -- indicated airspeed, captain
defineProperty("ias_right", globalPropertyf("tu-154/gauges/speed/ias_right")) -- indicated airspeed, copilot

-- controls
defineProperty("absu_speed_change", globalPropertyi("tu-154/switchers/console/absu_speed_change")) -- speed change knob.
defineProperty("absu_speed_off", globalPropertyi("tu-154/switchers/console/absu_speed_off")) -- 1 and 2 disconnect
defineProperty("absu_speed_prepare", globalPropertyi("tu-154/switchers/console/absu_speed_prepare")) -- preparation
defineProperty("absu_speed_us_right_left", globalPropertyi("tu-154/switchers/console/absu_speed_us_right_left")) -- preparation

defineProperty("absu_stab_speed", globalPropertyi("tu-154/buttons/console/absu_stab_speed")) -- button C on the ABSU panel
defineProperty("absu_throt_off_1", globalPropertyi("tu-154/buttons/console/absu_throt_off_1")) -- G1 disconnect button on the ABSU panel
defineProperty("absu_throt_off_2", globalPropertyi("tu-154/buttons/console/absu_throt_off_2")) -- G2 disconnect button on the ABSU panel
defineProperty("absu_throt_off_3", globalPropertyi("tu-154/buttons/console/absu_throt_off_3")) -- G3 disconnect button on the ABSU panel

defineProperty("anim_rud1", globalPropertyf("tu-154/controlls/throttle_1")) -- throttle 1
defineProperty("anim_rud2", globalPropertyf("tu-154/controlls/throttle_2")) -- throttle 2
defineProperty("anim_rud3", globalPropertyf("tu-154/controlls/throttle_3")) -- throttle 3


defineProperty("tro_comm_1", globalPropertyf("tu-154/SC/engine/ENGN_thro_0")) 
defineProperty("tro_comm_2", globalPropertyf("tu-154/SC/engine/ENGN_thro_1")) 
defineProperty("tro_comm_3", globalPropertyf("tu-154/SC/engine/ENGN_thro_2"))


defineProperty("absu_nav_on", globalPropertyi("tu-154/switchers/console/absu_nav_on")) -- navigation needles
defineProperty("absu_landing_on", globalPropertyi("tu-154/switchers/console/absu_landing_on")) -- landing needles

defineProperty("roll_main_mode", globalPropertyi("tu-154/absu/roll_main_mode")) -- ABSU main roll mode. 0 = off, 1 = control-wheel steering, 2 = stabilisation
defineProperty("pitch_main_mode", globalPropertyi("tu-154/absu/pitch_main_mode")) -- ABSU main pitch mode. 0 = off, 1 = control-wheel steering, 2 = stabilisation

defineProperty("roll_sub_mode", globalPropertyi("tu-154/absu/roll_sub_mode")) -- ABSU roll mode. 0 - off, 1 - stab, 2 - ZK, 3 - NVU, 4 - AZ1, 5 - AZ2, 6 - approach, 7 - go-around, 10 - armed APPROACH
defineProperty("pitch_sub_mode", globalPropertyi("tu-154/absu/pitch_sub_mode")) -- ABSU pitch mode. 0 - off, 1 - stab, 2 - V, 3 - M, 4 - H, 5 - glideslope, 6 - go-around, 10 - armed GLIDESLOPE

-- power
defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right"))

defineProperty("bus36_volt_left", globalPropertyf("tu-154/elec/bus36_volt_left"))

defineProperty("bus115_1_volt", globalPropertyf("tu-154/elec/bus115_1_volt"))

defineProperty("absu_at_power_cc", globalPropertyf("tu-154/absu_at_power_cc")) -- ABSU current draw


defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time")) -- time of frame

-- results
defineProperty("ias_yellow_left", globalPropertyf("tu-154/gauges/speed/ias_yellow_left")) -- yellow marker on the captain's speed indicator
defineProperty("ias_yellow_right", globalPropertyf("tu-154/gauges/speed/ias_yellow_right")) -- yellow marker on the copilot's speed indicator


defineProperty("absu_at_dif_left", globalPropertyf("tu-154/absu_at_dif_left")) -- speed difference for the PKP indication
defineProperty("absu_at_dif_right", globalPropertyf("tu-154/absu_at_dif_right")) -- speed difference for the PKP indication


defineProperty("rud_1_spd", globalPropertyf("tu-154/absu/rud_1_spd")) -- lever movement rate
defineProperty("rud_2_spd", globalPropertyf("tu-154/absu/rud_2_spd")) -- lever movement rate
defineProperty("rud_3_spd", globalPropertyf("tu-154/absu/rud_3_spd")) -- lever movement rate

defineProperty("stu_mode", globalPropertyi("tu-154/absu/stu_mode")) -- autothrottle modes. 0 = off, 1 = on, 2 = armed, 3 = stabilisation, 4 = go-around
defineProperty("toga_command", globalPropertyi("tu-154/absu/toga_comm")) -- 	GO-AROUND mode


-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control

-- failures
defineProperty("absu_at1_fail", globalPropertyi("tu-154/failures/absu_at1_fail")) -- autothrottle failure
defineProperty("absu_at2_fail", globalPropertyi("tu-154/failures/absu_at2_fail")) -- autothrottle failure




defineProperty("absu_thro1_lit", globalPropertyf("tu-154/lights/button/absu_thro1"))
defineProperty("absu_thro2_lit", globalPropertyf("tu-154/lights/button/absu_thro2"))
defineProperty("absu_thro3_lit", globalPropertyf("tu-154/lights/button/absu_thro3"))
defineProperty("absu_spd_btn_lit", globalPropertyf("tu-154/lights/button/absu_stab_spd"))
-- Longitudinal acceleration feedback, ported from the Tu-154B2 auto-throttle
-- (2026-09-10). gforce_axil is read-only in v1243, which is all we need here.
defineProperty("g_ax", globalPropertyf("sim/flightmodel2/misc/gforce_axil"))
defineProperty("bkk_pitch", globalPropertyf("tu-154/bkk/bkk_pitch")) -- pitch from the BKK, set by warnings/bkk.lua
-- Flight-path kinematics, the second acceleration source (documented, local OGL frame)
defineProperty("loc_ax", globalPropertyf("sim/flightmodel/position/local_ax"))
defineProperty("loc_ay", globalPropertyf("sim/flightmodel/position/local_ay"))
defineProperty("loc_az", globalPropertyf("sim/flightmodel/position/local_az"))
defineProperty("loc_vx", globalPropertyf("sim/flightmodel/position/local_vx"))
defineProperty("loc_vy", globalPropertyf("sim/flightmodel/position/local_vy"))
defineProperty("loc_vz", globalPropertyf("sim/flightmodel/position/local_vz"))
-- published for the debug inspector's ABSU tab and the test cards
defineProperty("at_gain", globalPropertyf("tu-154/absu/at_gain"))
defineProperty("at_cmd", globalPropertyf("tu-154/absu/at_cmd"))
defineProperty("at_accel_body", globalPropertyf("tu-154/absu/at_accel_body"))
defineProperty("at_accel_path", globalPropertyf("tu-154/absu/at_accel_path"))
-- test switches, set from DataRefTool (see core/dataref_creator_2.lua)
defineProperty("tune_gain_table", globalPropertyi("tu-154/tune/at_gain_table"))
defineProperty("tune_ax_mode", globalPropertyi("tu-154/tune/at_ax_mode"))


local AT_mode = 0 -- 0 = off, 1 = sync spd, 2 = prepare, 3 = work, 4 = TOGA

-- sim/engines/throttle_down
-- sim/engines/throttle_up

-- Auto-throttle PD gain schedule, written in INDICATED AIRSPEED, KM/H.
-- Caution: ias_left / ias_right do NOT carry a speed, they carry the airspeed
-- NEEDLE ANGLE in degrees (mech_aneroid.lua:
--   ang = (V - 150) * 260 / 650 + 10, so V[km/h] = ang * 2.5 + 125).
-- The pre-patch code indexed it with ang * 1.885, which moved the
-- 300/330/400 breakpoints to ~523/563/655 km/h. tu-154/tune/at_gain_table
-- picks between that reading (0) and the km/h one (1) - see update().
local PD_gain_tbl = {{ 0, 0.33},  -- bugs workaround
				  { 300, 0.33 },  --
				  { 330, 0.5 },  --				  
				  { 400, 1 },  -- 
          		  { 1000, 1 }}   -- bugs workaround


local THR_dn = findCommand("sim/engines/throttle_down")

function THR_dn_hnd(phase)
	if 1 == phase then
		if get(stu_mode) > 2 then set(stu_mode, 2) end
	end
	return 0
end

registerCommandHandler(THR_dn, 0, THR_dn_hnd)


local THR_up = findCommand("sim/engines/throttle_up")

function THR_up_hnd(phase)
	if 1 == phase then
		if get(stu_mode) > 2 then set(stu_mode, 2) end
	end
	return 0
end

registerCommandHandler(THR_up, 0, THR_up_hnd)


local spd_hold = 0
local IAS_smth = 0


local prepare_counter = 0
local rud_chng = false
local rud_last = get(tro_comm_1) + get(tro_comm_2) + get(tro_comm_3)

local rud_last_1 = get(tro_comm_1)
local rud_last_2 = get(tro_comm_2)
local rud_last_3 = get(tro_comm_3)

local marker_act_L = get(ias_left)
local marker_act_R = get(ias_right)

IAS_last = 0
local T_FILT = 0.1       -- s, acceleration filter time constant (from the B2 script)
local acc_smth = 0       -- low-passed forward acceleration, km/h/s
local acc_last = 0
local ax_mode_last = 0

local stab_counter = 0
local stab_unpr = 0

local spd_diff_ind_L = 0
local spd_diff_ind_R = 0


function update()
	
	local MASTER = get(ismaster) ~= 1
	
	local passed = get(frame_time)

	-- Forward acceleration for the autothrottle, km/h/s, positive = speeding
	-- up. Computed every frame, engaged or not, so test card T1 can compare the
	-- two sources on a takeoff roll and the filter is settled on engagement.
	--   source 1, body axis (the 2026-09-10 patch): gforce_axil corrected for
	--     pitch. ASSUMES gforce_axil reads negative when accelerating forward -
	--     DataRefs.txt does not document its sign - and goes wrong if the BKK
	--     pitch freezes.
	--   source 2, flight path: the local OGL acceleration projected on the
	--     velocity vector. Documented units, no sign question, no BKK.
	local accel_body = -(get(g_ax) + math.sin(get(bkk_pitch) * math.pi / 180)) * 9.81 * 3.6
	local vx, vy, vz = get(loc_vx), get(loc_vy), get(loc_vz)
	local v_path = math.sqrt(vx * vx + vy * vy + vz * vz)
	local accel_path = 0
	if v_path > 1 then
		accel_path = (get(loc_ax) * vx + get(loc_ay) * vy + get(loc_az) * vz) / v_path * 3.6
	end
	set(at_accel_body, accel_body)
	set(at_accel_path, accel_path)

	local ax_mode = get(tune_ax_mode)
	local accel = 0
	if ax_mode == 1 then accel = accel_body elseif ax_mode == 2 then accel = accel_path end
	if ax_mode ~= ax_mode_last then -- a source change must not read as a jerk
		acc_smth, acc_last, ax_mode_last = accel, accel, ax_mode
	end
	acc_smth = accel * passed / (T_FILT + passed) + acc_smth * T_FILT / (T_FILT + passed)
	local D_acc = 0
	if passed > 0 then D_acc = (acc_smth - acc_last) / passed end
	acc_last = acc_smth

	local channel_off = get(absu_speed_off) -- 1 = 1, -1 = 2
	
	-- get(absu_speed_prepare) == 1
	
	local power = get(bus36_volt_left) > 30 and get(bus115_1_volt) > 110 and get(bus27_volt_left) > 13 
	local at_1_work = bool2int(get(bus27_volt_left) > 13 and channel_off ~= 1 and get(absu_at1_fail) == 0) 
	local at_2_work = bool2int(get(bus27_volt_right) > 13 and channel_off ~= -1 and get(absu_at2_fail) == 0)
	
	local prepare = get(absu_speed_prepare) == 1
	local rud_now = get(tro_comm_1) + get(tro_comm_2) + get(tro_comm_3)
	-- calculate working throttles
	local rud_work_1 = (1 - get(absu_throt_off_1))
	local rud_work_2 = (1 - get(absu_throt_off_2))
	local rud_work_3 = (1 - get(absu_throt_off_3))
	
	local rud_now_1 = get(tro_comm_1)
	local rud_now_2 = get(tro_comm_2)
	local rud_now_3 = get(tro_comm_3)
	

	-- STU modes
	local stu_roll_ready = get(roll_main_mode) > 0 and get(absu_nav_on) == 1
	local stu_pitch_ready = get(pitch_main_mode) > 0 and get(absu_landing_on) == 1
	
	
	local stab_button = get(absu_stab_speed) == 1
	
	AT_mode = get(stu_mode)
	
	-- calculate the AT mode
	if not power then 
		AT_mode = 0 -- off
	elseif at_1_work + at_2_work == 0 then -- total fail
		AT_mode = -1
	elseif prepare_counter < 1 and power then -- sync mode
		AT_mode = 1 -- ON, but not ready
	elseif power and prepare and prepare_counter >= 1 and AT_mode == 1 then -- preparing, sync mode is active
		AT_mode = 2 -- ready mode
	elseif power and prepare and rud_work_1 + rud_work_2 + rud_work_3 > 1 and stab_button and AT_mode == 2 and stab_counter > 0.1 and get(anim_rud1) > 0.09 and get(anim_rud2) > 0.09 and get(anim_rud3) > 0.09 then 
		AT_mode = 3 -- stab mode
		rud_last = rud_now
		rud_last_1 = rud_now_1
		rud_last_2 = rud_now_2
		rud_last_3 = rud_now_3
		stab_counter = 0
	elseif power and prepare and AT_mode == 3 and stu_pitch_ready and get(pitch_sub_mode) == 6 then
		AT_mode = 4 -- TOGA mode
		rud_last = rud_now
		rud_last_1 = rud_now_1
		rud_last_2 = rud_now_2
		rud_last_3 = rud_now_3
		stab_counter = 0
	elseif rud_work_1 + rud_work_2 + rud_work_3 < 2 and AT_mode >= 3 then 
		AT_mode = 2 -- disable AT by disconnecting two RUDs
		stab_counter = 0
	elseif rud_chng and AT_mode >= 3 then
		AT_mode = 2 -- disable AT by moving RUDs
		stab_counter = 0
	elseif AT_mode == 4 and get(anim_rud1) > 0.98 * rud_work_1 and get(anim_rud2) > 0.98 * rud_work_2 and get(anim_rud3) > 0.98 * rud_work_3 then
		AT_mode = 2 -- disable AT, when TOGA move complete
		stab_counter = 0
    elseif power and prepare and (get(absu_throt_off_1) + get(absu_throt_off_2) + get(absu_throt_off_3)) == 2 and stab_button and AT_mode == 2 and stab_counter > 0.1 then
            set(absu_spd_btn_lit,1)
            if get(absu_throt_off_1) > 0 then
                set(absu_thro1_lit,1)
            end
            if get(absu_throt_off_2) > 0 then
                set(absu_thro2_lit,1)
            end
            if get(absu_throt_off_3) > 0 then
                set(absu_thro3_lit,1)
            end
            stab_unpr = 1
	end
	
    if stab_unpr == 1 and not stab_button then
            set(absu_thro1_lit,0)
            set(absu_thro2_lit,0)
            set(absu_thro3_lit,0)
            set(absu_spd_btn_lit,0)
            stab_unpr = 0
    end
    
	if not stab_button then stab_counter = stab_counter + passed end
	
	if MASTER then set(stu_mode, AT_mode) end
	
	
	-- additional calculations
	if power and prepare then prepare_counter = prepare_counter + passed 
	else prepare_counter = 0
	end
	
	if prepare_counter > 1 then prepare_counter = 1 end
	
	-- RUD change calc
	local rud_moved = bool2int(math.abs(rud_last_1 - rud_now_1) > passed and rud_work_1 == 1) + bool2int(math.abs(rud_last_2 - rud_now_2) > passed and rud_work_2 == 1) + bool2int(math.abs(rud_last_3 - rud_now_3) > passed and rud_work_3 == 1)
	if rud_moved > 1 then
		rud_last = rud_now
		rud_last_1 = rud_now_1
		rud_last_2 = rud_now_2
		rud_last_3 = rud_now_3
		rud_chng = true
	else 
		rud_chng = false
	end
	
	-- take IAS
	local IAS = get(ias_left)
	
	-- sync markers
	marker_act_L = get(ias_yellow_left)
	marker_act_R = get(ias_yellow_right)
	
	
	-- switch source
	local source = 1 - get(absu_speed_us_right_left)
	if source == 1 then 
		IAS = get(ias_right)
	end
	
	IAS_smth = IAS_smth + (IAS - IAS_smth) * passed * 2

	-- PD gain, from the schedule tu-154/tune/at_gain_table selects
	local gain
	if get(tune_gain_table) == 0 then
		gain = interpolate(PD_gain_tbl, IAS * 1.885)       -- pre-patch indexing
	else
		gain = interpolate(PD_gain_tbl, IAS * 2.5 + 125)   -- needle angle -> km/h
	end
	set(at_gain, gain)
	set(at_cmd, 0) -- overwritten below while the autothrottle stabilises
	

	-- throttles and speed calculations
	if AT_mode == 1 or AT_mode == 2 then -- sync markers
		
		marker_act_L = marker_act_L + (IAS_smth - marker_act_L) * passed * 2
		marker_act_R = marker_act_R + (IAS_smth - marker_act_R) * passed * 2
		
		set(rud_1_spd, 0)
		set(rud_2_spd, 0)
		set(rud_3_spd, 0)
		
		spd_diff_ind_L = spd_diff_ind_L - spd_diff_ind_L * passed
		spd_diff_ind_R = spd_diff_ind_R - spd_diff_ind_R * passed
		
	elseif AT_mode == 3 then -- work throuttles
		
		-- control marker's position
		local work_spd = 0
		if source == 0 then -- work with left side
			marker_act_L = marker_act_L + get(absu_speed_change) * passed * 4
			marker_act_R = marker_act_R + (IAS_smth - marker_act_R) * passed * 2
			work_spd = marker_act_L
			
			spd_diff_ind_L = IAS_smth - marker_act_L
			spd_diff_ind_R = spd_diff_ind_R - spd_diff_ind_R * passed
			
		else
			marker_act_R = marker_act_R + get(absu_speed_change) * passed * 4
			marker_act_L = marker_act_L + (IAS_smth - marker_act_L) * passed * 2
			work_spd = marker_act_R
			
			spd_diff_ind_L = spd_diff_ind_L - spd_diff_ind_L * passed
			spd_diff_ind_R =  IAS_smth - marker_act_R
		end
		
		
		-- calculate the speed
		local P = work_spd - IAS_smth
		
		local D = 0 -- take airspeed
		if passed ~= 0 then D = (IAS_smth - IAS_last) / passed end
		IAS_last = IAS_smth
		
		local K_P = 0.003
		local K_D = -0.05
		
		
		-- gain was taken from the selected schedule above, next to IAS_smth
		
		
		-- Longitudinal acceleration feedback, ported from the Tu-154B2 script
		-- (2026-09-10). acc_smth / D_acc are the forward acceleration (km/h/s,
		-- positive = speeding up) and its rate, filtered at the top of update()
		-- from the source tu-154/tune/at_ax_mode selects; 0 when the term is off.
		-- Fed back NEGATIVELY, it lets the controller see a thrust/drag imbalance
		-- before the speed moves - which is what makes the B2 hold speed through
		-- climbs and descents.
		
		-- B2 gains rescaled to this script: the B2 divides the whole sum by 80 and
		-- applies no channel multiplier, while here main_rud_spd is later multiplied
		-- by (at_1_work + at_2_work) * 0.6 = 1.2 with both channels. So B2 K/80/1.2.
		-- SET BOTH TO 0 TO DISABLE THIS TERM AND BISECT AGAINST THE GAIN-SCHEDULE FIX.
		local K_AX   = 0.0167   -- B2 1.6 / 80 / 1.2
		local K_D_AX = 0.0208   -- B2 2.0 / 80 / 1.2
		
		local main_rud_spd = P * K_P * gain + D * K_D * gain -
		                     (acc_smth * K_AX + D_acc * K_D_AX) * gain
		
		if main_rud_spd > 0.3 then main_rud_spd = 0.3
		elseif main_rud_spd < -0.3 then main_rud_spd = -0.3 end
		
		local rud_current = (get(anim_rud1) + get(anim_rud2) + get(anim_rud3)) / 3
		
		if rud_current > 0.95 and main_rud_spd > 0 then main_rud_spd = 0 end -- limit upper edge of throttle usage
		-- Lower stop, ported from the Tu-154B2 script: once any working throttle is
		-- down at the idle end, stop commanding further reduction. Without this the
		-- auto-throttle keeps integrating downwards against the idle stop and then
		-- has to wind all the way back up before anything moves.
		if main_rud_spd < 0 and ((get(anim_rud1) < 0.15 and rud_work_1 == 1)
		                      or (get(anim_rud2) < 0.15 and rud_work_2 == 1)
		                      or (get(anim_rud3) < 0.15 and rud_work_3 == 1)) then
			main_rud_spd = 0
		end
		set(at_cmd, main_rud_spd)
		
		local rud_spd_1 = main_rud_spd * math.random(95, 105) * 0.01
		local rud_spd_2 = main_rud_spd * math.random(95, 105) * 0.01
		local rud_spd_3 = main_rud_spd * math.random(95, 105) * 0.01
		
		
		if MASTER then
		
			set(rud_1_spd, rud_spd_1 * rud_work_1 * (at_1_work + at_2_work) * 0.6)
			set(rud_2_spd, rud_spd_2 * rud_work_2 * (at_1_work + at_2_work) * 0.6)
			set(rud_3_spd, rud_spd_3 * rud_work_3 * (at_1_work + at_2_work) * 0.6)
		
		end
		
		
	elseif AT_mode == 4 then -- TOGA
		
		marker_act_L = marker_act_L + (IAS_smth - marker_act_L) * passed * 2
		marker_act_R = marker_act_R + (IAS_smth - marker_act_R) * passed * 2
		
		
		if MASTER then
			set(rud_1_spd, 0.3 * rud_work_1 * (at_1_work + at_2_work) * 0.6)
			set(rud_2_spd, 0.3 * rud_work_2 * (at_1_work + at_2_work) * 0.6)
			set(rud_3_spd, 0.3 * rud_work_3 * (at_1_work + at_2_work) * 0.6)
		end
		
		spd_diff_ind_L = spd_diff_ind_L - spd_diff_ind_L * passed
		spd_diff_ind_R = spd_diff_ind_R - spd_diff_ind_R * passed
		
	else
		
		set(rud_1_spd, 0)
		set(rud_2_spd, 0)
		set(rud_3_spd, 0)
		
		spd_diff_ind_L = spd_diff_ind_L - spd_diff_ind_L * passed
		spd_diff_ind_R = spd_diff_ind_R - spd_diff_ind_R * passed
	

	end
	
	
	if marker_act_L > 350 then marker_act_L = 350
	elseif marker_act_L < 0 then marker_act_L = 0 end
	
	if marker_act_R > 350 then marker_act_R = 350
	elseif marker_act_R < 0 then marker_act_R = 0 end

if MASTER then
	
	set(ias_yellow_left, marker_act_L)
	set(ias_yellow_right, marker_act_R)
	
	
	if get(toga_command) == 1 and AT_mode ~= 4 then -- fake TOGA
		set(rud_1_spd, -0.00001)
		set(rud_2_spd, -0.00001)
		set(rud_3_spd, -0.00001)
	
	end
	
	
end
	
	set(absu_at_dif_left, spd_diff_ind_L)
	set(absu_at_dif_right, spd_diff_ind_R)

	set(absu_at_power_cc, bool2int(power and channel_off ~= 1) + bool2int(power and channel_off ~= -1)*get(absu_speed_prepare))
	
	
end

