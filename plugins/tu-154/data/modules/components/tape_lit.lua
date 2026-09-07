-- scrollable tape, drawn independent of the cockpit lighting
-- Draw body is drawScrollTape (core/glbl_draw.lua) -- see tape.lua.

-- tape image
defineProperty("image")

-- size of visible area
defineProperty("window", { 1.0, 1.0 } )

-- amount to scroll horizontal
defineProperty("scrollX", 0)

-- amount to scroll vertically
defineProperty("scrollY", 0)

-- draw tape
function draw(self)
    drawScrollTape(get(image), get(window), get(scrollX), get(scrollY), size[1], size[2], {1, 1, 1, 1})
end
