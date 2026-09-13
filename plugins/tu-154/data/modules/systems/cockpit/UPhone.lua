size = {241, 446}

defineProperty("bg", loadImage("UPhone.png", 0, 66, 241, 446))
defineProperty("APPS", loadImage("UPhone.png", 260, 207, 205, 305))
defineProperty("digitsImage", loadImage("UPhone.png", 493, 232, 14, 280))
--defineProperty("uphone_subpanel", globalPropertyi("tu-154/xap/An24_panels/uphone_subpanel"))
defineProperty("uphone_subpanel",globalPropertyi("tu-154/panels/show_phone")) -- show the telephone panel

program = 0

components = {
	texture {
		position = {0, 0, 240, 444},
		image = get(bg),
		visible = true
	},
	
	--menu
	clickable {
		position = {71, 19, 99, 40 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseDown = function()
		program = 0
		return true
		end  

	},

	--APPS
	textureLit {
		position = {20, 68, 205, 305},
		image = get(APPS),
		visible = function()
		return program == 0
		end,
	},
	clickable {
		position = {30, 300, 25, 25 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return program == 0
		end,
		onMouseDown = function()
		program = 1
		end  
	},
	UHUD {
		position = { 20, 68, 205, 305 },
		visible = function()
		return program == 1
		end,
	},	

	clickable {
		position = {65, 300, 25, 25 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return program == 0
		end,
		onMouseDown = function()
		program = 2
		end  
	},	

	UConvert {
		position = { 20, 68, 205, 305 },
		visible = function()
		return program == 2
		end,
	}, 
	clickable {
		position = {100, 300, 25, 25 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return program == 0
		end,
		onMouseDown = function()
		program = 3
		end  
	},	

	UTurn {
		position = { 20, 68, 205, 305 },
		visible = function()
		return program == 3
		end,
	}, 
	
	
	clickable {
		position = {135, 300, 25, 25 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		visible = function()
		return program == 0
		end,
		onMouseDown = function()
		program = 4
		end  
	},	
	
	
	UMETAR {
		position = { 20, 68, 205, 305 },
		visible = function()
		return program == 4
		end,
	}, 
	
	
}
