size = {170, 45}

defineProperty("text")

local font = loadBitmapFont('basic_font.fnt')

function draw()

	drawBitmapText(font, 0, 0, get(text), TEXT_ALIGN_LEFT, {1, 0.8, 0.7})

end

