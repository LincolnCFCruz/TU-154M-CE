-- this is checklist panel
size = {240, 850}

defineProperty("hide_eng_objects", globalPropertyi("tu-154/lang/hide_eng_objects")) -- hide the English cockpit objects. 1 = RUS


-- controls
defineProperty("show_checklist_panel",globalPropertyi("tu-154/panels/show_checklist_panel")) -- show the NVU panel

defineProperty("side",globalPropertyi("tu-154/checklist/side")) -- which side to show. 0 = before takeoff, 1 = before approach

defineProperty("fishka_1",globalPropertyi("tu-154/checklist/fishka_1")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_2",globalPropertyi("tu-154/checklist/fishka_2")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_3",globalPropertyi("tu-154/checklist/fishka_3")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_4",globalPropertyi("tu-154/checklist/fishka_4")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_5",globalPropertyi("tu-154/checklist/fishka_5")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_6",globalPropertyi("tu-154/checklist/fishka_6")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_7",globalPropertyi("tu-154/checklist/fishka_7")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_8",globalPropertyi("tu-154/checklist/fishka_8")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_9",globalPropertyi("tu-154/checklist/fishka_9")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_10",globalPropertyi("tu-154/checklist/fishka_10")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_11",globalPropertyi("tu-154/checklist/fishka_11")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_12",globalPropertyi("tu-154/checklist/fishka_12")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_13",globalPropertyi("tu-154/checklist/fishka_13")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_14",globalPropertyi("tu-154/checklist/fishka_14")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_15",globalPropertyi("tu-154/checklist/fishka_15")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_16",globalPropertyi("tu-154/checklist/fishka_16")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_17",globalPropertyi("tu-154/checklist/fishka_17")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_18",globalPropertyi("tu-154/checklist/fishka_18")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_19",globalPropertyi("tu-154/checklist/fishka_19")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_20",globalPropertyi("tu-154/checklist/fishka_20")) -- selector position. 0 = left, 1 = right

defineProperty("checklist_selected",globalPropertyi("tu-154/checklist/checklist_selected")) -- checklist selection


-- images

defineProperty("bg_img_0", loadImage("checklist_tex.png", 0, 174, 240, 850))
defineProperty("bg_img_1", loadImage("checklist_tex.png", 249, 174, 240, 850))

defineProperty("bg_img_0_RUS", loadImage("checklist_tex_RUS.png", 0, 174, 240, 850))
defineProperty("bg_img_1_RUS", loadImage("checklist_tex_RUS.png", 249, 174, 240, 850))

defineProperty("fishka_left", loadImage("checklist_tex.png", 0, 140, 166, 25))
defineProperty("fishka_right", loadImage("checklist_tex.png", 0, 112, 166, 25))





components = {

	
	-- background
	textureLit {
		position = {0, 0, size[1], size[2]},
		image = get(bg_img_0),
		visible = function()
			return get(side) == 0 and get(hide_eng_objects) == 0
		end,
	},	
	textureLit {
		position = {0, 0, size[1], size[2]},
		image = get(bg_img_1),
		visible = function()
			return get(side) == 1 and get(hide_eng_objects) == 0
		end,
	},	

	
	textureLit {
		position = {0, 0, size[1], size[2]},
		image = get(bg_img_0_RUS),
		visible = function()
			return get(side) == 0 and get(hide_eng_objects) == 1
		end,
	},	
	textureLit {
		position = {0, 0, size[1], size[2]},
		image = get(bg_img_1_RUS),
		visible = function()
			return get(side) == 1 and get(hide_eng_objects) == 1
		end,
	},
	
	
	---------------------
	-- clickables --
	---------------------
	
	-- change side --
	clickable {
		position = {58, 788, 122, 15},
      
		onMouseDown = function() 
			set(side, 1 - get(side))
			return true
		end,
	},	
	
	-- before start --
	clickable {
		position = {4, 424, 28, 350},
      
		onMouseDown = function() 
			set(fishka_1, 1)
			set(fishka_2, 1)
			set(fishka_3, 1)
			set(fishka_4, 1)
			set(fishka_5, 1)
			set(fishka_6, 1)
			set(fishka_7, 1)
			set(fishka_8, 1)
			set(fishka_9, 1)
			set(fishka_10, 1)
			if get(checklist_selected) ~=1 then set(checklist_selected, 1) end
			return true
		end,
		onMouseUp = function() 
			--set(checklist_selected, 0)
			return true
		end,
		
		
		visible = function()
			return get(side) == 0
		end,
	},	
	
	-- before taxi --
	clickable {
		position = {4, 57, 28, 350},
      
		onMouseDown = function() 
			set(fishka_11, 1)
			set(fishka_12, 1)
			set(fishka_13, 1)
			set(fishka_14, 1)
			set(fishka_15, 1)
			set(fishka_16, 1)
			set(fishka_17, 1)
			set(fishka_18, 1)
			set(fishka_19, 1)
			set(fishka_20, 1)
			if get(checklist_selected) ~=2 then set(checklist_selected, 2) end
			return true
		end,
		onMouseUp = function() 
			--set(checklist_selected, 0)
			return true
		end,
		visible = function()
			return get(side) == 0
		end,
	},	
	
	-- on taxi --
	clickable {
		position = {207, 688, 28, 91},
      
		onMouseDown = function() 
			set(fishka_1, 0)
			set(fishka_2, 0)
			set(fishka_3, 0)
			if get(checklist_selected) ~=3 then set(checklist_selected, 3) end
			return true
		end,
		onMouseUp = function() 
			--set(checklist_selected, 0)
			return true
		end,
		visible = function()
			return get(side) == 0
		end,
	},	
	
	-- before line up --
	clickable {
		position = {207, 350, 28, 327},
      
		onMouseDown = function() 
			set(fishka_4, 0)
			set(fishka_5, 0)
			set(fishka_6, 0)
			set(fishka_7, 0)
			set(fishka_8, 0)
			set(fishka_9, 0)
			set(fishka_10, 0)
			set(fishka_11, 0)
			set(fishka_12, 0)
			if get(checklist_selected) ~=4 then set(checklist_selected, 4) end
			return true
		end,
		onMouseUp = function() 
			--set(checklist_selected, 0)
			return true
		end,
		visible = function()
			return get(side) == 0
		end,
	},		
	
	-- before take-off --
	clickable {
		position = {207, 48, 28, 289},
      
		onMouseDown = function() 
			set(fishka_13, 0)
			set(fishka_14, 0)
			set(fishka_15, 0)
			set(fishka_16, 0)
			set(fishka_17, 0)
			set(fishka_18, 0)
			set(fishka_19, 0)
			set(fishka_20, 0)
			if get(checklist_selected) ~=5 then set(checklist_selected, 5) end
			return true
		end,
		onMouseUp = function() 
			--set(checklist_selected, 0)
			return true
		end,
		visible = function()
			return get(side) == 0
		end,
	},	
	
	-----------------------------
	
	-- before descend --
	clickable {
		position = {4, 270, 28, 257},
      
		onMouseDown = function() 
			set(fishka_8, 1)
			set(fishka_9, 1)
			set(fishka_10, 1)
			set(fishka_11, 1)
			set(fishka_12, 1)
			set(fishka_13, 1)
			set(fishka_14, 1)
			if get(checklist_selected) ~=6 then set(checklist_selected, 6) end
			return true
		end,
		onMouseUp = function() 
			--set(checklist_selected, 0)
			return true
		end,
		visible = function()
			return get(side) == 1
		end,
	},		
	
	-- after transition level --
	clickable {
		position = {4, 47, 28, 213},
      
		onMouseDown = function() 
			set(fishka_15, 1)
			set(fishka_16, 1)
			set(fishka_17, 1)
			set(fishka_18, 1)
			set(fishka_19, 1)
			set(fishka_20, 1)
			if get(checklist_selected) ~=7 then set(checklist_selected, 7) end
			return true
		end,
		onMouseUp = function() 
			--set(checklist_selected, 0)
			return true
		end,
		visible = function()
			return get(side) == 1
		end,
	},		
		
	-- before base turn --
	clickable {
		position = {207, 462, 28, 315},
      
		onMouseDown = function() 
			set(fishka_1, 0)
			set(fishka_2, 0)
			set(fishka_3, 0)
			set(fishka_4, 0)
			set(fishka_5, 0)
			set(fishka_6, 0)
			set(fishka_7, 0)
			set(fishka_8, 0)
			set(fishka_9, 0)
			if get(checklist_selected) ~=8 then set(checklist_selected, 8) end
			return true
		end,
		onMouseUp = function() 
			--set(checklist_selected, 0)
			return true
		end,
		visible = function()
			return get(side) == 1
		end,
	},		
		
	-- on final --
	clickable {
		position = {207, 50, 28, 396},
      
		onMouseDown = function() 
			set(fishka_10, 0)
			set(fishka_11, 0)
			set(fishka_12, 0)
			set(fishka_13, 0)
			set(fishka_14, 0)
			set(fishka_15, 0)
			set(fishka_16, 0)
			set(fishka_17, 0)
			set(fishka_18, 0)
			set(fishka_19, 0)
			set(fishka_20, 0)
			if get(checklist_selected) ~=9 then set(checklist_selected, 9) end
			return true
		end,
		onMouseUp = function() 
			--set(checklist_selected, 0)
			return true
		end,
		visible = function()
			return get(side) == 1
		end,
	},	
	

	-------------------------
	-- fishki --
	-------------------------
	
	
	-- fishka 1 --
	switch_lit {
		position = {35, 758, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_1) == 1
		end,
		onMouseDown = function()
			set(fishka_1, 1 - get(fishka_1))
			return true
		end,
	},	
		
	-- fishka 2 --
	switch_lit {
		position = {35, 720, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_2) == 1
		end,
		onMouseDown = function()
			set(fishka_2, 1 - get(fishka_2))
			return true
		end,
	},	
		
	-- fishka 3 --
	switch_lit {
		position = {35, 684, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_3) == 1
		end,
		onMouseDown = function()
			set(fishka_3, 1 - get(fishka_3))
			return true
		end,
	},	
		
	-- fishka 4 --
	switch_lit {
		position = {35, 646, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_4) == 1
		end,
		onMouseDown = function()
			set(fishka_4, 1 - get(fishka_4))
			return true
		end,
	},	
	
	-- fishka 5 --
	switch_lit {
		position = {35, 608, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_5) == 1
		end,
		onMouseDown = function()
			set(fishka_5, 1 - get(fishka_5))
			return true
		end,
	},		
	
	-- fishka 6 --
	switch_lit {
		position = {35, 570, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_6) == 1
		end,
		onMouseDown = function()
			set(fishka_6, 1 - get(fishka_6))
			return true
		end,
	},		
	
	-- fishka 7 --
	switch_lit {
		position = {35, 533, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_7) == 1
		end,
		onMouseDown = function()
			set(fishka_7, 1 - get(fishka_7))
			return true
		end,
	},	

	-- fishka 8 --
	switch_lit {
		position = {35, 495, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_8) == 1
		end,
		onMouseDown = function()
			set(fishka_8, 1 - get(fishka_8))
			return true
		end,
	},

	-- fishka 9 --
	switch_lit {
		position = {35, 457, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_9) == 1
		end,
		onMouseDown = function()
			set(fishka_9, 1 - get(fishka_9))
			return true
		end,
	},
	
	-- fishka 10 --
	switch_lit {
		position = {35, 418, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_10) == 1
		end,
		onMouseDown = function()
			set(fishka_10, 1 - get(fishka_10))
			return true
		end,
	},	
	
	-- fishka 11 --
	switch_lit {
		position = {35, 379, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_11) == 1
		end,
		onMouseDown = function()
			set(fishka_11, 1 - get(fishka_11))
			return true
		end,
	},	

	-- fishka 12 --
	switch_lit {
		position = {35, 342, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_12) == 1
		end,
		onMouseDown = function()
			set(fishka_12, 1 - get(fishka_12))
			return true
		end,
	},

	-- fishka 13 --
	switch_lit {
		position = {35, 305, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_13) == 1
		end,
		onMouseDown = function()
			set(fishka_13, 1 - get(fishka_13))
			return true
		end,
	},

	-- fishka 14 --
	switch_lit {
		position = {35, 267, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_14) == 1
		end,
		onMouseDown = function()
			set(fishka_14, 1 - get(fishka_14))
			return true
		end,
	},

	-- fishka 15 --
	switch_lit {
		position = {35, 229, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_15) == 1
		end,
		onMouseDown = function()
			set(fishka_15, 1 - get(fishka_15))
			return true
		end,
	},

	-- fishka 16 --
	switch_lit {
		position = {35, 193, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_16) == 1
		end,
		onMouseDown = function()
			set(fishka_16, 1 - get(fishka_16))
			return true
		end,
	},

	-- fishka 17 --
	switch_lit {
		position = {35, 154, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_17) == 1
		end,
		onMouseDown = function()
			set(fishka_17, 1 - get(fishka_17))
			return true
		end,
	},

	-- fishka 18 --
	switch_lit {
		position = {35, 117, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_18) == 1
		end,
		onMouseDown = function()
			set(fishka_18, 1 - get(fishka_18))
			return true
		end,
	},

	-- fishka 19 --
	switch_lit {
		position = {35, 80, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_19) == 1
		end,
		onMouseDown = function()
			set(fishka_19, 1 - get(fishka_19))
			return true
		end,
	},

	-- fishka 20 --
	switch_lit {
		position = {35, 44, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_20) == 1
		end,
		onMouseDown = function()
			set(fishka_20, 1 - get(fishka_20))
			return true
		end,
	},

	




	
	
	--------------------------------

	-- close button
	clickable {
		position = {size[1] - 30, size[2] - 30, 30, 30 },
      
		onMouseDown = function() 
			set(show_checklist_panel, 0)
			
			return true
		end,
	}, 	

}



