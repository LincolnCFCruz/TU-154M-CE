
-- controls
defineProperty("soi21_on", globalPropertyi("tu-154/switchers/eng/soi21_on")) -- SOI 21 switch
defineProperty("soi21_test", globalPropertyi("tu-154/buttons/eng/soi21_test")) -- SOI 21 test


defineProperty("antiice_slats", globalPropertyi("tu-154/switchers/eng/antiice_slats"))
defineProperty("antiice_eng_1", globalPropertyi("tu-154/switchers/eng/antiice_eng_1"))
defineProperty("antiice_eng_2", globalPropertyi("tu-154/switchers/eng/antiice_eng_2"))
defineProperty("antiice_eng_3", globalPropertyi("tu-154/switchers/eng/antiice_eng_3"))
defineProperty("antiice_wing", globalPropertyi("tu-154/switchers/eng/antiice_wing"))

defineProperty("window_heat_1", globalPropertyi("tu-154/switchers/ovhd/window_heat_1")) -- window heating. -1 = low, 0 = off, 1 = high
defineProperty("window_heat_2", globalPropertyi("tu-154/switchers/ovhd/window_heat_2")) -- window heating. -1 = low, 0 = off, 1 = high
defineProperty("window_heat_3", globalPropertyi("tu-154/switchers/ovhd/window_heat_3")) -- window heating. -1 = low, 0 = off, 1 = high

defineProperty("pitot_heat_1", globalPropertyi("tu-154/switchers/ovhd/pitot_heat_1")) -- left pitot heating
defineProperty("pitot_heat_2", globalPropertyi("tu-154/switchers/ovhd/pitot_heat_2")) -- right pitot heating
defineProperty("pitot_heat_3", globalPropertyi("tu-154/switchers/ovhd/pitot_heat_3")) -- ABSU pitot heating



-- lamps
defineProperty("heat_ok_1", globalPropertyf("tu-154/lights/small/heat_ok_1")) -- pitot heating healthy lamp
defineProperty("heat_ok_2", globalPropertyf("tu-154/lights/small/heat_ok_2")) -- pitot heating healthy lamp
defineProperty("heat_ok_3", globalPropertyf("tu-154/lights/small/heat_ok_3")) -- pitot heating healthy lamp

defineProperty("soi_work", globalPropertyf("tu-154/lights/small/soi_work")) -- SOI system operating lamp
defineProperty("soi_ice_detected", globalPropertyf("tu-154/lights/small/soi_ice_detected")) -- ice detection lamp

defineProperty("antiice_slats_lamp", globalPropertyf("tu-154/lights/small/antiice_slats")) -- heating healthy lamp
defineProperty("antiice_eng_1_lamp", globalPropertyf("tu-154/lights/small/antiice_eng_1")) -- heating healthy lamp
defineProperty("antiice_eng_2_lamp", globalPropertyf("tu-154/lights/small/antiice_eng_2")) -- heating healthy lamp
defineProperty("antiice_eng_3_lamp", globalPropertyf("tu-154/lights/small/antiice_eng_3")) -- heating healthy lamp
defineProperty("antiice_wings_lamp", globalPropertyf("tu-154/lights/small/antiice_wings")) -- heating healthy lamp




-- gauges
defineProperty("stab_temp", globalPropertyf("tu-154/gauges/eng/stab_temp")) -- stabiliser temperature
defineProperty("wing_temp", globalPropertyf("tu-154/gauges/eng/wing_temp")) -- wing temperature

-- sources
defineProperty("wing_heat_t", globalPropertyf("tu-154/antiice/wing_heat_t")) -- wing anti-ice temperature
defineProperty("stab_heat_t", globalPropertyf("tu-154/antiice/stab_heat_t")) -- stabiliser anti-ice temperature

defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right"))


defineProperty("ice_inlet_heat_1", globalProperty("sim/cockpit2/ice/ice_inlet_heat_on_per_engine[0]"))
defineProperty("ice_inlet_heat_2", globalProperty("sim/cockpit2/ice/ice_inlet_heat_on_per_engine[1]"))
defineProperty("ice_inlet_heat_3", globalProperty("sim/cockpit2/ice/ice_inlet_heat_on_per_engine[2]"))

defineProperty("eng_heat_open_1", globalPropertyi("tu-154/antiice/eng_heat_open_1")) -- engine heating flap open
defineProperty("eng_heat_open_2", globalPropertyi("tu-154/antiice/eng_heat_open_2")) -- engine heating flap open
defineProperty("eng_heat_open_3", globalPropertyi("tu-154/antiice/eng_heat_open_3")) -- engine heating flap open


