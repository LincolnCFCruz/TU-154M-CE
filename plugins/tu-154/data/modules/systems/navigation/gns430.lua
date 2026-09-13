
defineProperty("show_gns", globalPropertyi("tu-154/anim/show_gns"))
-- overrideGPS removed: X-Plane manages it itself through g430n1_popup

-- source
defineProperty("kln_on", globalPropertyi("tu-154/switchers/ovhd/kln_on"))  -- KLN switch

defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left")) -- 27 V bus voltage
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right")) -- 27 V bus voltage

defineProperty("gps_course_degtm", globalPropertyf("sim/cockpit/radios/gps_course_degtm")) -- DTK magnetic
defineProperty("gps_hdef_dot", globalPropertyf("sim/cockpit/radios/gps_hdef_dot")) -- Course dev in dots
defineProperty("gps_fromto", globalPropertyi("sim/cockpit/radios/gps_fromto"))


-- results
-- XP12 dropped the sim/GPS/g430n1_power_up / _dn commands, so findCommand returned nil
-- and the GPS power was never actually switched. XP12 publishes the power as a plain
-- writable int (Resources/plugins/DataRefs.txt: sim/cockpit2/radios/actuators/gps_power,
-- "GPS 1 off or on, 0 or 1"), so it is written directly.
defineProperty("gps_power", globalPropertyi("sim/cockpit2/radios/actuators/gps_power"))
local last_pwr_state = -1  -- so the power is written only on a change

defineProperty("gns_lit", globalPropertyf("tu-154/lights/gns430_lit")) -- GPS power


defineProperty("GNS430_dtk", globalPropertyf("tu-154/SC/GNS430_dtk")) -- heading on the GNS
defineProperty("GNS430_dev", globalPropertyf("tu-154/SC/GNS430_dev")) -- cross-track deviation from the GNS
defineProperty("GNS430_flag", globalPropertyi("tu-154/SC/GNS430_flag")) -- cross-track deviation from the GNS


-- animation
defineProperty("LB_angle", globalPropertyf("tu-154/rotary/GNS430/LB_angle")) -- LB_angle
defineProperty("LS_angle", globalPropertyf("tu-154/rotary/GNS430/LS_angle")) -- LS_angle
defineProperty("RB_angle", globalPropertyf("tu-154/rotary/GNS430/RB_angle")) -- RB_angle
defineProperty("RS_angle", globalPropertyf("tu-154/rotary/GNS430/RS_angle")) -- RS_angle

defineProperty("kill_map_fms_line", globalPropertyi("sim/graphics/misc/kill_map_fms_line"))


-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control


local LB_left = findCommand("sim/GPS/g430n1_coarse_down")

function LB_left_hnd(phase)
	if 1 == phase then
		set(LB_angle, get(LB_angle) - 10)
	end
	return 0
end

registerCommandHandler(LB_left, 0, LB_left_hnd)

local LB_right = findCommand("sim/GPS/g430n1_coarse_up")

function LB_right_hnd(phase)
	if 1 == phase then
		set(LB_angle, get(LB_angle) + 10)
	end
	return 0
end

registerCommandHandler(LB_right, 0, LB_right_hnd)


local LS_left = findCommand("sim/GPS/g430n1_fine_down")

function LS_left_hnd(phase)
	if 1 == phase then
		set(LS_angle, get(LS_angle) - 10)
	end
	return 0
end

registerCommandHandler(LS_left, 0, LS_left_hnd)

local LS_right = findCommand("sim/GPS/g430n1_fine_up")

function LS_right_hnd(phase)
	if 1 == phase then
		set(LS_angle, get(LS_angle) + 10)
	end
	return 0
end

registerCommandHandler(LS_right, 0, LS_right_hnd)


local RB_left = findCommand("sim/GPS/g430n1_chapter_dn")

function RB_left_hnd(phase)
	if 1 == phase then
		set(RB_angle, get(RB_angle) - 10)
	end
	return 0
end

registerCommandHandler(RB_left, 0, RB_left_hnd)

local RB_right = findCommand("sim/GPS/g430n1_chapter_up")

function RB_right_hnd(phase)
	if 1 == phase then
		set(RB_angle, get(RB_angle) + 10)
	end
	return 0
