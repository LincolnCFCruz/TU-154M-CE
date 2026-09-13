
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


-- power
defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right"))
defineProperty("bus115_1_volt", globalPropertyf("tu-154/elec/bus115_1_volt"))
defineProperty("bus115_2_volt", globalPropertyf("tu-154/elec/bus115_2_volt"))
defineProperty("bus115_3_volt", globalPropertyf("tu-154/elec/bus115_3_volt"))

-- sources
defineProperty("window_ice", globalPropertyf("sim/flightmodel/failures/window_ice")) -- ratio of icing on the windshield


defineProperty("rpm_high_1", globalPropertyf("tu-154/gauges/engine/rpm_high_1")) -- engine 1 high-pressure spool rpm
defineProperty("rpm_high_2", globalPropertyf("tu-154/gauges/engine/rpm_high_2")) -- engine 2 high-pressure spool rpm
defineProperty("rpm_high_3", globalPropertyf("tu-154/gauges/engine/rpm_high_3")) -- engine 3 high-pressure spool rpm


defineProperty("termo", globalPropertyf("sim/weather/aircraft/temperature_ambient_deg_c")) -- air temperature xp12

defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))

defineProperty("IAS", globalPropertyf("sim/flightmodel/position/indicated_airspeed")) 

defineProperty("deflection_mtr_2", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]"))
defineProperty("deflection_mtr_3", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]"))

-- failures
defineProperty("ppd_3_heat_fail", globalPropertyi("tu-154/antiice/ppd_3_heat_fail"))


defineProperty("rel_ice_inlet_heat1", globalPropertyi("sim/operation/failures/rel_ice_inlet_heat"))
defineProperty("rel_ice_inlet_heat2", globalPropertyi("sim/operation/failures/rel_ice_inlet_heat2"))
defineProperty("rel_ice_inlet_heat3", globalPropertyi("sim/operation/failures/rel_ice_inlet_heat3"))

defineProperty("rel_ice_pitot_heat1", globalPropertyi("sim/operation/failures/rel_ice_pitot_heat1"))
defineProperty("rel_ice_pitot_heat2", globalPropertyi("sim/operation/failures/rel_ice_pitot_heat2"))

defineProperty("rel_ice_surf_heat", globalPropertyi("sim/operation/failures/rel_ice_surf_heat"))
defineProperty("rel_ice_surf_heat2", globalPropertyi("sim/operation/failures/rel_ice_surf_heat2"))

defineProperty("rio_fail", globalPropertyi("tu-154/failures/rio_fail"))

defineProperty("window_heat_fail_1", globalPropertyi("tu-154/failures/window_heat_fail_1"))
defineProperty("window_heat_fail_2", globalPropertyi("tu-154/failures/window_heat_fail_2"))
defineProperty("window_heat_fail_3", globalPropertyi("tu-154/failures/window_heat_fail_3"))

-- results
defineProperty("ice_detected", globalPropertyi("tu-154/antiice/ice_detected"))
defineProperty("ice_detect_ok", globalPropertyi("tu-154/antiice/ice_detect_ok")) -- SOI system running

defineProperty("ice_window_heat_on", globalPropertyi("sim/cockpit2/ice/ice_window_heat_on")) -- window heating in the sim

defineProperty("window_ice_1", globalPropertyf("tu-154/anim/window_ice_1")) -- ice on the windows
defineProperty("window_ice_2", globalPropertyf("tu-154/anim/window_ice_2")) -- ice on the windows
defineProperty("window_ice_3", globalPropertyf("tu-154/anim/window_ice_3")) -- ice on the windows
defineProperty("window_ice_4", globalPropertyf("tu-154/anim/window_ice_4")) -- ice on the windows

defineProperty("inlet_heat_1", globalProperty("sim/cockpit2/ice/ice_inlet_heat_on_per_engine[0]"))
defineProperty("inlet_heat_2", globalProperty("sim/cockpit2/ice/ice_inlet_heat_on_per_engine[1]"))
defineProperty("inlet_heat_3", globalProperty("sim/cockpit2/ice/ice_inlet_heat_on_per_engine[2]"))

defineProperty("sim_pitot_heat_1", globalPropertyi("sim/cockpit2/ice/ice_pitot_heat_on_pilot"))
defineProperty("sim_pitot_heat_2", globalPropertyi("sim/cockpit2/ice/ice_pitot_heat_on_copilot"))

defineProperty("AOA_heat_on", globalPropertyi("sim/cockpit2/ice/ice_AOA_heat_on"))
defineProperty("AOA_heat_on_copilot", globalPropertyi("sim/cockpit2/ice/ice_AOA_heat_on_copilot"))

defineProperty("wings_heat_on", globalPropertyi("sim/cockpit2/ice/ice_surfce_heat_on"))

