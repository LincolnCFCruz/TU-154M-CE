-- Fills the component with `image` (drawTextureFill, core/glbl_draw.lua).

defineProperty("image")

function draw(self)
    drawTextureFill(get(image), size[1], size[2])
end
