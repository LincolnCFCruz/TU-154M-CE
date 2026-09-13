-- Code-drawn menu cell for the menu strip in panels/panel_windows.lua: a framed
-- dark cell with a centred caption, replacing the crops of the old menus.png.
-- Draw body is drawMenuCell (core/glbl_draw.lua).
-- SASL3: the component extent is size[1] x size[2] (SASL2's implicit 100x100).
--
-- Mouse handlers (onMouseDown) come in as constructor arguments, exactly as
-- they do for clickable.
--
-- `state` picks the caption colour and may be a function:
--   "off"   white -- idle
--   "on"    green -- the group is expanded, or the panel it opens is showing
--   "alert" red   -- the THRO cell's "the other seat has the throttles"
--   "na"    grey  -- the target is not loaded (debug inspector commented out)
--   nil           -- draw nothing; the cell stays clickable (THRO's third state)

defineProperty("label", "")
defineProperty("state", "off")

local CAPTION = {
    off   = {0.93, 0.94, 0.96, 1},
    on    = {0.30, 0.95, 0.40, 1},
    alert = {1.00, 0.30, 0.25, 1},
    na    = {0.45, 0.47, 0.50, 1},
}

function draw(self)
    local s = get(state)
    if s == nil then
        return
    end
    drawMenuCell(size[1], size[2], get(label), CAPTION[s] or CAPTION.off)
end
