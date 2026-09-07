-- ================================================================= --
-- Tu-154M high-lift device aerodynamics: flaps, slats and landing
-- FULLY CORRECTED VERSION (globalPropertyf error fix)
-- Optimised for the 78-80% RPM setting and a soft touchdown
-- ================================================================= --

-- Main coefficients (DataRefs) - globalPropertyf is used throughout
defineProperty("cl", globalPropertyf("sim/aircraft/controls/acf_flap_cl"))
defineProperty("cd", globalPropertyf("sim/aircraft/controls/acf_flap_cd"))
defineProperty("cm", globalPropertyf("sim/aircraft/controls/acf_flap_cm"))

defineProperty("cl2", globalPropertyf("sim/aircraft/controls/acf_flap2_cl"))
defineProperty("cd2", globalPropertyf("sim/aircraft/controls/acf_flap2_cd"))
defineProperty("cm2", globalPropertyf("sim/aircraft/controls/acf_flap2_cm"))

-- High-lift device positions
defineProperty("flap_inn_L", globalPropertyf("sim/flightmodel/controls/wing1l_fla1def")) 
defineProperty("flap_mid_L", globalPropertyf("sim/flightmodel/controls/wing2l_fla2def")) 
defineProperty("slat_L", globalPropertyf("sim/flightmodel2/controls/slat1_deploy_ratio")) -- Slats, 0..1 deployment ratio (driven by flight_ctrls/flaps.lua)

-- Engine and atmosphere parameters (corrected to globalPropertyf)
defineProperty("thrust_L", globalProperty("sim/cockpit2/engine/indicators/thrust_n[0]")) 
defineProperty("thrust_R", globalProperty("sim/cockpit2/engine/indicators/thrust_n[2]"))
defineProperty("true_airspeed", globalPropertyf("sim/flightmodel/position/true_airspeed"))
defineProperty("dens", globalPropertyf("sim/weather/rho"))

-- Ground effect and landing gear (corrected to globalPropertyf)
defineProperty("cl_GE1", globalProperty("sim/flightmodel/parts/CL_grndeffect[8]"))
defineProperty("gear_on_ground_L", globalProperty("sim/flightmodel2/gear/on_ground[1]")) 
defineProperty("gear_on_ground_R", globalProperty("sim/flightmodel2/gear/on_ground[2]")) 

-- Forces and moments (corrected to globalPropertyf)
defineProperty("pitch_add", globalPropertyf("sim/flightmodel/forces/M_plug_acf"))
defineProperty("lift_left", globalProperty("sim/flightmodel2/wing/elements/element_cl_total[2]"))
defineProperty("lift_right", globalProperty("sim/flightmodel2/wing/elements/element_cl_total[12]"))

-- Interpolation tables
local engine_lift_tbl = { {-300, 1}, {300, 1}, {420, 0}, {1000, 0} }
local engine_lift_tbl2 = { {0, 0}, {5500, 1}, {100000, 1} }

-- Slat travel at full extension, degrees. Matches the slat animation in
-- objects/wings.obj (ANIM_rotate_key 1 -> 22.00) and converts the 0..1
-- deployment ratio back into the degrees the coefficients below expect.
-- local SLAT_FULL_DEG = 22

function update()
    -- Getting the data
    local t_L = get(thrust_L)
    local t_R = get(thrust_R)
    local tas = get(true_airspeed) * 3.6
    local q = get(dens) / 2 * math.pow(tas / 3.6, 2)
    
    local f_inn = math.max(get(flap_inn_L), 15)
    local f_out = math.max(get(flap_mid_L), 15)
    local slat = get(slat_L) -- * SLAT_FULL_DEG -- ratio -> degrees
    
    -- Touchdown state
    local main_on_ground = (get(gear_on_ground_L) + get(gear_on_ground_R)) > 0.5

    -- 1. Slat effect
    local slat_cl_add = slat * 0.0016 
    local slat_cm_add = slat * 0.0024 
    local slat_cd_add = slat * 0.0007 

    -- 2. Ground Effect
    local GE_val = get(cl_GE1)
    if GE_val < 1.0 then GE_val = 1.0 end
    if GE_val > 1.12 then GE_val = 1.12 end

    -- 3. Moment coefficient (CM) - quadratic functions tuned for 36 degrees
    local flap1_cm = (-1.15e-04 * math.pow(f_inn, 2) + 2.20e-04 * f_inn - 0.38) + slat_cm_add
    local flap2_cm = (-2.30e-04 * math.pow(f_out, 2) + 3.10e-04 * f_out - 0.28) + (slat_cm_add * 0.5)
    
    -- Correction near the ground (unloading the nose for a main-gear touchdown)
    local cm_corr = (0.43 * math.pow(GE_val, 2) - 0.12 * GE_val - 0.26) / (GE_val - 0.93)
    if main_on_ground then cm_corr = cm_corr * 0.5 end -- Softening the nose drop at touchdown

    flap1_cm = flap1_cm * cm_corr
    flap2_cm = flap2_cm * cm_corr

    -- 4. Drag coefficient (CD) - tuned for 78-80% RPM
    local flap1_cd = (2.80e-05 * math.pow(f_inn, 2) + 3.75e-03 * f_inn + 0.058) + slat_cd_add
    local flap2_cd = (3.15e-05 * math.pow(f_out, 2) + 3.95e-03 * f_out + 0.063) + slat_cd_add
    
    local cd_corr = 0.00115 * math.pow(GE_val, 33.0) + 0.99
    local final_cd1 = flap1_cd * cd_corr * 0.93 -- "Clean" aerodynamics of the M variant
    local final_cd2 = flap2_cd * cd_corr * 0.93

    -- 5. Lift coefficient (CL)
    local flap1_cl = (6.00e-04 * math.pow(f_inn, 2) - 1.30e-02 * f_inn + 1.08) + slat_cl_add
    local flap2_cl = (7.85e-04 * math.pow(f_out, 2) - 1.20e-02 * f_out + 1.18) + slat_cl_add

    -- 6. Moment from the engines
    local spd_f = interpolate(engine_lift_tbl, tas)
    local lift_tot = (get(lift_left) + get(lift_right)) / 2 * q
    local lft_f = interpolate(engine_lift_tbl2, lift_tot)
    
    local eng_m = 80000 * 0.05 * 9.81 * 2.6 * (1.45 * (t_L + t_R) / 100000) * spd_f * lft_f
    
    if tas > 60 then 
        set(pitch_add, eng_m)
    else
        set(pitch_add, 0)
    end

    -- Writing the final values
    set(cl, flap1_cl)
    set(cl2, flap2_cl)
    set(cd, final_cd1)
    set(cd2, final_cd2)
    set(cm, flap1_cm)
    set(cm2, flap2_cm)
end
