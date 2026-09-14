--[[
  All floating panels: ten content panels (one contextWindow each, paired with
  a tu-154/panels/show_* dataref that core/panel_logic.lua keeps in step with
  the window), the menu-strip window, and the Plugins > Tu-154M menu.

  X-Plane floating windows have a 100x100 minimum and the menu strips are
  31x30 .. 151x31, so all six strips share one fixed-size 181x160 window.
  MISC's DBG cell toggles the debug inspector through cw_panels.inspector,
  resolved at click time because that component loads after this one.
--]]

defineProperty("window_height", globalPropertyi("sim/graphics/view/window_height"))

defineProperty("show_gns", globalPropertyi("tu-154/anim/show_gns")) -- 0 = KLN, 1 = GNS (or RealityXP)
defineProperty("KLN90visible", globalPropertyi("tu-154/xap/KLN90/visible"))

-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster"))         -- 0 = plugin not found, 1 = slave, 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- 0 = plugin not found, 1 = no control, 2 = has control
defineProperty("control_thro_other", globalPropertyf("tu-154/SC/control_thro_other"))

-- Initial panel scale: smaller on screens under 1024 px tall. It changes every
-- declared size, and a changed size discards each user's saved geometry.
local coef = (get(window_height) / 1024) * 0.8
if coef > 1 then coef = 1 end

local function togglePanel(key) set(drf_panels[key], 1 - get(drf_panels[key])) end
local function panelShown(key) return get(drf_panels[key]) == 1 end

-- ---------------------------------------------------------------------------
-- Content panels, one row each. The row order is the Plugins-menu order.
-- `name` is the key SASL saves window geometry under, and `dref` is part of
-- the dataref contract: never rename either.
-- ---------------------------------------------------------------------------
local panels = {
    { key = "palette", label = "Tab Palette", name = "palette",
      dref = "tu-154/panels/show_palette", pos = {50, 50}, w = 251, h = 305, save = true,
      content = function(pos) return palette_2d { position = pos } end },
    { key = "payload", label = "Payload", name = "payload_panel",
      dref = "tu-154/panels/show_load_panel", pos = {50, 50}, w = 1024, h = 683, save = true,
      content = function(pos) return load_panel { position = pos } end },
    { key = "absu", label = "ABSU", name = "absu_2d_panel",
      dref = "tu-154/panels/show_absu_panel", pos = {50, 50}, w = 917, h = 597, save = true,
      content = function(pos) return absu_panel_2d { position = pos } end },
    { key = "ovhd", label = "Overhead", name = "ovhd_2d_panel",
      dref = "tu-154/panels/show_ohvd_panel", pos = {50, 0}, w = 1458, h = 1013, save = true,
      content = function(pos) return overhead_2d { position = pos } end },
    { key = "nvu", label = "NVU", name = "nvu_2D_panel", background = true,
      dref = "tu-154/panels/show_nvu_panel", pos = {50, 0}, w = 636, h = 786, save = true,
      content = function(pos) return nvu_panel_2d { position = pos } end },
    { key = "checklist", label = "Checklist", name = "checklist_panel_2d",
      dref = "tu-154/panels/show_checklist_panel", pos = {50, 50}, w = 240, h = 850, save = true,
      content = function(pos) return checklist_panel_2d { position = pos } end },
    { key = "ground", label = "Ground Service", name = "ground_srv_panel",
      dref = "tu-154/panels/show_ground_panel", pos = {50, 50}, w = 655, h = 880, save = true,
      content = function(pos) return ground_panel { position = pos } end },
    { key = "uphone", label = "Interphone", name = "uphone",
      dref = "tu-154/panels/show_phone", pos = {40, 20}, w = 241, h = 446, save = true,
      content = function(pos) return UPhone { position = pos } end },
    { key = "camera", label = "Camera", name = "camera_panel",
      dref = "tu-154/panels/show_cam", pos = {50, 50}, w = 512, h = 512, save = true,
      content = function(pos) return camera { position = pos } end },
    -- ground_panel.lua shuts this every frame unless the aircraft is stopped on the ground
    { key = "fails", label = "Failures", name = "fails_panel",
      dref = "tu-154/panels/show_fail_panel", pos = {50, 100}, w = 512, h = 700, save = false,
      content = function(pos) return failures_2d { position = pos } end },
}

for _, p in ipairs(panels) do
    local w, h = p.w * coef, p.h * coef

    drf_panels[p.key] = globalPropertyi(p.dref)
    cw_panels[p.key] = contextWindow {
        name         = p.name,
        position     = { p.pos[1], p.pos[2], w, h },
        proportional = true,
        saveState    = p.save,
        noBackground = not p.background,
        visible      = false,
        layer        = SASL_CW_LAYER_FLOATING_WINDOWS,
        components   = {
            p.content({ 0, 0, w, h }),
        },
    }
end

-- ---------------------------------------------------------------------------
-- Menu strip: one transparent, undecorated window at the strips' old origin
-- (0, 510). Cell coordinates are their SASL2 screen positions minus (0, 510);
-- cells are 31 px on a 30 px pitch, so neighbours share their 1 px edge.
-- ---------------------------------------------------------------------------
local MENU_X, MENU_Y = 0, 510
local MENU_W, MENU_H = 181, 160 -- the MISC strip's fifth cell ends at x = 181

