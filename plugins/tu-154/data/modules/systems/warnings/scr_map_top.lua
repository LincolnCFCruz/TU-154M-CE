

size = {1000, 770}

defineProperty("mode_set", globalPropertyi("tu-154/taws/mode_set")) -- screen mode. 0 = off, 1 = terrain map, 2 = side view, 3 = clock, 4 = power-up sequence

defineProperty("distance_set", globalPropertyi("tu-154/taws/distance_set")) -- map drawing range, km. 0 = 10, 1 = 20, 2 = 40, 3 = 80, 4 = 160, 5 = 320, 6 = 640

defineProperty("brt_handle", globalPropertyf("tu-154/rotary/srpbz/brightness")) -- brightness knob

-- load images
defineProperty("scale_top_img", loadImage("taws_scale_1.png", 0, 254, 1000, 770))


-- map parameters
defineProperty("pos_x", globalPropertyf("sim/flightmodel/position/local_x")) -- longtitude. positive from W to E
defineProperty("pos_y", globalPropertyf("sim/flightmodel/position/local_y")) -- altitude. positive UP
defineProperty("pos_z", globalPropertyf("sim/flightmodel/position/local_z")) -- latitude. positive from N to S

defineProperty("speed", globalPropertyf("sim/flightmodel/position/groundspeed"))
defineProperty("course", globalPropertyf("sim/flightmodel/position/psi")) -- angle between -Z axis and airplane's nose
defineProperty("course_fly", globalPropertyf("sim/flightmodel/position/hpath")) -- course, where aircraft actually flies


defineProperty("gear1_deploy", globalProperty("sim/aircraft/parts/acf_gear_deploy[0]"))  -- deploy of front gear
defineProperty("gear2_deploy", globalProperty("sim/aircraft/parts/acf_gear_deploy[1]"))  -- deploy of right gear


local rows = 60
local cols = 80

local low_qlty = false

if low_qlty then
	rows = 30
	cols = 40
end


-- colors of heights: 1 - black, 2 - dark green, 3 - green, 4 - yellow, 5 - dark yellow, 6 - orange, 7 - red, 8 - blue, 9 - magenta
local colorTable = {[1]={0.1, 0.1, 0.1}, [2]={0.2, 0.5, 0.2}, [3]={0.3, 1, 0.3}, [4]={1, 1, 0.3}, [5]={1, 0.8, 0.2}, [6]={1, 0.6, 0.2}, [7]={1,0.3,0.3}, [8]={0.1,0.1,1}, [9] = {1,0.1,1}}

-- declare and fill drawed table of heights coded in color
local heightTable = {}

for i = 1, cols, 1 do
	table.insert(heightTable, {})
	for j = 1, rows, 1 do
		table.insert(heightTable[i], 1)
	end
end

-- declare and fill temporal table of heights
local tempHeightTable = {}

for i = 1, cols, 1 do
	table.insert(tempHeightTable, {})
	for j = 1, rows, 1 do
		table.insert(tempHeightTable[i], 1)
	end
end


function giveColor(acf_alt, terr_alt, wet, gears)
	local colorID = 8
	
	-- check alt
	if not terr_alt then return 8 end -- error reading terrain
	local alt = (terr_alt - acf_alt) -- meters
	
	
	if alt >= 600 then colorID = 7 -- red
	elseif alt >= 300 then colorID = 6 -- orange
	elseif alt >= 0 then colorID = 5 -- dark yellow
	elseif alt >= -150 then colorID = 4 -- yellow
	elseif alt >=- 300 then colorID = 3 -- green
	elseif alt >=- 600 then colorID = 2 -- dark green
	elseif alt < -600 then colorID = 1 -- black
	end
	
	return colorID


end


local frame_counter = 1 -- use frames to fill table row by row
		
local dir = math.rad(get(course))
local dir_x = math.sin(dir); -- direct vector
local dir_z = -math.cos(dir);
local right_x = -dir_z; -- vector to the right
local right_z = dir_x;
local height, width = 20000, 25000 -- dimensions of scanned area in meters
local plane_x = get(pos_x)
local plane_y = get(pos_y)
local plane_z = get(pos_z)


local LG = false

