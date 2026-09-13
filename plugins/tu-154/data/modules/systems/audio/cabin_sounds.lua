defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))

defineProperty("external_view", globalPropertyi("sim/graphics/view/view_is_external")) -- enviroment


-- logic sources

-- RV
defineProperty("dh_set_L", globalPropertyf("tu-154/gauges/alt/radioalt_dh_left"))  -- DH angle
defineProperty("dh_set_R", globalPropertyf("tu-154/gauges/alt/radioalt_dh_right"))  -- DH angle
defineProperty("rv_angle_L", globalPropertyf("tu-154/gauges/alt/radioalt_needle_left"))  -- RV needle
defineProperty("rv_angle_R", globalPropertyf("tu-154/gauges/alt/radioalt_needle_right"))  -- RV needle

defineProperty("rv5_dh_signal_left", globalPropertyi("tu-154/misc/rv5_dh_signal_left"))
defineProperty("rv5_dh_signal_right", globalPropertyi("tu-154/misc/rv5_dh_signal_right"))


-- ABSU
defineProperty("roll_main_mode", globalPropertyi("tu-154/absu/roll_main_mode")) -- ABSU main roll mode. 0 = off, 1 = control-wheel steering, 2 = stabilisation
defineProperty("pitch_main_mode", globalPropertyi("tu-154/absu/pitch_main_mode")) -- ABSU main pitch mode. 0 = off, 1 = control-wheel steering, 2 = stabilisation

defineProperty("stu_mode", globalPropertyi("tu-154/absu/stu_mode")) -- autothrottle modes 0 - off, 1 - on, 2 - ready, 3 stab,

defineProperty("absu_fail_signal", globalPropertyi("tu-154/absu/absu_fail_signal")) -- signal to the siren

-- alarm overall
defineProperty("main_gear_flaps", globalPropertyi("tu-154/alarm/main_gear_flaps")) -- flaps not in the takeoff position or gear not extended
defineProperty("main_pressure", globalPropertyi("tu-154/alarm/main_pressure")) -- cabin depressurisation or overpressure
defineProperty("speaker_auasp", globalPropertyi("tu-154/alarm/speaker_auasp")) -- limit angle of attack or g
defineProperty("speaker_fuel", globalPropertyi("tu-154/alarm/speaker_fuel")) -- 2500 of fuel remaining in tank 1
defineProperty("speaker_speed", globalPropertyi("tu-154/alarm/speaker_speed")) -- limit speed
defineProperty("speaker_absu", globalPropertyi("tu-154/alarm/speaker_absu")) -- mode disengagement or ABSU failures

defineProperty("fire_siren", globalPropertyi("tu-154/fire/fire_siren")) -- siren running

-- controls
defineProperty("srd_buzzer", globalPropertyi("tu-154/switchers/eng/srd_buzzer")) -- SRD siren
defineProperty("fuel_buzzer", globalPropertyi("tu-154/switchers/eng/fuel_buzzer")) -- fuel siren

defineProperty("srd_buzzer_cap", globalPropertyi("tu-154/switchers/eng/srd_buzzer_cap")) -- SRD siren
defineProperty("fuel_buzzer_cap", globalPropertyi("tu-154/switchers/eng/fuel_buzzer_cap")) -- SRD siren

defineProperty("srd_buzzer_test", globalPropertyi("tu-154/buttons/eng/srd_buzzer_test")) -- test button


-- MRP
defineProperty("outer_marker", globalPropertyi("sim/cockpit/misc/outer_marker_lit"))   -- runway markers
defineProperty("middle_marker", globalPropertyi("sim/cockpit/misc/middle_marker_lit"))
defineProperty("inner_marker", globalPropertyi("sim/cockpit/misc/inner_marker_lit"))

-- lights
defineProperty("light_open_left", globalPropertyf("tu-154/anim/light_open_left")) -- light open
defineProperty("light_open_right", globalPropertyf("tu-154/anim/light_open_right")) -- light open

defineProperty("airspeed", globalPropertyf("sim/flightmodel/position/indicated_airspeed")) -- indicated airspeed in KTS

-- power
defineProperty("bus27_volt_L", globalPropertyf("tu-154/elec/bus27_volt_left"))
defineProperty("bus27_volt_R", globalPropertyf("tu-154/elec/bus27_volt_right"))