-- MENU opens the group column; a group's strip shows while both are open
local open = { menu = false, nav = false, serv = false, misc = false }

local function menuOpen() return open.menu end
local function stripShown(group)
    return function() return open.menu and open[group] end
end
local navShown, servShown, miscShown = stripShown("nav"), stripShown("serv"), stripShown("misc")

local function throVisible() return get(ismaster) > 0 end

local function lit(b) return b and "on" or "off" end

-- opens a content panel; lit while it is showing
local function panelCell(key, x, y, label, visible)
    return menu_button {
        position = { x, y, 31, 31 },
        label    = label,
        visible  = visible,
        state    = function() return lit(panelShown(key)) end,
        onMouseDown = function()
            togglePanel(key)
            return true
        end,
    }
end

-- a group cell in the MENU column; toggles its strip
local function groupCell(y, label, group)
    return menu_button {
        position = { 0, y, 31, 30 },
        label    = label,
        visible  = menuOpen,
        state    = function() return lit(open[group]) end,
        onMouseDown = function()
            open[group] = not open[group]
            return true
        end,
    }
end

cw_panels.menu = contextWindow {
    name         = "tu154_menu",
    position     = { MENU_X, MENU_Y, MENU_W, MENU_H },
    noDecore     = true,
    noBackground = true,
    noMove       = true,
    noResize     = true,
    proportional = false,
    visible      = true,
    layer        = SASL_CW_LAYER_FLOATING_WINDOWS,
    components   = {

        -- SmartCopilot throttle hand-over. Red and green are the two art
        -- states; any other combination draws nothing and still takes the click.
        menu_button {
            position = { 0, 130, 31, 30 },
            label    = "THRO",
            visible  = throVisible,
            state    = function()
                local hc, other = get(hascontrol_1), get(control_thro_other)
                if (hc == 2 and other == 1) or (hc == 1 and other == 0) then
                    return "alert"
                elseif (hc == 2 and other == 0) or (hc == 1 and other == 1) then
                    return "on"
                end
                return nil
            end,
            onMouseDown = function()
                set(control_thro_other, 1 - get(control_thro_other))
                return true
            end,
        },

        menu_button { -- always visible
            position = { 0, 90, 31, 30 },
            label    = "MENU",
            state    = function() return lit(open.menu) end,
            onMouseDown = function()
                open.menu = not open.menu
                return true
            end,
        },

        groupCell(60, "NAV",  "nav"),
        groupCell(30, "SERV", "serv"),
        groupCell(0,  "MISC", "misc"),

        -- NAV
        panelCell("nvu",  30, 60, "NVU",  navShown),
        panelCell("absu", 60, 60, "ABSU", navShown),
        panelCell("ovhd", 90, 60, "OVHD", navShown),
        menu_button { -- the KLN90B window, or the GNS popup when that is fitted
            position = { 120, 60, 31, 31 },
            label    = "GPS",
            visible  = navShown,
            state    = function()
                return lit(get(show_gns) == 0 and get(KLN90visible) == 1)
            end,
            onMouseDown = function()
                if get(show_gns) == 1 then      -- GNS
                    commandOnce(findCommand("sim/GPS/g430n1_popup"))
                    set(KLN90visible, 0)
                elseif get(show_gns) == 0 then  -- KLN
                    set(KLN90visible, 1 - get(KLN90visible))
                else                            -- no value this aircraft writes
                    set(KLN90visible, 0)
                end
                return true
            end,
        },

        -- SERV
        panelCell("payload", 30, 30, "LOAD", servShown),
        panelCell("ground",  60, 30, "GND",  servShown),

        -- MISC
        panelCell("camera",    30, 0, "CAM",      miscShown),
        panelCell("uphone",    60, 0, "PHON",     miscShown),
        panelCell("checklist", 90, 0, "CHK\nLST", miscShown),
        panelCell("palette",  120, 0, "TAB",      miscShown),
        menu_button { -- the debug inspector; grey when it is not loaded
            position = { 150, 0, 31, 31 },
            label    = "DBG",
            visible  = miscShown,
            state    = function()
                local win = cw_panels.inspector
                if not win then return "na" end
                return lit(win:isVisible())
            end,
            onMouseDown = function()
                local win = cw_panels.inspector
                if win then win:setIsVisible(not win:isVisible()) end
                return true
            end,
        },
    },
}

-- ---------------------------------------------------------------------------
-- Plugins > Tu-154M: a checkbox per content panel, then one for the strip.
-- core/panel_logic.lua's updatePanels() keeps the ticks in step.
-- ---------------------------------------------------------------------------
local topbar_menu_item = sasl.appendMenuItem(PLUGINS_MENU_ID, "Tu-154M")
local topbar_menu      = sasl.createMenu("", PLUGINS_MENU_ID, topbar_menu_item)

local function addCheckItem(label, onClick, checked)
    local id = sasl.appendMenuItem(topbar_menu, label, onClick)
    topbar_items[#topbar_items + 1] = { menu = topbar_menu, id = id, checked = checked }
end

for _, p in ipairs(panels) do
    local key = p.key
    addCheckItem(p.label,
        function() togglePanel(key) end,
        function() return panelShown(key) end)
end

sasl.appendMenuSeparator(topbar_menu)

addCheckItem("MENU Panel",
    function() menu_strip.visible = not menu_strip.visible end,
    function() return menu_strip.visible end)
