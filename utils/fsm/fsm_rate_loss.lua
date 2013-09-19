print ("FSM loading...")

local function FSM(t)
	local a = {}
	for _,v in ipairs(t) do
		local old, t_function, new, actions = v[1], v[2], v[3], v[4]
    
    if a[old] == nil then a[old] = {} end
    if new then
      table.insert(a[old],{new = new, actions = actions, t_function = t_function})
    end    
  end
  return a
end


--auxiliar functions to be used when detecting happening events
local function register_as_happening(event)
  happening_events[event]=true
end
local function unregister_as_happening(event)
  happening_events[event]=nil
end
local function unregister_as_happening_f(filter)
	for event, _ in pairs(happening_events) do
		local matches = true
		for key, value in pairs(filter) do
			if not event[key]==value then
				matches=false
				break
			end
		end
		if matches then
			happening_events[event]=nil
		end
	end	
end


local shared = {}

--begin generated code
--------------------------------------------------------------------------


--initialization
local initialization_notifs = {
}
local initialization_subs = {
}

-------------------------------

-- Non-Generated functions ----

-- Obtained from:          ----

-- fsm_rate_loss_manual.lua  --

-------------------------------
local functions = {}
local actions = {}
local events = {}
local notifs = {}

--auxiliar functions
local lineal_func = function(a,b,x)
  return a*x+b
end

local getDomain = function(universe)
  if universe == "rate" or universe == "power" then
    return {-3,-2,-1,0,1,2,3}
  end
end

functions.fAnd = function(f1,f2,l)
  local ret1 = f1(l)
  local ret2 = f2(l)
  local maxVal = -100
  if ret1 < ret2 then
    return ret1
  else
    return ret2
  end
end

 --notifs
notifs.change_rate = function(l,e)
  if l<0 then
    return {
      {target_host="127.0.0.1", target_service="NS3-PEP", notification_id=math.random(2^30), 
	    command="decrease_rate", level=-l, station=e.station},
	  } 
  else
	  return {
      {target_host="127.0.0.1", target_service="NS3-PEP", notification_id=math.random(2^30), 
	    command="increase_rate", level=l, station=e.station},
	  }
  end
end

notifs.change_power = function(l,e)
  if l<0 then
    return {
      {target_host="127.0.0.1", target_service="NS3-PEP", notification_id=math.random(2^30), 
	    command="decrease_power", level=-l, station=e.station},
	  } 
  else
	  return {
      {target_host="127.0.0.1", target_service="NS3-PEP", notification_id=math.random(2^30), 
	    command="increase_power", level=l, station=e.station},
	  }
  end
end

notifs.change_rate_power = function(lr,lp,e)
  if lr<0 and lp<0 then
    return {
      {target_host="127.0.0.1", target_service="NS3-PEP", notification_id=math.random(2^30), 
	    command="decrease_rate", level=-l, station=e.station},
      {target_host="127.0.0.1", target_service="NS3-PEP", notification_id=math.random(2^30), 
	    command="decrease_power", level=-l, station=e.station},
	  } 
  elseif lr<0 then
	  return {
      {target_host="127.0.0.1", target_service="NS3-PEP", notification_id=math.random(2^30), 
	    command="decrease_rate", level=-l, station=e.station},
      {target_host="127.0.0.1", target_service="NS3-PEP", notification_id=math.random(2^30), 
	    command="increase_power", level=l, station=e.station},
	  }
  elseif lp<0 then
	  return {
      {target_host="127.0.0.1", target_service="NS3-PEP", notification_id=math.random(2^30), 
	    command="increase_rate", level=l, station=e.station},
      {target_host="127.0.0.1", target_service="NS3-PEP", notification_id=math.random(2^30), 
	    command="decrease_power", level=-l, station=e.station},
	  }    
  else
	  return {
      {target_host="127.0.0.1", target_service="NS3-PEP", notification_id=math.random(2^30), 
	    command="increase_rate", level=l, station=e.station},
      {target_host="127.0.0.1", target_service="NS3-PEP", notification_id=math.random(2^30), 
	    command="increase_power", level=l, station=e.station},
	  }      
  end
end

	-- function action_kr(e)
actions.action_kr = function(e)
	local levels = getDomain('rate')
	local retMax = -100
	local l
	for _,lr in ipairs(levels) do
		local ret = functions.action_kr(lr)
		if ret > retMax then
			retMax = ret
			l = lr
		end
	end
	return notifs.change_rate(l,e)
end

	-- Membership function for action_kr
functions.action_kr = function(l)
  if (l<0) then
    return lineal_func(1/3,1,l)
  else
	  return lineal_func(-1/3,1,l)
  end
end

	-- function action_ip(e)
actions.action_ip = function(e)
	local levels = getDomain('power')
	local retMax = -100
	local l
	for _,lp in ipairs(levels) do
		local ret = functions.action_ip(lp)
		if ret > retMax then
			retMax = ret
			l = lp
		end
	end
	return notifs.change_power(l,e)
end

	-- Membership function for action_ip
functions.action_ip = function(l)
  return lineal_func(1/6,0.5,l)
end

	-- function action_dr(e)
