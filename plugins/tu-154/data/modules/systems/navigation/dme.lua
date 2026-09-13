size = {215, 70}

-- DataRefs
defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))

defineProperty("vor_dme", globalPropertyf("tu-154/radio/vor_dme_1")) -- distance

defineProperty("sd75_on", globalPropertyi("tu-154/switchers/ovhd/sd75_1_on")) -- switch on

defineProperty("nav_mile_km", globalPropertyi("tu-154/switchers/nav_1_mile_km")) -- miles/km mode

-- lamps
defineProperty("dme_mile_lit", globalPropertyf("tu-154/lights/small/dme_mile_left")) -- mile lamp
defineProperty("dme_km_lit", globalPropertyf("tu-154/lights/small/dme_km_left")) -- km lamp

-- power
defineProperty("bus27_volt", globalPropertyf("tu-154/elec/bus27_volt_left"))
defineProperty("bus115_volt", globalPropertyf("tu-154/elec/bus115_1_volt"))

defineProperty("fail", globalPropertyi("sim/operation/failures/rel_dme"))
defineProperty("dme_fail", globalPropertyi("tu-154/failures/dme1_fail"))

local text_font = loadBitmapFont('digital7_it.fnt')

local dist_text = "888.8"

local power = false

local dist_now = 0
local dist_show = 0

function update()
	
	power = get(sd75_on) == 1 and get(bus27_volt) > 13 and get(bus115_volt) > 110 and get(dme_fail) == 0
	
	local passed = get(frame_time)
	
	if power then
		local dist = get(vor_dme)
		
		dist_now = dist
		
	else	
		dist_now = 0
	
	end
	
	dist_show = math.floor((dist_now + 0.03) * 10) / 10
	
	if dist_show == 0 then dist_text = "---.-"
	elseif dist_show < 10 then 
		dist_text = "  "..dist_show
	elseif dist_show < 100 then
		dist_text = " "..dist_show
	else dist_text = dist_show
	end
	
	if dist_show - math.floor(dist_show) == 0 and dist_text ~= "---.-" then dist_text = dist_text..".0" end

	-- lamps
	local mode = get(nav_mile_km)
	
	if power then
		set(dme_mile_lit, bool2int(mode == 0))
		set(dme_km_lit, bool2int(mode == 1))
	else
		set(dme_mile_lit, 0)
		set(dme_km_lit, 0)
	end
	
	
	
	
	
	
	
end





components = {
	--[[
	rectangle {
		position = {0, 0, 215, 70},
		color = {0,0,1,1},
	},
	--]]

	text_draw {
		position = {16, 12, 130, 130},
		color = {1, 0.3, 0.2, 1},
		font = text_font,
		visible = function()
			return power
		end,
		text = function()
			return dist_text
		end,
	
	},


}