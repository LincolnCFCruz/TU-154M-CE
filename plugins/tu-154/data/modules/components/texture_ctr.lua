-- draw texture with a controllable brightness
-- SASL3: the component extent is size[1] x size[2] (SASL2's implicit 100x100).

defineProperty("image")
defineProperty("lapha")

function draw(self)
	local a = get(alpha)
    drawTextureFill(get(image), size[1], size[2], {a, a, a})
end
