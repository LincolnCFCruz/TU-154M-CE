size = {205, 305}

defineProperty("overlay", loadImage("UHUD.png", 0, 207, 205, 305))
defineProperty("black", loadImage("UHUD.png", 5, 7, 5, 5))
defineProperty("digitsImage", loadImage("UPhone.png", 493, 232, 14, 280))
defineProperty("tape", loadImage("UHUD.png", 241, 0, 128, 512))
defineProperty("compass", loadImage("UHUD.png", 370, 106, 128, 128))
defineProperty("search", loadImage("UHUD.png", 0, 0, 205, 125))
defineProperty("warning", loadImage("UHUD.png", 0, 127, 205, 78))
defineProperty("understood", loadImage("UHUD.png", 381, 58, 107, 21))

defineProperty("pitch", globalPropertyf("sim/flightmodel/position/theta"))
defineProperty("roll", globalPropertyf("sim/flightmodel/position/phi"))
defineProperty("speed", globalPropertyf("sim/flightmodel/position/groundspeed"))
defineProperty("altitude", globalPropertyf("sim/flightmodel/position/elevation"))
defineProperty("heading", globalPropertyf("sim/flightmodel/position/hpath"))
defineProperty("vert", globalPropertyf("sim/flightmodel/position/vh_ind_fpm"))
defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))


local GS = 0
local Alt = 0
local Alt2 = 0
local head = 0
local verts = 0
local alignment = 0
-- Alignment timeline, accumulated from frame_time so it stops on pause.
-- This used to run on sim/time/total_running_time_sec, which does not.
local run_clock = 0
local timer = 0


function update()

run_clock = run_clock + get(frame_time)

pixels = get(pitch) / -255 + 0.4
rotation = 0 - get(roll) 


if alignment == 2 then
timer = run_clock + math.random(30, 60) 
alignment = 3
end

if alignment == 3 then
if run_clock > timer then
alignment = 1
end
end

if alignment == 1 then
if run_clock > timer then
timer = timer + 2
GS = get(speed) * 1.94 + math.random(-2, 2)
Alt = get(altitude) * 3.2808 + math.random(-5, 5) 
verts = ( Alt - Alt2 ) * 30
Alt2 = Alt
--verts = get(vert) + math.random(-50, 50) 

if get(speed) > 5 then
head = 0 - get(heading) + math.random(-2, 2) 
end
end
end
end

--0: KG 1:LB 2:KM 3:NM 4:MPS 5:FPM

components = {

	
	rotated_tapeLit {
		position = { 33, 135, 140, 140},
		image = get(tape),
		window = { 1.0, 0.2 },
		scrollY = function()
		return pixels
		end;
		angle = function()
		return rotation
		end;
		visible = true
	},
	
	textureLit {
		position = {0, 0, 205, 305 },
		image = get(overlay),
		visible = true
	},
	
	digitstapeLit {
		position = { 11, 97, 63, 22},
		image = digitsImage;
		digits = 5;
		allowNonRound = true;
		showLeadingZeros = false;
		fractional = 0;
		value = function()
		return GS
		end;
		visible = function()
		return alignment == 1
		end,
	},
	digitstapeLit {
		position = { 136, 97, 63, 22},
		image = digitsImage;
		digits = 5;
		allowNonRound = true;
		showLeadingZeros = false;
		fractional = 0;
		value = function()
		return Alt
		end;
		visible = function()
		return alignment == 1
		end,
	},
	digitstapeLit {
		position = { 136, 49, 63, 22},
		image = digitsImage;
		digits = 5;
		allowNonRound = true;
		showLeadingZeros = false;
		fractional = 0;
		showSign = true;
		value = function()
		return verts
		end;
		visible = function()
		return alignment == 1
		end,
	},

	needleLit {
		position = { 18, 120, 170, 170 },
		image = get(compass),
		angle = function() 
		return head
		end,
		visible = function()
		return alignment == 1
		end,
	},  

	textureLit {
		position = {5, 5, 205, 127},
		image = get(search),
		visible = function()
		return alignment == 3
		end,
	},
	textureLit {
		position = {0, 0, 205, 305 },
		image = get(black),
		visible = function()
		return alignment == 0
		end,
	},
	textureLit {
		position = {5, 180, 195, 78},
		image = get(warning),
		visible = function()
		return alignment == 0
		end,
	},
	textureLit {
		position = {49, 80, 107, 21},
		image = get(understood),
		visible = function()
		return alignment == 0
		end,
	},
	clickable {
		position = {49, 80, 107, 21 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		}, 
		visible = function()
		return alignment == 0
		end,		
		onMouseDown = function()
		alignment = 2
		return true
		end   
	},
}
