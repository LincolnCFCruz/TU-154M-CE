-- createGlobalPropertyf("tu-154/buttons/console/d_inz_p", 0)
-- createGlobalPropertyf("tu-154/buttons/console/d_inz_r", 0)
-- createGlobalPropertyf("tu-154/buttons/console/d_inz_y", 0)
-- createGlobalPropertyf("tu-154/buttons/console/pt_inz", 0)

-- defineProperty("d_inz_p", globalPropertyf("tu-154/buttons/console/d_inz_p"))
-- defineProperty("d_inz_r", globalPropertyf("tu-154/buttons/console/d_inz_r"))
-- defineProperty("d_inz_y", globalPropertyf("tu-154/buttons/console/d_inz_y"))
-- defineProperty("pt_inz", globalPropertyf("tu-154/buttons/console/pt_inz"))

-- createGlobalPropertyf("tu-154/controlls/absu_debug1", 1)
-- createGlobalPropertyf("tu-154/controlls/absu_debug2", 0)
-- createGlobalPropertyf("tu-154/controlls/absu_debug3", 0)
--defineProperty("absu_debug1", globalPropertyf("tu-154/controlls/absu_debug1")) 
-- defineProperty("absu_debug2", globalPropertyf("tu-154/controlls/absu_debug2")) 
-- defineProperty("absu_debug3", globalPropertyf("tu-154/controlls/absu_debug3")) 


-- createGlobalPropertyf("tu-154/controlls/absu_debug1", 1)

-- defineProperty("absu_debug1", globalPropertyf("tu-154/controlls/absu_debug1")) 

-- defineProperty("hydro_ra56_rud_1", globalPropertyi("tu-154/switchers/eng/hydro_ra56_rud_1")) -- RA56 hydraulic supply, yaw
-- defineProperty("hydro_ra56_rud_2", globalPropertyi("tu-154/switchers/eng/hydro_ra56_rud_2")) -- RA56 hydraulic supply, yaw
-- defineProperty("hydro_ra56_rud_3", globalPropertyi("tu-154/switchers/eng/hydro_ra56_rud_3")) -- RA56 hydraulic supply, yaw

-- defineProperty("hydro_ra56_ail_1", globalPropertyi("tu-154/switchers/eng/hydro_ra56_ail_1")) -- RA56 hydraulic supply, roll
-- defineProperty("hydro_ra56_ail_2", globalPropertyi("tu-154/switchers/eng/hydro_ra56_ail_2")) -- RA56 hydraulic supply, roll
-- defineProperty("hydro_ra56_ail_3", globalPropertyi("tu-154/switchers/eng/hydro_ra56_ail_3")) -- RA56 hydraulic supply, roll
defineProperty("hod1", globalPropertyf("tu-154/absu/d_ra1_p"))
defineProperty("hod2", globalPropertyf("tu-154/absu/d_ra2_p"))
defineProperty("hod3", globalPropertyf("tu-154/absu/d_ra3_p"))

defineProperty("hydro_ra56_elev_1", globalPropertyi("tu-154/switchers/eng/hydro_ra56_elev_1")) -- RA-56 pitch hydraulic supply
defineProperty("hydro_ra56_elev_2", globalPropertyi("tu-154/switchers/eng/hydro_ra56_elev_2")) -- RA-56 pitch hydraulic supply
defineProperty("hydro_ra56_elev_3", globalPropertyi("tu-154/switchers/eng/hydro_ra56_elev_3")) -- RA-56 pitch hydraulic supply


-- failures
--defineProperty("absu_ra56_roll_fail", globalPropertyi("tu-154/failures/absu_ra56_roll_fail")) -- ra56 failure
defineProperty("absu_ra56_pitch_fail", globalPropertyi("tu-154/failures/absu_ra56_pitch_fail")) -- RA-56 failure
--defineProperty("absu_ra56_yaw_fail", globalPropertyi("tu-154/failures/absu_ra56_yaw_fail")) -- ra56 failure
--defineProperty("roll_main_mode", globalPropertyi("tu-154/absu/roll_main_mode")) 
defineProperty("pitch_main_mode", globalPropertyi("tu-154/absu/pitch_main_mode")) -- ABSU main pitch mode. 0 = off, 1 = control-wheel steering, 2 = stabilisation

defineProperty("absu_ra1_pitch_fail", globalPropertyi("tu-154/failures/absu_ra1_pitch_fail"))
defineProperty("absu_ra2_pitch_fail", globalPropertyi("tu-154/failures/absu_ra2_pitch_fail"))
defineProperty("absu_ra3_pitch_fail", globalPropertyi("tu-154/failures/absu_ra3_pitch_fail"))

