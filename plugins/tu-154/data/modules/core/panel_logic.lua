--[[

  File: panel_logic.lua
  -----
  Floating-panel visibility logic (port of the update() half of the former
  "Custom Avionics/panels_2d/panels_2d.lua").

  SASL2 -> SASL3
  --------------
  Under SASL2 the popups were subpanel{} components living in the `popups`
  layer, and panels_2d's update() simply assigned `<panel>.visible = <dataref>`
  every frame. SASL3 renders that layer only for 2D-panel aircraft, so the
  popups became contextWindows (see panels/panel_windows.lua).

  A contextWindow's visibility is not a plain property -- it is owned by
  X-Plane and changed with win:setIsVisible(). The sync below is therefore
  bidirectional, so that the X-Plane window decoration's own close button
  writes the dataref back instead of being overridden on the next frame:

    - dataref changed (menu button, 3D hotspot) -> the window follows
    - window changed  (decoration close button) -> the dataref follows
    - first frame: the window state (saved geometry/visibility) wins

  The visible *value* seen by the rest of the aircraft is unchanged: the same
  tu-154/panels/* datarefs drive the same panels.

  drf_panels / cw_panels are filled by panels/panel_windows.lua, which runs
  AFTER the components table in main.lua -- the datarefs it binds are created
  by dataref_creator_2 {} and by KLN90 {}.

--]]

-- panel key -> visibility dataref handle (filled by panel_windows.lua)
drf_panels = {}

-- panel key -> contextWindow handle (filled by panel_windows.lua)
cw_panels = {}

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

    -- the menu strip window has no dataref: it is always on, exactly as
    -- `main_menu.visible = true` was in panels_2d.lua's update()
    if cw_panels.menu and not cw_panels.menu:isVisible() then
        cw_panels.menu:setIsVisible(true)
    end
end
