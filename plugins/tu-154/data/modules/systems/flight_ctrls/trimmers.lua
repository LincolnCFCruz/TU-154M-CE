-- defineProperty("absu_debug1", globalPropertyf("tu-154/controlls/absu_debug1")) 
-- defineProperty("absu_debug2", globalPropertyf("tu-154/controlls/absu_debug2")) 


-- controls
defineProperty("elev_trimm_sw", globalPropertyi("tu-154/controll/elev_trimm_switcher")) -- elevator trim control. -1 = nose down, 0 = neutral, +1 = nose up
defineProperty("ail_trimm_sw", globalPropertyi("tu-154/controll/ail_trimm_sw")) -- aileron trim switch
defineProperty("rudd_trimm_sw", globalPropertyi("tu-154/controll/rudd_trimm_sw")) -- rudder trim switch

defineProperty("external_view", globalPropertyi("sim/graphics/view/view_is_external")) -- enviroment
defineProperty("warning_volume_ratio", globalPropertyf("sim/operation/sound/warning_volume_ratio"))

defineProperty("emerg_elev_trimm", globalPropertyi("tu-154/switchers/console/emerg_elev_trimm")) -- emergency trim control


defineProperty("absu_pitch_trimm", globalPropertyi("tu-154/absu/absu_pitch_trimm")) -- trim command from the ABSU. +1 = up, -1 = down
defineProperty("pilot_Z", globalPropertyf("sim/aircraft/view/acf_peZ")) -- Position of pilot's head relative to CG


-- results
defineProperty("int_pitch_trim", globalPropertyf("tu-154/trimmers/int_pitch_trim")) -- elevator trim position
defineProperty("int_roll_trim", globalPropertyf("tu-154/trimmers/int_roll_trim")) -- aileron trim position
defineProperty("int_yaw_trim", globalPropertyf("tu-154/trimmers/int_yaw_trim")) -- rudder trim position


defineProperty("absu_roll_mode", globalPropertyi("tu-154/gauges/console/absu_roll_mode")) -- ABSU operating mode. 0 = off, 1 = control-wheel steering, 2 = stabilisation
defineProperty("absu_pitch_mode", globalPropertyi("tu-154/gauges/console/absu_pitch_mode")) -- ABSU operating mode. 0 = off, 1 = control-wheel steering, 2 = stabilisation




-- power
defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left")) -- 27 V bus voltage
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right")) -- 27 V bus voltage

defineProperty("bus115_1_volt", globalPropertyf("tu-154/elec/bus115_1_volt")) -- 115 V bus voltage
defineProperty("bus115_3_volt", globalPropertyf("tu-154/elec/bus115_3_volt")) -- 115 V bus voltage

defineProperty("bus36_volt_left", globalPropertyf("tu-154/elec/bus36_volt_left")) -- 36 V left bus voltage
defineProperty("bus36_volt_right", globalPropertyf("tu-154/elec/bus36_volt_right")) -- 36 V right bus voltage
defineProperty("bus36_volt_pts250_1", globalPropertyf("tu-154/elec/bus36_volt_pts250_1")) -- 36 V bus voltage, PTS 1
defineProperty("bus36_volt_pts250_2", globalPropertyf("tu-154/elec/bus36_volt_pts250_2")) -- 36 V bus voltage, PTS 2

defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time")) -- time of frame

defineProperty("ctr_27_L_cc", globalPropertyf("tu-154/control/ctr_27_L_cc")) -- bus load
defineProperty("ctr_27_R_cc", globalPropertyf("tu-154/control/ctr_27_R_cc")) -- bus load

defineProperty("ctr_36L_cc", globalPropertyf("tu-154/control/ctr_36L_cc")) -- bus load
defineProperty("ctr_36R_cc", globalPropertyf("tu-154/control/ctr_36R_cc")) -- bus load

-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control

