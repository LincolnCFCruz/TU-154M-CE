--main.lua
size = {210, 110}
sasl.logInfo("THIS IS KLN90B V0.99.2B:  https://forums.x-plane.org/index.php?/files/file/55881-kln90bmd41-for-x-plane-1112/")

sasl.options.setAircraftPanelRendering(true)
sasl.options.set3DRendering(false)
sasl.options.setInteractivity(false)

-- Tu-154M: draw the panel in separate lit and non-lit passes, as the aircraft's
-- own plugin does. The default mode is a single pass into the day layer of the
-- panel texture only, so nothing reached the emissive layer and the 3D screen
-- never lit up at night (the 2D windows are unaffected -- they ignore cockpit
-- lighting). KLN90_panel, KLN90_bezel and KLN90_screen pick their pass with
-- isLitStage / isNonLitStage.
sasl.options.setRenderingMode2D(SASL_RENDER_2D_MULTIPASS)

-- Tu-154M: render the display into an offscreen target instead of drawing it
-- straight onto the panel texture.
--
-- With draw3d = true, KLN90_panel draws the screen at its panel rect and then
-- copies that rect back into `display` with getTargetTextureData() for the 2D
-- windows -- which only lines up while the panel rect is exactly the unit's
-- native 210x110. The An-24's cut-out is; the Tu-154's is 479.6 x 224.6, scaled
-- up from the same design. Rendering to the target and blitting it
-- (KLN90_screen.lua) keeps the 3D screen and the 2D windows correct at any size.
draw3d = false
roll_rate = 8 --autopilot constant in degree per second. Have to find a way to extract it from acf file.

addSearchPath(sasl.getXPlanePath ().."/Resources/bitmaps/interface")
addSearchPath(sasl.getXPlanePath ().."/Resources/bitmaps/interface11")

if draw3d == true then
display  = sasl.gl.createTexture(size[1], size[2])
else
display = sasl.gl.createRenderTarget(size[1], size[2])
end

local popout_img = sasl.gl.loadImage("floating_window@1.5x.png", 27, 0, 28, 28)
local close_img = sasl.gl.loadImage("floating_window@1.5x.png", 0, 28, 26, 26)
local hide_ui_kln = true
local hide_ui_md = true

-- ---------------------------------------------------------------------------
-- Tu-154M integration
-- ---------------------------------------------------------------------------
-- The Tu-154 drives this GPS from its own menu strip and 3D hotspots through
-- the tu-154/xap/... datarefs its previous KLN module used to own. Those
-- names are part of the aircraft's frozen dataref contract
-- (panels/panel_windows.lua toggles KLN90/visible, systems/warnings/misc_lamps
-- reads MSG and WPT, smartcopilot.cfg syncs them), so they are created here now
-- that the module that used to create them is gone.
local tu154_kln_visible = createGlobalPropertyi("tu-154/xap/KLN90/visible", 0)
local tu154_pop_visible = createGlobalPropertyi("tu-154/xap/KLN90pop/visible", 0)
local tu154_md41_visible = createGlobalPropertyi("tu-154/xap/MD41/visible", 0)
createGlobalPropertyi("tu-154/xap/KLN90/MSG", 0) -- MSG lamp, written by KLN90_panel.lua
createGlobalPropertyi("tu-154/xap/KLN90/WPT", 0) -- WPT lamp, written by KLN90_panel.lua

-- Where the unit sits on the Tu-154's 2048x2048 panel texture. Both rects are
-- the ones the aircraft's previous KLN module used, so the 3D cockpit is
-- unchanged: the unit occupied {1018, 506, 1029, 329} in a 457 x 146.5 design
-- space, with the display at {122, 33, 213, 100} inside it.
local TU154_UNIT = {1018, 506, 1029, 329}
local SX = TU154_UNIT[3] / 457      -- panel pixels per design unit, x
local SY = TU154_UNIT[4] / 146.5    -- ... y
local TU154_SCREEN = {
    TU154_UNIT[1] + 122 * SX,
    TU154_UNIT[2] + 33 * SY,
    213 * SX,
    100 * SY,
}

-- Shared between KLN90_panel (which fills it with drawDisplay, the function that
-- draws the display in its native 210 x 110 space) and KLN90_screen (which calls
-- it in the lit pass). A component cannot see another component's locals.
tu154_kln = {}

components = {
   -- Renders the display into the `display` target (draws nothing on the panel
   -- itself, so its rect only needs to be 1:1 with the target). Kept first so
   -- the target is fresh before KLN90_screen blits it.
   KLN90_panel {
         position = { 0, 0, size[1], size[2]}
   },
   -- The unit face and its screen, at the Tu-154's original 3D panel geometry.
   KLN90_bezel {
         position = TU154_UNIT
   },
   KLN90_screen {
         position = TU154_SCREEN
   },
}


