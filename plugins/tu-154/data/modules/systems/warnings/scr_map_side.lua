size = {1000, 770}

defineProperty("mode_set", globalPropertyi("tu-154/taws/mode_set")) -- screen mode. 0 = off, 1 = terrain map, 2 = side view, 3 = clock, 4 = power-up sequence

defineProperty("distance_set", globalPropertyi("tu-154/taws/distance_set")) -- map drawing range, km. 0 = 10, 1 = 20, 2 = 40, 3 = 80, 4 = 160, 5 = 320, 6 = 640

defineProperty("brt_handle", globalPropertyf("tu-154/rotary/srpbz/brightness")) -- brightness knob


-- map parameters
defineProperty("pos_x", globalPropertyf("sim/flightmodel/position/local_x")) -- longtitude. positive from W to E
defineProperty("pos_y", globalPropertyf("sim/flightmodel/position/local_y")) -- altitude. positive UP
defineProperty("pos_z", globalPropertyf("sim/flightmodel/position/local_z")) -- latitude. positive from N to S

defineProperty("speed", globalPropertyf("sim/flightmodel/position/groundspeed"))
defineProperty("course", globalPropertyf("sim/flightmodel/position/psi")) -- angle between -Z axis and airplane's nose
defineProperty("course_fly", globalPropertyf("sim/flightmodel/position/hpath")) -- course, where aircraft actually flies
defineProperty("elevation", globalPropertyf("sim/flightmodel/position/elevation"))


defineProperty("gear1_deploy", globalProperty("sim/aircraft/parts/acf_gear_deploy[0]"))  -- deploy of front gear
defineProperty("gear2_deploy", globalProperty("sim/aircraft/parts/acf_gear_deploy[1]"))  -- deploy of right gear

-- time
defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))

-- images
defineProperty("scale_side_img", loadImage("taws_scale_2.png", 0, 254, 1000, 770))


local rows = 60

local low_qlty = false

if low_qlty then
	rows = 30
end


-- declare and fill drawed table of heights coded in color
local heightTable = {}

for i = 1, rows, 1 do
	heightTable[i] = -5000
end


-- declare and fill temporal table of heights
local tempHeightTable = {}

for i = 1, rows, 1 do
	tempHeightTable[i] = -5000
end


local time_counter = 0 -- use frames to fill table row by row
		
local dir = math.rad(get(course))
local dir_x = math.sin(dir); -- direct vector
local dir_z = -math.cos(dir);
local right_x = -dir_z; -- vector to the right
local right_z = dir_x;
local height = 20000 -- dimensions of scanned area in meters
local plane_x = get(pos_x)
local plane_y = get(pos_y)
local plane_z = get(pos_z)


local LG = false

local text_font = loadBitmapFont('taws_scr.fnt')

local range_text = " 20"

local brightness = 0.8


local screen_work = get(mode_set) == 2

local distance = 10

local vvi = 0
local elev_last = get(elevation)

local GS = get(speed)

function update()
	
	local passed = get(frame_time)
	
	screen_work = get(mode_set) == 2
	
	if not screen_work then 
		brightness = 0 
		time_counter = 0	
		for i = 1, rows, 1 do
			heightTable[i] = -5000
		end	
	else brightness = get(brt_handle)
	end
	
	local dist = get(distance_set)

	
	range_text = "20км"
	
	if dist == 0 then distance = 10 range_text = "10км"
	elseif dist == 1 then distance = 20 range_text = "20км"
	elseif dist == 2 then distance = 40 range_text = "40км"
	elseif dist == 3 then distance = 80 range_text = "80км"
	elseif dist == 4 then distance = 160 range_text = "160км"
	elseif dist == 5 then distance = 320 range_text = "320км"
	elseif dist == 6 then distance = 640 range_text = "640км"
	end
	
		
	-- scan terrain and fill height table
	if screen_work and time_counter > 1 then
		
		dir = math.rad(get(course))
		GS = get(speed)
		
		if GS > 11 then dir = math.rad(get(course_fly)) end
		
		if GS < 1 then GS = 0 end
		
		dir_x = math.sin(dir); -- direct vector
		dir_z = -math.cos(dir);
		plane_x = get(pos_x)
		plane_y = get(pos_y)
		plane_z = get(pos_z)
		LG = get(gear1_deploy) > 0.99 and get(gear2_deploy) > 0.99 and get(gear2_deploy) > 0.99
		
		local acf_lat, acf_lon, acf_alt = localToWorld(plane_x, plane_y, plane_z)
		
		height = distance * 1000
		
		
		for row = 1, rows, 1 do
			local p_x = plane_x + dir_x * height * row/rows
			local p_z = plane_z + dir_z * height * row/rows
			prob, locationX, locationY, locationZ, normalX, normalY, normalZ, velocityX, velocityY, vlocityZ, isWet = probeTerrain(p_x, plane_y, p_z)
								
			
			-- [FIX-PROBE] probeTerrain returns nil location values outside loaded
			-- scenery (same guard as scr_map_top.lua and taws_warn_logic.lua,
			-- which both already have this check with the identical comment).
			-- Without it, localToWorld and the subtraction below ran on nils on
			-- every probe point beyond loaded scenery, throwing on every frame
			-- for the whole flight -- Evgeniy reported a very rough 50-minute
			-- flight on 2026-09-09 with this in the log continuously.
			local lat, lon, alt
			if locationX then lat, lon, alt = localToWorld(locationX, locationY, locationZ) end
			
			heightTable[row] = alt and (alt - acf_alt) or -5000  -- -5000: same "no data" sentinel used above
		end	
		
		local elev_now = get(elevation)
		vvi = (elev_now - elev_last)
		elev_last = elev_now
		
		
		time_counter = 0
	end
	time_counter = time_counter + passed
	
end


components = {

	-- brightness controll
	rectangle_ctr {
		R = 0.1,
		G = 0.1,
		B = 0.1,
		A = 1,
		position_x = 0,
		position_y = 0,
		width = size[1],
		height = size[2],
		visible = function()
			return screen_work
		end,
	},

	
	side_draw {
		position = {197, 167, 800, 600},
		columns = rows,
		image_table = function()
			return heightTable
		end,
		visible = function()
			return screen_work
		end,
		range = function()
			return distance
		end,
		v_spd = function()
			return vvi
		end,
		g_spd = function()
			return GS
		end,
	},
	
	
	-- scale for side view
	textureLit {
		position = {0, 0, size[1], size[2]},
		image = get(scale_side_img),
		visible = function()
			return screen_work
		end,
	},

	-- distance text
	text_draw {
		position = {800, 100, 160, 160},
		text = function()
			return range_text
		end,
		font = text_font,
		color = {1,1,1,1},
		visible = function()
			return screen_work
		end,
	},

}