actions.action_dr = function(e)
	local levels = getDomain('rate')
	local retMax = -100
	local l
	for _,lr in ipairs(levels) do
		local ret = functions.action_dr(lr)
		if ret > retMax then
			retMax = ret
			l = lr
		end
	end
	return notifs.change_rate(l,e)
end
	-- Membership function for action_dr
functions.action_dr = function(l)
  return lineal_func(-1/6,0.5,l)
end

	-- function action_kp(e)
actions.action_kp = function(e)
	local levels = getDomain('power')
	local retMax = -100
	local l
	for _,lp in ipairs(levels) do
		local ret = functions.action_kp(lp)
		if ret > retMax then
			retMax = ret
			l = lp
		end
	end
	return notifs.change_power(l,e)
end

	-- Membership function for action_kp
functions.action_kp = function(l)
  if (l<0) then
    return lineal_func(1/3,1,l)
  else
	  return lineal_func(-1/3,1,l)
  end
end

	-- function event_ll(e)
events.event_ll = function(e) 
	shared["incomming_event"] = e
	if e.mib and e.value and string.match(e.mib, "loss", 1) then
	  local loss = tonumber(e.value)
    if loss < 0.3 then
      return lineal_func(-(0.2/0.3),1,loss)
    else
      return lineal_func(-(0.2/0.7),0.2/0.7,loss)
    end
  else
    return 0
  end
end

	-- function event_hl(e)
events.event_hl = function(e) 
	shared["incomming_event"] = e
	if e.mib and e.value and string.match(e.mib, "loss", 1) then
	  local loss = tonumber(e.value)
    if loss < 0.3 then
      return lineal_func((0.2/0.3),0,loss)
    else
      return lineal_func((0.2/0.7),0.5/0.7,loss)
    end
  else
    return 0
  end
end

	-- function event_hp(e)
events.event_hp = function(e) 
	shared["incomming_event"] = e
  if e.mib and e.value and string.match(e.mib, "power", 1) then
    local pow = tonumber(e.value)
    if pow < 10 then
      return lineal_func((0.5/10),0,pow)
    else
      return lineal_func((0.2/7),3.6/7,pow)
    end
  else
    return 0
  end
end

	-- function event_lp(e)
events.event_lp = function(e) 
	shared["incomming_event"] = e
  if e.mib and e.value and string.match(e.mib, "power", 1) then
    local pow = tonumber(e.value)
    if pow < 5 then
      return lineal_func(-(0.2/5),1,pow)
    else
      return lineal_func(-(0.5/12),8.5/12,pow)
    end
  else
    return 0
  end
end

	-- function action_ir(e)
actions.action_ir = function(e)
	local levels = getDomain('rate')
	local retMax = -100
	local l
	for _,lr in ipairs(levels) do
		local ret = functions.action_ir(lr)
		if ret > retMax then
			retMax = ret
			l = lr
		end
	end
	return notifs.change_rate(l,e)
end
	-- Membership function for action_ir
functions.action_ir = function(l)
  return lineal_func(1/6,0.5,l)
end


-------------------------------

-- End of functions        ----

-------------------------------

local init_state="307"
--shares

--events
-----------------------------------------------
--          BEGIN COMPOSITE EVENTS           --
-----------------------------------------------
-- (¬hp∧¬ll)
events.f8 = function(e) 
	local left= events.f5(e)
	local right= events.f1(e)
	if left < right then return left else return right end
end
-- ¬ll
events.f1 = function(e) 
	local nonneg = events.event_ll(e)
	return 1-nonneg
end
-- (hp∧¬ll)
events.f0 = function(e) 
	local left= events.event_hp(e)
	local right= events.f1(e)
	if left < right then return left else return right end
end
-- (hp∧ll)
events.f2 = function(e) 
	local left= events.event_hp(e)
	local right= events.event_ll(e)
	if left < right then return left else return right end
end
-- ¬hp
events.f5 = function(e) 
	local nonneg = events.event_hp(e)
	return 1-nonneg
end
-- (¬hp∧ll)
events.f4 = function(e) 
	local left= events.f5(e)
	local right= events.event_ll(e)
	if left < right then return left else return right end
end
-----------------------------------------------
--           END COMPOSITE EVENTS            --
-----------------------------------------------

--actions
-----------------------------------------------
--          BEGIN COMPOSITE ACTIONS          --
-----------------------------------------------
-- f6
actions.f6 = function(e)
	local levels = getDomain('rate')
	local retMax = -100
	local l
	for _,lr in ipairs(levels) do
		local ret = functions.fAnd(functions.action_dr, functions.action_kr,lr)
		if ret > retMax then
			retMax = ret
			l = lr
		end
	end
	return notifs.change_rate(l,e)
end
-- f7
actions.f7 = function(e)
	local levels = getDomain('power')
	local retMax = -100
	local l
	for _,lp in ipairs(levels) do
		local ret = functions.fAnd(functions.action_kp, functions.action_ip,lp)
		if ret > retMax then
			retMax = ret
			l = lp
		end
	end
	return notifs.change_power(l,e)