KLN90B = contextWindow {
    name      = "KLN90B",
    position    = {50, 50, 898, 296},
    minimumSize = {898/2, 296/2},
    maximumSize = {898*2, 296*2},
    noDecore = false,
	customDecore = true,
    resizeMode = SASL_CW_RESIZE_RIGHT_BOTTOM, 
	proportional = true,
    visible     = false,
	savePosition = true,  
	saveState = true,
        components = {
            KLN90_2D {
                position    = {0, 0, 898, 296}
            }
          },
	decoration = {
		headerHeight = 0 ,
			
			 main = {
				draw = function(w, h)-- draw  window  header...
					if hide_ui_kln == false then
					sasl.gl.drawTexture(popout_img, w-20, h-20, 20, 20, {1, 1, 1})
					sasl.gl.drawTexture(close_img, 0, h-20, 20, 20, {1, 1, 1})
					end
				end, 
				
				onMouseMove = function(x, y, w, h)
					if y > h - 20 and y < h and KLN90B:isPoppedOut() == false then
						hide_ui_kln = false
					else
						hide_ui_kln = true
					end
					
				end ,
				
				onMouseDown = function(x, y, w, h, button)
					if  KLN90B:isPoppedOut() == false and button == MB_LEFT then
						if y > h - 20 then
							if x > w - 20 then
								KLN90B:setMode(SASL_CW_MODE_POPOUT)
							elseif x < 20 then
								KLN90B:setIsVisible(false)
							end
						end	
						
						
					end

				end ,				
				
			}
	}	
}

KLN90B_DISPLAY = contextWindow {
    name      = "KLN90B_DISPLAY",
    position    = {512, 512, size[1], size[2]},
    minimumSize = {size[1], size[2]},
    maximumSize = {size[1]*4, size[2]*4},
    noDecore = false,
	customDecore = true,
    resizeMode = SASL_CW_RESIZE_RIGHT_BOTTOM, 
	proportional = true,
    visible     = false,
	savePosition = true,  
	saveState = true,
        components = {
            KLN90_2D_display {
                position    = {0, 0, size[1], size[2]}
            }
          },
	decoration = {
		headerHeight = 0 ,
			
			 main = {
				draw = function(w, h)-- draw  window  header...
					if hide_ui_kln == false then
					sasl.gl.drawTexture(popout_img, w-20, h-20, 20, 20)
					sasl.gl.drawTexture(close_img, 0, h-20, 20, 20)
					end
				end, 
				
				onMouseMove = function(x, y, w, h)
					if y > h - 20 and y < h and KLN90B_DISPLAY:isPoppedOut() == false then
						hide_ui_kln = false
					else
						hide_ui_kln = true
					end
					
				end ,
				
				onMouseDown = function(x, y, w, h, button)
					if  KLN90B_DISPLAY:isPoppedOut() == false and button == MB_LEFT then
						if y > h - 20 then
							if x > w - 20 then
								KLN90B_DISPLAY:setMode(SASL_CW_MODE_POPOUT)
							elseif x < 20 then
								KLN90B_DISPLAY:setIsVisible(false)
							end
						end	
						
						
					end

				end ,				
				
			}
	}	
}

MD41 = contextWindow {
    name      = "MD41",
    position    = {500, 505, 411, 152},
    savePosition = true,
    minimumSize = {411/2, 152/2},
    maximumSize = {411*2, 152*2},
    noDecore = false,
	customDecore = true,
    resizeMode = SASL_CW_RESIZE_RIGHT_BOTTOM, 
	proportional = true,
    visible     = false,
	saveState = true,
        components = {
            MD41_2D {
                position    = {0, 0, 411, 152}
            }
          },
	decoration = {
		headerHeight = 0 ,
			
			 main = {
				draw = function(w, h)-- draw  window  header...
					if hide_ui_md == false then
					sasl.gl.drawTexture(popout_img, w-20, h-20, 20, 20)
					sasl.gl.drawTexture(close_img, 0, h-20, 20, 20)
					end
				end, 
				
				onMouseMove = function(x, y, w, h)
					if y > h - 20 and y < h and MD41:isPoppedOut() == false then
						hide_ui_md = false
					else
						hide_ui_md = true
					end
					
				end ,
				
				onMouseDown = function(x, y, w, h, button)
					if  MD41:isPoppedOut() == false and button == MB_LEFT then
						if y > h - 20 then
							if x > w - 20 then
								MD41:setMode(SASL_CW_MODE_POPOUT)
							elseif x < 20 then
								MD41:setIsVisible(false)
							end
						end					
					end

				end ,				
				
			}
	}	
}

