--[[

  File: KLN90_screen.lua
  -----
  Tu-154M only. Puts the KLN90B display onto the aircraft's 3D panel texture.

  KLN90_panel.lua renders the display into the `display` render target (main.lua
  sets draw3d = false for this aircraft, see the note there). This component just
  blits that target into the screen cut-out of the bezel, so the 3D screen can be
  any size -- the Tu-154's is 479.6 x 224.6 on the panel texture, while the
  render target is the unit's native 210 x 110.

--]]

size = {210, 110}

function draw()
    sasl.gl.drawTexture(display, 0, 0, size[1], size[2])
end
