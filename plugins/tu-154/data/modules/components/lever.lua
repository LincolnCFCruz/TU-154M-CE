size = {30, 120}

defineProperty("value", {0})

defineProperty("minimum", 0) -- minimum for variable, lower position of lever
defineProperty("maximum", 1) -- maximum for variable, higher position of lever

defineProperty("lever_count", 1)  -- count of levers to manipulate


defineProperty("back_img")
defineProperty("lever_img")

local Min = get(minimum)
local Max = get(maximum)
local Range = Max - Min
local Count = get(lever_count)

local mouse_stat = false
local v = get(value)

components = {

     -- movable lever image
    free_texture {
        image = get(lever_img),
        position_x = 0,
        position_y = function()
             local a = (get(v[1]) - Min) * 90 / Range
             if a > 90 then a = 90 end
             if a < 0 then a = 0 end
             return a - 10   
        end,
        width = 30,
        height = 30, 
    },
    
    -- clickable area for the lever
    clickable {
       position = { 5, 0, 20, 100 },
        
       cursor = { 
            x = 0, 
            y = 0, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        -- SASL3: onMouseDown fires once per press (SASL2's repeating
        -- onMouseDown needed a was_click guard here; no longer required).
        onMouseDown = function(comp, x, y, button)
           mouse_stat = true
           if y < 0 then y = 0 elseif y > 100 then y = 100 end
		   local val = y / 100 * Range + Min
           for i = 1, Count, 1 do
               set(v[i], val)
           end
           return true
        end,
        
        onMouseUp = function(comp, x, y, button)
           mouse_stat = false
           return true
        end,
        
        onMouseMove = function(comp, x, y, button) 
           if y < 0 then y = 0 elseif y > 100 then y = 100 end
		   local val = y / 100 * Range + Min
		   if mouse_stat then 
              for i = 1, Count, 1 do  
                  set(v[i], val)
              end
           end
           return true 
        end,
    },

}








