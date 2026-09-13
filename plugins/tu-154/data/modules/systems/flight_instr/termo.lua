-- termometers
-- sources
defineProperty("thermo", globalPropertyf("sim/cockpit2/temperature/outside_air_temp_degc")) -- outside temperature

defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left")) -- 27 V bus voltage
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right")) -- 27 V bus voltage
-- time
defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))


-- results
defineProperty("thermo_outside", globalPropertyf("tu-154/gauges/misc/thermo_outside")) -- outside air thermometer

local termENG_act = -55
function update()
	local passed = get(frame_time)
	local therm = -55
	if get(bus27_volt_right) > 13 then
		therm = get(thermo)
	end
	-- set limits
	if therm > 115 then therm = 115
	elseif therm < -55 then therm = -55 end
	
	termENG_act = termENG_act + (therm - termENG_act) * passed * 5
	
	
	
	set(thermo_outside, termENG_act)
	
	
end
