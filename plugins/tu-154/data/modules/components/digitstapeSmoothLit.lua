-- no image by default
defineProperty("image")

-- image to display over digits (for 3d effect)
defineProperty("overlayImage")

-- default value
defineProperty("value", 0)

-- maximum digits
defineProperty("digits", 1)

-- maximum digits
defineProperty("fractional", 0)

-- allow non-round values
defineProperty("allowNonRound", false)

-- enable of disable value display
defineProperty("valueEnabler", true)

-- show leading zeros
defineProperty("showLeadingZeros", false)

-- show sign instead of first digit
defineProperty("showSign", false)


-- Draw body is drawDigitStrip (core/glbl_draw.lua), shared by all three digit
-- strips. It carries the SASL2 -> SASL3 source-rect conversion (normalised,
-- top origin -> pixels, bottom-left) and the component extent (size[1]/size[2]
-- instead of SASL2's implicit 100x100).
function draw(self)
    drawDigitStrip(get(image), get(overlayImage), get(value), get(digits), get(fractional),
        get(allowNonRound), get(valueEnabler), get(showLeadingZeros), get(showSign),
        size[1], size[2], {1, 1, 1, 1}, true)
end