-- failures
defineProperty("rel_trim_rud", globalPropertyi("sim/operation/failures/rel_trim_rud"))
defineProperty("rel_trim_ail", globalPropertyi("sim/operation/failures/rel_trim_ail"))
defineProperty("rel_trim_elv", globalPropertyi("sim/operation/failures/rel_trim_elv"))
defineProperty("trim_emerg_elv_fail", globalPropertyi("tu-154/failures/trim_emerg_elv_fail"))

-- other
defineProperty("elev_trimm_1_pk", globalPropertyi("tu-154/b2/elev_trimm_1_pk"))
defineProperty("elev_trimm_2_pk", globalPropertyi("tu-154/b2/elev_trimm_2_pk"))


defineProperty("pedal_left_sw", globalPropertyi("tu-154/other/pedal_left_sw"))
defineProperty("pedal_right_sw", globalPropertyi("tu-154/other/pedal_right_sw"))
defineProperty("pedal_left_pos", globalPropertyf("tu-154/other/pedal_left_pos"))
defineProperty("pedal_right_pos", globalPropertyf("tu-154/other/pedal_right_pos"))


-- sound
local trimm_up = loadSample('sounds/trimm_up.wav')
local trimm_down = loadSample('sounds/trimm_down.wav')
local trimm_ctr = loadSample('sounds/trimm_ctr.wav')
local trimm_sound = loadSample('sounds/new_snds/trimm.wav') --
local trimm_el = loadSample('sounds/new_snds/trimm_EL.wav') --
local trimm_rn = loadSample('sounds/new_snds/trimm_RN.wav') --

local pitch_trim_power = true
local roll_trim_power = true
local yaw_trim_power = true


local trimm_pitch_last = 0
local trimm_roll_last = 0
local trimm_yaw_last = 0


function update()
	local MASTER = get(ismaster) ~= 1

	-- the camera moves at runtime, so this has to be read every frame (it used
	-- to be sampled once at module scope, which pinned it to the cockpit view)
	local external = get(external_view)
	
	-- initial
	local passed = get(frame_time)
	local power_27_L = bool2int(get(bus27_volt_left) > 13)
	local power_27_R = bool2int(get(bus27_volt_right) > 13)
	local power36_L = bool2int(get(bus36_volt_left) > 30)
	local power36_R = bool2int(get(bus36_volt_right) > 30)
	
	local CC_27L = get(ctr_27_L_cc)
	local CC_27R = get(ctr_27_R_cc)
	
	local elev_tr_sw = get(elev_trimm_sw)
	local emer_tr_sw = get(emerg_elev_trimm)
	local absu_tr_pt = get(absu_pitch_trimm)
	
	if get(absu_pitch_mode) == 2 then
		elev_tr_sw = 0
		emer_tr_sw = 0
	end
	
	-- pitch trimmer --
	local pitch_trim_eng = 2 -- working engines for trim. can add failures here
	local pitch_trim_pos = get(int_pitch_trim)
	local pitch_trimm_work = bool2int(get(rel_trim_elv) ~= 6 and get(elev_trimm_1_pk)+get(elev_trimm_2_pk) < 2)
	-- (this used to be an `if pitch_trim_pos >= 0 then ... else ... end` whose
	--  two branches were identical; collapsed, the rates are unchanged)
	pitch_trim_pos = pitch_trim_pos + elev_tr_sw * passed * power_27_L * power_27_R * (power36_L + power36_R) * pitch_trim_eng * 0.011 * pitch_trimm_work
	pitch_trim_pos = pitch_trim_pos + absu_tr_pt * passed * power_27_L * power_27_R * (power36_L + power36_R) * pitch_trim_eng * 0.005 * pitch_trimm_work
	pitch_trim_pos = pitch_trim_pos + emer_tr_sw * passed * power_27_L * power36_L * 0.03 * (1 - get(trim_emerg_elv_fail))
	
	if pitch_trim_pos > 0.517 then pitch_trim_pos = 0.517
	elseif pitch_trim_pos < -0.344 then pitch_trim_pos = -0.344 end

