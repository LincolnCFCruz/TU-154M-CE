-- texture.lua, drawn independent of the cockpit lighting.

defineProperty("image")

function draw(self)
    drawTextureFill(get(image), size[1], size[2], {1, 1, 1})
end
