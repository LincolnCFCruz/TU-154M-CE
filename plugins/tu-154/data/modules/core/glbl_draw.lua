--[[

  File: glbl_draw.lua
  -----
  Shared draw helpers for the widget library in modules/components/. Each
  drawing widget is a thin wrapper around one of these. Published on _G so the
  component draw() environments reach them from any layer (see glbl_func.lua).

  Why this file exists (SASL2 -> SASL3)
  -------------------------------------
  Two coordinate conventions changed between SASL2 and SASL3, and both of them
  are concentrated here instead of being spread over the widget files:

  1. COMPONENT EXTENT. In SASL2 a component with no explicit `size` defaulted to
     {100, 100}, so every widget drew itself as "0,0,100,100" and SASL scaled
     that onto the component's position rect. In SASL3 (initMain.lua
     loadComponent) the default size is the component's OWN position w/h -- i.e.
     a 1:1 pixel space -- so the extent must now be size[1] x size[2]. The
     helpers below therefore take w/h from the caller.

  2. TEXTURE-PART COORDS. SASL2's drawTexturePart()/drawRotatedTexturePart()
     took the source rect NORMALISED (0..1) with a TOP-LEFT origin. SASL3 takes
     it in PIXELS with a BOTTOM-LEFT origin. tapeRect() and drawDigitStrip()
     below do that conversion, so the widgets keep their SASL2 inputs
     (`window`, `scrollX/Y`, the 1/14 digit rows) unchanged.

  Colour convention: the "Lit" widget variants pass an explicit white tint, the
  base variants pass nil and the helper substitutes WHITE (the SASL drawTexture*
  functions reject an explicit nil colour, and white is their default).

--]]

local WHITE = {1, 1, 1, 1}

-- Texture dimensions never change at runtime, so cache them by texture handle
-- and avoid a getTextureSize() call inside every draw().
local sizeCache = {}
function _G.texSize(img)
    local s = sizeCache[img]
    if not s then
        s = {sasl.gl.getTextureSize(img)}
        sizeCache[img] = s
    end
    return s[1], s[2]
end

-- texture.lua / textureLit.lua / texture_ctr.lua: fill the component area.
function _G.drawTextureFill(img, w, h, color)
    if not img then
        return
    end
    sasl.gl.drawTexture(img, 0, 0, w, h, color or WHITE)
end

-- Source rect for a scroll tape: maps the SASL2 normalised window/scroll values
-- onto SASL3's pixel, bottom-left-origin source rect.
local function tapeRect(img, window, sx, sy)
    local tw, th = texSize(img)
    local szx = (window and window[1]) or 1
    local szy = (window and window[2]) or 1
    sx, sy = sx or 0, sy or 0
    return sx * tw, th - (sy + szy) * th, szx * tw, szy * th
end

-- tape.lua / tape_lit.lua
function _G.drawScrollTape(img, window, sx, sy, w, h, color)
    if not img then
        return
    end
    local rx, ry, rw, rh = tapeRect(img, window, sx, sy)
    sasl.gl.drawTexturePart(img, 0, 0, w, h, rx, ry, rw, rh, color or WHITE)
end

-- rotated_tape.lua / rotated_tapeLit.lua / rotatedTape.lua
function _G.drawRotatedScrollTape(img, angle, window, sx, sy, w, h, color)
    if not img then
        return
    end
    local rx, ry, rw, rh = tapeRect(img, window, sx, sy)
    sasl.gl.drawRotatedTexturePart(img, angle or 0, 0, 0, w, h, rx, ry, rw, rh, color or WHITE)
end

-- needle.lua / needleLit.lua: rotating needle, centred and aspect-preserved
-- inside the component area (the SASL2 body with 100 -> w/h).
function _G.drawNeedleTex(img, angle, w, h, color)
    if not img then
        return
    end
    local tw, th = texSize(img)
    local max = tw
    if th > max then
        max = th
    end
    local rw = (tw / max) * w
    local rh = (th / max) * h
    sasl.gl.drawRotatedTexture(img, angle or 0, (w - rw) / 2, (h - rh) / 2, rw, rh, color or WHITE)
end

-- digitstape.lua / digitstapeLit.lua / digitstapeSmoothLit.lua
--
-- The digit texture has DIGIT_STRIP_ROWS rows: digits 0-9 in the first ten, the
-- decimal point at row ROW_DECIMAL and the minus sign at ROW_SIGN. SASL2 used a
-- hard-coded normalised row height of 0.0714285714286 (= 1/14); here the row
-- height is derived in pixels from the texture, which is the same thing after
-- the pixel conversion.
--
-- `smooth` selects digitstapeSmoothLit's carry rule (a partially rolled higher
-- digit) instead of the plain "round up past 9.5" rule. Both bodies are copied
-- verbatim from the SASL2 widgets.
local DIGIT_STRIP_ROWS = 14
local ROW_DECIMAL = 12
local ROW_SIGN = 13

