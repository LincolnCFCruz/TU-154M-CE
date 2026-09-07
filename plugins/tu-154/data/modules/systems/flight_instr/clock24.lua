-- source datarefs
defineProperty("utc_time", globalPropertyf("sim/time/zulu_time_sec"))


--[[
tu-154/buttons/clock_24_left	int	left button of the 24-hour clock. 0 - released, 1 - pressed (applies to all the buttons)
tu-154/buttons/clock_24_right	int	right button of the 24-hour clock
tu-154/gauges/clock_24_hours	float	hour hand
tu-154/gauges/clock_24_mins	float	minute hand
tu-154/gauges/clock_24_red	float	red needle

--]]

defineProperty("clock_24_hours", globalPropertyf("tu-154/gauges/clock_24_hours"))
defineProperty("clock_24_mins", globalPropertyf("tu-154/gauges/clock_24_mins"))
defineProperty("clock_24_red", globalPropertyf("tu-154/gauges/clock_24_red"))

--math.randomseed( os.time() ) -- randomise random :)
set(clock_24_red, math.random(360))

function update()
	local main_time = get(utc_time) -- seconds
	
	local minutes_angle = main_time * 0.1 -- minutes
	local hour_angle = main_time * 360 / (60*60*24)
	
	set(clock_24_mins, minutes_angle)
	set(clock_24_hours, hour_angle)
	
end