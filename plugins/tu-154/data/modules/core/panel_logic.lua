--[[
  Floating-panel visibility and the Plugins-menu ticks. A contextWindow's
  visibility belongs to X-Plane, so each window is kept in step with its
  tu-154/panels/show_* dataref in both directions:

    - dataref changed (menu cell, Plugins menu, panel click, in-panel close
      cross) -> the window follows
    - window changed (X-Plane's own close button) -> the dataref follows
    - first frame: the window state (saved geometry/visibility) wins

  The tables below are filled by panels/panel_windows.lua. It runs in its own
  component environment, so it can only share state by mutating their fields.
--]]

drf_panels   = {}                 -- panel key -> visibility dataref
cw_panels    = {}                 -- panel key -> contextWindow
menu_strip   = { visible = true } -- the strip has no dataref; "MENU Panel" drives it
topbar_items = {}                 -- { menu, id, checked = fun():bool } per checkbox

-- rawget: a bare unresolved global is loaded as a component (CLAUDE.md §14)
local MENU_CHECKED_STATE   = rawget(_G, "MENU_CHECKED")
local MENU_UNCHECKED_STATE = rawget(_G, "MENU_UNCHECKED")

-- last seen dataref state per panel, used to tell which side changed
local last_state = {}

function updatePanels()
    for key, drf in pairs(drf_panels) do
        local win = cw_panels[key]
        if win then
            local drfV = get(drf) == 1
            local winV = win:isVisible()
            if last_state[key] == nil then
                -- first frame: the window state wins
                if winV ~= drfV then
                    set(drf, winV and 1 or 0)
                end
                last_state[key] = winV
            elseif drfV ~= last_state[key] then
                -- the dataref changed
                if winV ~= drfV then
                    win:setIsVisible(drfV)
                end
                last_state[key] = drfV
            elseif winV ~= drfV then
                -- the window changed
                set(drf, winV and 1 or 0)
                last_state[key] = winV
            end
        end
    end

    if cw_panels.menu and cw_panels.menu:isVisible() ~= menu_strip.visible then
        cw_panels.menu:setIsVisible(menu_strip.visible)
    end

    -- after the windows, so a tick shows this frame's state; written on change only
    for _, item in ipairs(topbar_items) do
        local checked = item.checked()
        if checked ~= item.shown then
            sasl.setMenuItemState(item.menu, item.id,
                checked and MENU_CHECKED_STATE or MENU_UNCHECKED_STATE)
            item.shown = checked
        end
    end
end
