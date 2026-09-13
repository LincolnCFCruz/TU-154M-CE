defineProperty("diss_fail", globalPropertyi("tu-154/failures/diss_fail"))
defineProperty("nvu_fail", globalPropertyi("tu-154/failures/nvu_fail"))
defineProperty("radar_fail", globalPropertyi("tu-154/failures/radar_fail"))
defineProperty("rsbn_fail", globalPropertyi("tu-154/failures/rsbn_fail"))
defineProperty("taws_fail", globalPropertyi("tu-154/failures/taws_fail"))

defineProperty("acs1_fail", globalPropertyi("tu-154/failures/acs1_fail"))
defineProperty("acs2_fail", globalPropertyi("tu-154/failures/acs2_fail"))
defineProperty("acs3_fail", globalPropertyi("tu-154/failures/acs3_fail"))

defineProperty("agr_fail", globalPropertyi("tu-154/failures/agr_fail"))
defineProperty("bkk_fail", globalPropertyi("tu-154/failures/bkk_fail"))

defineProperty("pitot1", globalPropertyi("tu-154/failures/pitot1"))
defineProperty("pitot2", globalPropertyi("tu-154/failures/pitot2"))
defineProperty("static1", globalPropertyi("tu-154/failures/static1"))
defineProperty("static2", globalPropertyi("tu-154/failures/static2"))

defineProperty("mgv_fail", globalPropertyi("tu-154/failures/mgv_fail"))
defineProperty("rv1_fail", globalPropertyi("tu-154/failures/rv1_fail"))
defineProperty("rv2_fail", globalPropertyi("tu-154/failures/rv2_fail"))
defineProperty("AOA", globalPropertyi("tu-154/failures/AOA"))
defineProperty("uvid15_fail", globalPropertyi("tu-154/failures/uvid15_fail"))


-- sim fails

defineProperty("rel_ss_alt", globalPropertyi("sim/operation/failures/rel_ss_alt"))
defineProperty("rel_cop_alt", globalPropertyi("sim/operation/failures/rel_cop_alt"))
defineProperty("rel_ss_tsi", globalPropertyi("sim/operation/failures/rel_ss_tsi"))

defineProperty("rel_adc_comp", globalPropertyi("sim/operation/failures/rel_adc_comp"))
defineProperty("rel_ss_ahz", globalPropertyi("sim/operation/failures/rel_ss_ahz"))
defineProperty("rel_cop_ahz", globalPropertyi("sim/operation/failures/rel_cop_ahz"))
defineProperty("rel_stall_warn", globalPropertyi("sim/operation/failures/rel_stall_warn"))
defineProperty("rel_ss_vvi", globalPropertyi("sim/operation/failures/rel_ss_vvi"))
defineProperty("rel_cop_vvi", globalPropertyi("sim/operation/failures/rel_cop_vvi"))


defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))
defineProperty("failures_enabled", globalPropertyi("tu-154/failures/failures_enabled"))

-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control


-- random failures: { flag, k1, k2, failed value } (rollFailures, core/glbl_func.lua)
local RANDOM_FAILS = {
	{ diss_fail, 0.00001, 0.3, 1 },
	{ nvu_fail, 0.00001, 0.3, 1 },
	{ radar_fail, 0.00001, 0.3, 1 },
	{ rsbn_fail, 0.00001, 0.3, 1 },
	{ taws_fail, 0.00001, 0.3, 1 },

	{ acs1_fail, 0.00001, 0.3, 1 },
	{ acs2_fail, 0.00001, 0.3, 1 },
	{ acs3_fail, 0.00001, 0.3, 1 },

	{ agr_fail, 0.00001, 0.3, 1 },
	{ bkk_fail, 0.00001, 0.3, 1 },

	{ pitot1, 0.00001, 0.3, 1 },
	{ pitot2, 0.00001, 0.3, 1 },
	{ static1, 0.00001, 0.3, 1 },
	{ static2, 0.00001, 0.3, 1 },

	{ mgv_fail, 0.00001, 0.3, 1 },
	{ rv1_fail, 0.00001, 0.3, 1 },
	{ rv2_fail, 0.00001, 0.3, 1 },
	{ AOA, 0.00001, 0.3, 1 },
	{ uvid15_fail, 0.00001, 0.3, 1 },

	{ rel_ss_alt, 0.00001, 0.3, 6 },
	{ rel_cop_alt, 0.00001, 0.3, 6 },
	{ rel_ss_tsi, 0.00001, 0.3, 6 },

	{ rel_adc_comp, 0.00001, 0.3, 6 },
	{ rel_ss_ahz, 0.00001, 0.3, 6 },
	{ rel_cop_ahz, 0.00001, 0.3, 6 },
	{ rel_stall_warn, 0.00001, 0.3, 6 },
	{ rel_ss_vvi, 0.00001, 0.3, 6 },
	{ rel_cop_vvi, 0.00001, 0.3, 6 },
}

local fail_counter = 0
local check_time = math.random(15, 30)


function update()
	local passed = get(frame_time)
	
	
local MASTER = get(ismaster) ~= 1	
	

if MASTER then	

	
	local FAIL = get(failures_enabled)
	FAIL = FAIL * 0.05 * 4 ^ (FAIL * 0.5)
	if FAIL > 0 then
		
		fail_counter = fail_counter + passed
		
		if fail_counter > check_time then
			fail_counter = 0
			check_time = math.random(15, 30)
			
			-- random failures
			rollFailures(RANDOM_FAILS, FAIL)
			
	
		end
		
		-- dependent failures
		

	else
		-- no failures enabled
		fail_counter = 0
		
		clearFailures(RANDOM_FAILS)

	
	end
	
	
end

end