end
-- f9
actions.f9 = function(e)
	local levels = getDomain('rate')
	local retMax = -100
	local l
	for _,lr in ipairs(levels) do
		local ret = functions.fAnd(functions.action_kr, functions.action_ir,lr)
		if ret > retMax then
			retMax = ret
			l = lr
		end
	end
	return notifs.change_rate(l,e)
end
-- f3
actions.f3 = function(e)
	local levels = getDomain('rate')
	local retMax = -100
	local l
	for _,lr in ipairs(levels) do
		local ret = functions.fAnd(functions.action_dr, functions.action_ir,lr)
		if ret > retMax then
			retMax = ret
			l = lr
		end
	end
	return notifs.change_rate(l,e)
end
-----------------------------------------------
--           END COMPOSITE ACTIONS           --
-----------------------------------------------

--transitions
local fsm = FSM{
  {"244", events.f0, "212", nil},
  {"244", events.f1, "258", {actions.action_dr, actions.action_kp, }},
  {"244", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"244", events.event_ll, "259", nil},
  {"244", events.f8, "211", nil},
  {"244", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"243", events.f0, "212", nil},
  {"243", events.event_hp, "256", {actions.action_dr, actions.action_kp, }},
  {"243", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"243", events.f5, "257", nil},
  {"243", events.f8, "211", nil},
  {"243", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"242", events.f8, "243", {actions.action_kr, actions.action_ip, }},
  {"242", events.f2, "228", {actions.action_dr, actions.action_kp, }},
  {"242", events.f0, "244", {actions.f6, actions.f7, }},
  {"242", events.f4, "242", nil},
  {"241", events.event_ll, "241", nil},
  {"241", events.f1, "273", {actions.f6, actions.f7, }},
  {"248", events.f0, "212", nil},
  {"248", events.event_ll, "299", {actions.action_ir, actions.action_kp, }},
  {"248", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"248", events.f8, "211", nil},
  {"248", events.f1, "298", {actions.action_dr, actions.action_kp, }},
  {"248", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"247", events.f0, "212", nil},
  {"247", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"247", events.event_ll, "259", nil},
  {"247", events.f8, "211", nil},
  {"247", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"247", events.f1, "258", {actions.action_dr, actions.action_kp, }},
  {"246", events.f2, "247", {actions.f3, actions.action_kp, }},
  {"246", events.f0, "248", {actions.action_dr, actions.action_kp, }},
  {"246", events.f4, "249", {actions.action_ir, actions.action_kp, }},
  {"246", events.f8, "246", nil},
  {"245", events.f0, "212", nil},
  {"245", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"245", events.f5, "296", {actions.action_kr, actions.action_ip, }},
  {"245", events.f8, "211", nil},
  {"245", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"245", events.event_hp, "297", nil},
  {"252", events.f0, "212", nil},
  {"252", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"252", events.f8, "211", nil},
  {"252", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"251", events.f0, "212", nil},
  {"251", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"251", events.f8, "211", nil},
  {"251", events.f1, "262", {actions.action_kr, actions.action_ip, }},
  {"251", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"251", events.event_ll, "263", nil},
  {"250", events.f8, "253", {actions.action_kr, actions.action_ip, }},
  {"250", events.f4, "250", nil},
  {"250", events.f0, "252", {actions.f6, actions.f7, }},
  {"250", events.f2, "251", {actions.action_dr, actions.action_kp, }},
  {"249", events.f0, "212", nil},
  {"249", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"249", events.event_hp, "256", {actions.action_dr, actions.action_kp, }},
  {"249", events.f8, "211", nil},
  {"249", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"249", events.f5, "257", nil},
  {"256", events.f0, "212", nil},
  {"256", events.f1, "258", {actions.action_dr, actions.action_kp, }},
  {"256", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"256", events.event_ll, "259", nil},
  {"256", events.f8, "211", nil},
  {"256", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"255", events.f0, "212", nil},
  {"255", events.f4, "281", {actions.action_kr, actions.action_ip, }},
  {"255", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"255", events.f0, "268", {actions.f6, actions.f7, }},
  {"255", events.f2, "294", {actions.action_dr, actions.action_kp, }},
  {"255", events.f8, "211", nil},
  {"255", events.f8, "295", {actions.action_kr, actions.action_ip, }},
  {"255", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"254", events.f0, "212", nil},
  {"254", events.f5, "281", {actions.action_kr, actions.action_ip, }},
  {"254", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"254", events.event_hp, "278", {actions.action_dr, actions.action_kp, }},
  {"254", events.f8, "211", nil},
  {"254", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"253", events.f0, "212", nil},
  {"253", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"253", events.event_hp, "280", {actions.action_dr, actions.action_kp, }},
  {"253", events.f8, "211", nil},
  {"253", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"253", events.f5, "275", nil},
  {"227", events.f0, "212", nil},
  {"227", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"227", events.event_ll, "263", nil},
  {"227", events.f8, "211", nil},
  {"227", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"227", events.f1, "262", {actions.action_kr, actions.action_ip, }},
  {"228", events.f0, "212", nil},
  {"228", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"228", events.event_ll, "206", nil},
  {"228", events.f1, "207", {actions.f6, actions.f7, }},
  {"228", events.f8, "211", nil},
  {"228", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"225", events.f0, "212", nil},
  {"225", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"225", events.f8, "211", nil},
  {"225", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"226", events.f0, "212", nil},
  {"226", events.event_ll, "266", {actions.action_ir, actions.action_kp, }},
  {"226", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"226", events.f1, "269", {actions.action_kr, actions.action_ip, }},
  {"226", events.f8, "211", nil},
  {"226", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"231", events.f0, "212", nil},
  {"231", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"231", events.f5, "275", nil},
  {"231", events.event_hp, "280", {actions.action_dr, actions.action_kp, }},
  {"231", events.f8, "211", nil},
  {"231", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"232", events.f0, "212", nil},
  {"232", events.f0, "303", {actions.action_dr, actions.action_kp, }},
  {"232", events.f2, "304", {actions.f3, actions.action_kp, }},
  {"232", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"232", events.f8, "305", nil},
  {"232", events.f8, "211", nil},
  {"232", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"232", events.f4, "285", {actions.action_ir, actions.action_kp, }},
  {"229", events.f2, "228", {actions.action_dr, actions.action_kp, }},
  {"229", events.f8, "231", {actions.f6, actions.f7, }},
  {"229", events.f4, "229", nil},
  {"229", events.f0, "230", {actions.f6, actions.f7, }},
  {"230", events.f0, "212", nil},
  {"230", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"230", events.f8, "211", nil},
  {"230", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"235", events.f0, "212", nil},
  {"235", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"235", events.event_ll, "260", {actions.action_ir, actions.action_kp, }},
  {"235", events.f8, "211", nil},
  {"235", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"235", events.f1, "261", nil},
  {"236", events.f0, "212", nil},
  {"236", events.f0, "289", {actions.action_dr, actions.action_kp, }},
  {"236", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"236", events.f2, "282", nil},
  {"236", events.f8, "211", nil},
  {"236", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"236", events.f4, "284", {actions.action_kr, actions.action_ip, }},
  {"236", events.f8, "283", {actions.f6, actions.f7, }},
  {"233", events.f0, "212", nil},
  {"233", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"233", events.f8, "211", nil},
  {"233", events.f1, "261", nil},
  {"233", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"233", events.event_ll, "260", {actions.action_ir, actions.action_kp, }},
  {"234", events.f0, "212", nil},
  {"234", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"234", events.f0, "288", nil},
  {"234", events.f8, "286", {actions.action_kr, actions.action_ip, }},
  {"234", events.f8, "211", nil},
  {"234", events.f4, "293", {actions.f9, actions.f7, }},
  {"234", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"234", events.f2, "287", {actions.action_ir, actions.action_kp, }},
  {"239", events.f0, "212", nil},
  {"239", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"239", events.f8, "211", nil},
  {"239", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"239", events.event_hp, "277", {actions.action_dr, actions.action_kp, }},
  {"239", events.f5, "274", {actions.action_kr, actions.action_ip, }},
  {"240", events.f8, "239", {actions.action_kr, actions.action_ip, }},
  {"240", events.f4, "240", nil},
  {"240", events.f0, "238", {actions.action_kr, actions.action_ip, }},
  {"240", events.f2, "241", nil},
  {"237", events.f0, "212", nil},
  {"237", events.f1, "258", {actions.action_dr, actions.action_kp, }},
  {"237", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"237", events.event_ll, "259", nil},
  {"237", events.f8, "211", nil},
  {"237", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"238", events.f0, "212", nil},
  {"238", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"238", events.f0, "270", {actions.action_dr, actions.action_kp, }},
  {"238", events.f8, "271", {actions.f6, actions.f7, }},
  {"238", events.f2, "277", {actions.action_dr, actions.action_kp, }},
  {"238", events.f8, "211", nil},
  {"238", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"238", events.f4, "276", {actions.action_kr, actions.action_ip, }},
  {"274", events.f0, "212", nil},
  {"274", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"274", events.event_hp, "256", {actions.action_dr, actions.action_kp, }},
  {"274", events.f5, "257", nil},
  {"274", events.f8, "211", nil},
  {"274", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"273", events.f0, "212", nil},
  {"273", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"273", events.f5, "272", {actions.action_kr, actions.action_ip, }},
  {"273", events.f8, "211", nil},
  {"273", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"273", events.event_hp, "267", {actions.action_dr, actions.action_kp, }},
  {"276", events.f0, "212", nil},
  {"276", events.f0, "301", {actions.action_dr, actions.action_kp, }},
  {"276", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"276", events.f2, "256", {actions.action_dr, actions.action_kp, }},
  {"276", events.f4, "300", nil},
  {"276", events.f8, "211", nil},
  {"276", events.f8, "302", {actions.action_dr, actions.action_kp, }},
  {"276", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"275", events.event_hp, "280", {actions.action_dr, actions.action_kp, }},
  {"275", events.f5, "275", nil},
  {"278", events.f0, "212", nil},
  {"278", events.f5, "265", {actions.action_kr, actions.action_ip, }},
  {"278", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"278", events.event_hp, "264", nil},
  {"278", events.f8, "211", nil},
  {"278", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"277", events.f0, "212", nil},
  {"277", events.f4, "284", {actions.action_kr, actions.action_ip, }},
  {"277", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"277", events.f2, "282", nil},
  {"277", events.f8, "211", nil},
  {"277", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"277", events.f8, "283", {actions.f6, actions.f7, }},
  {"277", events.f0, "289", {actions.action_dr, actions.action_kp, }},
  {"280", events.f0, "212", nil},
  {"280", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"280", events.f8, "211", nil},
  {"280", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"279", events.f0, "254", {actions.action_dr, actions.action_kp, }},
  {"279", events.f4, "241", nil},
  {"279", events.f8, "255", {actions.action_dr, actions.action_kp, }},
  {"279", events.f2, "279", nil},
  {"282", events.f8, "283", {actions.f6, actions.f7, }},
  {"282", events.f4, "284", {actions.action_kr, actions.action_ip, }},
  {"282", events.f2, "282", nil},
  {"282", events.f0, "289", {actions.action_dr, actions.action_kp, }},
  {"281", events.f0, "212", nil},
  {"281", events.f8, "253", {actions.action_kr, actions.action_ip, }},
  {"281", events.f2, "251", {actions.action_dr, actions.action_kp, }},
  {"281", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"281", events.f4, "250", nil},
  {"281", events.f8, "211", nil},
  {"281", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"281", events.f0, "252", {actions.f6, actions.f7, }},
  {"284", events.f0, "212", nil},
  {"284", events.f1, "258", {actions.action_dr, actions.action_kp, }},
  {"284", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"284", events.event_ll, "259", nil},
  {"284", events.f8, "211", nil},
  {"284", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"283", events.f0, "212", nil},
  {"283", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"283", events.f8, "211", nil},
  {"283", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"286", events.f0, "212", nil},
  {"286", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"286", events.f1, "261", nil},
  {"286", events.event_ll, "260", {actions.action_ir, actions.action_kp, }},
  {"286", events.f8, "211", nil},
  {"286", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"285", events.f0, "212", nil},
  {"285", events.event_hp, "280", {actions.action_dr, actions.action_kp, }},
  {"285", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"285", events.f5, "275", nil},
  {"285", events.f8, "211", nil},
  {"285", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"288", events.f4, "293", {actions.f9, actions.f7, }},
  {"288", events.f8, "286", {actions.action_kr, actions.action_ip, }},
  {"288", events.f2, "287", {actions.action_ir, actions.action_kp, }},
  {"288", events.f0, "288", nil},
  {"287", events.f0, "212", nil},
  {"287", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"287", events.event_hp, "297", nil},
  {"287", events.f8, "211", nil},
  {"287", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"287", events.f5, "296", {actions.action_kr, actions.action_ip, }},
  {"257", events.f5, "257", nil},
  {"257", events.event_hp, "256", {actions.action_dr, actions.action_kp, }},
  {"258", events.f0, "212", nil},
  {"258", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"258", events.f8, "211", nil},
  {"258", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"259", events.event_ll, "259", nil},
  {"259", events.f1, "258", {actions.action_dr, actions.action_kp, }},
  {"260", events.f0, "212", nil},
  {"260", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"260", events.f8, "211", nil},
  {"260", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"261", events.event_ll, "260", {actions.action_ir, actions.action_kp, }},
  {"261", events.f1, "261", nil},
  {"262", events.f0, "212", nil},
  {"262", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"262", events.f8, "211", nil},
  {"262", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"263", events.f1, "262", {actions.action_kr, actions.action_ip, }},
  {"263", events.event_ll, "263", nil},
  {"264", events.f5, "265", {actions.action_kr, actions.action_ip, }},
  {"264", events.event_hp, "264", nil},
  {"265", events.f0, "212", nil},
  {"265", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"265", events.event_ll, "263", nil},
  {"265", events.f1, "262", {actions.action_kr, actions.action_ip, }},
  {"265", events.f8, "211", nil},
  {"265", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"266", events.f0, "212", nil},
  {"266", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"266", events.f1, "262", {actions.action_kr, actions.action_ip, }},
  {"266", events.event_ll, "263", nil},
  {"266", events.f8, "211", nil},
  {"266", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"267", events.f0, "212", nil},
  {"267", events.event_hp, "297", nil},
  {"267", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"267", events.f8, "211", nil},
  {"267", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"267", events.f5, "296", {actions.action_kr, actions.action_ip, }},
  {"268", events.f0, "212", nil},
  {"268", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"268", events.event_hp, "297", nil},
  {"268", events.f8, "211", nil},
  {"268", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"268", events.f5, "296", {actions.action_kr, actions.action_ip, }},
  {"269", events.f0, "212", nil},
  {"269", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"269", events.f1, "261", nil},
  {"269", events.f8, "211", nil},
  {"269", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"269", events.event_ll, "260", {actions.action_ir, actions.action_kp, }},
  {"270", events.f0, "212", nil},
  {"270", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"270", events.event_hp, "297", nil},
  {"270", events.f5, "296", {actions.action_kr, actions.action_ip, }},
  {"270", events.f8, "211", nil},
  {"270", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"271", events.f0, "212", nil},
  {"271", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"271", events.f5, "275", nil},
  {"271", events.f8, "211", nil},
  {"271", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"271", events.event_hp, "280", {actions.action_dr, actions.action_kp, }},
  {"272", events.f0, "212", nil},
  {"272", events.event_hp, "280", {actions.action_dr, actions.action_kp, }},
  {"272", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"272", events.f8, "211", nil},
  {"272", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"272", events.f5, "275", nil},
  {"307", events.f0, "212", nil},
  {"307", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"307", events.f8, "211", nil},
  {"307", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"305", events.f8, "305", nil},
  {"305", events.f4, "285", {actions.action_ir, actions.action_kp, }},
  {"305", events.f2, "304", {actions.f3, actions.action_kp, }},
  {"305", events.f0, "303", {actions.action_dr, actions.action_kp, }},
  {"295", events.f0, "212", nil},
  {"295", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"295", events.f8, "211", nil},
  {"295", events.f5, "275", nil},
  {"295", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"295", events.event_hp, "280", {actions.action_dr, actions.action_kp, }},
  {"296", events.f0, "212", nil},
  {"296", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"296", events.f8, "211", nil},
  {"296", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"293", events.f0, "212", nil},
  {"293", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"293", events.f8, "211", nil},
  {"293", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"294", events.f0, "212", nil},
  {"294", events.f4, "265", {actions.action_kr, actions.action_ip, }},
  {"294", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"294", events.f8, "290", {actions.action_kr, actions.action_ip, }},
  {"294", events.f2, "292", nil},
  {"294", events.f8, "211", nil},
  {"294", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"294", events.f0, "291", {actions.action_kr, actions.action_ip, }},
  {"291", events.f0, "212", nil},
  {"291", events.f5, "296", {actions.action_kr, actions.action_ip, }},
  {"291", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"291", events.event_hp, "297", nil},
  {"291", events.f8, "211", nil},
  {"291", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"292", events.f2, "292", nil},
  {"292", events.f4, "265", {actions.action_kr, actions.action_ip, }},
  {"292", events.f8, "290", {actions.action_kr, actions.action_ip, }},
  {"292", events.f0, "291", {actions.action_kr, actions.action_ip, }},
  {"289", events.f0, "212", nil},
  {"289", events.f5, "296", {actions.action_kr, actions.action_ip, }},
  {"289", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"289", events.f8, "211", nil},
  {"289", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"289", events.event_hp, "297", nil},
  {"290", events.f0, "212", nil},
  {"290", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"290", events.f8, "211", nil},
  {"290", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"303", events.f0, "212", nil},
  {"303", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"303", events.event_ll, "260", {actions.action_ir, actions.action_kp, }},
  {"303", events.f1, "261", nil},
  {"303", events.f8, "211", nil},
  {"303", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"304", events.f0, "212", nil},
  {"304", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"304", events.f8, "211", nil},
  {"304", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"301", events.f0, "212", nil},
  {"301", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"301", events.f8, "211", nil},
  {"301", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"302", events.f0, "212", nil},
  {"302", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"302", events.event_hp, "280", {actions.action_dr, actions.action_kp, }},
  {"302", events.f5, "275", nil},
  {"302", events.f8, "211", nil},
  {"302", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"299", events.f0, "212", nil},
  {"299", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"299", events.event_ll, "259", nil},
  {"299", events.f8, "211", nil},
  {"299", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"299", events.f1, "258", {actions.action_dr, actions.action_kp, }},
  {"300", events.f8, "302", {actions.action_dr, actions.action_kp, }},
  {"300", events.f0, "301", {actions.action_dr, actions.action_kp, }},
  {"300", events.f2, "256", {actions.action_dr, actions.action_kp, }},
  {"300", events.f4, "300", nil},
  {"297", events.event_hp, "297", nil},
  {"297", events.f5, "296", {actions.action_kr, actions.action_ip, }},
  {"298", events.f0, "212", nil},
  {"298", events.f1, "261", nil},
  {"298", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"298", events.event_ll, "260", {actions.action_ir, actions.action_kp, }},
  {"298", events.f8, "211", nil},
  {"298", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"208", events.f0, "212", nil},
  {"208", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"208", events.event_hp, "264", nil},
  {"208", events.f8, "211", nil},
  {"208", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"208", events.f5, "265", {actions.action_kr, actions.action_ip, }},
  {"207", events.f0, "212", nil},
  {"207", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"207", events.f8, "211", nil},
  {"207", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"206", events.f1, "207", {actions.f6, actions.f7, }},
  {"206", events.event_ll, "206", nil},
  {"205", events.f0, "212", nil},
  {"205", events.f1, "207", {actions.f6, actions.f7, }},
  {"205", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"205", events.event_ll, "206", nil},
  {"205", events.f8, "211", nil},
  {"205", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"204", events.f8, "202", {actions.f6, actions.f7, }},
  {"204", events.f0, "203", {actions.action_dr, actions.action_kp, }},
  {"204", events.f2, "204", nil},
  {"204", events.f4, "205", {actions.action_kr, actions.action_ip, }},
  {"203", events.f0, "212", nil},
  {"203", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"203", events.event_hp, "264", nil},
  {"203", events.f5, "265", {actions.action_kr, actions.action_ip, }},
  {"203", events.f8, "211", nil},
  {"203", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"202", events.f0, "212", nil},
  {"202", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"202", events.f1, "262", {actions.action_kr, actions.action_ip, }},
  {"202", events.event_ll, "263", nil},
  {"202", events.f8, "211", nil},
  {"202", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"223", events.f0, "212", nil},
  {"223", events.f4, "205", {actions.action_kr, actions.action_ip, }},
  {"223", events.f0, "245", {actions.f6, actions.f7, }},
  {"223", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"223", events.f2, "224", nil},
  {"223", events.f8, "211", nil},
  {"223", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"223", events.f8, "225", {actions.f6, actions.f7, }},
  {"224", events.f4, "205", {actions.action_kr, actions.action_ip, }},
  {"224", events.f8, "225", {actions.f6, actions.f7, }},
  {"224", events.f2, "224", nil},
  {"224", events.f0, "245", {actions.f6, actions.f7, }},
  {"221", events.f0, "212", nil},
  {"221", events.f0, "248", {actions.action_dr, actions.action_kp, }},
  {"221", events.f4, "249", {actions.action_ir, actions.action_kp, }},
  {"221", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"221", events.f8, "246", nil},
  {"221", events.f8, "211", nil},
  {"221", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"221", events.f2, "247", {actions.f3, actions.action_kp, }},
  {"222", events.f0, "212", nil},
  {"222", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"222", events.f0, "234", {actions.action_dr, actions.action_kp, }},
  {"222", events.f2, "236", {actions.action_ir, actions.action_kp, }},
  {"222", events.f8, "211", nil},
  {"222", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"222", events.f4, "237", {actions.f9, actions.f7, }},
  {"222", events.f8, "235", {actions.f6, actions.f7, }},
  {"219", events.f0, "212", nil},
  {"219", events.f0, "252", {actions.f6, actions.f7, }},
  {"219", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"219", events.f2, "251", {actions.action_dr, actions.action_kp, }},
  {"219", events.f8, "211", nil},
  {"219", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"219", events.f4, "250", nil},
  {"219", events.f8, "253", {actions.action_kr, actions.action_ip, }},
  {"220", events.f0, "212", nil},
  {"220", events.f2, "228", {actions.action_dr, actions.action_kp, }},
  {"220", events.f4, "242", nil},
  {"220", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"220", events.f8, "243", {actions.action_kr, actions.action_ip, }},
  {"220", events.f0, "244", {actions.f6, actions.f7, }},
  {"220", events.f8, "211", nil},
  {"220", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"217", events.f0, "212", nil},
  {"217", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"217", events.f4, "205", {actions.action_kr, actions.action_ip, }},
  {"217", events.f2, "204", nil},
  {"217", events.f8, "202", {actions.f6, actions.f7, }},
  {"217", events.f8, "211", nil},
  {"217", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"217", events.f0, "203", {actions.action_dr, actions.action_kp, }},
  {"218", events.f0, "212", nil},
  {"218", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"218", events.event_ll, "263", nil},
  {"218", events.f1, "262", {actions.action_kr, actions.action_ip, }},
  {"218", events.f8, "211", nil},
  {"218", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"215", events.f0, "212", nil},
  {"215", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"215", events.f2, "208", {actions.action_ir, actions.action_kp, }},
  {"215", events.f0, "209", nil},
  {"215", events.f4, "227", {actions.f9, actions.f7, }},
  {"215", events.f8, "226", {actions.action_kr, actions.action_ip, }},
  {"215", events.f8, "211", nil},
  {"215", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"216", events.f0, "212", nil},
  {"216", events.f2, "218", {actions.f3, actions.action_kp, }},
  {"216", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"216", events.f0, "233", {actions.f6, actions.f7, }},
  {"216", events.f4, "219", {actions.action_ir, actions.action_kp, }},
  {"216", events.f8, "211", nil},
  {"216", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"216", events.f8, "232", {actions.action_kr, actions.action_ip, }},
  {"213", events.f0, "212", nil},
  {"213", events.f8, "255", {actions.action_dr, actions.action_kp, }},
  {"213", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"213", events.f2, "279", nil},
  {"213", events.f0, "254", {actions.action_dr, actions.action_kp, }},
  {"213", events.f4, "241", nil},
  {"213", events.f8, "211", nil},
  {"213", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"214", events.f0, "212", nil},
  {"214", events.f2, "228", {actions.action_dr, actions.action_kp, }},
  {"214", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"214", events.f4, "229", nil},
  {"214", events.f8, "231", {actions.f6, actions.f7, }},
  {"214", events.f8, "211", nil},
  {"214", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"214", events.f0, "230", {actions.f6, actions.f7, }},
  {"211", events.f2, "223", {actions.f3, actions.action_kp, }},
  {"211", events.f8, "221", {actions.action_kr, actions.action_ip, }},
  {"211", events.f0, "222", {actions.f6, actions.f7, }},
  {"211", events.f4, "220", {actions.f9, actions.f7, }},
  {"212", events.f4, "214", {actions.f9, actions.f7, }},
  {"212", events.f8, "216", {actions.f6, actions.f7, }},
  {"212", events.f2, "217", {actions.f3, actions.action_kp, }},
  {"212", events.f0, "215", {actions.action_dr, actions.action_kp, }},
  {"209", events.f2, "208", {actions.action_ir, actions.action_kp, }},
  {"209", events.f4, "227", {actions.f9, actions.f7, }},
  {"209", events.f8, "226", {actions.action_kr, actions.action_ip, }},
  {"209", events.f0, "209", nil},
  {"210", events.f0, "212", nil},
  {"210", events.f4, "210", {actions.action_ir, actions.action_kp, }},
  {"210", events.f2, "241", nil},
  {"210", events.f8, "211", nil},
  {"210", events.f2, "213", {actions.action_ir, actions.action_kp, }},
  {"210", events.f8, "239", {actions.action_kr, actions.action_ip, }},
  {"210", events.f4, "240", nil},
  {"210", events.f0, "238", {actions.action_kr, actions.action_ip, }},
}

