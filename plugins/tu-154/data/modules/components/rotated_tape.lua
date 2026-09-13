-- scrollable rotatable tape
-- Draw body is drawRotatedScrollTape (core/glbl_draw.lua) -- see tape.lua for
-- the SASL2 -> SASL3 source-rect conversion.

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
        size[1], size[2])
end
