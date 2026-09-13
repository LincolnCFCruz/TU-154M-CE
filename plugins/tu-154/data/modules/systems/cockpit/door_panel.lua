
-- controlls
defineProperty("test_lamps", globalPropertyi("tu-154/buttons/lamp_test_doors")) -- engine panel lamp test button
defineProperty("day_night_set", globalPropertyf("tu-154/lights/day_night_set")) -- day/night switch. 0 = day, 1 = night. dims the annunciator lamps.

-- other sources
defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left")) -- 27 V bus voltage
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right")) -- 27 V bus voltage

defineProperty("nosewheel_turn_enable", globalPropertyi("tu-154/switchers/nosewheel_turn_enable")) -- nosewheel steering switch on the control wheel
defineProperty("nosewheel_turn_sel", globalPropertyi("tu-154/switchers/nosewheel_turn_sel")) -- nosewheel steering angle selector. 0 = 10, 1 = 63

-- lamps
defineProperty("other_hatches", globalPropertyf("tu-154/lights/other_hatches")) -- lamp for the unused hatches
defineProperty("left_front_pax_door", globalPropertyf("tu-154/lights/left_front_pax_door")) -- left front door open
defineProperty("left_mid_pax_door", globalPropertyf("tu-154/lights/left_mid_pax_door")) -- left middle door open
defineProperty("right_mid_pax_door", globalPropertyf("tu-154/lights/right_mid_pax_door")) -- middle middle door open
defineProperty("cargo_front_door", globalPropertyf("tu-154/lights/cargo_front_door")) -- forward cargo hatch
defineProperty("cargo_back_door", globalPropertyf("tu-154/lights/cargo_back_door")) -- aft baggage hatch
defineProperty("turn63_lamp", globalPropertyf("tu-154/lights/turn63_lamp")) -- turn 63
defineProperty("nosewheel_turn_off", globalPropertyf("tu-154/lights/nosewheel_turn_off")) -- steering not engaged
defineProperty("busters_off", globalPropertyf("tu-154/lights/busters_off")) -- booster lamp

-- hatches
defineProperty("cargo_1", globalPropertyf("tu-154/anim/cargo_1")) -- cargo door 1 position. 0 = closed, 1 = open
defineProperty("cargo_2", globalPropertyf("tu-154/anim/cargo_2")) -- cargo door 1 position. 0 = closed, 1 = open
defineProperty("pax_door_1", globalPropertyf("tu-154/anim/pax_door_1")) -- front passenger door position
defineProperty("pax_door_2", globalPropertyf("tu-154/anim/pax_door_2")) -- middle passenger door position
defineProperty("pax_door_3", globalPropertyf("tu-154/anim/pax_door_3")) -- right emergency door position


defineProperty("busters_cap", globalPropertyi("tu-154/switchers/console/busters_cap")) -- booster switch guard







local function lamps()
	local day_night = 1 - get(day_night_set) * 0.25
	local test_btn = get(test_lamps) * math.max((get(bus27_volt_right) - 10) / 18.5, 0)
	local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0)
	
	local other_hatches_brt = math.max(0 * lamps_brt * day_night, test_btn) -- fake for now
	set(other_hatches, other_hatches_brt)
	
	local left_front_pax_door_brt = math.max(bool2int(get(pax_door_1) > 0) * lamps_brt * day_night, test_btn)
	set(left_front_pax_door, left_front_pax_door_brt)
	
	local left_mid_pax_door_brt = math.max(bool2int(get(pax_door_2) > 0) * lamps_brt * day_night, test_btn) 
	set(left_mid_pax_door, left_mid_pax_door_brt)
	
	local right_mid_pax_door_brt = math.max(bool2int(get(pax_door_3) > 0) * lamps_brt * day_night, test_btn)
	set(right_mid_pax_door, right_mid_pax_door_brt)
	
	local cargo_front_door_brt = math.max(bool2int(get(cargo_1) > 0) * lamps_brt * day_night, test_btn)
	set(cargo_front_door, cargo_front_door_brt)
	
	local cargo_back_door_brt = math.max(bool2int(get(cargo_2) > 0) * lamps_brt * day_night, test_btn)
	set(cargo_back_door, cargo_back_door_brt)
	
	local turn63_lamp_brt = math.max(get(nosewheel_turn_sel) * lamps_brt * day_night, test_btn)
	set(turn63_lamp, turn63_lamp_brt)
	
	local nosewheel_turn_off_brt = math.max((1-get(nosewheel_turn_enable)) * lamps_brt * day_night, test_btn)
	set(nosewheel_turn_off, nosewheel_turn_off_brt)
	
	local busters_off_brt = math.max(get(busters_cap) * lamps_brt * day_night, test_btn)
	set(busters_off, busters_off_brt)
	
	
end

local button_sound = loadSample('sounds/plastic_btn.wav')

local buttn_last = get(test_lamps)

function update()

	lamps()
	
	local button_sw = get(test_lamps)
	
	if button_sw ~= buttn_last then playSample(button_sound, false) end
	buttn_last = button_sw


end








