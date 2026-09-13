--[[
  All floating panels: ten content panels (one contextWindow each, paired with
  a tu-154/panels/show_* dataref; closing one writes the dataref back through
  core/panel_logic.lua) and one undecorated menu-strip window.

  X-Plane floating windows have a 100x100 minimum and the menu strips are
  31x30 .. 151x31, so all six strips share one fixed-size 181x160 window, each
  at its original screen offset. The cells are drawn in code (menu_button): a
  group cell lights while its strip is open, a panel cell while its panel shows.
  MISC's DBG cell toggles the debug inspector through cw_panels.inspector,
  resolved at click time because that component loads after this one.
--]]

-- ---------------------------------------------------------------------------
-- Datarefs (identical to the ones panels_2d.lua bound)
-- ---------------------------------------------------------------------------
defineProperty("window_height", globalPropertyi("sim/graphics/view/window_height"))

defineProperty("show_gns", globalPropertyi("tu-154/anim/show_gns"))
defineProperty("show_RXP", globalPropertyi("tu-154/anim/RXP"))
defineProperty("KLN90visible", globalPropertyi("tu-154/xap/KLN90/visible"))

-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster"))         -- 0 = plugin not found, 1 = slave, 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- 0 = plugin not found, 1 = no control, 2 = has control
defineProperty("control_thro_other", globalPropertyf("tu-154/SC/control_thro_other"))

-- Panel visibility datarefs, published to core/panel_logic.lua's updatePanels()
drf_panels.payload    = globalPropertyi("tu-154/panels/show_load_panel")
drf_panels.absu       = globalPropertyi("tu-154/panels/show_absu_panel")
drf_panels.ovhd       = globalPropertyi("tu-154/panels/show_ohvd_panel")
drf_panels.nvu        = globalPropertyi("tu-154/panels/show_nvu_panel")
drf_panels.checklist  = globalPropertyi("tu-154/panels/show_checklist_panel")
drf_panels.ground     = globalPropertyi("tu-154/panels/show_ground_panel")
drf_panels.uphone     = globalPropertyi("tu-154/panels/show_phone")
drf_panels.camera     = globalPropertyi("tu-154/panels/show_cam")
drf_panels.palette    = globalPropertyi("tu-154/panels/show_palette")
drf_panels.fails      = globalPropertyi("tu-154/panels/show_fail_panel")

-- set initial coefficient for float panel's size - make 'em smaller, if screen
-- resolution less then 1024 by height.  (unchanged from panels_2d.lua)
local coef = (get(window_height) / 1024) * 0.8
if coef > 1 then coef = 1 end

-- ---------------------------------------------------------------------------
-- Content panels
--
-- One declarative table + one loop, replacing ten near-identical subpanel{}
-- blocks. `w`/`h` are the SASL2 design sizes; the coef scaling is applied here
-- exactly as it was there.
-- ---------------------------------------------------------------------------
local panels = {
    { key = "palette",   name = "palette",           pos = {50,  50},  w = 251,  h = 305,  save = true  },
    { key = "payload",   name = "payload_panel",     pos = {50,  50},  w = 1024, h = 683,  save = true  },
    { key = "absu",      name = "absu_2d_panel",     pos = {50,  50},  w = 917,  h = 597,  save = true  },
    { key = "ovhd",      name = "ovhd_2d_panel",     pos = {50,  0},   w = 1458, h = 1013, save = true  },
    { key = "nvu",       name = "nvu_2D_panel",      pos = {50,  0},   w = 636,  h = 786,  save = true, background = true },
    { key = "checklist", name = "checklist_panel_2d",pos = {50,  50},  w = 240,  h = 850,  save = true  },
    { key = "ground",    name = "ground_srv_panel",  pos = {50,  50},  w = 655,  h = 880,  save = true  },
    { key = "uphone",    name = "uphone",            pos = {40,  20},  w = 241,  h = 446,  save = true  },
    { key = "camera",    name = "camera_panel",      pos = {50,  50},  w = 512,  h = 512,  save = true  },
    { key = "fails",     name = "fails_panel",       pos = {50, 100},  w = 512,  h = 700,  save = false },
}

