-- Rotary knob: two clickable halves (left = decrease, right = increase).
-- SASL2 -> SASL3:
--   * the halves were {0,0,50,100}/{50,0,50,100} in SASL2's implicit 100x100
--     component space; SASL3 sizes a component from its own position, so they
--     are size[1]/2 wide and size[2] tall.
--   * SASL2's onMouseDown fired on the press AND repeated while held. In
--     SASL3 the press is onMouseDown and the held repeat is holdToRepeat
--     (core/glbl_func.lua), which restores the SASL2 cadence; with autoRepeat
--     disabled the hold does nothing, as before.

defineProperty("image")
defineProperty("value", 0)
defineProperty("step", 1)

defineProperty('autoRepeat', true)

-- function for adjusting value to near suitable
--defineProperty("adjuster")

--adjuster = function (v) return v ; end

function updateValue(newValue)
    local a = rawget(_C, 'adjuster')
    if a then
        newValue = a(newValue)
    end
    set(value, newValue)
end

local repeatDec = holdToRepeat(function() updateValue(get(value) - get(step)) end)
local repeatInc = holdToRepeat(function() updateValue(get(value) + get(step)) end)

components = {

    texture { image = image },

    clickable {
        position = { 0, 0, size[1] / 2, size[2] },

        cursor = {
            x = 10,
            y = 28,
            width = 16,
            height = 16,
            shape = loadImage("rotateleft.png")
        },

        onMouseDown = function()
            updateValue(get(value) - get(step))
            return true
        end,

        onMouseHold = function(comp, x, y, button, parentX, parentY)
            if not get(autoRepeat) then return false end
            return repeatDec(comp, x, y, button, parentX, parentY)
        end,
    },

    clickable {
        position = { size[1] / 2, 0, size[1] / 2, size[2] },

        cursor = {
            x = 10,
            y = 28,
            width = 16,
            height = 16,
            shape = loadImage("rotateright.png")
        },

        onMouseDown = function()
            updateValue(get(value) + get(step))
            return true
        end,

        onMouseHold = function(comp, x, y, button, parentX, parentY)
            if not get(autoRepeat) then return false end
            return repeatInc(comp, x, y, button, parentX, parentY)
        end,
    },

}
