-- TAWS main logic
size = {1000, 770}

-- controls
defineProperty("but_view", globalPropertyi("tu-154/buttons/srpbz/but_view")) -- VIEW button
defineProperty("but_empty", globalPropertyi("tu-154/buttons/srpbz/but_empty")) -- "-" button
defineProperty("but_down", globalPropertyi("tu-154/buttons/srpbz/but_down")) -- scale down button
defineProperty("but_up", globalPropertyi("tu-154/buttons/srpbz/but_up")) -- scale up


defineProperty("egpws_alarm_1", globalPropertyi("tu-154/switchers/ovhd/egpws_alarm_1")) -- SRPBZ (GPWS) warning, general
defineProperty("egpws_alarm_2", globalPropertyi("tu-154/switchers/ovhd/egpws_alarm_2")) -- SRPBZ (GPWS) warning
defineProperty("egpws_alarm_1_cap", globalPropertyi("tu-154/switchers/ovhd/egpws_alarm_1_cap")) -- SRPBZ (GPWS) warning, general
defineProperty("egpws_alarm_2_cap", globalPropertyi("tu-154/switchers/ovhd/egpws_alarm_2_cap")) -- SRPBZ (GPWS) warning
defineProperty("egpws_relief", globalPropertyi("tu-154/switchers/ovhd/egpws_relief")) -- terrain
defineProperty("egpws_mode", globalPropertyi("tu-154/switchers/ovhd/egpws_mode")) -- QNH - QFE

defineProperty("egpws_control", globalPropertyi("tu-154/buttons/ovhd/egpws_control")) -- SRPBZ test button
defineProperty("egpws_contr_gs", globalPropertyi("tu-154/buttons/ovhd/egpws_contr_gs")) -- SRPBZ glideslope test


-- power
defineProperty("bus115_1_volt", globalPropertyf("tu-154/elec/bus115_1_volt")) -- 115 V bus voltage
defineProperty("bus115_3_volt", globalPropertyf("tu-154/elec/bus115_3_volt"))

defineProperty("rv_on", globalPropertyi("tu-154/switchers/ovhd/rv5_2_on"))  -- switcher

defineProperty("bus27_volt", globalPropertyf("tu-154/elec/bus27_volt_left")) -- 27 V bus voltage

defineProperty("taws_fail", globalPropertyi("tu-154/failures/taws_fail")) -- SRPBZ failure


-- sources
defineProperty("vvi_L", globalPropertyf("sim/cockpit2/gauges/indicators/vvi_fpm_pilot")) -- vertical speed in ft/min
defineProperty("vvi_R", globalPropertyf("sim/cockpit2/gauges/indicators/vvi_fpm_copilot"))

defineProperty("rv5_alt", globalPropertyf("tu-154/misc/rv5_alt_left"))  -- altitude on the left altimeter


-- results
defineProperty("mode_set", globalPropertyi("tu-154/taws/mode_set")) -- screen operating mode. 0 - off, 1 - terrain map, 2 - side view, 3 - clock, 4 - power-up sequence, 5 - test, 6 - game
defineProperty("distance_set", globalPropertyi("tu-154/taws/distance_set")) -- map drawing range, km. 0 = 10, 1 = 20, 2 = 40, 3 = 80, 4 = 160, 5 = 320, 6 = 640

defineProperty("taws_cc", globalPropertyf("tu-154/taws/taws_cc")) -- current draw of the SRPBZ system


-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control




local but_view_last = 0
local but_empt_last = 0

local but_rng_up_last = 0
local but_rng_dn_last = 0

local up_counter = 0

function update()

local MASTER = get(ismaster) ~= 1	
	

if MASTER then	

	local power = get(bus115_1_volt) > 110 and get(bus27_volt) > 13 and get(rv_on) == 1
	
	if not power then
		set(mode_set, 0)
		set(distance_set, 1)
		set(taws_cc, 0)
		
		but_view_last = 0
		but_empt_last = 0

		but_rng_up_last = 0
		but_rng_dn_last = 0
	else

		local current_mode = get(mode_set)
		
		if current_mode == 0 then set(mode_set, 4) end -- system just started
		
		local but_view_now = get(but_view)
		local but_empty_now = get(but_empty)
		local but_down_now = get(but_down)
		local but_up_now = get(but_up)
		
		
		if (current_mode > 0 and current_mode < 4) or current_mode == 10 then
			
			if get(egpws_control) == 1 then set(mode_set, 5) end -- test mode
			
			if up_counter > 10 and get(ismaster) == 0 then
				set(mode_set, 6)
				up_counter = 0
			elseif get(ismaster) ~= 0 then
				up_counter = 0
			end
			

			if but_view_now == 1 and but_view_now ~= but_view_last then
				if current_mode ~= 1 then set(mode_set, 1)
				else set(mode_set, 2) end
				up_counter = 0
			end
			
			if but_empty_now == 1 and but_empty_now ~= but_empt_last then
				if current_mode ~= 3 then set(mode_set, 3)
				else set(mode_set, 1) end
				up_counter = up_counter + 1
			end
			
			if but_up_now == 1 and but_up_now ~= but_rng_up_last then
				local a = math.min(4, get(distance_set) + 1)
				set(distance_set, a)
				up_counter = 0
			end
			
			if but_down_now == 1 and but_down_now ~= but_rng_dn_last then
				local a = math.max(0, get(distance_set) - 1)
				set(distance_set, a)
				up_counter = 0
			end
			
			if get(taws_fail) == 1 then 
				set(mode_set, 10)
			elseif current_mode == 10 and get(taws_fail) == 0 then
				set(mode_set, 1)
			end
			
			
		end
	
		if current_mode == 6 and but_view_now == 1 and but_view_now ~= but_view_last then
			set(mode_set, 1)
		end
		
		but_view_last = but_view_now
		but_empt_last = but_empty_now

		but_rng_up_last = but_up_now
		but_rng_dn_last = but_down_now
	
		set(taws_cc, 1.5)
	end
	
end	
	
	--set(mode_set, 6) -- test game

end