defineProperty("hydro_circuit_auto_man", globalPropertyi("tu-154/switchers/eng/hydro_circuit_auto_man"))
defineProperty("absu_contr_pitch", globalPropertyf("tu-154/absu/contr_pitch")) -- RA-56 pitch actuator rod travel
-- defineProperty("absu_contr_roll", globalPropertyf("tu-154/absu/contr_roll")) -- RA56 rod deflection in roll
-- defineProperty("absu_contr_yaw", globalPropertyf("tu-154/absu/contr_yaw")) -- RA56 rod deflection in yaw

defineProperty("gs_press_1", globalPropertyf("tu-154/hydro/gs_press_1")) -- hydraulic system 1 pressure
defineProperty("gs_press_2", globalPropertyf("tu-154/hydro/gs_press_2")) -- hydraulic system 2 pressure
defineProperty("gs_press_3", globalPropertyf("tu-154/hydro/gs_press_3")) -- hydraulic system 3 pressure
--defineProperty("buster_on_1", globalPropertyi("tu-154/switchers/console/buster_on_1")) -- booster switch
--defineProperty("buster_on_2", globalPropertyi("tu-154/switchers/console/buster_on_2")) -- booster switch
--defineProperty("buster_on_3", globalPropertyi("tu-154/switchers/console/buster_on_3")) -- booster switch


defineProperty("absu_cmd_pitch", globalPropertyf("tu-154/absu/cmd_pitch"))
--defineProperty("absu_cmd_roll", globalPropertyf("tu-154/absu/cmd_roll"))
--defineProperty("absu_cmd_yaw", globalPropertyf("tu-154/absu/cmd_yaw"))

defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time")) -- time of frame
defineProperty("ppn_ra", globalPropertyf("tu-154/t154/ppn13_lamp1"))
defineProperty("ppn_1", globalPropertyf("tu-154/t154/ppn13_lamp25"))
defineProperty("ppn_2", globalPropertyf("tu-154/t154/ppn13_lamp26"))
defineProperty("ppn_3", globalPropertyf("tu-154/t154/ppn13_lamp27"))
defineProperty("ppn_snp", globalPropertyf("tu-154/t154/ppn13_sbk_test"))
defineProperty("absu_power_27", globalPropertyi("tu-154/absu_power_27"))
defineProperty("absu_power", globalPropertyf("tu-154/absu_power_cc"))

local ra56_act_p=0
local ra1_act_p=0
local ra2_act_p=0
local ra3_act_p=0
local p_kolc1=0
local p_kolc2=0
local p_kolc3=0
local kolc_zad=0.5
local p_kolc1t=0
local p_kolc2t=0
local p_kolc3t=0
local c_cent=0.1
local ra56_act_p_prev=0
local ra1_act_p_prev=0
local ra2_act_p_prev=0
local ra3_act_p_prev=0
local ra_gs1=0
local ra_gs2=0
local ra_gs3=0
local d_ra1_p=0
local d_ra2_p=0
local d_ra3_p=0
local centr=0

local elev_lim = 0.345
--local ail_lim = 0.4
--local yaw_lim = 0.4


local c_ra56=2
local c_act=1
local c_hs=0.5

-- [DT] c_hs is the rate at which a failed / depressurised channel is dragged
-- back to the composite actuator position. It was written as a per-FRAME
-- fraction, so the force-fight settled four times faster at 120 fps than at
-- 30, and it kept moving while frame_time was 0. hs_coef() turns it into the
-- equivalent per-SECOND rate: it reproduces c_hs exactly at FPS_REF, scales
-- correctly either side of it, and returns 0 for a zero delta so a paused sim
-- freezes the servos like every other system in the plugin.
--
-- c_act (=1) and c_cent are deliberately NOT converted. c_act settles in a
-- single frame at any frame rate, and c_cent is a static gain trim on
-- ra56_act_p (steady state = mean/(1+c_cent)) whose transient pole is 0.1 and
-- is therefore dead within one frame. Scaling c_cent by dt would make that
-- steady-state gain depend on the frame rate, which is strictly worse than
-- leaving it alone.
local FPS_REF = 50 -- the frame rate the per-frame constants above were tuned at

local function hs_coef(dt, fail)
	local k = c_hs * fail
	if dt <= 0 or k <= 0 then return 0 end
	if k >= 1 then return 1 end
	local a = 1 - (1 - k) ^ (dt * FPS_REF)
	if a > 1 then a = 1 end
	return a
end

