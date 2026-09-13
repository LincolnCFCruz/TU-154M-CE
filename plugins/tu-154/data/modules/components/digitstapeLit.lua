defineProperty("image")

-- image to display over digits (for 3d effect)
defineProperty("overlayImage")

defineProperty("value", 0)

-- number of digits
defineProperty("digits", 1)

-- number of fractional digits
defineProperty("fractional", 0)

-- allow non-round values
defineProperty("allowNonRound", false)

-- enable of disable value display
defineProperty("valueEnabler", true)

-- show leading zeros
defineProperty("showLeadingZeros", false)

-- show sign instead of first digit
defineProperty("showSign", false)


-- Draw body: drawDigitStrip (core/glbl_draw.lua), shared with digitstape;
-- this one is drawn independent of the cockpit lighting.
function draw(self)
    drawDigitStrip(get(image), get(overlayImage), get(value), get(digits), get(fractional),
        get(allowNonRound), get(valueEnabler), get(showLeadingZeros), get(showSign),
        size[1], size[2], {1, 1, 1, 1})
end