if MASTER then	
	set(int_pitch_trim, pitch_trim_pos)
end

	if pitch_trim_pos ~= trimm_pitch_last then
		set(ctr_36L_cc, power36_L)
		set(ctr_36R_cc, power36_R)
	else
		set(ctr_36L_cc, 0)
		set(ctr_36R_cc, 0)
	end
	
	trimm_pitch_last = pitch_trim_pos
	
	
	-- roll trimmer --
	local roll_trim_pos = get(int_roll_trim) + get(ail_trimm_sw) * passed * power_27_L * 0.02 * bool2int(get(rel_trim_ail) ~= 6)

	if roll_trim_pos > 0.24 then roll_trim_pos = 0.24
	elseif roll_trim_pos < -0.24 then roll_trim_pos = -0.24 end
    
    
    
    
	local dist = -get(pilot_Z) + 9 
    
	setSampleGain(trimm_sound, 5*math.max(dist*3 - 25, 0))
    setSamplePosition(trimm_sound, 0.00515, -2.3967, -21.3144)
    setSampleMaxDistance(trimm_sound, 0.001)
    
	setSampleGain(trimm_el, 10*math.max(dist*3 - 25, 0))
    setSamplePosition(trimm_el, 0.00515, -2.3967, -21.3144)
    setSampleMaxDistance(trimm_el, 0.001)
	
	setSampleGain(trimm_rn, 10*math.max(dist*3 - 25, 0))
    setSamplePosition(trimm_rn, 0.00515, -2.3967, -21.3144)
    setSampleMaxDistance(trimm_rn, 0.001)
    
if MASTER then	
	set(int_roll_trim, roll_trim_pos)
end

	if roll_trim_pos ~= trimm_roll_last then
		set(ctr_27_L_cc, CC_27L + 3)
	end
	
	
	trimm_roll_last = roll_trim_pos
	
	
	-- yaw trimmer --
	local yaw_trim_pos = get(int_yaw_trim) + get(rudd_trimm_sw) * passed * power_27_R * 0.02 * bool2int(get(rel_trim_rud) ~= 6)
	
	if yaw_trim_pos > 0.2 then yaw_trim_pos = 0.2
	elseif yaw_trim_pos < -0.2 then yaw_trim_pos = -0.2 end
    
    
	-- `and` binds tighter than `or`, so the external-view guard has to wrap the
	-- whole pedal test -- without the outer parens it only gated the right pedal.
	if external == 0 and ((get(pedal_right_sw) ~= 0 and get(bus36_volt_right) > 5 and get(pedal_right_pos) < 1 and get(pedal_right_pos) > 0) or (get(pedal_left_sw) ~= 0 and get(bus36_volt_left) > 15 and get(pedal_left_pos) < 1 and get(pedal_left_pos) > 0)) then
		if not isSamplePlaying(trimm_sound) then playSample(trimm_sound, false) end
	else
		stopSample(trimm_sound) 
	end
    
	if external == 0 and get(ail_trimm_sw) ~= 0 and get(bus27_volt_left) > 13 and roll_trim_pos > -0.24 and roll_trim_pos < 0.24 then
		if not isSamplePlaying(trimm_el) then 
			playSample(trimm_el, false) 
		end
	else
		stopSample(trimm_el) 
	end
	if external == 0 and get(rudd_trimm_sw) ~= 0 and get(bus27_volt_right) > 13 and yaw_trim_pos > -0.2 and yaw_trim_pos < 0.2 then
		if not isSamplePlaying(trimm_rn) then 
			playSample(trimm_rn, false) 
		end
	else
		stopSample(trimm_rn)
	end
    
    

if MASTER then	
	set(int_yaw_trim, yaw_trim_pos)
end
	
	if yaw_trim_pos ~= trimm_yaw_last then
		set(ctr_27_R_cc, CC_27R + 3)
	end
	
	trimm_yaw_last = yaw_trim_pos


