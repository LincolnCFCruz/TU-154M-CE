-- scrollable rotatable tape, drawn independent of the cockpit lighting
-- Draw body is drawRotatedScrollTape (core/glbl_draw.lua) -- see tape.lua.

defineProperty("image")

-- size of visible area
defineProperty("window", { 1.0, 1.0 } )

-- amount to scroll horizontal
defineProperty("scrollX", 0)

-- amount to scroll vertically
defineProperty("scrollY", 0)

-- rotation angle
defineProperty("angle", 0)

function draw(self)
    drawRotatedScrollTape(get(image), get(angle), get(window), get(scrollX), get(scrollY),
        size[1], size[2], {1, 1, 1})
end