defineProperty("frm_ice", globalPropertyf("sim/flightmodel/failures/frm_ice"))
defineProperty("frm_ice2", globalPropertyf("sim/flightmodel/failures/frm_ice2"))

defineProperty("wing_heating", globalPropertyi("tu-154/antiice/wing_heating")) -- wing heating running
defineProperty("slat_heating", globalPropertyi("tu-154/antiice/slat_heating")) -- slat heating running

defineProperty("ai_27_L_cc", globalPropertyf("tu-154/antiice/ai_27_L_cc")) -- bus load
defineProperty("ai_27_R_cc", globalPropertyf("tu-154/antiice/ai_27_R_cc")) -- bus load

defineProperty("ai_115_1_cc", globalPropertyf("tu-154/antiice/ai_115_1_cc")) -- bus load
defineProperty("ai_115_2_cc", globalPropertyf("tu-154/antiice/ai_115_2_cc")) -- bus load
defineProperty("ai_115_3_cc", globalPropertyf("tu-154/antiice/ai_115_3_cc")) -- bus load

defineProperty("eng_heat_open_1", globalPropertyi("tu-154/antiice/eng_heat_open_1")) -- engine heating flap open
defineProperty("eng_heat_open_2", globalPropertyi("tu-154/antiice/eng_heat_open_2")) -- engine heating flap open
defineProperty("eng_heat_open_3", globalPropertyi("tu-154/antiice/eng_heat_open_3")) -- engine heating flap open


-- gauges
defineProperty("wing_heat_t", globalPropertyf("tu-154/antiice/wing_heat_t")) -- wing anti-ice temperature
defineProperty("stab_heat_t", globalPropertyf("tu-154/antiice/stab_heat_t")) -- stabiliser anti-ice temperature

-- Published for the anti-ice diagram; nothing else reads them and nothing
-- here changes as a result. Each was already being computed and then dropped
-- into a local, which is why the system could be watched but not explained.
defineProperty("ice_speed_out", globalPropertyf("tu-154/antiice/ice_speed")) -- icing rate
defineProperty("soi_ice_timer", globalPropertyf("tu-154/antiice/soi_ice_timer")) -- s since ice last seen
defineProperty("soi_test_timer", globalPropertyf("tu-154/antiice/soi_test_timer")) -- s since the SOI test button
defineProperty("window_heat_rate_1", globalPropertyf("tu-154/antiice/window_heat_rate_1")) -- delivered window heat
defineProperty("window_heat_rate_2", globalPropertyf("tu-154/antiice/window_heat_rate_2"))
defineProperty("window_heat_rate_3", globalPropertyf("tu-154/antiice/window_heat_rate_3"))
defineProperty("ice_wing_L_out", globalPropertyf("tu-154/antiice/ice_wing_L")) -- ice on the wings, bleed-air heated
defineProperty("ice_wing_R_out", globalPropertyf("tu-154/antiice/ice_wing_R"))
defineProperty("ice_slat_L_out", globalPropertyf("tu-154/antiice/ice_slat_L")) -- ice on the slats, electrically heated
defineProperty("ice_slat_R_out", globalPropertyf("tu-154/antiice/ice_slat_R"))


-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control


local ice_reseted = false
local ice_ratio_last = get(window_ice)
local ice_speed = 0

local ice_timer = 20
local ice_work_timer = 150

local ice_on_wings_L = 0
local ice_on_wings_R = 0
local ice_on_slats_L = 0
local ice_on_slats_R = 0


function update()
	
local MASTER = get(ismaster) ~= 1	
	
	local passed = get(frame_time)
	
	local power27_L = get(bus27_volt_left) > 13
	local power27_R = get(bus27_volt_right) > 13
	local power115_1 = get(bus115_1_volt) > 110
	local power115_2 = get(bus115_2_volt) > 110
	local power115_3 = get(bus115_3_volt) > 110
	
	local power_CC_115_1 = 0
	local power_CC_115_2 = 0
	local power_CC_115_3 = 0
	
	local out_term = get(termo)
	
	-- check icing conditions
	local ice_ratio = get(window_ice)