--final states
local is_accept =   {
['244']=true,
['243']=true,
['248']=true,
['247']=true,
['245']=true,
['252']=true,
['251']=true,
['249']=true,
['256']=true,
['255']=true,
['254']=true,
['253']=true,
['227']=true,
['228']=true,
['225']=true,
['226']=true,
['231']=true,
['232']=true,
['230']=true,
['235']=true,
['236']=true,
['233']=true,
['234']=true,
['239']=true,
['237']=true,
['238']=true,
['274']=true,
['273']=true,
['276']=true,
['278']=true,
['277']=true,
['280']=true,
['281']=true,
['284']=true,
['283']=true,
['286']=true,
['285']=true,
['287']=true,
['258']=true,
['260']=true,
['262']=true,
['265']=true,
['266']=true,
['267']=true,
['268']=true,
['269']=true,
['270']=true,
['271']=true,
['272']=true,
['307']=true,
['295']=true,
['296']=true,
['293']=true,
['294']=true,
['291']=true,
['289']=true,
['290']=true,
['303']=true,
['304']=true,
['301']=true,
['302']=true,
['299']=true,
['298']=true,
['208']=true,
['207']=true,
['205']=true,
['203']=true,
['202']=true,
['223']=true,
['221']=true,
['222']=true,
['219']=true,
['220']=true,
['217']=true,
['218']=true,
['215']=true,
['216']=true,
['213']=true,
['214']=true,
['210']=true,
}