local text_font = loadBitmapFont('taws_scr.fnt')

local range_text = " 20"

local brightness = 0.8


local screen_work = get(mode_set) == 1


function update()
	
	screen_work = get(mode_set) == 1
	
	if not screen_work then 
		brightness = 0 
		frame_counter = 1
	else brightness = get(brt_handle)
	end
	
	local dist = get(distance_set)

	local distance = 20
	range_text = " 20"
	
	if dist == 0 then distance = 10 range_text = " 10"
	elseif dist == 2 then distance = 40 range_text = " 40"
	elseif dist == 3 then distance = 80 range_text = " 80"
	elseif dist == 4 then distance = 160 range_text = "160"
	elseif dist == 5 then distance = 320 range_text = "320"
	elseif dist == 6 then distance = 640 range_text = "640"
	end
	
	-- moving map calculations
	if frame_counter > rows/2 then frame_counter = 1 end
	if frame_counter == 1 and screen_work then
		dir = math.rad(get(course))
		
		if get(speed) > 11 then dir = math.rad(get(course_fly)) end
		
		dir_x = math.sin(dir); -- direct vector
		dir_z = -math.cos(dir);
		right_x = -dir_z; -- vector to the right
		right_z = dir_x;
		plane_x = get(pos_x)
		plane_y = get(pos_y)
		plane_z = get(pos_z)
		LG = get(gear1_deploy) > 0.99 and get(gear2_deploy) > 0.99 and get(gear2_deploy) > 0.99
		
		height = distance * 1000
		width = distance * 1250
		
		-- copy temp table to draw table and reset temp one
		for i = 1, cols, 1 do
			for j = 1, rows, 1 do
				heightTable[i][j] = tempHeightTable[i][j]
				tempHeightTable[i][j] = 1
			end
		end		
		
		
	end	
	
	-- scan terrain and fill temp table
	if screen_work then
		
		local acf_lat, acf_lon, acf_alt = localToWorld(plane_x, plane_y, plane_z)
		for row = frame_counter * 2 - 1, frame_counter * 2, 1 do
			for col = 1, cols, 1 do
				local p_x = plane_x + dir_x * height * row/rows - right_x * width / 2 + right_x * width * col/cols;
				local p_z = plane_z + dir_z * height * row/rows - right_z * width / 2 + right_z * width * col/cols;
				local prob, locationX, locationY, locationZ, normalX, normalY, normalZ, velocityX, velocityY, vlocityZ, isWet = probeTerrain(p_x, plane_y, p_z)
								
				
				local lat, lon, alt
				if locationX then lat, lon, alt = localToWorld(locationX, locationY, locationZ) end -- the probe returns nils outside loaded scenery; giveColor() paints alt == nil as "no data"
				
				tempHeightTable[col][row] = giveColor(acf_alt, alt, isWet, LG)
				
			end	
		end
	else
		-- reset tables
		for i = 1, cols, 1 do
			for j = 1, rows, 1 do
				heightTable[i][j] = 1
				tempHeightTable[i][j] = 1
			end
		end	
		frame_counter = 0
		
	end
	
	frame_counter = frame_counter + 1	
	
end


components = {
	
	draw_map {
		position = {0, 0, size[1], size[2]},
		size_x = cols,
		size_y = rows,
		
		image_table = function()
			return heightTable
		end,
		
		colors = function()
			return colorTable
		end,
		
		visible = function()
			return screen_work
		end,
		
		
	},
	
	-- scale for top view
	texture {
		position = {0, 0, size[1], size[2]},
		image = get(scale_top_img),
		visible = function()
			return screen_work
		end,
	},

	rectangle {
		position = {0, 600, 120, 120},
		color = {0.1,0.1,0.1,1},
		visible = function()
			return screen_work
		end,
	},
	
	-- distance text
	text_draw {
		position = {0, 660, 160, 160},
		text = function()
			return range_text
		end,
		font = text_font,
		color = {1,1,1,1},
		visible = function()
			return screen_work
		end,
	},
	
	-- distance text
	text_draw {
		position = {20, 610, 160, 160},
		text = "км",
		font = text_font,
		color = {1,1,1,1},
		visible = function()
			return screen_work
		end,
	},	
	
	
}