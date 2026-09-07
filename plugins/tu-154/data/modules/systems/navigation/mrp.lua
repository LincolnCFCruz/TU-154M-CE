size = {2048, 2048}

-- define property table
-- datarefs
defineProperty("outer_marker", globalPropertyi("sim/cockpit/misc/outer_marker_lit"))   -- runway markers
defineProperty("middle_marker", globalPropertyi("sim/cockpit/misc/middle_marker_lit"))
defineProperty("inner_marker", globalPropertyi("sim/cockpit/misc/inner_marker_lit"))

defineProperty("alt", globalPropertyf("sim/flightmodel/position/y_agl"))
defineProperty("mrp_mode", globalPropertyi("tu-154/switchers/ovhd/sp50_nav_mode")) -- 0 - landing, 1 = navigation
--defineProperty("marker_audio", globalPropertyi("sim/cockpit/radios/gear_audio_working"))

--[[
tu-154/switchers/ovhd/sp50_mode	int	SP50 mode. 0 - ILS, 1 - Katet, 2 - SP-50	0
tu-154/switchers/ovhd/sp50_nav_mode	int	SP50 mode. landing - en route	0

--]]


-- power
defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right"))

defineProperty("mrp_cc", globalPropertyf("tu-154/xap/An24_gauges/mrp_cc"))

-- sfail
defineProperty("sim_fail", globalPropertyi("sim/operation/failures/rel_marker"))
defineProperty("mrp_fail", globalPropertyi("tu-154/failures/mrp_fail"))




-- lamps
defineProperty("marker_1", globalPropertyf("tu-154/lights/marker_1")) -- marker 1
defineProperty("marker_2", globalPropertyf("tu-154/lights/marker_2")) -- marker 2
defineProperty("marker_3", globalPropertyf("tu-154/lights/marker_3")) -- marker 3

defineProperty("lamp_test", globalPropertyi("tu-154/buttons/lamp_test_front")) -- front panel lamp test button	0
defineProperty("day_night_set", globalPropertyf("tu-154/lights/day_night_set")) -- day/night switch. 0 = day, 1 = night. dims the annunciator lamps.



local out_lit = 0
local mid_lit = 0
local in_lit = 0


function update()
	local mode = get(mrp_mode)
	--print(mode)
	if get(bus27_volt_left) > 13 and ((get(alt) < 5000 and mode == 1) or mode == 0) and get(mrp_fail) == 0 then
		set(mrp_cc, 2)
		set(sim_fail, 0)
		out_lit = get(outer_marker)
		mid_lit = get(middle_marker)
		in_lit = get(inner_marker)
	else
		set(mrp_cc, 0)
		set(sim_fail, 6)
		out_lit = 0
		mid_lit = 0
		in_lit = 0
	end
	
	local test_btn = get(lamp_test) * math.max(get(bus27_volt_right) - 10 / 18.5, 0)
	local day_night = 1 - get(day_night_set) * 0.25
	local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0) * day_night
	
	
	
	
	set(marker_1, math.max(out_lit * lamps_brt, test_btn))
	set(marker_2, math.max(mid_lit * lamps_brt, test_btn))
	set(marker_3, math.max(in_lit * lamps_brt, test_btn))
	
	

end