-- child component constructor per panel (kept as a function so the component
-- loader resolves the name lazily, when the window is built)
local content = {
    palette   = function(w, h) return palette_2d          { position = {0, 0, w, h} } end,
    payload   = function(w, h) return load_panel          { position = {0, 0, w, h} } end,
    absu      = function(w, h) return absu_panel_2d       { position = {0, 0, w, h} } end,
    ovhd      = function(w, h) return overhead_2d         { position = {0, 0, w, h} } end,
    nvu       = function(w, h) return nvu_panel_2d        { position = {0, 0, w, h} } end,
    checklist = function(w, h) return checklist_panel_2d  { position = {0, 0, w, h} } end,
    ground    = function(w, h) return ground_panel        { position = {0, 0, w, h} } end,
    uphone    = function(w, h) return UPhone              { position = {0, 0, w, h} } end,
    camera    = function(w, h) return camera              { position = {0, 0, w, h} } end,
    fails     = function(w, h) return failures_2d         { position = {0, 0, w, h} } end,
}

for _, p in ipairs(panels) do
    local w, h = p.w * coef, p.h * coef

    cw_panels[p.key] = contextWindow {
        name         = p.name,
        position     = { p.pos[1], p.pos[2], w, h },
        proportional = true,
        saveState    = p.save,
        noBackground = not p.background,
        visible      = false,
        layer        = SASL_CW_LAYER_FLOATING_WINDOWS,
        components   = {
            content[p.key](w, h),
        },
    }
end

-- ---------------------------------------------------------------------------
-- Menu strips
--
-- Merged into one transparent, undecorated window whose origin is the former
-- ext_menu/misc_menu origin (0, 510). Every strip below therefore uses its
-- ORIGINAL screen position minus (0, 510); the comment on each block gives the
-- SASL2 subpanel rect it came from. Cells are 31 px on a 30 px pitch, so
-- neighbours share their 1 px edge, as they did in menus.png.
-- ---------------------------------------------------------------------------
local MENU_X, MENU_Y = 0, 510
local MENU_W, MENU_H = 181, 160 -- the MISC strip's fifth cell ends at x = 181

local main_menu_ext = false
local nav_ext  = false
local serv_ext = false
local misc_ext = false

local function navVisible()  return main_menu_ext and nav_ext  end
local function servVisible() return main_menu_ext and serv_ext end
local function miscVisible() return main_menu_ext and misc_ext end
local function extVisible()  return main_menu_ext end
local function throVisible() return get(ismaster) > 0 end

local function lit(b) return b and "on" or "off" end

-- a cell that opens one of the content panels above: toggles its dataref and
-- lights while it is showing
local function panelCell(key, x, y, label, visible)
    return menu_button {
        position = { x, y, 31, 31 },
        label    = label,
        visible  = visible,
        state    = function() return lit(get(drf_panels[key]) == 1) end,
        onMouseDown = function()
            set(drf_panels[key], 1 - get(drf_panels[key]))
            return true
        end,
    }
end

