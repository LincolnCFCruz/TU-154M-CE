-- this is USVP gauge (true airspeed and groundspeed)

-- sources
defineProperty("tas_svs", globalPropertyf("tu-154/svs/true_airspeed")) -- TAS
defineProperty("diss_groundspeed", globalPropertyf("tu-154/nvu/diss_groundspeed")) -- ground speed from the DISS
-- time
defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time")) -- flight time


-- controls
defineProperty("speed_mid_flag", globalPropertyi("tu-154/gauges/speed/speed_mid_flag")) -- speed indicator flag in the centre 0 - air, 1 - ground

-- result
defineProperty("speed_mid_needle", globalPropertyf("tu-154/gauges/speed/speed_mid_needle")) -- speed indicator needle in the centre


local speed_act = 0


function update()
	local passed = get(frame_time)
	
	local flag = get(speed_mid_flag)
	
	local spd = get(tas_svs)
	
	if flag == 1 then spd = get(diss_groundspeed) end
	
	speed_act = speed_act + (spd - speed_act) * passed * 5
	
	set(speed_mid_needle, speed_act / 1000 * 360)

end
