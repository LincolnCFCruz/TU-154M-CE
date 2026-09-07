-- this is water panel on engineer's upper part

-- controls
defineProperty("wing_light", globalPropertyi("tu-154/switchers/eng/wing_light")) -- wing ground marker lights
--defineProperty("door_heat", globalPropertyi("tu-154/switchers/eng/door_heat")) -- door heating
defineProperty("gear_fan", globalPropertyi("tu-154/switchers/eng/gear_fan")) -- landing gear bay ventilation
defineProperty("galley_heat", globalPropertyi("tu-154/switchers/eng/galley_heat")) -- galley drain heating
defineProperty("lavatory_heat", globalPropertyi("tu-154/switchers/eng/lavatory_heat")) -- toilet drain heating
defineProperty("water_meter", globalPropertyi("tu-154/switchers/eng/water_meter")) -- water level in the tank
defineProperty("water_compressor_1", globalPropertyi("tu-154/switchers/eng/water_compressor_1")) -- galley drain heating
defineProperty("water_compressor_2", globalPropertyi("tu-154/switchers/eng/water_compressor_2")) -- galley drain heating
defineProperty("tail_temp_signal", globalPropertyi("tu-154/switchers/eng/tail_temp_signal")) -- tail compartment temperature signal
defineProperty("tail_temp_heat", globalPropertyi("tu-154/switchers/eng/tail_temp_heat")) -- ARD heating

defineProperty("tail_temp_signal_control_1", globalPropertyi("tu-154/buttons/eng/tail_temp_signal_control_1")) -- tail compartment temperature signal test
defineProperty("tail_temp_signal_control_2", globalPropertyi("tu-154/buttons/eng/tail_temp_signal_control_2")) -- tail compartment temperature signal test

defineProperty("lamp_test_eng_up_1", globalPropertyi("tu-154/buttons/lamp_test_eng_up_1"))
defineProperty("lamp_test_eng_up_2", globalPropertyi("tu-154/buttons/lamp_test_eng_up_2"))



defineProperty("water_pressure", globalPropertyf("tu-154/gauges/eng/water_pressure")) -- water pressure

-- lamps
defineProperty("water_level_1", globalPropertyf("tu-154/lights/water_level_1")) -- water level 1
defineProperty("water_level_12", globalPropertyf("tu-154/lights/water_level_12")) -- water level 1
defineProperty("water_level_14", globalPropertyf("tu-154/lights/water_level_14")) -- water level 1
defineProperty("water_level_0", globalPropertyf("tu-154/lights/water_level_0")) -- water level 1

defineProperty("tail_temp_high", globalPropertyf("tu-154/lights/small/tail_temp_high")) -- 
defineProperty("lavatory_heat_lamp", globalPropertyf("tu-154/lights/small/lavatory_heat")) -- 
defineProperty("galley_heat_lamp", globalPropertyf("tu-154/lights/small/galley_heat")) -- 

-- power
defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right"))

-- time
defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time")) -- flight time

-- gears
defineProperty("deploy_ratio_1", globalProperty("sim/flightmodel2/gear/deploy_ratio[0]")) -- 
defineProperty("deploy_ratio_2", globalProperty("sim/flightmodel2/gear/deploy_ratio[1]")) -- 
defineProperty("deploy_ratio_3", globalProperty("sim/flightmodel2/gear/deploy_ratio[2]")) -- 

defineProperty("groundspeed", globalPropertyf("sim/flightmodel/position/groundspeed")) -- GS, m/s

-- results
defineProperty("water_lvl", globalPropertyf("tu-154/misc/water_level")) -- water level


-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control



local switch_sound = loadSample('sounds/metal_switch.wav')
local cap_sound = loadSample('sounds/cap.wav')
local btn_click = loadSample('sounds/plastic_btn.wav')
local rot_click = loadSample('sounds/rot_click.wav')
local plastic_sound = loadSample('sounds/plastic_switch.wav')

local passed = get(frame_time)


local switchers_last = 0
local buttons_last = 0

