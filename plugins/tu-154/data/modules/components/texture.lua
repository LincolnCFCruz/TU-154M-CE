-- draw texture
-- Draw body is drawTextureFill (core/glbl_draw.lua), shared with textureLit.
-- SASL3: the component extent is size[1] x size[2] (SASL2's implicit 100x100).

-- no default texture
defineProperty("image")

function draw(self)
    drawTextureFill(get(image), size[1], size[2])
end