defineProperty("bus27_source_left", globalPropertyf("tu-154/elec/bus27_source_left")) -- bus source. 0 - nothing. 1 - VU1, 2 - VU standby, 3 - batteries 1 and 3, 6 - the other bus
defineProperty("bus27_source_right", globalPropertyf("tu-154/elec/bus27_source_right")) -- bus source. 0 - nothing. 1 - VU2, 2 - VU standby, 3 - batteries 2 and 4, 6 - the other bus

defineProperty("pilot_Z", globalPropertyf("sim/aircraft/view/acf_peZ")) -- Position of pilot's head relative to CG

-- air kond
defineProperty("air_usage_L", globalPropertyf("tu-154/bleed/air_usage_L")) -- left air flow
defineProperty("air_usage_R", globalPropertyf("tu-154/bleed/air_usage_R")) -- right air flow

-- gears
defineProperty("deflection_mtr_2", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]"))
defineProperty("deflection_mtr_3", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]"))
defineProperty("groundspeed", globalPropertyf("sim/flightmodel/position/groundspeed")) -- GS, m/s

-- flaps
defineProperty("flaps_lever", globalPropertyf("tu-154/controll/flaps_lever")) -- sim flaps ratio control. use for axis and commands


-- loudness
defineProperty("engine_volume_ratio", globalPropertyf("sim/operation/sound/engine_volume_ratio"))
defineProperty("prop_volume_ratio", globalPropertyf("sim/operation/sound/prop_volume_ratio"))
defineProperty("ground_volume_ratio", globalPropertyf("sim/operation/sound/ground_volume_ratio"))
defineProperty("weather_volume_ratio", globalPropertyf("sim/operation/sound/weather_volume_ratio"))
defineProperty("warning_volume_ratio", globalPropertyf("sim/operation/sound/warning_volume_ratio"))
defineProperty("radio_volume_ratio", globalPropertyf("sim/operation/sound/radio_volume_ratio"))
defineProperty("fan_volume_ratio", globalPropertyf("sim/operation/sound/fan_volume_ratio"))


-- failures
defineProperty("main_alarm_fail", globalPropertyi("tu-154/failures/main_alarm_fail")) -- siren failure
defineProperty("speaker_alarm_fail", globalPropertyi("tu-154/failures/speaker_alarm_fail")) -- siren failure

defineProperty("failures_enabled", globalPropertyi("tu-154/failures/failures_enabled"))

-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control






-- sound sources
local absu_sound = loadSample('sounds/short_speaker.wav') --
local long_speaker = loadSample('sounds/long_speaker.wav')
local inverters = loadSample('sounds/inverters.wav') --
local long_sirena = loadSample('sounds/long_siren.wav')
local short_sirena = loadSample('sounds/short_siren.wav')
local bell = loadSample('sounds/mrp_bell.wav') --
local rv5_tone = loadSample('sounds/rv5_tone.wav') --
local lights_noise = loadSample('sounds/lights_noise.wav') --
local air_cond_noise = loadSample('sounds/air_noise.wav') --
local taxi_noise = loadSample('sounds/roll_inn.wav') --

local flaps_sound = loadSample('sounds/flaps_hnd.wav') --




local RV_counter = 0
local RV_played = true

local absu_last = get(roll_main_mode) + get(pitch_main_mode)
local stu_last = get(stu_mode)

local invert_counter = 0
playSample(inverters, true)
setSampleGain(inverters, 0)

local short_siren_timer = 0
local short_speaker_timer = 0
local long_speaker_timer = 0

playSample(air_cond_noise, true)
setSampleGain(air_cond_noise, 0)


local switcher_sound = loadSample('sounds/metal_switch.wav')
local button_sound = loadSample('sounds/plastic_btn.wav')
local cap_sound = loadSample('sounds/cap.wav')


local switchers_last = 0
local caps_last = 0
local buttons_last = 0

local fail_counter = 0
local check_time = math.random(15, 30)