end



-- turn pitch trimmer UP
pitch_UP_comm = findCommand("sim/flight_controls/pitch_trim_up")
function pitch_UP_hnd(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if (1 == phase or 0 == phase) then
		set(elev_trimm_sw, 1)
		if 0 == phase then playSample(trimm_up, false) end
	else
		set(elev_trimm_sw, 0)
		playSample(trimm_ctr, false)
    end
return 0
end
registerCommandHandler(pitch_UP_comm, 0, pitch_UP_hnd)

-- turn pitch trimmer DOWN
pitch_DOWN_comm = findCommand("sim/flight_controls/pitch_trim_down")
function pitch_DOWN_hnd(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if (1 == phase or 0 == phase) then
		set(elev_trimm_sw, -1)
		if 0 == phase then playSample(trimm_down, false) end
	else
		set(elev_trimm_sw, 0)
		playSample(trimm_ctr, false)
    end
return 0
end
registerCommandHandler(pitch_DOWN_comm, 0, pitch_DOWN_hnd)

-- turn pitch trimmer CENTER
pitch_TO_comm = findCommand("sim/flight_controls/pitch_trim_takeoff")
function pitch_TO_hnd(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if (1 == phase or 0 == phase) then
		if pitch_trim_power then set(int_pitch_trim, 0)  end
    end
return 0
end
registerCommandHandler(pitch_TO_comm, 0, pitch_TO_hnd)




-- turn roll trimmer LEFT
roll_LEFT_comm = findCommand("sim/flight_controls/aileron_trim_left")
function roll_LEFT_hnd(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if (1 == phase or 0 == phase) then
		set(ail_trimm_sw, -1)
	else
		set(ail_trimm_sw, 0)
    end
return 0
end
registerCommandHandler(roll_LEFT_comm, 0, roll_LEFT_hnd)

-- turn roll trimmer RIGHT
roll_RIGHT_comm = findCommand("sim/flight_controls/aileron_trim_right")
function roll_RIGHT_hnd(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if (1 == phase or 0 == phase) then
		set(ail_trimm_sw, 1)
	else
		set(ail_trimm_sw, 0)
    end
return 0
end
registerCommandHandler(roll_RIGHT_comm, 0, roll_RIGHT_hnd)

-- turn roll trimmer CTR
roll_CTR_comm = findCommand("sim/flight_controls/aileron_trim_center")
function roll_CTR_hnd(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if (1 == phase or 0 == phase) then
		if roll_trim_power then set(int_roll_trim, 0) end
    end
return 0
end
registerCommandHandler(roll_CTR_comm, 0, roll_CTR_hnd)




-- turn yaw trimmer LEFT
yaw_LEFT_comm = findCommand("sim/flight_controls/rudder_trim_left")
function yaw_LEFT_hnd(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if (1 == phase or 0 == phase) then
		set(rudd_trimm_sw, -1)
	else
		set(rudd_trimm_sw, 0)
    end
return 0
end
registerCommandHandler(yaw_LEFT_comm, 0, yaw_LEFT_hnd)

-- turn yaw trimmer RIGHT
yaw_RIGHT_comm = findCommand("sim/flight_controls/rudder_trim_right")
function yaw_RIGHT_hnd(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if (1 == phase or 0 == phase) then
		set(rudd_trimm_sw, 1)
	else
		set(rudd_trimm_sw, 0)
    end
return 0
end
registerCommandHandler(yaw_RIGHT_comm, 0, yaw_RIGHT_hnd)

-- turn yaw trimmer CTR
yaw_CTR_comm = findCommand("sim/flight_controls/rudder_trim_center")
function yaw_CTR_hnd(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if (1 == phase or 0 == phase) then
		if yaw_trim_power then set(int_yaw_trim, 0) end
    end
return 0
end
registerCommandHandler(yaw_CTR_comm, 0, yaw_CTR_hnd)