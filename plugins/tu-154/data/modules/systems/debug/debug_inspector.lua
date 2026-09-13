--[[

  File: debug_inspector.lua
  -----
  Tu-154M System Viewer / Debug Inspector -- standalone window registration.

  This is a self-contained developer tool. It is instantiated once from
  modules/main.lua (`debug_inspector {}`, right after `panel_windows {}`) and
  does nothing but create its own floating contextWindow. It deliberately does
  NOT register in cw_panels / core/panel_logic.lua and owns no
  tu-154/panels/show_* dataref: the contextWindow's `command` parameter
  auto-creates a bindable X-Plane command whose handler toggles the window's
  visibility (see init/initContextWindows.lua), and `saveState` keeps its
  position/size between sessions.

  The window is FIXED at 1180 x 740 (`noResize`), and that is not a
  convenience -- it is what keeps the panel sharp. initProcessing.lua draws a
  component with

      setComponentTransform(pos[1], pos[2], pos[3], pos[4], size[1], size[2])

  which maps the component's logical size onto whatever rectangle the window
  gives it. Any client area other than 1180 x 740 therefore SCALES the whole
  panel by a non-integer factor: every line and glyph is resampled (which is
  what "soft" or "low resolution" looks like) and the right-hand column of
  pixels lands on a fraction and is clipped. With `noResize` the framework
  calls setSizeLimits(1180, 740, 1180, 740) and the transform stays 1:1.
  The layout cannot reflow anyway -- several diagrams carry absolute x
  coordinates tuned to this width -- so a resizable window only ever made it
  worse.

  Changing the `position` below is safe even though saveState is on:
  init/initContextWindows.lua's cwInitStateEqual() only re-applies a saved
  geometry when the *declared* initial position still matches the one stored
  with it, so editing this line invalidates the stale entry in state.txt and
  the new default takes effect instead of the old remembered size. The y is
  121 rather than 120 for exactly that reason: it drops any geometry saved
  while the window was still resizable.

  Bind a key to:

      Tu-154/Debug/inspector

  The window content is debug_inspector_view (the tabbed graphical UI), which
  reads aircraft state by dataref name only -- nothing here touches systems
  code, and nothing here creates a dataref (so CLAUDE.md Hard Rule 4 does not
  apply to this component).

  The handle is published as cw_panels.inspector, and only so that the DBG cell
  on the menu strip (panels/panel_windows.lua) can toggle the window and light
  up while it is open. There is deliberately no drf_panels.inspector, so
  core/panel_logic.lua's updatePanels() never touches it. With the
  `debug_inspector {}` line in main.lua commented out the entry is nil and the
  DBG cell draws greyed out and does nothing.

--]]

cw_panels.inspector = contextWindow {
    name = "debug_inspector",
    description = "Toggle Tu-154M System / Debug Inspector",
    command = "Tu-154/Debug/inspector",
    position = { 80, 121, 1180, 740 },
    noResize = true, -- a scaled window is a blurred window; see above
    proportional = true,
    saveState = true,
    noBackground = true, -- the view draws its own opaque background
    layer = SASL_CW_LAYER_FLOATING_WINDOWS,
    visible = false,
    components = {
        debug_inspector_view {
            position = { 0, 0, 1180, 740 }
        }
    }
}
