size = {139, 29}

-- property table
defineProperty("value", 0) -- variable for changing

defineProperty("minimum", 0) -- minimum for variable, lower position of lever
defineProperty("maximum", 1) -- maximum for variable, higher position of lever

defineProperty("addFunc") -- variable for changing


-- images
defineProperty("back_img") -- background image
defineProperty("lever_img") -- lever image  

local Min = get(minimum)
local Max = get(maximum)
local Range = Max - Min  -- define range of used variable


local mouse_stat = false

-- Width of the clickable strip below. SASL2 always handed mouse coordinates in
-- a component's implicit 100x100 space, so the handlers normalised by 100 even
-- though the strip is 109 wide; SASL3 hands them in the component's own pixel
-- space, so they normalise by the real width. The resulting value is identical.
local CLICK_W = 109

-- lever consist of several components
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
    
    -- clicable area for lever
    clickable {
       position = { 15, 0, CLICK_W, 29 },
       --[[ 
       cursor = { 
            x = 0, 
            y = 0, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        --]]
        -- SASL3: onMouseDown fires once per press (SASL2's repeating
        -- onMouseDown needed a was_click guard here; no longer required).
        -- Dragging is handled by onMouseMove while mouse_stat is true.
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
