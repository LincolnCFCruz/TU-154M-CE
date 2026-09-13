-- this TAWS panel logic

-- panel controls
defineProperty("but_view", globalPropertyi("tu-154/buttons/srpbz/but_view")) -- VIEW button
defineProperty("but_empty", globalPropertyi("tu-154/buttons/srpbz/but_empty")) -- "-" button
defineProperty("but_down", globalPropertyi("tu-154/buttons/srpbz/but_down")) -- scale down button
defineProperty("but_up", globalPropertyi("tu-154/buttons/srpbz/but_up")) -- scale up
defineProperty("brightness", globalPropertyf("tu-154/rotary/srpbz/brightness")) -- brightness knob

-- overhead controls
defineProperty("egpws_alarm_1", globalPropertyi("tu-154/switchers/ovhd/egpws_alarm_1")) -- SRPBZ (GPWS) warning, general
defineProperty("egpws_alarm_2", globalPropertyi("tu-154/switchers/ovhd/egpws_alarm_2")) -- SRPBZ (GPWS) warning
defineProperty("egpws_alarm_1_cap", globalPropertyi("tu-154/switchers/ovhd/egpws_alarm_1_cap")) -- SRPBZ (GPWS) warning, general
defineProperty("egpws_alarm_2_cap", globalPropertyi("tu-154/switchers/ovhd/egpws_alarm_2_cap")) -- SRPBZ (GPWS) warning
defineProperty("egpws_relief", globalPropertyi("tu-154/switchers/ovhd/egpws_relief")) -- terrain
defineProperty("egpws_mode", globalPropertyi("tu-154/switchers/ovhd/egpws_mode")) -- QNH - QFE

defineProperty("egpws_control", globalPropertyi("tu-154/buttons/ovhd/egpws_control")) -- SRPBZ test button
defineProperty("egpws_contr_gs", globalPropertyi("tu-154/buttons/ovhd/egpws_contr_gs")) -- SRPBZ glideslope test


-- lamps
defineProperty("pull_up_lamp", globalPropertyf("tu-154/lights/pull_up")) -- pull up
defineProperty("check_alt_left_lamp", globalPropertyf("tu-154/lights/check_alt_left")) -- pull up
defineProperty("check_alt_right_lamp", globalPropertyf("tu-154/lights/check_alt_right")) -- pull up
defineProperty("warning_terrain_lamp", globalPropertyf("tu-154/lights/warning_terrain")) -- pull up
defineProperty("gs_low_lamp", globalPropertyf("tu-154/lights/gs_low")) -- pull up
defineProperty("srpbz_fail_lamp", globalPropertyf("tu-154/lights/srpbz_fail")) -- pull up

-- other sources
defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left")) -- 27 V bus voltage
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right")) -- 27 V bus voltage

defineProperty("test_lamps", globalPropertyi("tu-154/buttons/lamp_test_front")) -- APU panel lamp test button
defineProperty("day_night_set", globalPropertyf("tu-154/lights/day_night_set")) -- day/night switch. 0 = day, 1 = night. dims the annunciator lamps.

defineProperty("taws_message", globalPropertyi("tu-154/taws/taws_message"))
-- 0 - none, 1 - Pull UP, 2 - alt callout, 3 - Pull Up, 4 - Terrain, 5 - Terrain Ahead, 6 - Too low, Terrain, 
-- 7 - Alt collout, 8 - Too low, Gear, 9 - Too low, Flaps, 10 - Check altitude, 11 - Sink Rate, 12 - Don't sink, 13 - Glideslope

defineProperty("taws_alt_left", globalPropertyi("tu-154/taws/taws_alt_left")) -- compare the altitude on the left altimeter
defineProperty("taws_alt_right", globalPropertyi("tu-154/taws/taws_alt_right")) -- compare the altitude on the right altimeter

defineProperty("mode_set", globalPropertyi("tu-154/taws/mode_set")) -- screen operating mode. 0 - off, 1 - terrain map, 2 - side view, 3 - clock, 4 - power-up sequence, 5 - test, 6 - game, 10 - failure


-- time
defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))


-- sounds
local switcher_sound = loadSample('sounds/metal_switch.wav')
local button_sound = loadSample('sounds/plastic_btn.wav')
local cap_sound = loadSample('sounds/cap.wav')

local passed = get(frame_time)


-- sound the buttons
local but_view_last = get(but_view)
local but_empty_last = get(but_empty)
local but_down_last = get(but_down)
local but_up_last = get(but_up)
local egpws_control_last = get(egpws_control)
local egpws_contr_gs_last = get(egpws_contr_gs)



local function buttons_check()

	local but_view_sw = get(but_view)
	local but_empty_sw = get(but_empty)
	local but_down_sw = get(but_down)
	local but_up_sw = get(but_up)
	local egpws_control_sw = get(egpws_control)
	local egpws_contr_gs_sw = get(egpws_contr_gs)	

	local change = but_view_sw + but_empty_sw + but_down_sw + but_up_sw + egpws_control_sw + egpws_contr_gs_sw
	change = change - but_view_last - but_empty_last - but_down_last - but_up_last - egpws_control_last - egpws_contr_gs_last
	
	if change ~= 0 then
		playSample(button_sound, false)
	end
	

	but_view_last = but_view_sw
	but_empty_last = but_empty_sw
	but_down_last = but_down_sw
	but_up_last = but_up_sw
	egpws_control_last = egpws_control_sw
	egpws_contr_gs_last = egpws_contr_gs_sw
	

end


local egpws_alarm_1_last = get(egpws_alarm_1)
local egpws_alarm_2_last = get(egpws_alarm_2)
local egpws_relief_last = get(egpws_relief)
local egpws_mode_last = get(egpws_mode)