-- a group cell in the ext column: toggles its strip
local function groupCell(y, label, isOpen, toggle)
    return menu_button {
        position = { 0, y, 31, 30 },
        label    = label,
        visible  = extVisible,
        state    = function() return lit(isOpen()) end,
        onMouseDown = function() toggle(); return true end,
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

        -- thro_button -- was subpanel { 0, 640, 31, 30 }. Red and green are the
        -- two art states; any other SmartCopilot combination drew nothing and
        -- still took the click, and that is kept.
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

        -- main_menu -- was subpanel { 0, 600, 31, 30 } (always visible)
        menu_button {
            position = { 0, 90, 31, 30 },
            label    = "MENU",
            state    = function() return lit(main_menu_ext) end,
            onMouseDown = function()
                main_menu_ext = not main_menu_ext
                return true
            end,
        },

        -- ext_menu -- was subpanel { 0, 510, 31, 90 }
        groupCell(60, "NAV",  function() return nav_ext  end, function() nav_ext  = not nav_ext  end),
        groupCell(30, "SERV", function() return serv_ext end, function() serv_ext = not serv_ext end),
        groupCell(0,  "MISC", function() return misc_ext end, function() misc_ext = not misc_ext end),

        -- nav_menu -- was subpanel { 30, 570, 121, 31 }
        panelCell("nvu",  30, 60, "NVU",  navVisible),
        panelCell("absu", 60, 60, "ABSU", navVisible),
        panelCell("ovhd", 90, 60, "OVHD", navVisible),
        menu_button { -- GPS: the KLN90B window, or the GNS popup when that is fitted
            position = { 120, 60, 31, 31 },
            label    = "GPS",
            visible  = navVisible,
            state    = function()
                return lit(get(show_gns) == 0 and get(KLN90visible) == 1)
            end,
            onMouseDown = function()
                if get(show_gns) == 1 then      -- GNS
                    commandOnce(findCommand("sim/GPS/g430n1_popup"))
                    set(KLN90visible, 0)
                elseif get(show_gns) == 0 then  -- KLN
                    set(KLN90visible, 1 - get(KLN90visible))
                else set(KLN90visible, 0)       -- RNX
                end
                return true
            end,
        },

        -- serv_menu -- was subpanel { 30, 540, 61, 31 }
        panelCell("payload", 30, 30, "LOAD", servVisible),
        panelCell("ground",  60, 30, "GND",  servVisible),

        -- misc_menu -- was subpanel { 30, 510, 121, 31 }, plus the DBG cell
        panelCell("camera",    30, 0, "CAM",      miscVisible),
        panelCell("uphone",    60, 0, "PHON",     miscVisible),
        panelCell("checklist", 90, 0, "CHK\nLST", miscVisible),
        panelCell("palette",  120, 0, "TAB",      miscVisible),
        menu_button { -- debug inspector (systems/debug/debug_inspector.lua)
            position = { 150, 0, 31, 31 },
            label    = "DBG",
            visible  = miscVisible,
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
-- X-Plane top bar menu
--
-- One "Tu-154M" submenu under Plugins, mirroring the menu strip: each panel
-- item flips the same tu-154/panels/show_* dataref a menu-strip cell does, and
-- "MENU Panel" flips menu_strip.visible (core/panel_logic.lua). Every item is a
-- checkbox; updateTopBarMenu(), called from main.lua's update(), keeps the
-- ticks in step with whichever side changed the state.
-- ---------------------------------------------------------------------------
local topbar_labels = {
    palette   = "Tab Palette",
    payload   = "Payload",
    absu      = "ABSU",
    ovhd      = "Overhead",
    nvu       = "NVU",
    checklist = "Checklist",
    ground    = "Ground Service",
    uphone    = "Interphone",
    camera    = "Camera",
    fails     = "Failures",
}

local topbar_menu_item = sasl.appendMenuItem(PLUGINS_MENU_ID, "Tu-154M")
local topbar_menu      = sasl.createMenu("", PLUGINS_MENU_ID, topbar_menu_item)
local topbar_items     = {} -- { {id = menuItemID, checked = fun():bool}, ... }

for _, p in ipairs(panels) do
    local key = p.key
    local id = sasl.appendMenuItem(topbar_menu, topbar_labels[key], function()
        set(drf_panels[key], 1 - get(drf_panels[key]))
    end)
    topbar_items[#topbar_items + 1] = {
        id      = id,
        checked = function() return get(drf_panels[key]) == 1 end,
    }
end

sasl.appendMenuSeparator(topbar_menu)

local menu_strip_menu_id = sasl.appendMenuItem(topbar_menu, "MENU Panel", function()
    -- menu_strip is a table (core/panel_logic.lua), so this mutates the same
    -- one updatePanels() reads, exactly like drf_panels/cw_panels elsewhere --
    -- see the comment above menu_strip's declaration for why it isn't a bare
    -- boolean
    menu_strip.visible = not menu_strip.visible
end)
topbar_items[#topbar_items + 1] = {
    id      = menu_strip_menu_id,
    checked = function() return menu_strip.visible end,
}

-- MENU_CHECKED/MENU_UNCHECKED, looked up once via rawget rather than referenced
-- bare: a bare unresolved global inside a component is handed to the component
-- loader and logs "can't load component MENU_UNCHECKED" -- the same trap
-- FONT_HINTER_NATIVE hits in the debug inspector (see CLAUDE.md, SASL3 API traps)
local MENU_CHECKED_STATE   = rawget(_G, "MENU_CHECKED")
local MENU_UNCHECKED_STATE = rawget(_G, "MENU_UNCHECKED")

-- published on _G (see glbl_func.lua) so main.lua's update() can call it --
-- a plain top-level declaration here would stay private to this component
function _G.updateTopBarMenu()
    for _, item in ipairs(topbar_items) do
        sasl.setMenuItemState(topbar_menu, item.id, item.checked() and MENU_CHECKED_STATE or MENU_UNCHECKED_STATE)
    end
end