if MASTER then	
	-- reset ice ratio
	if ice_ratio > 0.9 or ice_ratio < 0.1 then 
		ice_ratio = 0.5
		set(window_ice, 0.5)
		ice_reseted = true
	else ice_reseted = false
	end

	if passed ~= 0 and not ice_reseted then
		if math.abs(ice_ratio - ice_ratio_last) > 0.01 then 
			ice_speed = 0
		else
			ice_speed = (ice_ratio - ice_ratio_last) * 2 / passed
		end
	end
	
	ice_ratio_last = ice_ratio
	set(ice_speed_out, ice_speed)


	-- SOI logic
	ice_timer = ice_timer + passed
	local ice_test = get(soi21_test) == 1
	if power27_L and power27_R and get(soi21_on) == 1 then
		if (ice_speed > 0 or ice_test) and get(rio_fail) ~= 1 then 
			ice_timer = 0 
		end
		
		
		-- test system
		if ice_test then ice_work_timer = 0 else ice_work_timer = ice_work_timer + passed end
		
		set(ice_detect_ok, bool2int(ice_work_timer > 30 and ice_work_timer < 55 and get(rio_fail) ~= 1))
		
		
		if ice_timer < 8 then set(ice_detected, 1) else set(ice_detected, 0) end
	else
		ice_work_timer = 150
		ice_timer = 20
		
		set(ice_detect_ok, 0)
		set(ice_detected, 0)
	end

	set(soi_ice_timer, ice_timer)
	set(soi_test_timer, ice_work_timer)

	-- set amount of ice on windows
	local window_heat_spd_1 = 0
	local win_heat_sw_1 = get(window_heat_1)
	if win_heat_sw_1 == 1 and power27_L and power115_1 then window_heat_spd_1 = 0.02 * (1 - get(window_heat_fail_1))
	elseif win_heat_sw_1 == -1 and power27_L and power115_1 then window_heat_spd_1 = 0.015 * (1 - get(window_heat_fail_1)) end
	set(window_heat_rate_1, window_heat_spd_1)
	
	
	local window_heat_spd_2 = 0
	local win_heat_sw_2 = get(window_heat_2)
	if win_heat_sw_2 == 1 and power27_R and power115_3 then window_heat_spd_2 = 0.02 * (1 - get(window_heat_fail_2))
	elseif win_heat_sw_2 == -1 and power27_R and power115_3 then window_heat_spd_2 = 0.015 * (1 - get(window_heat_fail_2)) end
	set(window_heat_rate_2, window_heat_spd_2)
	
	
	local window_heat_spd_3 = 0
	local win_heat_sw_3 = get(window_heat_3)
	if win_heat_sw_3 == 1 and power27_R and power115_3 then window_heat_spd_3 = 0.02 * (1 - get(window_heat_fail_3))
	elseif win_heat_sw_3 == -1 and power27_R and power115_3 then window_heat_spd_3 = 0.015 * (1 - get(window_heat_fail_3)) end
	set(window_heat_rate_3, window_heat_spd_3)
	

	local win_ice_1 = get(window_ice_1) + ((ice_speed - window_heat_spd_1) - math.max(out_term * 1, 0)) * passed
	if win_ice_1 < 0 then win_ice_1 = 0
	elseif win_ice_1 > 1 then win_ice_1 = 1 end
	set(window_ice_1, win_ice_1)
	
	local win_ice_2 = get(window_ice_2) + ((ice_speed - window_heat_spd_2) - math.max(out_term * 1, 0)) * passed
	if win_ice_2 < 0 then win_ice_2 = 0
	elseif win_ice_2 > 1 then win_ice_2 = 1 end
	set(window_ice_2, win_ice_2)	

	local win_ice_3 = get(window_ice_3) + ((ice_speed - window_heat_spd_3) - math.max(out_term * 1, 0)) * passed
	if win_ice_3 < 0 then win_ice_3 = 0
	elseif win_ice_3 > 1 then win_ice_3 = 1 end
	set(window_ice_3, win_ice_3)

	local win_ice_4 = get(window_ice_4) + (ice_speed - math.max(out_term * 1, 0)) * passed 
	if win_ice_4 < 0 then win_ice_4 = 0
	elseif win_ice_4 > 1 then win_ice_4 = 1 end
	set(window_ice_4, win_ice_4)


	set(ai_115_1_cc, window_heat_spd_1 * 250)
	set(ai_115_3_cc, (window_heat_spd_2 + window_heat_spd_3) * 250)