end

registerCommandHandler(RB_right, 0, RB_right_hnd)


local RS_left = findCommand("sim/GPS/g430n1_page_dn")

function RS_left_hnd(phase)
	if 1 == phase then
		set(RS_angle, get(RS_angle) - 10)
	end
	return 0
end

registerCommandHandler(RS_left, 0, RS_left_hnd)

local RS_right = findCommand("sim/GPS/g430n1_page_up")

function RS_right_hnd(phase)
	if 1 == phase then
		set(RS_angle, get(RS_angle) + 10)
	end
	return 0
end

registerCommandHandler(RS_right, 0, RS_right_hnd)


--[[
================================================================================
 GPS button handlers (adapted from the Tu-154B2)
 Commands were ported for all the Garmin 430 buttons: DIRECT, FPL, PROC, CLR, ENT,
 MENU, OBS, CDI, ZOOM IN/OUT, MSG, CURSOR.
 The button sounds (but_sound/rot_sound) from B2 were NOT ported, because they
 they use datarefs specific to B2 (tu154b2/custom/taws/taws_button).
================================================================================
--]]

-- DIRECT (Direct-To) button
local dirct = findCommand("sim/GPS/g430n1_direct")
function dirct_hnd(phase)
    return 0
end
registerCommandHandler(dirct, 0, dirct_hnd)

-- FPL (Flight Plan) button
local fpl = findCommand("sim/GPS/g430n1_fpl")
function fpl_hnd(phase)
    return 0
end
registerCommandHandler(fpl, 0, fpl_hnd)

-- PROC (Procedures) button
local proc = findCommand("sim/GPS/g430n1_proc")
function proc_hnd(phase)
    return 0
end
registerCommandHandler(proc, 0, proc_hnd)

-- CLR (Clear) button
local clr = findCommand("sim/GPS/g430n1_clr")
function clr_hnd(phase)
    return 0
end
registerCommandHandler(clr, 0, clr_hnd)

-- ENT (Enter) button
local ent = findCommand("sim/GPS/g430n1_ent")
function ent_hnd(phase)
    return 0
end
registerCommandHandler(ent, 0, ent_hnd)

-- MENU button
local menu = findCommand("sim/GPS/g430n1_menu")
function menu_hnd(phase)
    return 0
end
registerCommandHandler(menu, 0, menu_hnd)

-- OBS button
local obs = findCommand("sim/GPS/g430n1_obs")
function obs_hnd(phase)
    return 0
end
registerCommandHandler(obs, 0, obs_hnd)

-- CDI button
local cdi = findCommand("sim/GPS/g430n1_cdi")
function cdi_hnd(phase)
    return 0
end
registerCommandHandler(cdi, 0, cdi_hnd)

-- ZOOM OUT button (RNG down)
local zoom_out = findCommand("sim/GPS/g430n1_zoom_out")
function zoom_out_hnd(phase)
    return 0
end
registerCommandHandler(zoom_out, 0, zoom_out_hnd)

-- ZOOM IN button (RNG up)
local zoom_in = findCommand("sim/GPS/g430n1_zoom_in")
function zoom_in_hnd(phase)
    return 0
end
registerCommandHandler(zoom_in, 0, zoom_in_hnd)

-- MSG (Messages) button
local msg = findCommand("sim/GPS/g430n1_msg")
function msg_hnd(phase)
    return 0
end
registerCommandHandler(msg, 0, msg_hnd)

-- CURSOR button (push on the RS knob)
local cursor = findCommand("sim/GPS/g430n1_cursor")
function cursor_hnd(phase)
    return 0
end
registerCommandHandler(cursor, 0, cursor_hnd)


--[[
================================================================================
 Navigation maths functions (from the Tu-154B2)
 distance() - computes the distance between two points on a sphere (in nautical miles)
 crs()      - computes the true course from point 1 to point 2, allowing for magnetic variation
 x_trk()    - cross-track error (lateral deviation from the track line) in km
 The functions are not used in update() yet, but they are available for further development.
================================================================================
--]]