KLNPanel = contextWindow {
  name = "KLN popup panel",
  position = { 0, 150, 64, 64 },
  savePosition = true,
  noBackground = true,
  noDecore = true,
  layer = SASL_CW_LAYER_FLIGHT_OVERLAY,
  noClose = true,
  noMove = false,
  visible = false,
  noResize = true,
  components = {
    KLNpopup_panel {
      position = { 0 , 0 , 64, 64 },
    }
  }
}

KLNc_command = sasl.createCommand("custom/KLN90/Toggle_KLN_90B_Panel", "KLN90visible")
function KLNc_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
  if 0 == phase then
    if KLN90B:isVisible () then
      KLN90B:setIsVisible(false)
    else
      KLN90B:setIsVisible(true)
    end
  end
  return false
end
sasl.registerCommandHandler(KLNc_command, 0, KLNc_handler)

KLNDISPc_command = sasl.createCommand("custom/KLN90/Toggle_KLN_90B_Display", "KLN90DISPLAYvisible")
function KLNDISPc_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
  if 0 == phase then
    if KLN90B_DISPLAY:isVisible () then
      KLN90B_DISPLAY:setIsVisible(false)
    else
      KLN90B_DISPLAY:setIsVisible(true)
    end
  end
  return false
end
sasl.registerCommandHandler(KLNDISPc_command, 0, KLNDISPc_handler)

MD41c_command = sasl.createCommand("custom/KLN90/Toggle_MD41_Panel", "MD41visible")
function MD41c_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
  if 0 == phase then
    if MD41:isVisible () then
      MD41:setIsVisible(false)
    else
      MD41:setIsVisible(true)
    end
  end
  return 0
end
sasl.registerCommandHandler(MD41c_command, 0, MD41c_handler)


-- Tu-154M: the aircraft's previous KLN module published a command for the small
-- floating popup button too (xap/KLN90/Toggle_Popup_Panel). Recreated here under
-- this plugin's prefix so every command the old unit offered still exists.
KLNPOPc_command = sasl.createCommand("custom/KLN90/Toggle_Popup_Panel", "KLN90 popup panel")
function KLNPOPc_handler(phase)
  if 0 == phase then
    KLNPanel:setIsVisible(not KLNPanel:isVisible())
  end
  return false
end
sasl.registerCommandHandler(KLNPOPc_command, 0, KLNPOPc_handler)

menu_master = sasl.appendMenuItem (PLUGINS_MENU_ID, "KLN90B/MD41" )
menu_main = sasl.createMenu ("", PLUGINS_MENU_ID, menu_master)
menu_option = sasl.appendMenuItem(menu_main, "Toggle KLN90B Window", function() 
                                                                        KLN90B:setIsVisible(not KLN90B:isVisible ())
                                                                        return false
                                                                        end)
menu_option = sasl.appendMenuItem(menu_main, "Toggle KLN90B Display Only", function() 
                                                                        KLN90B_DISPLAY:setIsVisible(not KLN90B_DISPLAY:isVisible ())
                                                                        return false
                                                                        end)
menu_option = sasl.appendMenuItem(menu_main, "Toggle MD41 Window", function() 
                                                                        MD41:setIsVisible(not MD41:isVisible ())
                                                                        return false
                                                                        end)
menu_option = sasl.appendMenuItem(menu_main, "Toggle KLN popup panel", function() 
                                                                        KLNPanel:setIsVisible(not KLNPanel:isVisible ())
                                                                        return false
                                                                        end)


-- ---------------------------------------------------------------------------
-- Tu-154M: keep the aircraft's panel datarefs and these windows in sync.
--
-- Same bidirectional rule as the aircraft's own core/panel_logic.lua: a dataref
-- change (menu strip, 3D hotspot) moves the window, a window change (its close
-- button, the commands and menu items above) writes the dataref back, and on
-- the first frame the window state wins.
-- ---------------------------------------------------------------------------
local last_vis = {}

local function syncWindow(key, drf, win)
    if drf == nil or win == nil then return end
    local drfV = get(drf) == 1
    local winV = win:isVisible()
    if last_vis[key] == nil then
        if winV ~= drfV then set(drf, winV and 1 or 0) end
        last_vis[key] = winV
    elseif drfV ~= last_vis[key] then
        if winV ~= drfV then win:setIsVisible(drfV) end
        last_vis[key] = drfV
    elseif winV ~= drfV then
        set(drf, winV and 1 or 0)
        last_vis[key] = winV
    end
end

function update()
    updateAll(components)
    syncWindow("kln", tu154_kln_visible, KLN90B)
    syncWindow("pop", tu154_pop_visible, KLNPanel)
    syncWindow("md41", tu154_md41_visible, MD41)
end
