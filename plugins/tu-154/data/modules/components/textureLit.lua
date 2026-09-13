-- draws the texture independent of the cockpit lighting system
-- Draw body is drawTextureFill (core/glbl_draw.lua), shared with texture.
-- SASL3: the component extent is size[1] x size[2] (SASL2's implicit 100x100).

defineProperty("image")

function draw(self)
    drawTextureFill(get(image), size[1], size[2], {1, 1, 1})
end