defineProperty("ice_surfce_heat_on", globalPropertyi("sim/cockpit2/ice/ice_surfce_heat_on"))

defineProperty("ice_detected", globalPropertyi("tu-154/antiice/ice_detected"))
defineProperty("ice_detect_ok", globalPropertyi("tu-154/antiice/ice_detect_ok")) -- SOI system running

-- failures
defineProperty("ppd_3_heat_fail", globalPropertyi("tu-154/antiice/ppd_3_heat_fail"))

defineProperty("rel_ice_window_heat", globalPropertyi("sim/operation/failures/rel_ice_window_heat"))
defineProperty("rel_ice_inlet_heat1", globalPropertyi("sim/operation/failures/rel_ice_inlet_heat"))
defineProperty("rel_ice_inlet_heat2", globalPropertyi("sim/operation/failures/rel_ice_inlet_heat2"))
defineProperty("rel_ice_inlet_heat3", globalPropertyi("sim/operation/failures/rel_ice_inlet_heat3"))

defineProperty("rel_ice_pitot_heat1", globalPropertyi("sim/operation/failures/rel_ice_pitot_heat1"))
defineProperty("rel_ice_pitot_heat2", globalPropertyi("sim/operation/failures/rel_ice_pitot_heat2"))

defineProperty("rel_ice_surf_heat", globalPropertyi("sim/operation/failures/rel_ice_surf_heat"))
defineProperty("rel_ice_surf_heat2", globalPropertyi("sim/operation/failures/rel_ice_surf_heat2"))

defineProperty("wing_heating", globalPropertyi("tu-154/antiice/wing_heating")) -- wing heating running
defineProperty("slat_heating", globalPropertyi("tu-154/antiice/slat_heating")) -- slat heating running


-- engines
defineProperty("eng1_N1", globalProperty("sim/flightmodel/engine/ENGN_N1_[0]")) -- engine 1 rpm
defineProperty("eng2_N1", globalProperty("sim/flightmodel/engine/ENGN_N1_[1]")) -- engine 2 rpm
defineProperty("eng3_N1", globalProperty("sim/flightmodel/engine/ENGN_N1_[2]")) -- engine 3 rpm

defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))

-- sounds
local switcher_sound = loadSample('sounds/metal_switch.wav')
local button_sound = loadSample('sounds/plastic_btn.wav')

local passed = get(frame_time)


-- reset switchers for cold & dark
local notLoaded = true

local function reset_switchers()
	if get(eng1_N1) < 5 and get(eng2_N1) < 5 and get(eng3_N1) < 5 then
		set(soi21_on, 0)
		set(antiice_slats, 0)
		set(antiice_eng_1, 0)
		set(antiice_eng_2, 0)
		set(antiice_eng_3, 0)
		set(antiice_wing, 0)
		
		set(window_heat_1, 0)
		set(window_heat_2, 0)
		set(window_heat_3, 0)
		
		set(pitot_heat_1, 0)
		set(pitot_heat_2, 0)
		set(pitot_heat_3, 0)
		
	end
	
	notLoaded = false
	
end


local stab_temp_act = 0 --get(stab_heat_t)
local wing_tem_act = 0

local function gauges()

	local stab_t = get(stab_heat_t)
	local wing_t = get(wing_heat_t)
	
	stab_temp_act = stab_temp_act + (stab_t - stab_temp_act) * passed * 5
	wing_tem_act = wing_tem_act + (wing_t - wing_tem_act) * passed * 5
	
	set(stab_temp, stab_temp_act)
	set(wing_temp, wing_tem_act)


end





local soi21_on_last = get(soi21_on)
local antiice_slats_last = get(antiice_slats)
local antiice_eng_1_last = get(antiice_eng_1)
local antiice_eng_2_last = get(antiice_eng_2)
local antiice_eng_3_last = get(antiice_eng_3)
local antiice_wing_last = get(antiice_wing)

local window_heat_1_last = get(window_heat_1)
local window_heat_2_last = get(window_heat_2)
local window_heat_3_last = get(window_heat_3)

local pitot_heat_1_last = get(pitot_heat_1)
local pitot_heat_2_last = get(pitot_heat_2)
local pitot_heat_3_last = get(pitot_heat_3)

local soi21_test_last = get(soi21_test)


