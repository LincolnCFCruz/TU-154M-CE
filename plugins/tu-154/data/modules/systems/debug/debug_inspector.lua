-- ---------------------------------------------------------------------------
-- Tu-154M System Viewer / Debug Inspector -- the window (content:
-- debug_inspector_view.lua). A developer tool: it reads datarefs by name only,
-- creates none, and can be commented out of main.lua without consequence.
--
-- Toggled by the command below (bind a key to it) or the menu strip's DBG
-- cell, which is the only reason the handle is published as
-- cw_panels.inspector. There is no drf_panels entry, so updatePanels() never
-- touches it.
--
-- Fixed at 1180 x 740: any other client area scales the panel by a
-- non-integer factor and blurs every line and glyph (CLAUDE.md section 9).
-- The y is 121, not 120, so a geometry saved while the window was still
-- resizable no longer matches the declared position and is dropped.
-- ---------------------------------------------------------------------------

cw_panels.inspector = contextWindow {
    name = "debug_inspector",
    description = "Toggle Tu-154M System / Debug Inspector",
    command = "Tu-154/Debug/inspector",
    position = { 80, 121, 1180, 740 },
    noResize = true, -- a scaled window is a blurred window; see above
    proportional = true,
    saveState = true,
    noBackground = true, -- the view draws its own opaque background
    layer = SASL_CW_LAYER_FLOATING_WINDOWS,
    visible = false,
    components = {
        debug_inspector_view {
            position = { 0, 0, 1180, 740 }
        }
    }
}
