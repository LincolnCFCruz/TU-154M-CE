--[[

  File: KLN90_bezel.lua
  -----
  Tu-154M only. Draws the KLN90B unit face on the aircraft's 3D panel texture.

  The An-24 has the bezel painted into its cockpit texture and only needs the
  display from this plugin. The Tu-154 does not: its previous KLN module drew
  the whole unit onto the panel texture, so the bezel has to come from here too.

  Geometry is exactly what that module used, so the unit lands where it always
  did in the 3D cockpit:
      design space 457 x 146.5, mapped by main.lua onto the panel rect
      {1018, 506, 1029, 329}
  and the art is the same crop of the same 1024x512 sheet (KLN90.png there,
  KLN90.dds here -- identical layout).

--]]

size = {457, 146.5}

local bg = sasl.gl.loadImage("KLN90.dds", 0, 219, 914, 293)

-- Non-lit stage only: the face is lit by the cockpit, it does not glow. Drawn in
-- the lit stage too, the whole grey bezel would be emissive at night.
function draw()
    if sasl.gl.isNonLitStage() then
        sasl.gl.drawTexture(bg, 0, 0, size[1], size[2])
    end
end
