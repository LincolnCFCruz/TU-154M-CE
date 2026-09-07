-- rotating needle, centred and aspect-preserved inside the component area
-- Draw body is drawNeedleTex (core/glbl_draw.lua), shared with needleLit.

-- default angle
defineProperty("angle", 0)

-- no image
defineProperty("image")

function draw(self)
    drawNeedleTex(get(image), get(angle), size[1], size[2])
end
