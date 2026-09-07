-- this is the palette
-- Tu-154M - speed and CG card
-- The logic was brought into line with the Tu-154B2

size = {251, 305}

defineProperty("show_palette", globalPropertyi("tu-154/panels/show_palette"))

defineProperty("payload",  globalPropertyf("sim/flightmodel/weight/m_fixed"))
defineProperty("CG_load",  globalPropertyf("sim/flightmodel/misc/cgz_ref_to_default")) -- xp11 (as in B2)
--defineProperty("CG_load", globalPropertyf("sim/flightmodel2/misc/cg_offset_z"))       -- xp12

defineProperty("fuel_q_1",  globalProperty("sim/flightmodel/weight/m_fuel[0]"))
defineProperty("fuel_q_4",  globalProperty("sim/flightmodel/weight/m_fuel[1]"))
defineProperty("fuel_q_2R", globalProperty("sim/flightmodel/weight/m_fuel[2]"))
defineProperty("fuel_q_2L", globalProperty("sim/flightmodel/weight/m_fuel[3]"))
defineProperty("fuel_q_3R", globalProperty("sim/flightmodel/weight/m_fuel[4]"))
defineProperty("fuel_q_3L", globalProperty("sim/flightmodel/weight/m_fuel[5]"))

defineProperty("gear1_deflect", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[0]"))

-- load images
defineProperty("bg_img1", loadImage("palette.png", 0, 207, 251, 305))
defineProperty("bg_img2", loadImage("palette.png", 250, 207, 251, 305))

defineProperty("cg_pos_actual", globalPropertyf("tu-154/misc/cg_pos_actual"))
defineProperty("weight_actual", globalPropertyf("tu-154/misc/weight_actual"))

-- save results
defineProperty("v1_15", globalPropertyi("tu-154/speeds/v1_15"))
defineProperty("vr_15", globalPropertyi("tu-154/speeds/vr_15"))
defineProperty("v2_15", globalPropertyi("tu-154/speeds/v2_15"))
defineProperty("v1_28", globalPropertyi("tu-154/speeds/v1_28"))
defineProperty("vr_28", globalPropertyi("tu-154/speeds/vr_28"))
defineProperty("v2_28", globalPropertyi("tu-154/speeds/v2_28"))

-- gear deploy (as in B2 - to compute the CG shift from gear retraction)
defineProperty("gear1_deploy", globalProperty("sim/aircraft/parts/acf_gear_deploy[0]"))
defineProperty("gear2_deploy", globalProperty("sim/aircraft/parts/acf_gear_deploy[1]"))
defineProperty("gear3_deploy", globalProperty("sim/aircraft/parts/acf_gear_deploy[2]"))

defineProperty("total_weight", globalPropertyf("sim/flightmodel/weight/m_total"))
defineProperty("empty_weight", globalPropertyf("sim/aircraft/weight/acf_m_empty"))


-- ============================================================
-- Index method of CG calculation (per the Tu-154M diagram)
-- ============================================================
local function calc_CG(weight, index)
	local MID_CG          = 40
	local MID_CG_POS      = 60
	local MIN_WEIGHT      = 54000
	local MAX_WEIGHT      = 74000
	local MAX_WEIGHT_POS  = 1
	local MIN_CG          = 22
	local MIN_CG_LOW_POS  = MID_CG_POS - 34.3
	local MIN_CG_HIGH_POS = MID_CG_POS - 24.8

	local z = (weight - MIN_WEIGHT) * MAX_WEIGHT_POS / (MAX_WEIGHT - MIN_WEIGHT)
	local b = ((MID_CG_POS - index) * MIN_CG_LOW_POS * MAX_WEIGHT_POS) /
	          (z * MIN_CG_HIGH_POS - z * MIN_CG_LOW_POS + MIN_CG_LOW_POS * MAX_WEIGHT_POS)
	return MID_CG - b * (MID_CG - MIN_CG) / MIN_CG_LOW_POS
end

local function calc_idx(weight, CG)
	local MID_CG          = 40
	local MID_CG_POS      = 60
	local MIN_WEIGHT      = 54000
	local MAX_WEIGHT      = 74000
	local MAX_WEIGHT_POS  = 1
	local MIN_CG          = 22
	local MIN_CG_LOW_POS  = MID_CG_POS - 34.3
	local MIN_CG_HIGH_POS = MID_CG_POS - 24.8

	local z = (weight - MIN_WEIGHT) * MAX_WEIGHT_POS / (MAX_WEIGHT - MIN_WEIGHT)
	local b = (MID_CG - CG) * MIN_CG_LOW_POS / (MID_CG - MIN_CG)
	return MID_CG_POS - b * (z * MIN_CG_HIGH_POS - z * MIN_CG_LOW_POS + MIN_CG_LOW_POS * MAX_WEIGHT_POS) /
	       (MIN_CG_LOW_POS * MAX_WEIGHT_POS)
end


-- ============================================================
-- Tu-154M speed tables
-- ============================================================

-- Takeoff, flaps 28 deg
local V1_28_tbl = {
	{70, 205}, {75, 210}, {80, 220}, {85, 230},
	{90, 235}, {95, 240}, {100, 250}, {120, 250}
}
-- Vr (rotation speed) - flaps 28 deg per the Flight Manual fig. 7.3.1
local Vr_28_tbl = {
	{70, 218}, {75, 226}, {80, 233}, {85, 240},
	{90, 248}, {95, 256}, {100, 263}, {120, 263}
}
-- V2 (safety speed) - flaps 28 deg per the Flight Manual fig. 7.3.1
local V2_28_tbl = {
	{70, 232}, {75, 240}, {80, 248}, {85, 255},
	{90, 263}, {95, 270}, {100, 278}, {120, 278}
}

-- Takeoff, flaps 15 deg
local V1_15_tbl = {
	{70, 220}, {75, 230}, {80, 235}, {85, 245},
	{90, 250}, {95, 260}, {100, 270}, {120, 270}
}
-- Vr (rotation speed) - flaps 15 deg per the Flight Manual fig. 7.3.2
local Vr_15_tbl = {
	{70, 245}, {75, 252}, {80, 258}, {85, 265},
	{90, 272}, {95, 278}, {100, 285}, {120, 285}
}
-- V2 (safety speed) - flaps 15 deg per the Flight Manual fig. 7.3.2
local V2_15_tbl = {
	{70, 258}, {75, 265}, {80, 272}, {85, 280},
	{90, 287}, {95, 294}, {100, 300}, {120, 300}
}

-- High-lift device retraction
local Vfl_0_tbl = {
	{70, 360}, {95, 360}, {100, 365}, {120, 365}
}

-- Approach
-- Approach with flaps 0 deg (slats retracted) - per the Flight Manual fig. 7.7.1
local Vapp_f0_tbl = {
	{60, 305}, {65, 318}, {70, 330}, {75, 345},
	{80, 360}, {85, 374}, {90, 388}, {120, 388}
}
-- Approach with flaps 15 deg (slats extended) - per the Flight Manual fig. 7.7.1
local Vapp_f15_tbl = {
	{60, 263}, {65, 272}, {70, 280}, {75, 290},
	{80, 300}, {85, 310}, {90, 320}, {120, 320}
}
-- Approach with flaps 28 deg - per the Flight Manual fig. 7.7.1
-- v5: the obvious anomaly 85 t=282 was fixed (it was lower than 80 t=286)
local Vapp_f28_tbl = {
	{60, 250}, {65, 260}, {70, 270}, {75, 278},
	{80, 285}, {85, 295}, {90, 305}, {120, 305}
}
-- Approach with flaps 36 deg - per the Flight Manual fig. 7.7.1
-- v5: an obvious jump was fixed: it was 80 t=268 -> 85 t=296 (non-linearity)
local Vapp_f36_tbl = {
	{60, 245}, {65, 254}, {70, 263}, {75, 272},
	{80, 280}, {85, 289}, {90, 298}, {120, 298}
}
-- Approach with flaps 45 deg - per the Flight Manual fig. 7.7.1 (the standard landing setting)
local Vapp_f45_tbl = {
	{60, 240}, {65, 248}, {70, 257}, {75, 266},
	{80, 275}, {85, 283}, {90, 292}, {120, 292}
}



-- ============================================================
-- Display variables
-- ============================================================
local show_side = 0

local show_weight    = 0
local CG_show        = 0

local show_V1_28     = "---"
local show_Vr_28     = "---"
local show_V2_28     = "---"
local show_Vfl_15_28 = 330
local show_Vfl_0     = 360

local show_V1_15  = "---"
local show_Vr_15  = "---"
local show_V2_15  = "---"

local show_Vapp_0  = "---"
local show_Vapp_15 = "---"
local show_Vapp_28 = "---"
local show_Vapp_36 = "---"
local show_Vapp_45 = "---"

local show_to_cg   = "---"  -- Takeoff CG, %MAC (latched at loading)
local show_land_cg = "---"  -- Landing CG, %MAC (latched at loading)

-- variables for latching the CG
local prev_weight     = 0
local weight_stable   = 0   -- counter of frames with a stable weight
local cg_fixed        = false


-- Landing gear state initialisation (as in B2)
local CG_shifted = false
local CG_return  = false

if get(gear1_deflect) > 0 then
	CG_shifted = false
	CG_return  = true
else
	CG_shifted = true
	CG_return  = false
end

local gear_shift_prev = 0
local cg_unshifted = get(CG_load)


function update()

	-- ZFW = payload + empty weight (dynamic, as in B2)
	local current_ZFW    = get(payload) + get(empty_weight)

	-- Formula converting CG_load -> % MAC (as in B2)
	local current_ZFW_CG = get(CG_load) * 100 / 5.28 + 25

	-- Accounting for the CG shift on gear retraction/extension (logic from B2)
	local gear_shift = (-0.01579 * get(total_weight) / 1000 + 1.463) *
	                   ((1 - get(gear1_deploy)) * 0.2 +
	                    (1 - get(gear2_deploy)) * 0.4 +
	                    (1 - get(gear3_deploy)) * 0.4) * 0.05253

	if get(gear1_deploy) + get(gear2_deploy) + get(gear3_deploy) == 0 or
	   get(gear1_deploy) + get(gear2_deploy) + get(gear3_deploy) == 3 then
		cg_unshifted = get(CG_load)
	end
	gear_shift_prev = gear_shift

	-- Fuel in the tanks
	local tank1  = get(fuel_q_1)
	local tank4  = get(fuel_q_4)
	local tank2L = get(fuel_q_2L)
	local tank2R = get(fuel_q_2R)
	local tank3L = get(fuel_q_3L)
	local tank3R = get(fuel_q_3R)

	-- Tank indices (the same as in load_panel)
	local index = {
		["tank_1_idx"] = -0.0011993,
		["tank_2_idx"] = -0.0000509,
		["tank_3_idx"] =  0.0014161,
		["tank_4_idx"] = -0.00194
	}

	local current_weight = current_ZFW + tank1 + tank4 + tank2L + tank2R + tank3L + tank3R

	-- Calculation of the current CG by the index method
	local ZFW_idx     = calc_idx(current_ZFW, current_ZFW_CG)
	local current_idx = ZFW_idx +
	                    index["tank_1_idx"] * tank1 +
	                    index["tank_2_idx"] * (tank2L + tank2R) +
	                    index["tank_3_idx"] * (tank3L + tank3R) +
	                    index["tank_4_idx"] * tank4

	local current_CG = calc_CG(current_weight, current_idx)

	-- Final values for display
	show_weight = math.floor(current_weight / 100) / 10
	CG_show     = math.floor(current_CG * 10) / 10

	-- Takeoff speeds (the 70-120 t range, as in B2)
	if show_weight >= 70 and show_weight <= 120 then
		show_V1_28 = math.floor(interpolate(V1_28_tbl, show_weight))
		show_Vr_28 = math.floor(interpolate(Vr_28_tbl, show_weight))
		show_V2_28 = math.floor(interpolate(V2_28_tbl, show_weight))
		show_V1_15 = math.floor(interpolate(V1_15_tbl, show_weight))
		show_Vr_15 = math.floor(interpolate(Vr_15_tbl, show_weight))
		show_V2_15 = math.floor(interpolate(V2_15_tbl, show_weight))
	elseif show_weight < 70 then
		show_V1_28 = 205
		show_Vr_28 = 215
		show_V2_28 = 235
		show_V1_15 = 220
		show_Vr_15 = 230
		show_V2_15 = 270
	end

	-- Approach speeds (the 60-120 t range, as in B2)
	if show_weight >= 60 and show_weight <= 120 then
		show_Vapp_0  = math.floor(interpolate(Vapp_f0_tbl,  show_weight))
		show_Vapp_15 = math.floor(interpolate(Vapp_f15_tbl, show_weight))
		show_Vapp_28 = math.floor(interpolate(Vapp_f28_tbl, show_weight))
		show_Vapp_36 = math.floor(interpolate(Vapp_f36_tbl, show_weight))
		show_Vapp_45 = math.floor(interpolate(Vapp_f45_tbl, show_weight))
	elseif show_weight < 60 then
		show_Vapp_0  = 318
		show_Vapp_15 = 251
		show_Vapp_28 = 236
		show_Vapp_36 = 232
		show_Vapp_45 = 230
	end

	-- Latch the takeoff CG once the weight has settled after loading
	local cur_w = math.floor(current_weight / 10)

	if math.abs(cur_w - prev_weight) > 5 then
		-- the weight is changing - loading is under way, drop the latch
		weight_stable = 0
		cg_fixed      = false
	else
		weight_stable = weight_stable + 1
	end

	-- 30 frames after it settles, latch the takeoff CG
	if weight_stable == 30 and current_weight > 50000 then
		show_to_cg = math.floor(current_CG * 10 + 0.5) / 10
		cg_fixed   = true
	end

	prev_weight = cur_w

	-- Landing CG - updated in real time from the current fuel
	-- shows which way the CG moves as the fuel burns off in flight
	if current_weight > 50000 then
		show_land_cg = math.floor(current_CG * 10 + 0.5) / 10
	end

	set(cg_pos_actual, current_CG)
	set(weight_actual, current_weight)

	set(v1_15, show_V1_15)
	set(vr_15, show_Vr_15)
	set(v2_15, show_V2_15)
	set(v1_28, show_V1_28)
	set(vr_28, show_Vr_28)
	set(v2_28, show_V2_28)

end


components = {

	-- background
	textureLit {
		position = {0, 0, size[1], size[2]},
		image = get(bg_img1),
		visible = function() return show_side == 0 end,
	},
	textureLit {
		position = {0, 0, size[1], size[2]},
		image = get(bg_img2),
		visible = function() return show_side == 1 end,
	},

	-- close button
	clickable {
		position = {size[1]-15, size[2]-15, 15, 15},
		onMouseDown = function() set(show_palette, 0); return true end,
	},

	-- change side
	clickable {
		position = {51, 281, 153, 21},
		onMouseDown = function() show_side = 1 - show_side; return true end,
	},

	-- current weight
	text_draw {
		position = {155, 264, 50, 50}, color = {0,0,0,1},
		text = function() return show_weight end,
	},

	-- current CG (at the current moment of the flight)
	text_draw {
		position = {155, 244, 50, 50}, color = {0,0,0,1},
		text = function() return CG_show end,
	},

	-- Takeoff CG %MAC (the grey row, Take-off side)
	text_draw {
		position = {155, 222, 50, 50}, color = {0,0,0,1},
		text    = function() return show_to_cg end,
		visible = function() return show_side == 0 end,
	},

	-- Landing CG %MAC (the grey row, Landing side)
	text_draw {
		position = {155, 222, 50, 50}, color = {0,0,0,1},
		text    = function() return show_land_cg end,
		visible = function() return show_side == 1 end,
	},

	-- === Takeoff (side 0) ===

	-- V1 flaps 15
	text_draw {
		position = {155, 184, 50, 50}, color = {0,0,0,1},
		text    = function() return show_V1_15 end,
		visible = function() return show_side == 0 end,
	},
	-- Vr flaps 15
	text_draw {
		position = {155, 164, 50, 50}, color = {0,0,0,1},
		text    = function() return show_Vr_15 end,
		visible = function() return show_side == 0 end,
	},
	-- V2 flaps 15
	text_draw {
		position = {155, 144, 50, 50}, color = {0,0,0,1},
		text    = function() return show_V2_15 end,
		visible = function() return show_side == 0 end,
	},
	-- Vfl 0 (retraction)
	text_draw {
		position = {155, 124, 50, 50}, color = {0,0,0,1},
		text    = function() return show_Vfl_0 end,
		visible = function() return show_side == 0 end,
	},

	-- V1 flaps 28
	text_draw {
		position = {155, 84, 50, 50}, color = {0,0,0,1},
		text    = function() return show_V1_28 end,
		visible = function() return show_side == 0 end,
	},
	-- Vr flaps 28
	text_draw {
		position = {155, 64, 50, 50}, color = {0,0,0,1},
		text    = function() return show_Vr_28 end,
		visible = function() return show_side == 0 end,
	},
	-- V2 flaps 28
	text_draw {
		position = {155, 44, 50, 50}, color = {0,0,0,1},
		text    = function() return show_V2_28 end,
		visible = function() return show_side == 0 end,
	},
	-- Vfl 15 (retraction from flaps 28)
	text_draw {
		position = {155, 24, 50, 50}, color = {0,0,0,1},
		text    = function() return show_Vfl_15_28 end,
		visible = function() return show_side == 0 end,
	},
	-- Vfl 0
	text_draw {
		position = {155, 4, 50, 50}, color = {0,0,0,1},
		text    = function() return show_Vfl_0 end,
		visible = function() return show_side == 0 end,
	},

	-- === Approach (side 1) ===

	-- Vapp flaps 0
	text_draw {
		position = {155, 184, 50, 50}, color = {0,0,0,1},
		text    = function() return show_Vapp_0 end,
		visible = function() return show_side == 1 end,
	},
	-- Vapp flaps 15
	text_draw {
		position = {155, 164, 50, 50}, color = {0,0,0,1},
		text    = function() return show_Vapp_15 end,
		visible = function() return show_side == 1 end,
	},
	-- Vapp flaps 28
	text_draw {
		position = {155, 144, 50, 50}, color = {0,0,0,1},
		text    = function() return show_Vapp_28 end,
		visible = function() return show_side == 1 end,
	},
	-- Vapp flaps 36
	text_draw {
		position = {155, 124, 50, 50}, color = {0,0,0,1},
		text    = function() return show_Vapp_36 end,
		visible = function() return show_side == 1 end,
	},
	-- Vapp flaps 45
	text_draw {
		position = {155, 104, 50, 50}, color = {0,0,0,1},
		text    = function() return show_Vapp_45 end,
		visible = function() return show_side == 1 end,
	},

}
