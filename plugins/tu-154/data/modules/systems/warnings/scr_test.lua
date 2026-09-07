-- this is the clock screen of TAWS
size = {1000, 770}

defineProperty("mode_set", globalPropertyi("tu-154/taws/mode_set")) -- screen mode. 0 = off, 1 = terrain map, 2 = side view, 3 = clock, 4 = power-up sequence
defineProperty("brt_handle", globalPropertyf("tu-154/rotary/srpbz/brightness")) -- brightness knob

defineProperty("taws_english", globalPropertyi("tu-154/taws/taws_english")) -- system language. 0 - Russian, 1 - English	0
defineProperty("taws_message", globalPropertyi("tu-154/taws/taws_message")) -- 
-- 0 - none, 1 - Pull UP, 2 - alt callout, 3 - Pull Up, 4 - Terrain, 5 - Terrain Ahead, 6 - Too low, Terrain, 
-- 7 - Alt collout, 8 - Too low, Gear, 9 - Too low, Flaps, 10 - Check altitude, 11 - Sink Rate, 12 - Don't sink, 13 - Glideslope

defineProperty("taws_eng_phrase", globalPropertyi("tu-154/sounds/taws_eng_phrase")) -- SRPBZ phrase number in English
defineProperty("taws_rus_phrase", globalPropertyi("tu-154/sounds/taws_rus_phrase")) -- SRPBZ phrase number in Russian

defineProperty("gs_msg_vol", globalPropertyf("tu-154/taws/gs_msg_vol")) -- GLIDESLOPE alert volume


-- time
defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time")) -- flight time

-- images
defineProperty("screen_img_img", loadImage("taws_clock.png", 0, 254, 1000, 770))
local text_font = loadBitmapFont('taws_scr.fnt')



local screen_work = get(mode_set) == 5
local brightness = 0.8


--[[
2:51 - 0:00 the check begins. the "TEST - CHECK" caption
2:55 - 0:04 the "DO NOT SINK" message. in yellow, at the top
3:08 - 0:17 the message disappeared
3:11 - 0:20 the "GLIDESLOPE" message
3:23 - 0:32 transition to map mode

stripes: black, green, yellow, orange, red, yellow, red, violet
--]]


local gs_msg_counter = 1
local sound_counter = 1

local time_counter = 0 -- use frames to fill table row by row

local test_msg = "ТЕСТ - КОНТРОЛЬ"

function update()

	screen_work = get(mode_set) == 5
	local passed = get(frame_time)
	
	local eng = get(taws_english)
	
	if eng == 1 then test_msg = "SYSTEM  -  TEST"
	else test_msg = "ТЕСТ - КОНТРОЛЬ"
	end
	
	if not screen_work then 
		brightness = 0 
		time_counter = 0	
	
	else
		brightness = get(brt_handle)
		
		if time_counter >= 0 and time_counter < 4 then 
			set(taws_message, 0)
			set(taws_rus_phrase, 0)
			set(taws_eng_phrase, 0)
		elseif time_counter < 17 then 
			set(taws_message, 12)
			if gs_msg_counter < 0 then
				set(taws_rus_phrase, 12 * (1 - eng))
				set(taws_eng_phrase, 12 * eng)
				gs_msg_counter = 2
			else
				set(taws_rus_phrase, 0)
				set(taws_eng_phrase, 0)
			end
			sound_counter = 0.2

		elseif time_counter < 20 then 
			set(taws_message, 0)
			set(taws_rus_phrase, 0)
			set(taws_eng_phrase, 0)
		elseif time_counter < 32 then 
			set(taws_message, 13)
			if sound_counter <= 0 then
				if gs_msg_counter < 0 then
					set(taws_rus_phrase, 13 * (1 - eng))
					set(taws_eng_phrase, 13 * eng)
					gs_msg_counter = 1.5
				else
					set(taws_rus_phrase, 0)
					set(taws_eng_phrase, 0)
				end
				sound_counter = 0.2
			end
		else 
			set(taws_message, 0)
			set(taws_rus_phrase, 0)
			set(taws_eng_phrase, 0)
			set(mode_set, 1)
		end
		
		
	
		
	end
	
	gs_msg_counter = gs_msg_counter - passed
	sound_counter = sound_counter - passed
	
	time_counter = time_counter + passed
	
	

end



components = {
	
	---------------------
	-- background --
	---------------------
	
	rectangle {
		position = {0, 0, 125, size[2]},
		color = {0.1, 0.1, 0.1, 1},
		visible = function()
			return screen_work
		end,
	},
	
	rectangle {
		position = {125, 0, 125, size[2]},
		color = {0.3, 1, 0.3, 1},
		visible = function()
			return screen_work
		end,
	},
	
	rectangle {
		position = {250, 0, 125, size[2]},
		color = {1, 1, 0.3, 1},
		visible = function()
			return screen_work
		end,
	},	
	
	rectangle {
		position = {375, 0, 125, size[2]},
		color = {1, 0.6, 0.2, 1},
		visible = function()
			return screen_work
		end,
	},		
	
	rectangle {
		position = {500, 0, 125, size[2]},
		color = {1, 0.3, 0.3, 1},
		visible = function()
			return screen_work
		end,
	},	
	
	rectangle {
		position = {625, 0, 125, size[2]},
		color = {1, 1, 0.3, 1},
		visible = function()
			return screen_work
		end,
	},		
	
	rectangle {
		position = {750, 0, 125, size[2]},
		color = {1, 0.3, 0.3, 1},
		visible = function()
			return screen_work
		end,
	},	
	
	rectangle {
		position = {875, 0, 125, size[2]},
		color = {1, 0.3, 1, 1},
		visible = function()
			return screen_work
		end,
	},	
	
	rectangle {
		position = {150, 335, 700, 80},
		color = {0.1, 0.1, 0.1, 1},
		visible = function()
			return screen_work 
		end,
	},	
	
	text_draw {
		position = {170, 350, 185, 160},
		text = function()
			return test_msg
		end,
		font = text_font,
		color = {1,1,1,1},
		visible = function()
			return screen_work
		end,
	},	
--[[	
	-- brightness controll
	rectangle_ctr {
		R = 0,
		G = 0,
		B = 0,
		A = function()
			return 1 - brightness
		end, -- controll via alpha
		position_x = 0,
		position_y = 0,
		width = size[1],
		height = size[2],
		visible = function()
			return screen_work
		end,
	},

--]]



}