--------------------------------------------------------------------------
--end generated code

local current_state=init_state --current state
local i_event=1 --current event in window

function initialize()
 	print("FSM: initializing")
	return initialization_subs or {}, initialization_notifs or {}
end

local function dump_window()
	local s="=> "
	for _,e in ipairs(window) do
		if e.event.message_type=="trap" then
			s=s .. tostring(e.event.mib) ..","
		else
			s=s .. "#,"
		end
	end
	return s
end

--advances the machine a single step.
--returns nil if arrives at the end the window, or the event is not recognized
--otherwise, returns the resulting list from the action
local function fst_step()
	local event_reg = window[i_event]
	if not event_reg then return end --window finished
	local event=event_reg.event
			
	local state=fsm[current_state]
  assert(#state>0)
	--search first transition that verifies e
	local best_tf=-1
	local transition
	for _, l in ipairs(state) do
    local tf=l.t_function(event)
    if best_tf<tf then
      best_tf=tf
      transition=l
    end
	end 
  assert(transition)
	
	local ret_call = {}
	if transition.actions then
    for _, action in ipairs(transition.actions) do
      local ret_action = action(event)
      for _, v in ipairs(ret_action) do ret_call[#ret_call+1] = v end
    end
  end
  
	i_event=i_event+1
	current_state = transition.new
	print (current_state, #fsm[current_state],  #ret_call, is_accept[current_state], #fsm[current_state]==0)
  return ret_call, is_accept[current_state], #fsm[current_state]==0
end

function step()
	print("FSM: WINDOW STEP ", #window, dump_window())
	
	local ret, accept, final = {}, false, false
  
  repeat
    local ret_step
		ret_step, accept, final = fst_step()
		if ret_step then 
			for _, r in ipairs(ret_step) do ret[#ret+1]=r	end --queue generated actions
		end
  until accept or i_event>#window
  assert(not (final and not accept))
  
  if accept then
    --purge consumed events from window
    print("Purge consumed events", #window)
    local i=1
    local e = window[i_event]
    repeat
      if happening_events[window[i]] then
        i=i+1
      else
        table.remove(window, i)
        i_event=i_event-1
      end
    until window[i]==e
    if not happening_events[window[i]] then table.remove(window, i) end
    print("Purge consumed events", #window)
  end
  
	if #ret>0 then
		print ("FSM: WINDOW STEP generating output ", #ret, accept, final, current_state)
	end
	return ret, accept, final
end

function reset()
  current_state=init_state 
  i_event=1 
  happening_events={}
  print ("FSM: RESET")
end

print ("FSM loaded.")