local egpws_alarm_1_cap_last = get(egpws_alarm_1_cap)
local egpws_alarm_2_cap_last = get(egpws_alarm_2_cap)



local function switchers_check()

	local egpws_alarm_1_sw = get(egpws_alarm_1)
	local egpws_alarm_2_sw = get(egpws_alarm_2)
	local egpws_relief_sw = get(egpws_relief)
	local egpws_mode_sw = get(egpws_mode)
	
	local changes = egpws_alarm_1_sw + egpws_alarm_2_sw + egpws_relief_sw + egpws_mode_sw
	changes = changes - egpws_alarm_1_last - egpws_alarm_2_last - egpws_relief_last - egpws_mode_last
	
	if changes ~= 0 then
		playSample(switcher_sound, false)
	end
	
	-- caps
	local egpws_alarm_1_cap_sw = get(egpws_alarm_1_cap)
	local egpws_alarm_2_cap_sw = get(egpws_alarm_2_cap)
	
	if egpws_alarm_1_cap_sw + egpws_alarm_2_cap_sw - egpws_alarm_1_cap_last - egpws_alarm_2_cap_last ~= 0 then
		playSample(cap_sound, false)
	end
	
	
	egpws_alarm_1_last = egpws_alarm_1_sw
	egpws_alarm_2_last = egpws_alarm_2_sw
	egpws_relief_last = egpws_relief_sw
	egpws_mode_last = egpws_mode_sw
	
	egpws_alarm_1_cap_last = egpws_alarm_1_cap_sw
	egpws_alarm_2_cap_last = egpws_alarm_2_cap_sw

end




local pull_up_lit = 0
local pull_up_counter = 0

local check_alt_left_lit = 0
local check_alt_left_counter = 0

local check_alt_right_lit = 0
local check_alt_right_counter = 0

local terrain_lit = 0
local terrain_counter = 0

local gs_lit = 0
local gs_counter = 0

local fail_lit = 0
local fail_counter = 0

local function lamps()

	local test_btn = get(test_lamps) * math.max((get(bus27_volt_right) - 10) / 18.5, 0)
	local day_night = 1 - get(day_night_set) * 0.25
	local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0) * day_night
	
	local taws_msg = get(taws_message)
	local alarm = get(egpws_alarm_1)
	
	
	-- pull up
	local pull_up = taws_msg == 1
	
	pull_up_counter = pull_up_counter + passed
	
	if pull_up and pull_up_counter > 0.5 then 
		pull_up_lit = 1 - pull_up_lit
		pull_up_counter = 0
	elseif not pull_up then pull_up_lit = 0 end
	
	local pull_up_lamp_brt = math.max(pull_up_lit * lamps_brt * alarm, test_btn)
	set(pull_up_lamp, pull_up_lamp_brt)
	
	
	-- check alt left
	local check_alt_left = get(taws_alt_left) == 1
	
	check_alt_left_counter = check_alt_left_counter + passed
	
	if check_alt_left and check_alt_left_counter > 0.5 then 
		check_alt_left_lit = 1 - check_alt_left_lit
		check_alt_left_counter = 0
	elseif not check_alt_left then check_alt_left_lit = 0 end
	
	local check_alt_left_lamp_brt = math.max(check_alt_left_lit * lamps_brt * alarm, test_btn)
	set(check_alt_left_lamp, check_alt_left_lamp_brt)
	
	
	
	
	-- check alt right
	local check_alt_right = get(taws_alt_right) == 1
	
	check_alt_right_counter = check_alt_right_counter + passed
	
	if check_alt_right and check_alt_right_counter > 0.5 then 
		check_alt_right_lit = 1 - check_alt_right_lit
		check_alt_right_counter = 0
	elseif not check_alt_right then check_alt_right_lit = 0 end
	
	local check_alt_right_lamp_brt = math.max(check_alt_right_lit * lamps_brt * alarm, test_btn)
	set(check_alt_right_lamp, check_alt_right_lamp_brt)
	
	
	-- terrain
	local terrain = taws_msg == 4 or taws_msg == 5 or taws_msg == 6
	
	terrain_counter = terrain_counter + passed
	
	if terrain and terrain_counter > 0.5 then 
		terrain_lit = 1 - terrain_lit
		terrain_counter = 0
	elseif not terrain then terrain_lit = 0 end
	
	local warning_terrain_lamp_brt = math.max(terrain_lit * lamps_brt * alarm, test_btn)
	set(warning_terrain_lamp, warning_terrain_lamp_brt)
	
	
	-- glideslope
	local gs = taws_msg == 13
	
	gs_counter = gs_counter + passed
	
	if gs and gs_counter > 0.5 then 
		gs_lit = 1 - gs_lit
		gs_counter = 0
	elseif not gs then gs_lit = 0 end
	
	local gs_low_lamp_brt = math.max(gs_lit * lamps_brt * alarm, test_btn)
	set(gs_low_lamp, gs_low_lamp_brt)
	
	
	
	-- failure
	local fail = get(mode_set) == 5 or get(mode_set) == 10 -- test or fail
	
	fail_counter = fail_counter + passed
	
	if fail and fail_counter > 0.5 then 
		fail_lit = 1 - fail_lit
		fail_counter = 0
	elseif not fail then fail_lit = 0 end
	
	local srpbz_fail_lamp_brt = math.max(fail_lit * lamps_brt, test_btn) -- fake
	set(srpbz_fail_lamp, srpbz_fail_lamp_brt)
	
	

end






function update()
	
	passed = get(frame_time)
	
	buttons_check()
	switchers_check()
	
	lamps()
	
	if get(brightness) < 0.1 then set(brightness, 0.1) end

end