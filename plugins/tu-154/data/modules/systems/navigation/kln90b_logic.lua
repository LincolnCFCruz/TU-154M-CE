--[[

  File: kln90b_logic.lua
  -----
  Aircraft side of the KLN90B / MD41 GPS.

  The unit itself is a separate SASL3 plugin, plugins/kln90b (the same build the
  An-24RV-CE ships, v0.99.2b). It replaced the in-tree systems/navigation/KLN90
  module, which was the SASL2-era port of a much older revision of the same
  codebase -- see CLAUDE.md section 10a.

  Everything crosses the plugin boundary as datarefs. This module owns the two
  inputs the unit needs; the unit itself writes the Tu-154 outputs the PNP, the
  ABSU, the annunciator panel and the 3D knobs read (the "Tu-154M outputs" block
  in plugins/kln90b/.../KLN90_panel.lua).

      tu-154/kln90/power_available   <- written here: KLN switch + 27 V bus
      tu-154/kln90/primary           <- written here: KLN is the selected GPS
      tu-154/kln90/initialized       <- read here: the plugin is alive

  All three are CREATED by the kln90b plugin, because X-Plane may load it after
  this one. They resolve through core/glbl_func.lua's late-binding wrapper, so
  if the plugin is missing or disabled these writes go nowhere, the unit's
  outputs stay 0 and the PNP simply shows its KLN flag -- which is exactly what
  the old systems/navigation/KLN_disable drop-in used to arrange by hand.

--]]

-- Inputs from the aircraft -----------------------------------------------
defineProperty("kln_on", globalPropertyi("tu-154/switchers/ovhd/kln_on"))          -- KLN switch
defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left"))  -- 27 V bus voltage
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right"))
defineProperty("show_gns", globalPropertyi("tu-154/anim/show_gns"))                -- 0 = KLN, 1 = GNS, 2 = RealityXP

-- Interface to the kln90b plugin -----------------------------------------
defineProperty("kln_power_available", globalPropertyi("tu-154/kln90/power_available"))
defineProperty("kln_primary", globalPropertyi("tu-154/kln90/primary"))

function update()
    -- Same rule the GNS430 uses (systems/navigation/gns430.lua): the overhead
    -- KLN switch on, and at least one 27 V bus alive.
    local powered = get(kln_on) == 1 and
                        (get(bus27_volt_left) > 13 or get(bus27_volt_right) > 13)
    set(kln_power_available, powered and 1 or 0)

    -- The unit takes over X-Plane's GPS (override_gps) only while it is the
    -- selected source on the PNP; with GNS or RealityXP selected it stands down
    -- and leaves the gps_* datarefs to them. This reproduces the old module's
    -- `if get(show_gns) == 0 then set(overrideGPS, 1) end`.
    set(kln_primary, get(show_gns) == 0 and 1 or 0)
end
