-- Invisible clickable area; outlined while X-Plane shows interactive areas.
-- SASL3's flag is globalShowInteractiveAreas. SASL2's showClickableAreas no
-- longer exists, and naming it would send every draw through the component
-- loader.
function draw(self)
    if globalShowInteractiveAreas then
        drawFrame(0, 0, size[1], size[2])
    end
end
