-- draw text

-- Logical drawing extent. SASL2 defaulted every component to 100x100; SASL3
-- derives size from the position rect instead, and since drawBitmapText emits
-- glyphs at their native pixel size, that default IS the font scale. Keep the
-- SASL2 extent so the call sites' 50x50 / 60x60 rects still scale the text.
size = {100, 100}

-- no default font
defineProperty("font")

-- no default text
defineProperty("text")

function draw(self) 
    drawBitmapText(get(font), 0, 0, get(text), TEXT_ALIGN_LEFT) 
end


