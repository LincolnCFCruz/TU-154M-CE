--[[
  Floating-panel visibility. A contextWindow's visibility belongs to X-Plane,
  so each window is kept in step with its tu-154/panels/show_* dataref in both
  directions, and X-Plane's own close button writes the dataref back instead
  of being overridden on the next frame:

    - dataref changed (menu button, 3D hotspot) -> the window follows
    - window changed  (decoration close button) -> the dataref follows
    - first frame: the window state (saved geometry/visibility) wins

  drf_panels / cw_panels are filled by panels/panel_windows.lua.
--]]

-- panel key -> visibility dataref handle (filled by panel_windows.lua)
drf_panels = {}

-- panel key -> contextWindow handle (filled by panel_windows.lua)
cw_panels = {}

-- The menu strip window has no dataref; the top bar's "MENU Panel" checkbox
-- drives it. A table, not a boolean: panel_windows.lua runs in its own
-- component environment, so it can only share state by mutating a field.
menu_strip = { visible = true }

-- last seen dataref state per panel, used to tell which side changed
local last_state = {}

function updatePanels()
    for key, drf in pairs(drf_panels) do
        local win = cw_panels[key]
        if win then
            local drfV = get(drf) == 1
            local winV = win:isVisible()
            if last_state[key] == nil then
                -- first frame: the window state (initial visible / saved state) wins
                if winV ~= drfV then
                    set(drf, winV and 1 or 0)
                end
                last_state[key] = winV
            elseif drfV ~= last_state[key] then
                -- dataref changed (menu button, 3D hotspot, close button)
                if winV ~= drfV then
                    win:setIsVisible(drfV)
                end
                last_state[key] = drfV
            elseif winV ~= drfV then
                -- window changed (decoration close button)
                set(drf, winV and 1 or 0)
                last_state[key] = winV
            end
        end
    end

    -- the menu strip window follows menu_strip.visible (see above)
    if cw_panels.menu and cw_panels.menu:isVisible() ~= menu_strip.visible then
        cw_panels.menu:setIsVisible(menu_strip.visible)
    end
end