local start1=math.random()*0.06
local start2=math.random()*0.06
local start3=math.random()*0.06

local fail1=1
local fail2=1
local fail3=1


function update()
	local dt = get(frame_time)
	local gs1=get(gs_press_1)
	local gs2=get(gs_press_2)
	local gs3=get(gs_press_3)
	local ra56_cmd_p=get(absu_cmd_pitch)
	local avt=get(hydro_circuit_auto_man)
	--local absu_work_p=bool2int(get(pitch_main_mode)>0)
	local otk1=bool2int(get(absu_ra56_pitch_fail)==1)
	local otk2=bool2int(get(absu_ra56_pitch_fail)>1)
	local otk3=0
	local ppn_test1=get(ppn_ra)+get(ppn_1)>1 and get(ppn_snp)==0
	local ppn_test2=get(ppn_ra)+get(ppn_2)>1 and get(ppn_snp)==0
	local ppn_test3=get(ppn_ra)+get(ppn_3)>1 and get(ppn_snp)==0
	local power27=get(absu_power_27)
	local power=bool2int(get(absu_power)>0)
	
	if power27==1 then
		fail1=math.max(p_kolc1*(1-avt),1-get(hydro_ra56_elev_1))
	else
		fail1=1
	end
	
	if power27==1 then
		fail2=math.max(p_kolc2*(1-avt),1-get(hydro_ra56_elev_2))
	else
		fail2=1
	end
	
	if power27==1 then
		fail3=math.max(p_kolc3*(1-avt),1-get(hydro_ra56_elev_3))
	else
		fail3=1
	end

	
	if fail1==0 then
		start1=0
	end
	if fail2==0 then
		start2=0
	end
	if fail3==0 then
		start3=0
	end
	
    if gs1>180 then
        ra_gs1=6.122841035013264e-12*math.exp(0.122947593444847*gs1)*50
    else
        ra_gs1=0.025/180*gs1*50
    end
    if gs2>180 then
        ra_gs2=6.122841035013264e-12*math.exp(0.122947593444847*gs2)*50
    else
        ra_gs2=0.025/180*gs2*50
    end
    if gs3>180 then
        ra_gs3=6.122841035013264e-12*math.exp(0.122947593444847*gs3)*50
    else
        ra_gs3=0.025/180*gs3*50
    end
    d_ra1_p=(ra56_cmd_p-ra1_act_p*(1-otk1))*ra_gs1*c_ra56*(1-fail1)*power
    d_ra2_p=(ra56_cmd_p-ra2_act_p*(1-otk2))*ra_gs2*c_ra56*(1-fail2)*power
    d_ra3_p=(ra56_cmd_p-ra3_act_p*(1-otk3))*ra_gs3*c_ra56*(1-fail3)*power
    if d_ra1_p>0.8 then
        d_ra1_p=0.8
    elseif d_ra1_p<-0.8 then
        d_ra1_p=-0.8
    end
    if d_ra2_p>0.8 then
        d_ra2_p=0.8
    elseif d_ra2_p<-0.8 then
        d_ra2_p=-0.8
    end
    if d_ra3_p>0.8 then
        d_ra3_p=0.8
    elseif d_ra3_p<-0.8 then
        d_ra3_p=-0.8
    end
	
	if dt>0 and math.abs(d_ra1_p*dt)>math.abs(ra56_cmd_p-ra1_act_p) then
        d_ra1_p=(ra56_cmd_p-ra1_act_p)/dt;
    end
	
	if dt>0 and math.abs(d_ra2_p*dt)>math.abs(ra56_cmd_p-ra2_act_p) then
        d_ra2_p=(ra56_cmd_p-ra2_act_p)/dt;
    end
	
	if dt>0 and math.abs(d_ra3_p*dt)>math.abs(ra56_cmd_p-ra3_act_p) then
        d_ra3_p=(ra56_cmd_p-ra3_act_p)/dt;
    end	
	
    ra1_act_p=ra1_act_p+d_ra1_p*dt-(ra1_act_p-ra56_act_p)*hs_coef(dt,fail1)
    ra2_act_p=ra2_act_p+d_ra2_p*dt-(ra2_act_p-ra56_act_p)*hs_coef(dt,fail2)
    ra3_act_p=ra3_act_p+d_ra3_p*dt-(ra3_act_p-ra56_act_p)*hs_coef(dt,fail3)
    if math.abs(ra1_act_p+start1-ra2_act_p-start2)>0.075 and math.abs(ra2_act_p+start2-ra3_act_p-start3)<0.075 and p_kolc2==0 then
        p_kolc1t=kolc_zad
    else
        if p_kolc1t>0  and avt==1 then
            p_kolc1t=p_kolc1t-dt
        end
    end
    if math.abs(ra1_act_p+start1-ra2_act_p-start2)>0.075 and math.abs(ra3_act_p+start3-ra2_act_p-start2)>0.075 and math.abs(ra1_act_p+start1-ra3_act_p-start3)<0.075 then
        p_kolc2t=kolc_zad
    else
        if p_kolc2t>0 and avt==1 then
            p_kolc2t=p_kolc2t-dt
        end
    end
    if math.abs(ra3_act_p+start3-ra1_act_p-start1)>0.075 and math.abs(ra1_act_p+start1-ra2_act_p-start2)<0.075 then
        p_kolc3t=kolc_zad
    else
        if p_kolc3t>0   and avt==1 then
            p_kolc3t=p_kolc3t-dt
        end
    end
    if math.abs(ra3_act_p+start3-ra1_act_p-start1)>0.075 and math.abs(ra3_act_p+start3-ra2_act_p-start2)>0.075 and math.abs(ra1_act_p+start1-ra2_act_p-start2)>0.075 then
        p_kolc1t=kolc_zad
        p_kolc3t=kolc_zad
    else
        if p_kolc1t>0 and avt==1 then
            p_kolc1t=p_kolc1t-dt
        end
        if p_kolc3t>0 and avt==1 then
            p_kolc3t=p_kolc3t-dt
        end
    end   
    
    if p_kolc1t>0 or ppn_test1 or (get(hydro_ra56_elev_1)==0) then
        p_kolc1=1
    else
        p_kolc1=0
    end
    if p_kolc2t>0 or ppn_test2 or (get(hydro_ra56_elev_2)==0) then
        p_kolc2=1
    else
        p_kolc2=0
    end
    if p_kolc3t>0 or ppn_test3 or (get(hydro_ra56_elev_3)==0) then
        p_kolc3=1
    else
        p_kolc3=0
    end
    if avt==0 and p_kolc1+p_kolc2+p_kolc3>1 then
        p_kolc1=1
        p_kolc2=1
        p_kolc3=1
    end
    -- if p_kolc1+p_kolc2+p_kolc3<3  then 
        -- centr=0
    -- else
        centr=ra56_act_p*c_cent        
    --end
    if fail1+fail2+fail3==0 then
        ra56_act_p=ra56_act_p+((ra1_act_p+ra2_act_p+ra3_act_p)/3-ra56_act_p)*c_act-centr
    elseif fail1==1 and fail2==0 and fail3==0 then
        ra56_act_p=ra56_act_p+((ra2_act_p+ra3_act_p)/2-ra56_act_p)*c_act-centr
    elseif fail2==1 and fail1==0 and fail3==0 then
        ra56_act_p=ra56_act_p+((ra1_act_p+ra3_act_p)/2-ra56_act_p)*c_act-centr
    elseif fail3==1 and fail1==0 and fail2==0 then
        ra56_act_p=ra56_act_p+((ra1_act_p+ra2_act_p)/2-ra56_act_p)*c_act-centr
    elseif fail1==1 and fail3==1 then
        ra56_act_p=ra56_act_p+(ra2_act_p-ra56_act_p)*c_act-centr
    elseif fail2==1 and fail3==1 then
        ra56_act_p=ra56_act_p+(ra1_act_p-ra56_act_p)*c_act-centr
    elseif fail1==1 and fail2==1 then
        ra56_act_p=ra56_act_p+(ra3_act_p-ra56_act_p)*c_act-centr
    else
        ra56_act_p=ra56_act_p_prev-centr
    end
	ra56_act_p_prev=ra56_act_p
	
	if ra56_act_p>elev_lim then
		ra56_act_p=elev_lim
	elseif ra56_act_p<-elev_lim then
		ra56_act_p=-elev_lim
	end
	
	set(absu_ra1_pitch_fail,p_kolc1)
	set(absu_ra2_pitch_fail,p_kolc2)
	set(absu_ra3_pitch_fail,p_kolc3)
	
	-- set(absu_ra1_pitch_kolc,p_kolc1)
	-- set(absu_ra2_pitch_kolc,p_kolc2)
	-- set(absu_ra3_pitch_kolc,p_kolc3)
	
	set(absu_contr_pitch,ra56_act_p)
	set(hod1,d_ra1_p)
	set(hod2,d_ra2_p)
	set(hod3,d_ra3_p)
	-- set(absu_debug1,ra1_act_p)
	-- set(absu_debug2,ra2_act_p)
	-- set(absu_debug3,ra3_act_p)
end