end	
	
	-- heat Pitots and AOA sensor
	local pitot_sw_1 = math.max(get(pitot_heat_1) * bool2int(get(rel_ice_pitot_heat1) ~= 6), 0)
	local pitot_sw_2 = math.max(get(pitot_heat_2) * bool2int(get(rel_ice_pitot_heat2) ~= 6), 0)
	local pitot_sw_3 = math.max(get(pitot_heat_3) * bool2int(get(ppd_3_heat_fail) ~= 1), 0)
	
	if power27_L then 
		set(sim_pitot_heat_1, pitot_sw_1) 
		set(AOA_heat_on, pitot_sw_1)
		set(AOA_heat_on_copilot, pitot_sw_1)
		
		set(ai_27_L_cc, 10 * pitot_sw_1)
	else
		set(sim_pitot_heat_1, 0) 
		set(AOA_heat_on, 0)
		set(AOA_heat_on_copilot, 0)
		
		set(ai_27_L_cc, 0)
	end
	
	if power27_R then -- add third Pitot here
		set(sim_pitot_heat_2, pitot_sw_2) 
		
		set(ai_27_R_cc, 7 * pitot_sw_2 + 7 * pitot_sw_3)
	else
		set(sim_pitot_heat_2, 0) 
		set(ai_27_R_cc, 0)
	end
	
	
	-- engines heat
	local rpm_1 = get(rpm_high_1) > 50
	set(inlet_heat_1, bool2int(get(rel_ice_inlet_heat1) ~= 6 and rpm_1 and power27_L) * get(antiice_eng_1))
	set(eng_heat_open_1, bool2int(get(rel_ice_inlet_heat1) ~= 6 and power27_L) * get(antiice_eng_1))
	
	local rpm_2 = get(rpm_high_2) > 50
	set(inlet_heat_2, bool2int(rpm_2 and power27_R) * get(antiice_eng_2) * bool2int(get(rel_ice_inlet_heat2) ~= 6))
	set(eng_heat_open_2, bool2int(get(rel_ice_inlet_heat2) ~= 6 and power27_R) * get(antiice_eng_2))
	
	local rpm_3 = get(rpm_high_3) > 50
	set(inlet_heat_3, bool2int(rpm_3 and power27_R) * get(antiice_eng_3) * bool2int(get(rel_ice_inlet_heat3) ~= 6))
	set(eng_heat_open_3, bool2int(get(rel_ice_inlet_heat3) ~= 6 and power27_R) * get(antiice_eng_3))
	
	-- wings and slat heat
	set(wings_heat_on, bool2int((rpm_1 or rpm_2 or rpm_3) and (power27_L or power27_R)) * get(antiice_wing))
	
	local wing_heat = bool2int((rpm_1 or rpm_2 or rpm_3) and (power27_L or power27_R) and get(rel_ice_surf_heat) < 6) * get(antiice_wing)
	local slat_heat = bool2int(power115_2 and (power27_L or power27_R) and get(rel_ice_surf_heat2) < 6 and get(deflection_mtr_2) < 0.1 and get(deflection_mtr_3) < 0.1) * get(antiice_slats)
	
	set(wing_heating, wing_heat)
	set(slat_heating, slat_heat)
	
	set(ai_115_2_cc, slat_heat * 70)
	

	-- heat tubes thermo
	local wing_tube = get(wing_heat_t)
	
	wing_tube = wing_tube + (out_term - wing_tube) * passed * 0.1 * (1 + get(IAS) / 200)
	wing_tube = wing_tube + (wing_heat * 300 - wing_tube) * passed * 0.1
	
	set(wing_heat_t, wing_tube)
	
	local stab_tube = get(stab_heat_t)
	
	stab_tube = stab_tube + (out_term - stab_tube) * passed * 0.1 * (1 + get(IAS) / 300)
	stab_tube = stab_tube + (wing_heat * 300 - stab_tube) * passed * 0.1
	
	set(stab_heat_t, stab_tube)	
	
	
	-- ice on wings and slats
	ice_on_wings_L = ice_on_wings_L + (ice_speed * math.random() * 2 - math.max(0, wing_tube) * 0.0005) * passed
	ice_on_slats_L = ice_on_slats_L + (ice_speed * math.random() * 2 - slat_heat * 0.02) * passed
	
	if ice_on_wings_L < 0 then ice_on_wings_L = 0 end
	if ice_on_slats_L < 0 then ice_on_slats_L = 0 end

	ice_on_wings_R = ice_on_wings_R + (ice_speed * math.random() * 2 - math.max(0, wing_tube) * 0.0005) * passed
	ice_on_slats_R = ice_on_slats_R + (ice_speed * math.random() * 2 - slat_heat * 0.02) * passed
	
	if ice_on_wings_R < 0 then ice_on_wings_R = 0 end
	if ice_on_slats_R < 0 then ice_on_slats_R = 0 end
	
	if ice_on_slats_L > 0.2 then ice_on_slats_L = 0.2 end
	if ice_on_slats_R > 0.2 then ice_on_slats_R = 0.2 end

	set(ice_wing_L_out, ice_on_wings_L)
	set(ice_wing_R_out, ice_on_wings_R)
	set(ice_slat_L_out, ice_on_slats_L)
	set(ice_slat_R_out, ice_on_slats_R)
	
	
	if MASTER then 
		set(frm_ice, ice_on_wings_L * 0.8 + ice_on_slats_L * 0.2) 
		set(frm_ice2, ice_on_wings_R * 0.8 + ice_on_slats_R * 0.2) 
	end


	set(ice_window_heat_on, 0)

end