local function distance(lat, lon, lat2, lon2, magvar)
    local phi_1 = lat * math.pi / 180
    local phi_2 = lat2 * math.pi / 180
    local phi = phi_2 - phi_1
    local lam = (lon2 - lon) * math.pi / 180
    local a = math.sin(phi/2) * math.sin(phi/2) + math.cos(phi_1) * math.cos(phi_2) * math.sin(lam/2) * math.sin(lam/2)
    local c = 2 * math.atan2(math.sqrt(a), math.sqrt(1-a))
    local d = 6371 * c / 1.852  -- in nautical miles
    return d
end

local function crs(lat, lon, lat2, lon2, magvar)
    local phi_1 = lat * math.pi / 180
    local phi_2 = lat2 * math.pi / 180
    local phi = phi_1 - phi_2
    local lam = (lon2 - lon) * math.pi / 180
    local course = math.atan2(math.sin(lam) * math.cos(phi_2), math.cos(phi_1) * math.sin(phi_2) - math.sin(phi_1) * math.cos(phi_2) * math.cos(lam)) + magvar * math.pi / 180
    course = course / math.pi * 180
    if course < 0 then
        course = 360 + course
    elseif course > 360 then
        course = course - 360
    end
    return course
end

local function x_trk(pos_lat, pos_lon, lat, lon, lat2, lon2)
    local d13 = distance(lat, lon, pos_lat, pos_lon) * 1.852 / 6371
    local tet13 = crs(lat, lon, pos_lat, pos_lon, 0)
    local tet12 = crs(lat, lon, lat2, lon2, 0)
    local xtr = math.asin(math.sin(d13) * math.sin((tet13 - tet12) * math.pi / 180)) * 6371
    return xtr
end


--[[
sim/GPS/g430n1_popup			Popup 2D panel

sim/GPS/g430n1_coarse_down		LB left
sim/GPS/g430n1_coarse_up		LB right
sim/GPS/g430n1_fine_down 		LS left
sim/GPS/g430n1_fine_up			LS right
sim/GPS/g430n1_nav_com_tog		LS push

sim/GPS/g430n1_chapter_dn		RB left
sim/GPS/g430n1_chapter_up		RB right
sim/GPS/g430n1_page_dn			RS left
sim/GPS/g430n1_page_up			RS right
sim/GPS/g430n1_cursor			RS push

sim/GPS/g430n1_com_ff			Com up-dn
sim/GPS/g430n1_nav_ff			Nav up-dn

sim/GPS/g430n1_cdi				CDI button
sim/GPS/g430n1_obs				OBS button
sim/GPS/g430n1_msg				MSG button
sim/GPS/g430n1_fpl				FPL button
sim/GPS/g430n1_proc				PROC button

sim/GPS/g430n1_zoom_out			RNG down
sim/GPS/g430n1_zoom_in			RNG up

sim/GPS/g430n1_direct			Dir button
sim/GPS/g430n1_menu				MENU button
sim/GPS/g430n1_clr				CLR button
sim/GPS/g430n1_ent				ENT button

--]]


function update()
    -- Check the power: the switch is ON and the voltage is > 13 V on at least one bus
    local pwr_logic = get(kln_on) == 1 and (get(bus27_volt_left) > 13 or get(bus27_volt_right) > 13)
    local pwr_value = pwr_logic and 1 or 0

    -- Switch the GPS power only when the state changes, not every frame
    if pwr_value ~= last_pwr_state then
        set(gps_power, pwr_value)
        last_pwr_state = pwr_value
    end
    
    -- Screen brightness
    set(gns_lit, pwr_value * 0.7)
    
    -- Data for Smart Copilot and the custom instruments
    if get(ismaster) ~= 1 then
        set(GNS430_dtk, get(gps_course_degtm))
        set(GNS430_dev, get(gps_hdef_dot))
        
        -- Failure flag (From/To == 0 means there is no signal)
        local is_failed = (get(gps_fromto) == 0 or pwr_value == 0)
        set(GNS430_flag, is_failed and 1 or 0)
        
        if is_failed then 
            set(GNS430_dev, 0) 
        end
    end
    
    set(kill_map_fms_line, 1)
end


function onModuleDone()
	-- The forced reset was removed: gps_power and kill_map_fms_line are managed through update()
	print("GPS reset")
end
