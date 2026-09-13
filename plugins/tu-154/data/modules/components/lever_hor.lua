size = {139, 29}

defineProperty("value", 0)

defineProperty("minimum", 0) -- minimum for variable, lower position of lever
defineProperty("maximum", 1) -- maximum for variable, higher position of lever

defineProperty("addFunc") -- callback fired when the drag ends

defineProperty("back_img")
defineProperty("lever_img")

local Min = get(minimum)
local Max = get(maximum)
local Range = Max - Min


local mouse_stat = false

-- width of the clickable strip below; mouse x arrives in its pixels
local CLICK_W = 109

components = {

     -- movable lever image
    free_texture {
        image = get(lever_img),
        position_y = 0,
        position_x = function()
             local a = (get(value) - Min) * (size[1]-30) / Range
             if a > size[1] - 30 then a = size[1] - 30 end
             if a < 0 then a = 0 end
             return a  
        end,
        width = 30,
        height = 30, 
    },
    
    -- clickable area for the lever
    clickable {
       position = { 15, 0, CLICK_W, 29 },
        -- dragging is handled by onMouseMove while mouse_stat is true
        onMouseDown = function(comp, x, y, button)
           mouse_stat = true
           if x < 0 then x = 0 elseif x > CLICK_W then x = CLICK_W end
		    local val = x / CLICK_W * Range + Min
              set(value, val)
           return true
        end,
        
                
        onMouseMove = function(comp, x, y, button) 
           if x < 0 then x = 0 elseif x > CLICK_W then x = CLICK_W end
		  
		   local val = x / CLICK_W * Range + Min
		   if mouse_stat then 
              set(value, val)
           end
           return true 
        end,
		
		onMouseUp = function(comp, x, y, button)
			if x < 0 then x = 0 elseif x > CLICK_W then x = CLICK_W end
			local val = x / CLICK_W * Range + Min
			set(value, val)
			mouse_stat = false
			addFunc()
			return true
        end,
		
    },

}
