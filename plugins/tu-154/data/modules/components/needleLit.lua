-- rotating needle, drawn independent of the cockpit lighting
-- Draw body is drawNeedleTex (core/glbl_draw.lua), shared with needle.

defineProperty("angle", 0)
defineProperty("image")

function draw(self)
    drawNeedleTex(get(image), get(angle), size[1], size[2], {1, 1, 1})
end
