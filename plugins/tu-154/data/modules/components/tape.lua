-- Draw body is drawScrollTape (core/glbl_draw.lua): it converts `window` and
-- scrollX/Y from SASL2's normalised, top-origin source rect to SASL3's pixel,
-- bottom-left one, so the values below keep their SASL2 meaning.

defineProperty("image")

-- size of visible area
defineProperty("window", { 1.0, 1.0 } )

-- amount to scroll horizontal
defineProperty("scrollX", 0)

-- amount to scroll vertically
defineProperty("scrollY", 0)

function draw(self)
    drawScrollTape(get(image), get(window), get(scrollX), get(scrollY), size[1], size[2])
end