function update()

	local passed = get(frame_time)
	
	local run = bool2int(passed ~= 0)
	
	local external = get(external_view)
	
	local power = get(bus27_volt_L) > 13 or get(bus27_volt_R) > 13
	
	local warn_vl = get(warning_volume_ratio)
	
	
	-----------------------------
	-- misc controls --
	-----------------------------
	
	local switchers = get(srd_buzzer) + get(fuel_buzzer)
	
	if switchers ~= switchers_last then playSample(switcher_sound, false) end
	
	switchers_last = switchers
	
	
	local caps = get(srd_buzzer_cap) + get(fuel_buzzer_cap)
	
	if caps ~= caps_last then playSample(cap_sound, false) end
	
	caps_last = caps
	
	
	local buttons = get(srd_buzzer_test)
	
	if buttons ~= buttons_last then playSample(button_sound, false) end
	
	buttons_last = buttons	
	
	
	
	
	
	
	
	
	
	
	
	
	----------------------
	-- RadioAltimeter --
	----------------------
	
	-- `and` binds tighter than `or`, so `power` only gated the right channel
	local RV_must_play = (get(rv5_dh_signal_left) == 1 or get(rv5_dh_signal_right) == 1) and power
	
	if RV_must_play and not RV_played and external == 0 then 
		RV_counter = 7 -- seconds to play tone
		RV_played = true
	end
	
	if not RV_must_play then 
		RV_played = false 
		RV_counter = 0
	end
	
	RV_counter = RV_counter - passed
	if not isSamplePlaying(rv5_tone) and RV_counter > 0 then playSample(rv5_tone, true) end
	if RV_counter <= 0 then stopSample(rv5_tone) end
	
	setSampleGain(rv5_tone, 1000 * warn_vl)
	
	-------------------
	-- main alarm --
	-------------------
	
	if (get(main_gear_flaps) == 1 or get(fire_siren) == 1) and power and get(srd_buzzer) == 1 and external == 0 and get(main_alarm_fail) == 0 then -- continous buzz
		if not isSamplePlaying(long_sirena) then playSample(long_sirena, true) end
		--stopSample(short_sirena)
	elseif get(srd_buzzer) == 1 and get(main_pressure) == 1 and power and external == 0 and get(main_alarm_fail) == 0 then
		short_siren_timer = short_siren_timer + passed
		
		if not isSamplePlaying(long_sirena) and short_siren_timer > 0.2 then playSample(long_sirena, true) end
		
		if short_siren_timer > 0.4 then 
			short_siren_timer = 0 
			stopSample(long_sirena)
		end
		
		--stopSample(long_sirena)
	else
		stopSample(long_sirena)
		--stopSample(short_sirena)
	end

	if passed == 0 or external == 1 then
		stopSample(long_sirena)		
	end
	
	if short_siren_timer > 0.4 then short_siren_timer = 0 end
	
	
	setSampleGain(long_sirena, 1000 * warn_vl)
	
	------------------
	-- speaker alarm --
	------------------
	
	local absu_now = get(roll_main_mode) + get(pitch_main_mode)
	local stu_now = get(stu_mode)
	
	if power and external == 0 and get(fuel_buzzer) == 1 and get(speaker_alarm_fail) == 0 and get(absu_fail_signal) == 1 then -- ABSU fails
		if not isSamplePlaying(absu_sound) then playSample(absu_sound, false) end
		stopSample(long_speaker)
	elseif get(speaker_auasp) == 1 and power and external == 0 and get(fuel_buzzer) == 1 and get(speaker_alarm_fail) == 0 then -- long buzzer
		if not isSamplePlaying(long_speaker) then playSample(long_speaker, true) end
		stopSample(absu_sound)
		
	elseif (get(speaker_fuel) == 1 or get(speaker_speed) == 1) and power and external == 0 and get(fuel_buzzer) == 1 and get(speaker_alarm_fail) == 0  then
		
		short_speaker_timer = short_speaker_timer + passed
		
		if not isSamplePlaying(long_speaker) and short_speaker_timer > 0.3 then playSample(long_speaker, true) end
		
		if short_speaker_timer > 0.6 then 
			short_speaker_timer = 0 
			stopSample(long_speaker)
		end
		stopSample(absu_sound)
		
	elseif ((absu_now ~= absu_last and absu_now < 4) or (stu_last >= 3 and stu_now <= 2)) and power and external == 0 and get(fuel_buzzer) == 1 and get(speaker_alarm_fail) == 0 then -- ABSU signals
		playSample(absu_sound, false) 
		stopSample(long_speaker)
	else
		stopSample(long_speaker)
		--stopSample(absu_sound)
	end
	
	absu_last = absu_now
	stu_last = stu_now
	
	setSampleGain(long_speaker, 1000 * warn_vl)
	

	----------------------
	-- markers sound --
	----------------------
	
	local inner = get(inner_marker) == 1
	local middle = get(middle_marker) == 1
	local outer = get(outer_marker) == 1
	
	local mrp_power = power -- need to extend this logic for MRP
	
	if (inner or middle or outer) and mrp_power and external == 0 then 
		if not isSamplePlaying(bell) then playSample(bell, false) end
	else 
		--stopSample(bell) 
	end

	setSampleGain(bell, 1000 * warn_vl)
	
	------------------
	-- power noise --
	-----------------
	local fan_vl = get(fan_volume_ratio)
	
	
	local vu_L = get(bus27_source_left)
	local vu_R = get(bus27_source_right)
	
	if power then invert_counter = invert_counter + passed
	else invert_counter = invert_counter - passed * 0.3 end
	
	if invert_counter > 1 then invert_counter = 1
	elseif invert_counter < 0 then invert_counter = 0 end
	
	local dist = -get(pilot_Z) + 9 
	
	setSampleGain(inverters, fan_vl * invert_counter * 200 * (bool2int(vu_L == 1 or vu_L == 2) + bool2int(vu_R == 1 or vu_R == 2)) * (1 - external) * math.max(dist - 25, 0) * 0.2 * run)
	setSamplePitch(inverters, invert_counter * 800 + 200)
	
	if passed == 0 or external == 1 then
		setSampleGain(inverters, 0)
	end	
	
	-----------------------
	-- air cond noise --
	-----------------------
	local air_usage = get(air_usage_L) + get(air_usage_R)
	setSampleGain(air_cond_noise, fan_vl * math.min(600, air_usage) * 1 * (1 - external) * run)
	setSamplePitch(air_cond_noise, 1000)

	
	-----------------------
	-- taxi noise --
	-----------------------
	local taxi_gain = bool2int(math.max(get(deflection_mtr_2), get(deflection_mtr_3)) > 0.001) * math.max(get(groundspeed) - 50, 0) * (1 - external) 
	local taxi_pitch = 1000 + (get(groundspeed) - 80) * 3
	
	-- 80 m/s
	
	if taxi_gain > 0 then
		if not isSamplePlaying(taxi_noise) then playSample(taxi_noise, true) end
	else
		stopSample(taxi_noise)
	end
	
	setSampleGain(taxi_noise, taxi_gain * 10 * get(ground_volume_ratio))
	setSamplePitch(taxi_noise, taxi_pitch)
	
	
	
	
	--------------------
	-- lights noise --
	--------------------
	
	local light_L = get(light_open_left)
	local light_R = get(light_open_right)
	local IAS = get(airspeed)
	
	if light_L + light_R > 0.1 then
		if not isSamplePlaying(lights_noise) then playSample(lights_noise, true) end
		
		local gain =  math.max(IAS - 150, 0) * (light_L + light_R) * (1 - external) * 1 * get(weather_volume_ratio)
		
		setSampleGain(lights_noise, gain)
		
		setSamplePitch(lights_noise, 250 + IAS * 1)
		
	else
		stopSample(lights_noise)
		
	end

	
local MASTER = get(ismaster) ~= 1	
	

if MASTER then	
	
	local FAIL = get(failures_enabled)
	FAIL = FAIL * 0.05 * 4 ^ (FAIL * 0.5)
	if FAIL > 0 then
		
		fail_counter = fail_counter + passed
		
		if fail_counter > check_time then
			fail_counter = 0
			check_time = math.random(15, 30)
			
			-- random failures
			if get(main_alarm_fail) ~= 1 then set(main_alarm_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(speaker_alarm_fail) ~= 1 then set(speaker_alarm_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
		
		end
		
		-- dependent failures

	else
		-- no failures enabled
		fail_counter = 0
		
		set(main_alarm_fail, 0)
		set(speaker_alarm_fail, 0)
	
	end

end	
	
	

end