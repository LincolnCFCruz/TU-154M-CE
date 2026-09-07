-- Invisible clickable area.
--
-- SASL2's init.lua published a global `showClickableAreas`; SASL3 renamed it to
-- `globalShowInteractiveAreas` (initMain.lua). Left unrenamed, the component
-- environment falls through to loadComponent("showClickableAreas") on EVERY
-- draw of every clickable -- one "can't load component" error per clickable
-- per frame.
function draw(self)
    if globalShowInteractiveAreas then
        drawFrame(0, 0, size[1], size[2])
    end
end
