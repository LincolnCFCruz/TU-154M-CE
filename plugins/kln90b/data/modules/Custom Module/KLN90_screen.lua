--[[

  File: KLN90_screen.lua
  -----
  Tu-154M only. Puts the KLN90B display onto the aircraft's 3D panel texture.

  KLN90_panel.lua renders the display into the `display` render target (main.lua
  sets draw3d = false for this aircraft, see the note there). This component just
  blits that target into the screen cut-out of the bezel, so the 3D screen can be
  any size -- the Tu-154's is 479.6 x 224.6 on the panel texture, while the
  render target is the unit's native 210 x 110.

  Drawn in BOTH panel stages (main.lua sets SASL_RENDER_2D_MULTIPASS), but not
  the same way:
    - non-lit stage: blit the render target -- the daytime screen;
    - lit stage: draw the display STRAIGHT onto the panel (tu154_kln.drawDisplay,
      published by KLN90_panel) -- this is what glows at night. Blitting the
      render target in the lit stage reaches nothing emissive: verified in-sim
      2026-09-14, a rectangle drawn here in the lit stage glowed while the blit
      under it stayed dark.
  This component's size is the display's native 210 x 110, so drawDisplay's
  coordinates map onto the cut-out exactly as the blit does. Its own dimming is
  the unit's brightness knob (custom/KLN90/display_brughtness), which
  drawDisplay already applies to the text.

--]]

size = {210, 110}

function draw()
    if sasl.gl.isLitStage() and tu154_kln.drawDisplay then
        tu154_kln.drawDisplay()
    else
        sasl.gl.drawTexture(display, 0, 0, size[1], size[2])
    end
end