local function check_controls()

	local soi21_on_sw = get(soi21_on)
	local antiice_slats_sw = get(antiice_slats)
	local antiice_eng_1_sw = get(antiice_eng_1)
	local antiice_eng_2_sw = get(antiice_eng_2)
	local antiice_eng_3_sw = get(antiice_eng_3)
	local antiice_wing_sw = get(antiice_wing)

	local window_heat_1_sw = get(window_heat_1)
	local window_heat_2_sw = get(window_heat_2)
	local window_heat_3_sw = get(window_heat_3)

	local pitot_heat_1_sw = get(pitot_heat_1)
	local pitot_heat_2_sw = get(pitot_heat_2)
	local pitot_heat_3_sw = get(pitot_heat_3)

	local changes = soi21_on_sw + antiice_slats_sw + antiice_eng_1_sw + antiice_eng_2_sw + antiice_eng_3_sw + antiice_wing_sw
	changes = changes + window_heat_1_sw + window_heat_2_sw + window_heat_3_sw + pitot_heat_1_sw + pitot_heat_2_sw + pitot_heat_3_sw
	
	changes = changes - soi21_on_last - antiice_slats_last - antiice_eng_1_last - antiice_eng_2_last - antiice_eng_3_last - antiice_wing_last
	changes = changes - window_heat_1_last - window_heat_2_last - window_heat_3_last - pitot_heat_1_last - pitot_heat_2_last - pitot_heat_3_last
	
	if 0 ~= changes then playSample(switcher_sound, false) end
	
	local soi21_test_sw = get(soi21_test)
	
	if soi21_test_sw ~= soi21_test_last then playSample(button_sound, false) end
	
	
	soi21_on_last = soi21_on_sw
	antiice_slats_last = antiice_slats_sw
	antiice_eng_1_last = antiice_eng_1_sw
	antiice_eng_2_last = antiice_eng_2_sw
	antiice_eng_3_last = antiice_eng_3_sw
	antiice_wing_last = antiice_wing_sw

	window_heat_1_last = window_heat_1_sw
	window_heat_2_last = window_heat_2_sw
	window_heat_3_last = window_heat_3_sw

	pitot_heat_1_last = pitot_heat_1_sw
	pitot_heat_2_last = pitot_heat_2_sw
	pitot_heat_3_last = pitot_heat_3_sw
	
	soi21_test_last = soi21_test_sw

end




local function lamps()

	local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0)
	
	local heat_ok_1_brt = 0
	if get(rel_ice_pitot_heat1) < 6 and get(pitot_heat_1) == -1 then heat_ok_1_brt = lamps_brt end
	set(heat_ok_1, heat_ok_1_brt)
	
	local heat_ok_2_brt = 0
	if get(rel_ice_pitot_heat2) < 6 and get(pitot_heat_2) == -1 then heat_ok_2_brt = lamps_brt end
	set(heat_ok_2, heat_ok_2_brt)
	
	local heat_ok_3_brt = 0
	if get(ppd_3_heat_fail) == 0 and get(pitot_heat_3) == -1 then heat_ok_3_brt = lamps_brt end
	set(heat_ok_3, heat_ok_3_brt)
	
	
	local soi_work_brt = get(ice_detect_ok) * lamps_brt
	set(soi_work, soi_work_brt)
	
	local soi_ice_detected_brt = get(ice_detected) * lamps_brt
	set(soi_ice_detected, soi_ice_detected_brt)
	
	
	
	local antiice_slats_brt = get(slat_heating) * lamps_brt
	set(antiice_slats_lamp, antiice_slats_brt)
	
	local antiice_eng_1_brt = 0 
	if get(eng_heat_open_1) == 1 then antiice_eng_1_brt = lamps_brt end
	set(antiice_eng_1_lamp, antiice_eng_1_brt)
	
	local antiice_eng_2_brt = 0 
	if get(eng_heat_open_2) == 1 then antiice_eng_2_brt = lamps_brt end
	set(antiice_eng_2_lamp, antiice_eng_2_brt)
	
	local antiice_eng_3_brt = 0
	if get(eng_heat_open_3) == 1 then antiice_eng_3_brt = lamps_brt end
	set(antiice_eng_3_lamp, antiice_eng_3_brt)
	
	local antiice_wings_brt = get(wing_heating) * lamps_brt
	set(antiice_wings_lamp, antiice_wings_brt)
	
	


end









local sim_start_timer = 0

function update()

	passed = get(frame_time)
	
		-- reset switchers
	sim_start_timer = sim_start_timer + passed
	if sim_start_timer > 0.3 then 
		if notLoaded then reset_switchers() end
		
		check_controls()
	end

	gauges()
	lamps()





end