local function controls()

	local switchers = get(wing_light) + get(gear_fan) + get(galley_heat) + get(lavatory_heat) + get(water_meter) + get(water_compressor_1)
	switchers = switchers + get(water_compressor_2) + get(tail_temp_signal) + get(tail_temp_heat)
	
	if switchers ~= switchers_last then playSample(switch_sound, false) end
	
	switchers_last = switchers
	
	local buttons = get(tail_temp_signal_control_1) + get(tail_temp_signal_control_2) + get(lamp_test_eng_up_1) + get(lamp_test_eng_up_2)

	if buttons ~= buttons_last then playSample(btn_click, false) end
	
	buttons_last = buttons



end


local water_level = math.random()

set(water_lvl, water_level)


local function lamps()

	local lamps_brt = math.max((math.max(get(bus27_volt_right), get(bus27_volt_left))  - 10) / 18.5, 0)
	local test_btn = get(lamp_test_eng_up_1) * math.max((get(bus27_volt_right)  - 10) / 18.5, 0)
	local test_btn_2 = get(lamp_test_eng_up_2) * math.max((get(bus27_volt_right)  - 10) / 18.5, 0)
	
	local MASTER = get(ismaster) ~= 1	
	
	water_level = get(water_lvl)
	
	-- fake water consumption in flight
	if get(deploy_ratio_1) < 0.1 and get(deploy_ratio_2) < 0.1 and get(deploy_ratio_3) < 0.1 then
		water_level = water_level - get(frame_time) * (get(water_compressor_1) + get(water_compressor_2)) / (8 * 3600)
	elseif get(groundspeed) < 0.1 then 
		water_level = water_level + get(frame_time) / (0.1 * 3600)
	
	end
	
	if water_level < 0 then water_level = 0 
	elseif water_level > 1 then water_level = 1
	end
	
	if MASTER then set(water_lvl, water_level) end
	
	
	local level_meter = get(water_meter) == 1

	local water_level_1_brt = math.max(bool2int(water_level >= 0.9 and level_meter) * lamps_brt, test_btn, test_btn_2) -- temp
	set(water_level_1, water_level_1_brt)
	
	local water_level_12_brt = math.max(bool2int(water_level < 0.9 and water_level >= 0.5 and level_meter) * lamps_brt, test_btn, test_btn_2) -- temp
	set(water_level_12, water_level_12_brt)
	
	local water_level_14_brt = math.max(bool2int(water_level < 0.5 and water_level >= 0.25 and level_meter) * lamps_brt, test_btn, test_btn_2) -- temp
	set(water_level_14, water_level_14_brt)
	
	local water_level_0_brt = math.max(bool2int(water_level < 0.25 and water_level >= 0 and level_meter) * lamps_brt, test_btn, test_btn_2) -- temp
	set(water_level_0, water_level_0_brt)
	
	local tail_temp_high_brt = math.max(bool2int(get(tail_temp_signal_control_1) + get(tail_temp_signal_control_2) > 0) * get(tail_temp_signal) * lamps_brt, test_btn) -- temp
	set(tail_temp_high, tail_temp_high_brt)
	
	local lavatory_heat_brt = math.max(bool2int(get(lavatory_heat) < 0) * lamps_brt, test_btn) -- temp get(lavatory_heat)
	set(lavatory_heat_lamp, lavatory_heat_brt)
	
	local galley_heat_brt = math.max(bool2int(get(galley_heat) < 0) * lamps_brt, test_btn) -- temp
	set(galley_heat_lamp, galley_heat_brt)
	
	
	
	
end

local press_act = 0

function update()

	-- [DT] refresh BEFORE the helpers, so they see this frame's delta.
	passed = get(frame_time)

	controls()
	lamps()
	
	local power = (get(bus27_volt_right) + get(bus27_volt_left)) / 2 > 13
	local press = 0
	if power then
		press = (get(water_compressor_1) + get(water_compressor_2)) * bool2int(water_level > 0.1) * 70
	end

	press_act = press_act + (press - press_act) * passed

	set(water_pressure, press_act)



end

