--[[

  File: panel_windows.lua
  -----
  All floating panels of the Tu-154M, ported from the subpanel{} declarations in
  the former "Custom Avionics/panels_2d/panels_2d.lua".

  SASL2 -> SASL3
  --------------
  subpanel{} still exists in SASL3 but is deprecated, and its `popups` layer is
  only rendered for 2D-panel projects -- this aircraft is 3D-cockpit only
  (panel2d = false), so the popups would never be drawn. Each subpanel is
  therefore a contextWindow here. Sizes, positions, child components and the
  driving tu-154/panels/* datarefs are unchanged.

  Two consequences of that swap, both unavoidable:

  * The content panels now carry X-Plane's own window decoration (title bar +
    close button) instead of SASL2's in-texture close cross and drag/resize
    corner. The decorative close cross that each panel drew is kept, so the art
    is unchanged. Closing through the decoration writes the panel dataref back
    (see core/panel_logic.lua).

  * SASL3/XP12 floating windows have a 100x100 minimum, and the six menu strips
    are 31x30 .. 121x31. They are therefore merged into ONE 160x160 undecorated,
    transparent window at the same screen origin, with every strip placed at its
    original screen offset inside it. Geometry on screen is identical; each
    strip keeps its own visibility expression, now on the child components.

  Panel order below follows panels_2d.lua.

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

defineProperty("closeImage", loadImage("close.png")) -- close cross image

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
    -- the uphone drew a coef-scaled close cross; every other panel a fixed 15px one
    local cw, ch = 15, 15
    if p.key == "uphone" then cw, ch = 16 * coef, 16 * coef end

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
            textureLit {
                position = { w - cw, h - ch, cw, ch },
                image    = get(closeImage),
            },
        },
    }
end

-- ---------------------------------------------------------------------------
-- Menu strips
--
-- Merged into one transparent, undecorated 160x160 window whose origin is the
-- former ext_menu/misc_menu origin (0, 510). Every strip below therefore uses
-- its ORIGINAL screen position minus (0, 510); the comment on each block gives
-- the SASL2 subpanel rect it came from.
--
-- Image crops: SASL2's loadImage() took the sub-rect with a TOP-LEFT origin,
-- SASL3 takes it BOTTOM-LEFT, so every y below is (256 - old_y - height) for
-- the 256x256 menus.png.
-- ---------------------------------------------------------------------------
local MENU_X, MENU_Y = 0, 510

defineProperty("menu_wt",      loadImage("menus.png", 0, 226, 31, 30)) -- was y=0
defineProperty("menu_gr",      loadImage("menus.png", 30, 226, 31, 30)) -- was y=0
defineProperty("menu_ex_wt",   loadImage("menus.png", 0, 136, 31, 90)) -- was y=30

defineProperty("nav_ext_gr",   loadImage("menus.png", 30, 196, 31, 30)) -- was y=30
defineProperty("serv_ext_gr",  loadImage("menus.png", 30, 166, 31, 30)) -- was y=60
defineProperty("misc_ext_gr",  loadImage("menus.png", 30, 136, 31, 30)) -- was y=90

defineProperty("nav_menu_wt",  loadImage("menus.png", 60, 196, 121, 31)) -- was y=29
defineProperty("serv_menu_wt", loadImage("menus.png", 60, 166, 61, 31)) -- was y=59
defineProperty("misc_menu_wt", loadImage("menus.png", 60, 136, 121, 31)) -- was y=89

defineProperty("thro_red",     loadImage("menus.png", 90, 226, 31, 30)) -- was y=0
defineProperty("thro_grn",     loadImage("menus.png", 120, 226, 31, 30)) -- was y=0

local main_menu_ext = false
local nav_ext  = false
local serv_ext = false
local misc_ext = false

local function navVisible()  return main_menu_ext and nav_ext  end
local function servVisible() return main_menu_ext and serv_ext end
local function miscVisible() return main_menu_ext and misc_ext end
local function extVisible()  return main_menu_ext end
local function throVisible() return get(ismaster) > 0 end

cw_panels.menu = contextWindow {
    name         = "tu154_menu",
    position     = { MENU_X, MENU_Y, 160, 160 },
    noDecore     = true,
    noBackground = true,
    noMove       = true,
    noResize     = true,
    proportional = false,
    visible      = true,
    layer        = SASL_CW_LAYER_FLOATING_WINDOWS,
    components   = {

        -- thro_button -- was subpanel { 0, 640, 31, 30 }
        textureLit {
            position = { 0, 130, 31, 30 },
            image    = get(thro_red),
            visible  = function()
                return throVisible() and
                    ((get(hascontrol_1) == 2 and get(control_thro_other) == 1) or
                     (get(hascontrol_1) == 1 and get(control_thro_other) == 0))
            end,
        },
        textureLit {
            position = { 0, 130, 31, 30 },
            image    = get(thro_grn),
            visible  = function()
                return throVisible() and
                    ((get(hascontrol_1) == 2 and get(control_thro_other) == 0) or
                     (get(hascontrol_1) == 1 and get(control_thro_other) == 1))
            end,
        },
        clickable {
            position = { 0, 130, 31, 30 },
            visible  = throVisible,
            onMouseDown = function()
                set(control_thro_other, 1 - get(control_thro_other))
                return true
            end,
        },

        -- main_menu -- was subpanel { 0, 600, 31, 30 } (always visible)
        textureLit {
            position = { 0, 90, 31, 30 },
            image    = get(menu_wt),
        },
        textureLit {
            position = { 0, 90, 31, 30 },
            image    = get(menu_gr),
            visible  = function() return main_menu_ext end,
        },
        clickable {
            position = { 0, 90, 31, 30 },
            onMouseDown = function()
                main_menu_ext = not main_menu_ext
                return true
            end,
        },

        -- ext_menu -- was subpanel { 0, 510, 31, 90 }
        textureLit {
            position = { 0, 0, 31, 90 },
            image    = get(menu_ex_wt),
            visible  = extVisible,
        },
        textureLit {
            position = { 0, 60, 31, 30 },
            image    = get(nav_ext_gr),
            visible  = function() return main_menu_ext and nav_ext end,
        },
        textureLit {
            position = { 0, 30, 31, 30 },
            image    = get(serv_ext_gr),
            visible  = function() return main_menu_ext and serv_ext end,
        },
        textureLit {
            position = { 0, 0, 31, 30 },
            image    = get(misc_ext_gr),
            visible  = function() return main_menu_ext and misc_ext end,
        },
        clickable {
            position = { 0, 60, 31, 30 },
            visible  = extVisible,
            onMouseDown = function() nav_ext = not nav_ext; return true end,
        },
        clickable {
            position = { 0, 30, 31, 30 },
            visible  = extVisible,
            onMouseDown = function() serv_ext = not serv_ext; return true end,
        },
        clickable {
            position = { 0, 0, 31, 30 },
            visible  = extVisible,
            onMouseDown = function() misc_ext = not misc_ext; return true end,
        },

        -- nav_menu -- was subpanel { 30, 570, 121, 31 }
        textureLit {
            position = { 30, 60, 121, 31 },
            image    = get(nav_menu_wt),
            visible  = navVisible,
        },
        clickable { -- KLN
            position = { 120, 60, 31, 31 },
            visible  = navVisible,
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
        clickable { -- OVHD
            position = { 90, 60, 31, 31 },
            visible  = navVisible,
            onMouseDown = function()
                set(drf_panels.ovhd, 1 - get(drf_panels.ovhd))
                return true
            end,
        },
        clickable { -- ABSU
            position = { 60, 60, 31, 31 },
            visible  = navVisible,
            onMouseDown = function()
                set(drf_panels.absu, 1 - get(drf_panels.absu))
                return true
            end,
        },
        clickable { -- NVU
            position = { 30, 60, 31, 31 },
            visible  = navVisible,
            onMouseDown = function()
                set(drf_panels.nvu, 1 - get(drf_panels.nvu))
                return true
            end,
        },

        -- serv_menu -- was subpanel { 30, 540, 61, 31 }
        textureLit {
            position = { 30, 30, 61, 31 },
            image    = get(serv_menu_wt),
            visible  = servVisible,
        },
        clickable {
            position = { 30, 30, 31, 31 },
            visible  = servVisible,
            onMouseDown = function()
                set(drf_panels.payload, 1 - get(drf_panels.payload))
                return true
            end,
        },
        clickable {
            position = { 60, 30, 31, 31 },
            visible  = servVisible,
            onMouseDown = function()
                set(drf_panels.ground, 1 - get(drf_panels.ground))
                return true
            end,
        },

        -- misc_menu -- was subpanel { 30, 510, 121, 31 }
        textureLit {
            position = { 30, 0, 121, 31 },
            image    = get(misc_menu_wt),
            visible  = miscVisible,
        },
        clickable {
            position = { 90, 0, 31, 31 },
            visible  = miscVisible,
            onMouseDown = function()
                set(drf_panels.checklist, 1 - get(drf_panels.checklist))
                return true
            end,
        },
        clickable {
            position = { 60, 0, 31, 31 },
            visible  = miscVisible,
            onMouseDown = function()
                set(drf_panels.uphone, 1 - get(drf_panels.uphone))
                return true
            end,
        },
        clickable {
            position = { 30, 0, 31, 31 },
            visible  = miscVisible,
            onMouseDown = function()
                set(drf_panels.camera, 1 - get(drf_panels.camera))
                return true
            end,
        },
        clickable {
            position = { 120, 0, 31, 31 },
            visible  = miscVisible,
            onMouseDown = function()
                set(drf_panels.palette, 1 - get(drf_panels.palette))
                return true
            end,
        },
    },
}