function _G.drawDigitStrip(img, overlayImg, value, digits, frac, allowNonRound,
                           valueEnabler, showLeadingZeros, showSign, w, h, color, smooth)
    if not img then
        return
    end
    color = color or WHITE

    local digitsNum = digits
    local symbolsNum = digitsNum
    if 0 < frac then
        symbolsNum = symbolsNum + 1
    end
    local digitWidth = w / symbolsNum

    local v = math.abs(value or 0) * (10 ^ frac)
    if allowNonRound then
        v = math.floor(v + 0.5)
    end
    local pos = w - digitWidth

    local tw, th = texSize(img)
    local digitHeight = th / DIGIT_STRIP_ROWS

    if 0 < frac then
        local y = (ROW_DECIMAL + 1) * digitHeight
        sasl.gl.drawTexturePart(img, pos - digitWidth * frac, 0, digitWidth, h,
            0, th - y - digitHeight, tw, digitHeight, color)
    end

    if valueEnabler then
        local prevDigit = 0
        if showSign then
            digitsNum = digitsNum - 1
        end
        for i = 1, digitsNum do
            local digit = v % 10
            if smooth then
                if i > 1 then
                    digit = math.floor(v % 10) + math.max(math.max((prevDigit - 9), 0), 0)
                end
            else
                if 9.5 < prevDigit then
                    digit = digit + 1
                end
            end
            prevDigit = digit
            v = math.floor(v / 10)
            local y = (10 - digit + 1) * digitHeight
            sasl.gl.drawTexturePart(img, pos, 0, digitWidth, h,
                0, th - y - digitHeight, tw, digitHeight, color)
            pos = pos - digitWidth
            if frac == i then
                pos = pos - digitWidth
            end
            if (i > frac) and (not showLeadingZeros) and (0 == v) then
                break
            end
        end
        if showSign and (0 > (value or 0)) then
            local y = (ROW_SIGN + 1) * digitHeight
            local srcY = th - y - digitHeight
            -- ROW_SIGN resolves to the 15th row of a 14-row strip, so srcY is
            -- negative and the rect falls off the bottom of the texture. None
            -- of the six digit strips actually carries a minus glyph (the last
            -- row holds the decimal point on white/yellow_digits and is blank
            -- on the bold/black/green ones), so there is nothing to sample:
            -- skip the draw rather than read outside the image. The gauges that
            -- need a minus draw it as their own texture -- see the minus_img
            -- widgets in vbe_altimeter.lua. The slot stays reserved either way,
            -- because showSign has already taken a digit off digitsNum.
            if srcY >= 0 then
                sasl.gl.drawTexturePart(img, pos, 0, digitWidth, h,
                    0, srcY, tw, digitHeight, color)
            end
        end
    end

    if overlayImg then
        sasl.gl.drawTexture(overlayImg, 0, 0, w, h, color)
    end
end

-- ---------------------------------------------------------------------------
-- Popup chrome: menu_button.lua (panels/panel_windows.lua). Drawn from
-- primitives rather than cropped from the old menus.png, so no texture-part
-- conversion is involved -- only the component extent.
-- ---------------------------------------------------------------------------

-- The font is resolved on first draw, not at include time: this file is
-- included before any component exists. rawget, not a bare FONT_HINTER_NATIVE:
-- see CLAUDE.md 14 (an unresolved global is handed to the component loader).
local UI_FONT_NAME = "Roboto-Regular.ttf"
local uiFont
local function getUIFont()
    if uiFont == nil then
        local hinter = rawget(_G, "FONT_HINTER_NATIVE")
        uiFont = (hinter and sasl.gl.loadFontHinted(UI_FONT_NAME, hinter))
            or sasl.gl.loadFont(UI_FONT_NAME) or false
    end
    return uiFont or nil
end

local CELL_BG = {0.05, 0.06, 0.07, 0.92}
local CELL_EDGE = {0.78, 0.80, 0.83, 1}
local CELL_FONT_MAX, CELL_FONT_MIN = 11, 7
local CAP_HEIGHT = 0.711 -- Roboto cap height, in em

-- menu_button.lua: a framed cell with a centred caption. "\n" in `label`
-- stacks lines ("CHK\nLST"). The size steps down from CELL_FONT_MAX until the
-- widest line fits, so a caption never runs into the frame. Edges are 1 px
-- rectangles on whole pixels rather than drawFrame, whose lines straddle the
-- boundary and lose half their width to the clip on the outer cells.
function _G.drawMenuCell(w, h, label, textCol)
    sasl.gl.drawRectangle(0, 0, w, h, CELL_BG)
    sasl.gl.drawRectangle(0, 0, w, 1, CELL_EDGE)
    sasl.gl.drawRectangle(0, h - 1, w, 1, CELL_EDGE)
    sasl.gl.drawRectangle(0, 0, 1, h, CELL_EDGE)
    sasl.gl.drawRectangle(w - 1, 0, 1, h, CELL_EDGE)

    local font = getUIFont()
    if not font or not label or label == "" then
        return
    end
    local lines = {}
    for s in string.gmatch(label, "[^\n]+") do
        lines[#lines + 1] = s
    end
    local n = #lines

    local fs = CELL_FONT_MAX
    while fs > CELL_FONT_MIN do
        local widest = 0
        for i = 1, n do
            local tw = sasl.gl.measureText(font, lines[i], fs, false, false)
            if tw > widest then
                widest = tw
            end
        end
        if widest <= w - 5 and n * (fs + 1) <= h - 4 then
            break
        end
        fs = fs - 1
    end

    -- drawText's y is a BASELINE: centre the block of cap heights, not the em
    -- boxes, so an all-caps caption sits optically in the middle.
    local pitch = fs + 1
    local capH = math.floor(fs * CAP_HEIGHT + 0.5)
    local base = math.floor((h - ((n - 1) * pitch + capH)) / 2)
    local cx = math.floor(w / 2)
    sasl.gl.setRenderTextPixelAligned(true)
    for i = 1, n do
        sasl.gl.drawText(font, cx, base + (n - i) * pitch, lines[i], fs,
            false, false, TEXT_ALIGN_CENTER, textCol)
    end
    sasl.gl.setRenderTextPixelAligned(false)
end
