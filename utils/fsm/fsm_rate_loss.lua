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
    return {-1,0,1}
  end
end

functions.fAnd = function(f1,f2)
  local ret1 = f1
  local ret2 = f2
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

local init_state="216"
--shares

--events
-----------------------------------------------
--          BEGIN COMPOSITE EVENTS           --
-----------------------------------------------
-- ((hl∧hp)∧¬ll)
events.f34 = function(e) 
	local left= events.f15(e)
	local right= events.f4(e)
	if left < right then return left else return right end
end
-- (((hl∧hp)∧¬ll)∧¬lp)
events.f33 = function(e) 
	local left= events.f34(e)
	local right= events.f5(e)
	if left < right then return left else return right end
end
-- (((hl∧¬hp)∧ll)∧lp)
events.f32 = function(e) 
	local left= events.f31(e)
	local right= events.event_lp(e)
	if left < right then return left else return right end
end
-- ((hl∧¬hp)∧ll)
events.f31 = function(e) 
	local left= events.f2(e)
	local right= events.event_ll(e)
	if left < right then return left else return right end
end
-- (((hl∧¬hp)∧ll)∧¬lp)
events.f30 = function(e) 
	local left= events.f31(e)
	local right= events.f5(e)
	if left < right then return left else return right end
end
-- ((¬hp∧¬ll)∧¬lp)
events.f39 = function(e) 
	local left= events.f40(e)
	local right= events.f5(e)
	if left < right then return left else return right end
end
-- (¬hl∧ll)
events.f38 = function(e) 
	local left= events.f9(e)
	local right= events.event_ll(e)
	if left < right then return left else return right end
end
-- ((¬hl∧ll)∧¬lp)
events.f37 = function(e) 
	local left= events.f38(e)
	local right= events.f5(e)
	if left < right then return left else return right end
end
-- (((¬hl∧hp)∧ll)∧lp)
events.f36 = function(e) 
	local left= events.f29(e)
	local right= events.event_lp(e)
	if left < right then return left else return right end
end
-- (((hl∧hp)∧¬ll)∧lp)
events.f35 = function(e) 
	local left= events.f34(e)
	local right= events.event_lp(e)
	if left < right then return left else return right end
end
-- ((hp∧¬ll)∧lp)
events.f43 = function(e) 
	local left= events.f44(e)
	local right= events.event_lp(e)
	if left < right then return left else return right end
end
-- (hl∧ll)
events.f42 = function(e) 
	local left= events.event_hl(e)
	local right= events.event_ll(e)
	if left < right then return left else return right end
end
-- ((¬hp∧¬ll)∧lp)
events.f45 = function(e) 
	local left= events.f40(e)
	local right= events.event_lp(e)
	if left < right then return left else return right end
end
-- (hp∧¬ll)
events.f44 = function(e) 
	local left= events.event_hp(e)
	local right= events.f4(e)
	if left < right then return left else return right end
end
-- ((hl∧ll)∧lp)
events.f41 = function(e) 
	local left= events.f42(e)
	local right= events.event_lp(e)
	if left < right then return left else return right end
end
-- (¬hp∧¬ll)
events.f40 = function(e) 
	local left= events.f3(e)
	local right= events.f4(e)
	if left < right then return left else return right end
end
-- (¬hl∧¬ll)
events.f47 = function(e) 
	local left= events.f9(e)
	local right= events.f4(e)
	if left < right then return left else return right end
end
-- ((¬hl∧¬ll)∧lp)
events.f46 = function(e) 
	local left= events.f47(e)
	local right= events.event_lp(e)
	if left < right then return left else return right end
end
-- (¬hp∧ll)
events.f49 = function(e) 
	local left= events.f3(e)
	local right= events.event_ll(e)
	if left < right then return left else return right end
end
-- ((¬hp∧ll)∧¬lp)
events.f48 = function(e) 
	local left= events.f49(e)
	local right= events.f5(e)
	if left < right then return left else return right end
end
-- (hp∧ll)
events.f59 = function(e) 
	local left= events.event_hp(e)
	local right= events.event_ll(e)
	if left < right then return left else return right end
end
-- (((¬hl∧¬hp)∧ll)∧¬lp)
events.f6 = function(e) 
	local left= events.f7(e)
	local right= events.f5(e)
	if left < right then return left else return right end
end
-- ((¬hl∧¬hp)∧ll)
events.f7 = function(e) 
	local left= events.f8(e)
	local right= events.event_ll(e)
	if left < right then return left else return right end
end
-- ((¬hl∧¬ll)∧¬lp)
events.f57 = function(e) 
	local left= events.f47(e)
	local right= events.f5(e)
	if left < right then return left else return right end
end
-- (¬hl∧¬hp)
events.f8 = function(e) 
	local left= events.f9(e)
	local right= events.f3(e)
	if left < right then return left else return right end
end
-- ((hp∧ll)∧¬lp)
events.f58 = function(e) 
	local left= events.f59(e)
	local right= events.f5(e)
	if left < right then return left else return right end
end
-- ¬hl
events.f9 = function(e) 
	local nonneg = events.event_hl(e)
	return 1-nonneg
end
-- (¬hl∧hp)
events.f12 = function(e) 
	local left= events.f9(e)
	local right= events.event_hp(e)
	if left < right then return left else return right end
end
-- ((¬hl∧hp)∧¬ll)
events.f11 = function(e) 
	local left= events.f12(e)
	local right= events.f4(e)
	if left < right then return left else return right end
end
-- (((¬hl∧hp)∧¬ll)∧lp)
events.f10 = function(e) 
	local left= events.f11(e)
	local right= events.event_lp(e)
	if left < right then return left else return right end
end
-- (hl∧¬ll)
events.f51 = function(e) 
	local left= events.event_hl(e)
	local right= events.f4(e)
	if left < right then return left else return right end
end
-- (hl∧hp)
events.f15 = function(e) 
	local left= events.event_hl(e)
	local right= events.event_hp(e)
	if left < right then return left else return right end
end
-- ((hl∧ll)∧¬lp)
events.f52 = function(e) 
	local left= events.f42(e)
	local right= events.f5(e)
	if left < right then return left else return right end
end
-- ((hl∧hp)∧ll)
events.f14 = function(e) 
	local left= events.f15(e)
	local right= events.event_ll(e)
	if left < right then return left else return right end
end
-- (((hl∧hp)∧ll)∧lp)
events.f13 = function(e) 
	local left= events.f14(e)
	local right= events.event_lp(e)
	if left < right then return left else return right end
end
-- ((hl∧¬ll)∧lp)
events.f50 = function(e) 
	local left= events.f51(e)
	local right= events.event_lp(e)
	if left < right then return left else return right end
end
-- ((hp∧¬ll)∧¬lp)
events.f55 = function(e) 
	local left= events.f44(e)
	local right= events.f5(e)
	if left < right then return left else return right end
end
-- ((hl∧¬ll)∧¬lp)
events.f56 = function(e) 
	local left= events.f51(e)
	local right= events.f5(e)
	if left < right then return left else return right end
end
-- (((hl∧¬hp)∧¬ll)∧lp)
events.f19 = function(e) 
	local left= events.f1(e)
	local right= events.event_lp(e)
	if left < right then return left else return right end
end
-- ((¬hp∧ll)∧lp)
events.f53 = function(e) 
	local left= events.f49(e)
	local right= events.event_lp(e)
	if left < right then return left else return right end
end
-- ((¬hl∧¬hp)∧¬ll)
events.f18 = function(e) 
	local left= events.f8(e)
	local right= events.f4(e)
	if left < right then return left else return right end
end
-- ((¬hl∧ll)∧lp)
events.f54 = function(e) 
	local left= events.f38(e)
	local right= events.event_lp(e)
	if left < right then return left else return right end
end
-- (((¬hl∧¬hp)∧¬ll)∧lp)
events.f17 = function(e) 
	local left= events.f18(e)
	local right= events.event_lp(e)
	if left < right then return left else return right end
end
-- ((hl∧¬hp)∧¬ll)
events.f1 = function(e) 
	local left= events.f2(e)
	local right= events.f4(e)
	if left < right then return left else return right end
end
-- (((hl∧¬hp)∧¬ll)∧¬lp)
events.f0 = function(e) 
	local left= events.f1(e)
	local right= events.f5(e)
	if left < right then return left else return right end
end
-- ¬hp
events.f3 = function(e) 
	local nonneg = events.event_hp(e)
	return 1-nonneg
end
-- (hl∧¬hp)
events.f2 = function(e) 
	local left= events.event_hl(e)
	local right= events.f3(e)
	if left < right then return left else return right end
end
-- ¬lp
events.f5 = function(e) 
	local nonneg = events.event_lp(e)
	return 1-nonneg
end
-- ¬ll
events.f4 = function(e) 
	local nonneg = events.event_ll(e)
	return 1-nonneg
end
-- (((hl∧hp)∧ll)∧¬lp)
events.f23 = function(e) 
	local left= events.f14(e)
	local right= events.f5(e)
	if left < right then return left else return right end
end
-- (((¬hl∧¬hp)∧¬ll)∧¬lp)
events.f22 = function(e) 
	local left= events.f18(e)
	local right= events.f5(e)
	if left < right then return left else return right end
end
-- ((hp∧ll)∧lp)
events.f60 = function(e) 
	local left= events.f59(e)
	local right= events.event_lp(e)
	if left < right then return left else return right end
end
-- (((¬hl∧hp)∧¬ll)∧¬lp)
events.f25 = function(e) 
	local left= events.f11(e)
	local right= events.f5(e)
	if left < right then return left else return right end
end
-- (((¬hl∧¬hp)∧ll)∧lp)
events.f26 = function(e) 
	local left= events.f7(e)
	local right= events.event_lp(e)
	if left < right then return left else return right end
end
-- ((¬hl∧hp)∧ll)
events.f29 = function(e) 
	local left= events.f12(e)
	local right= events.event_ll(e)
	if left < right then return left else return right end
end
-- (((¬hl∧hp)∧ll)∧¬lp)
events.f28 = function(e) 
	local left= events.f29(e)
	local right= events.f5(e)
	if left < right then return left else return right end
end
-----------------------------------------------
--           END COMPOSITE EVENTS            --
-----------------------------------------------

--actions
-----------------------------------------------
--          BEGIN COMPOSITE ACTIONS          --
-----------------------------------------------
-- f21
actions.f21 = function(e)
	local levels = getDomain('power')
	local retMax = -100
	local l
	for _,lp in ipairs(levels) do
		local ret = functions.fAnd(functions.action_ip(lp), functions.action_kp(lp))
		if ret > retMax then
			retMax = ret
			l = lp
		end
	end
	return notifs.change_power(l,e)
end
-- f20
actions.f20 = function(e)
	local levels = getDomain('rate')
	local retMax = -100
	local l
	for _,lr in ipairs(levels) do
		local ret = functions.fAnd(functions.action_kr(lr), functions.action_dr(lr))
		if ret > retMax then
			retMax = ret
			l = lr
		end
	end
	return notifs.change_rate(l,e)
end
-- f16
actions.f16 = function(e)
	local levels = getDomain('rate')
	local retMax = -100
	local l
	for _,lr in ipairs(levels) do
		local ret = functions.fAnd(functions.action_dr(lr), functions.action_ir(lr))
		if ret > retMax then
			retMax = ret
			l = lr
		end
	end
	return notifs.change_rate(l,e)
end
-- f24
actions.f24 = function(e)
	local levels = getDomain('rate')
	local retMax = -100
	local l
	for _,lr in ipairs(levels) do
		local ret = functions.fAnd(functions.action_dr(lr), functions.fAnd(functions.action_ir(lr), functions.action_kr(lr)))
		if ret > retMax then
			retMax = ret
			l = lr
		end
	end
	return notifs.change_rate(l,e)
end
-- f27
actions.f27 = function(e)
	local levels = getDomain('rate')
	local retMax = -100
	local l
	for _,lr in ipairs(levels) do
		local ret = functions.fAnd(functions.action_ir(lr), functions.action_kr(lr))
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
  {"244", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"244", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"244", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"244", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"244", events.f22, "298", nil},
  {"244", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"244", events.f23, "295", {actions.f24, actions.f21, }},
  {"244", events.f36, "252", {actions.f24, actions.f21, }},
  {"244", events.f13, "300", {actions.f24, actions.f21, }},
  {"244", events.f33, "301", {actions.f20, actions.f21, }},
  {"244", events.f10, "246", {actions.f20, actions.f21, }},
  {"244", events.f26, "269", {actions.f27, actions.f21, }},
  {"244", events.f35, "299", {actions.f20, actions.f21, }},
  {"244", events.f32, "297", {actions.f27, actions.f21, }},
  {"244", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"244", events.f30, "233", {actions.f27, actions.f21, }},
  {"243", events.f10, "246", {actions.f20, actions.f21, }},
  {"243", events.f35, "271", {actions.f20, actions.f21, }},
  {"243", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"243", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"243", events.f19, "274", {actions.f20, actions.f21, }},
  {"243", events.f0, "282", {actions.f20, actions.f21, }},
  {"243", events.f33, "276", {actions.f20, actions.f21, }},
  {"243", events.f26, "254", {actions.f27, actions.f21, }},
  {"243", events.f32, "280", {actions.f24, actions.f21, }},
  {"243", events.f22, "281", nil},
  {"243", events.f30, "278", {actions.f24, actions.f21, }},
  {"243", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"243", events.f23, "272", {actions.f24, actions.f21, }},
  {"243", events.f13, "277", {actions.f24, actions.f21, }},
  {"243", events.f36, "252", {actions.f24, actions.f21, }},
  {"243", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"242", events.f22, "260", nil},
  {"242", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"242", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"242", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"242", events.f35, "248", {actions.f20, actions.f21, }},
  {"242", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"242", events.f32, "250", {actions.f24, actions.f21, }},
  {"242", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"242", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"242", events.f13, "253", {actions.f24, actions.f21, }},
  {"242", events.f19, "258", {actions.f20, actions.f21, }},
  {"242", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"242", events.f26, "254", {actions.f27, actions.f21, }},
  {"242", events.f10, "246", {actions.f20, actions.f21, }},
  {"242", events.f36, "252", {actions.f24, actions.f21, }},
  {"242", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"241", events.f50, "306", {actions.f20, actions.f21, }},
  {"241", events.f54, "220", {actions.action_ir, actions.action_kp, }},
  {"241", events.f37, "237", {actions.action_ir, actions.action_kp, }},
  {"241", events.f56, "305", {actions.f20, actions.f21, }},
  {"241", events.f52, "304", {actions.f24, actions.f21, }},
  {"241", events.f57, "241", nil},
  {"241", events.f46, "224", nil},
  {"241", events.f41, "303", {actions.f24, actions.f21, }},
  {"248", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"248", events.f19, "274", {actions.f20, actions.f21, }},
  {"248", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"248", events.f32, "280", {actions.f24, actions.f21, }},
  {"248", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"248", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"248", events.f26, "254", {actions.f27, actions.f21, }},
  {"248", events.f30, "278", {actions.f24, actions.f21, }},
  {"248", events.f33, "276", {actions.f20, actions.f21, }},
  {"248", events.f10, "246", {actions.f20, actions.f21, }},
  {"248", events.f13, "277", {actions.f24, actions.f21, }},
  {"248", events.f0, "282", {actions.f20, actions.f21, }},
  {"248", events.f36, "252", {actions.f24, actions.f21, }},
  {"248", events.f23, "272", {actions.f24, actions.f21, }},
  {"248", events.f35, "271", {actions.f20, actions.f21, }},
  {"248", events.f22, "281", nil},
  {"247", events.f35, "320", {actions.f20, actions.f21, }},
  {"247", events.f17, "324", nil},
  {"247", events.f33, "276", {actions.f20, actions.f21, }},
  {"247", events.f22, "325", nil},
  {"247", events.f23, "272", {actions.f24, actions.f21, }},
  {"247", events.f13, "326", {actions.f24, actions.f21, }},
  {"247", events.f0, "282", {actions.f20, actions.f21, }},
  {"247", events.f6, "327", {actions.action_ir, actions.action_kp, }},
  {"247", events.f26, "322", {actions.action_ir, actions.action_kp, }},
  {"247", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"247", events.f25, "321", {actions.action_dr, actions.action_kp, }},
  {"247", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"247", events.f32, "307", {actions.f24, actions.f21, }},
  {"247", events.f28, "323", {actions.f16, actions.action_kp, }},
  {"247", events.f30, "278", {actions.f24, actions.f21, }},
  {"247", events.f19, "308", {actions.f20, actions.f21, }},
  {"246", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"246", events.f13, "313", {actions.f24, actions.f21, }},
  {"246", events.f32, "307", {actions.f24, actions.f21, }},
  {"246", events.f33, "293", {actions.f20, actions.f21, }},
  {"246", events.f0, "282", {actions.f20, actions.f21, }},
  {"246", events.f35, "314", {actions.f20, actions.f21, }},
  {"246", events.f6, "309", {actions.action_ir, actions.action_kp, }},
  {"246", events.f17, "312", nil},
  {"246", events.f10, "224", nil},
  {"246", events.f22, "310", nil},
  {"246", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"246", events.f19, "308", {actions.f20, actions.f21, }},
  {"246", events.f23, "284", {actions.f24, actions.f21, }},
  {"246", events.f30, "278", {actions.f24, actions.f21, }},
  {"246", events.f25, "241", nil},
  {"246", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"245", events.f32, "250", {actions.f24, actions.f21, }},
  {"245", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"245", events.f35, "248", {actions.f20, actions.f21, }},
  {"245", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"245", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"245", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"245", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"245", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"245", events.f26, "254", {actions.f27, actions.f21, }},
  {"245", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"245", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"245", events.f22, "260", nil},
  {"245", events.f10, "246", {actions.f20, actions.f21, }},
  {"245", events.f13, "253", {actions.f24, actions.f21, }},
  {"245", events.f19, "258", {actions.f20, actions.f21, }},
  {"245", events.f36, "252", {actions.f24, actions.f21, }},
  {"252", events.f22, "310", nil},
  {"252", events.f32, "307", {actions.f24, actions.f21, }},
  {"252", events.f6, "309", {actions.action_ir, actions.action_kp, }},
  {"252", events.f25, "241", nil},
  {"252", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"252", events.f33, "293", {actions.f20, actions.f21, }},
  {"252", events.f19, "308", {actions.f20, actions.f21, }},
  {"252", events.f17, "312", nil},
  {"252", events.f30, "278", {actions.f24, actions.f21, }},
  {"252", events.f23, "284", {actions.f24, actions.f21, }},
  {"252", events.f35, "314", {actions.f20, actions.f21, }},
  {"252", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"252", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"252", events.f0, "282", {actions.f20, actions.f21, }},
  {"252", events.f13, "313", {actions.f24, actions.f21, }},
  {"252", events.f10, "224", nil},
  {"251", events.f35, "248", {actions.f20, actions.f21, }},
  {"251", events.f10, "246", {actions.f20, actions.f21, }},
  {"251", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"251", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"251", events.f22, "260", nil},
  {"251", events.f26, "254", {actions.f27, actions.f21, }},
  {"251", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"251", events.f19, "258", {actions.f20, actions.f21, }},
  {"251", events.f36, "252", {actions.f24, actions.f21, }},
  {"251", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"251", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"251", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"251", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"251", events.f32, "250", {actions.f24, actions.f21, }},
  {"251", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"251", events.f13, "253", {actions.f24, actions.f21, }},
  {"250", events.f10, "246", {actions.f20, actions.f21, }},
  {"250", events.f32, "297", {actions.f27, actions.f21, }},
  {"250", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"250", events.f36, "252", {actions.f24, actions.f21, }},
  {"250", events.f23, "295", {actions.f24, actions.f21, }},
  {"250", events.f26, "269", {actions.f27, actions.f21, }},
  {"250", events.f30, "233", {actions.f27, actions.f21, }},
  {"250", events.f22, "298", nil},
  {"250", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"250", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"250", events.f35, "299", {actions.f20, actions.f21, }},
  {"250", events.f33, "301", {actions.f20, actions.f21, }},
  {"250", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"250", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"250", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"250", events.f13, "300", {actions.f24, actions.f21, }},
  {"249", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"249", events.f36, "252", {actions.f24, actions.f21, }},
  {"249", events.f10, "246", {actions.f20, actions.f21, }},
  {"249", events.f0, "222", nil},
  {"249", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"249", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"249", events.f13, "266", {actions.f24, actions.f21, }},
  {"249", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"249", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"249", events.f26, "269", {actions.f27, actions.f21, }},
  {"249", events.f32, "268", {actions.f27, actions.f21, }},
  {"249", events.f6, "262", {actions.action_ir, actions.action_kp, }},
  {"249", events.f22, "270", nil},
  {"249", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"249", events.f35, "261", {actions.f20, actions.f21, }},
  {"249", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"256", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"256", events.f6, "262", {actions.action_ir, actions.action_kp, }},
  {"256", events.f0, "222", nil},
  {"256", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"256", events.f13, "266", {actions.f24, actions.f21, }},
  {"256", events.f26, "269", {actions.f27, actions.f21, }},
  {"256", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"256", events.f10, "246", {actions.f20, actions.f21, }},
  {"256", events.f35, "261", {actions.f20, actions.f21, }},
  {"256", events.f22, "270", nil},
  {"256", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"256", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"256", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"256", events.f32, "268", {actions.f27, actions.f21, }},
  {"256", events.f36, "252", {actions.f24, actions.f21, }},
  {"256", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"255", events.f35, "248", {actions.f20, actions.f21, }},
  {"255", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"255", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"255", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"255", events.f36, "252", {actions.f24, actions.f21, }},
  {"255", events.f26, "254", {actions.f27, actions.f21, }},
  {"255", events.f32, "250", {actions.f24, actions.f21, }},
  {"255", events.f10, "246", {actions.f20, actions.f21, }},
  {"255", events.f22, "260", nil},
  {"255", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"255", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"255", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"255", events.f13, "253", {actions.f24, actions.f21, }},
  {"255", events.f19, "258", {actions.f20, actions.f21, }},
  {"255", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"255", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"254", events.f13, "326", {actions.f24, actions.f21, }},
  {"254", events.f32, "307", {actions.f24, actions.f21, }},
  {"254", events.f25, "321", {actions.action_dr, actions.action_kp, }},
  {"254", events.f33, "276", {actions.f20, actions.f21, }},
  {"254", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"254", events.f6, "327", {actions.action_ir, actions.action_kp, }},
  {"254", events.f28, "323", {actions.f16, actions.action_kp, }},
  {"254", events.f26, "322", {actions.action_ir, actions.action_kp, }},
  {"254", events.f23, "272", {actions.f24, actions.f21, }},
  {"254", events.f17, "324", nil},
  {"254", events.f0, "282", {actions.f20, actions.f21, }},
  {"254", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"254", events.f35, "320", {actions.f20, actions.f21, }},
  {"254", events.f22, "325", nil},
  {"254", events.f19, "308", {actions.f20, actions.f21, }},
  {"254", events.f30, "278", {actions.f24, actions.f21, }},
  {"253", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"253", events.f33, "276", {actions.f20, actions.f21, }},
  {"253", events.f13, "277", {actions.f24, actions.f21, }},
  {"253", events.f32, "280", {actions.f24, actions.f21, }},
  {"253", events.f30, "278", {actions.f24, actions.f21, }},
  {"253", events.f19, "274", {actions.f20, actions.f21, }},
  {"253", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"253", events.f23, "272", {actions.f24, actions.f21, }},
  {"253", events.f35, "271", {actions.f20, actions.f21, }},
  {"253", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"253", events.f26, "254", {actions.f27, actions.f21, }},
  {"253", events.f10, "246", {actions.f20, actions.f21, }},
  {"253", events.f0, "282", {actions.f20, actions.f21, }},
  {"253", events.f36, "252", {actions.f24, actions.f21, }},
  {"253", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"253", events.f22, "281", nil},
  {"227", events.f0, "282", {actions.f20, actions.f21, }},
  {"227", events.f19, "274", {actions.f20, actions.f21, }},
  {"227", events.f10, "246", {actions.f20, actions.f21, }},
  {"227", events.f13, "277", {actions.f24, actions.f21, }},
  {"227", events.f30, "278", {actions.f24, actions.f21, }},
  {"227", events.f33, "276", {actions.f20, actions.f21, }},
  {"227", events.f35, "271", {actions.f20, actions.f21, }},
  {"227", events.f32, "280", {actions.f24, actions.f21, }},
  {"227", events.f23, "272", {actions.f24, actions.f21, }},
  {"227", events.f26, "254", {actions.f27, actions.f21, }},
  {"227", events.f36, "252", {actions.f24, actions.f21, }},
  {"227", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"227", events.f22, "281", nil},
  {"227", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"227", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"227", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"228", events.f25, "386", {actions.action_dr, actions.action_kp, }},
  {"228", events.f17, "384", {actions.action_kr, actions.action_ip, }},
  {"228", events.f13, "390", {actions.f24, actions.f21, }},
  {"228", events.f22, "228", nil},
  {"228", events.f28, "389", {actions.f16, actions.action_kp, }},
  {"228", events.f10, "372", {actions.f20, actions.f21, }},
  {"228", events.f23, "392", {actions.f24, actions.f21, }},
  {"228", events.f35, "385", {actions.f20, actions.f21, }},
  {"228", events.f32, "391", {actions.f27, actions.f21, }},
  {"228", events.f36, "362", {actions.f24, actions.f21, }},
  {"228", events.f6, "223", {actions.action_ir, actions.action_kp, }},
  {"228", events.f26, "383", {actions.f27, actions.f21, }},
  {"228", events.f0, "338", {actions.action_kr, actions.action_ip, }},
  {"228", events.f30, "335", {actions.f27, actions.f21, }},
  {"228", events.f33, "387", {actions.f20, actions.f21, }},
  {"228", events.f19, "388", {actions.action_kr, actions.action_ip, }},
  {"225", events.f17, "312", nil},
  {"225", events.f23, "345", {actions.f16, actions.action_kp, }},
  {"225", events.f33, "346", {actions.action_dr, actions.action_kp, }},
  {"225", events.f22, "351", nil},
  {"225", events.f32, "354", {actions.f16, actions.action_kp, }},
  {"225", events.f13, "355", {actions.f16, actions.action_kp, }},
  {"225", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"225", events.f35, "352", {actions.action_dr, actions.action_kp, }},
  {"225", events.f28, "225", {actions.action_ir, actions.action_kp, }},
  {"225", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"225", events.f10, "224", nil},
  {"225", events.f25, "230", nil},
  {"225", events.f6, "353", {actions.action_ir, actions.action_kp, }},
  {"225", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"225", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"225", events.f19, "356", {actions.action_dr, actions.action_kp, }},
  {"226", events.f32, "401", {actions.f24, actions.f21, }},
  {"226", events.f17, "368", {actions.action_kr, actions.action_ip, }},
  {"226", events.f19, "406", {actions.f20, actions.f21, }},
  {"226", events.f35, "403", {actions.f20, actions.f21, }},
  {"226", events.f33, "402", {actions.f20, actions.f21, }},
  {"226", events.f6, "227", {actions.action_ir, actions.action_kp, }},
  {"226", events.f23, "404", {actions.f24, actions.f21, }},
  {"226", events.f30, "399", {actions.f24, actions.f21, }},
  {"226", events.f13, "405", {actions.f24, actions.f21, }},
  {"226", events.f0, "400", {actions.f20, actions.f21, }},
  {"226", events.f26, "366", {actions.f27, actions.f21, }},
  {"226", events.f25, "386", {actions.action_dr, actions.action_kp, }},
  {"226", events.f28, "389", {actions.f16, actions.action_kp, }},
  {"226", events.f10, "372", {actions.f20, actions.f21, }},
  {"226", events.f36, "362", {actions.f24, actions.f21, }},
  {"226", events.f22, "226", nil},
  {"231", events.f19, "228", nil},
  {"231", events.f35, "226", nil},
  {"231", events.f33, "229", nil},
  {"231", events.f25, "230", nil},
  {"231", events.f26, "221", {actions.action_ir, actions.action_kp, }},
  {"231", events.f6, "231", {actions.action_ir, actions.action_kp, }},
  {"231", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"231", events.f13, "227", {actions.action_ir, actions.action_kp, }},
  {"231", events.f10, "224", nil},
  {"231", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"231", events.f23, "232", {actions.action_ir, actions.action_kp, }},
  {"231", events.f17, "217", nil},
  {"231", events.f32, "223", {actions.action_ir, actions.action_kp, }},
  {"231", events.f28, "225", {actions.action_ir, actions.action_kp, }},
  {"231", events.f0, "222", nil},
  {"231", events.f22, "218", nil},
  {"232", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"232", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"232", events.f19, "258", {actions.f20, actions.f21, }},
  {"232", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"232", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"232", events.f26, "254", {actions.f27, actions.f21, }},
  {"232", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"232", events.f10, "246", {actions.f20, actions.f21, }},
  {"232", events.f35, "248", {actions.f20, actions.f21, }},
  {"232", events.f32, "250", {actions.f24, actions.f21, }},
  {"232", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"232", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"232", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"232", events.f36, "252", {actions.f24, actions.f21, }},
  {"232", events.f22, "260", nil},
  {"232", events.f13, "253", {actions.f24, actions.f21, }},
  {"229", events.f22, "229", nil},
  {"229", events.f13, "365", {actions.f24, actions.f21, }},
  {"229", events.f28, "367", {actions.f16, actions.action_kp, }},
  {"229", events.f0, "347", {actions.action_dr, actions.action_kp, }},
  {"229", events.f26, "366", {actions.f27, actions.f21, }},
  {"229", events.f10, "372", {actions.f20, actions.f21, }},
  {"229", events.f6, "232", {actions.action_ir, actions.action_kp, }},
  {"229", events.f36, "362", {actions.f24, actions.f21, }},
  {"229", events.f32, "361", {actions.f24, actions.f21, }},
  {"229", events.f17, "368", {actions.action_kr, actions.action_ip, }},
  {"229", events.f33, "364", {actions.action_dr, actions.action_kp, }},
  {"229", events.f30, "350", {actions.f16, actions.action_kp, }},
  {"229", events.f23, "370", {actions.f16, actions.action_kp, }},
  {"229", events.f19, "363", {actions.f20, actions.f21, }},
  {"229", events.f35, "369", {actions.f20, actions.f21, }},
  {"229", events.f25, "371", {actions.action_dr, actions.action_kp, }},
  {"230", events.f56, "347", {actions.action_dr, actions.action_kp, }},
  {"230", events.f46, "224", nil},
  {"230", events.f52, "350", {actions.f16, actions.action_kp, }},
  {"230", events.f57, "230", nil},
  {"230", events.f54, "220", {actions.action_ir, actions.action_kp, }},
  {"230", events.f41, "360", {actions.f16, actions.action_kp, }},
  {"230", events.f50, "359", {actions.action_dr, actions.action_kp, }},
  {"230", events.f37, "225", {actions.action_ir, actions.action_kp, }},
  {"235", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"235", events.f26, "269", {actions.f27, actions.f21, }},
  {"235", events.f10, "246", {actions.f20, actions.f21, }},
  {"235", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"235", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"235", events.f32, "268", {actions.f27, actions.f21, }},
  {"235", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"235", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"235", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"235", events.f13, "266", {actions.f24, actions.f21, }},
  {"235", events.f0, "222", nil},
  {"235", events.f6, "262", {actions.action_ir, actions.action_kp, }},
  {"235", events.f36, "252", {actions.f24, actions.f21, }},
  {"235", events.f22, "270", nil},
  {"235", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"235", events.f35, "261", {actions.f20, actions.f21, }},
  {"236", events.f19, "239", {actions.action_kr, actions.action_ip, }},
  {"236", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"236", events.f26, "221", {actions.action_ir, actions.action_kp, }},
  {"236", events.f17, "217", nil},
  {"236", events.f6, "236", {actions.action_ir, actions.action_kp, }},
  {"236", events.f33, "242", {actions.action_kr, actions.action_ip, }},
  {"236", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"236", events.f25, "241", nil},
  {"236", events.f13, "243", {actions.f27, actions.f21, }},
  {"236", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"236", events.f35, "234", {actions.action_kr, actions.action_ip, }},
  {"236", events.f22, "238", nil},
  {"236", events.f32, "244", {actions.f27, actions.f21, }},
  {"236", events.f10, "224", nil},
  {"236", events.f30, "233", {actions.f27, actions.f21, }},
  {"236", events.f23, "240", {actions.f27, actions.f21, }},
  {"233", events.f26, "269", {actions.f27, actions.f21, }},
  {"233", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"233", events.f0, "222", nil},
  {"233", events.f13, "266", {actions.f24, actions.f21, }},
  {"233", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"233", events.f10, "246", {actions.f20, actions.f21, }},
  {"233", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"233", events.f36, "252", {actions.f24, actions.f21, }},
  {"233", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"233", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"233", events.f32, "268", {actions.f27, actions.f21, }},
  {"233", events.f35, "261", {actions.f20, actions.f21, }},
  {"233", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"233", events.f6, "262", {actions.action_ir, actions.action_kp, }},
  {"233", events.f22, "270", nil},
  {"233", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"234", events.f32, "280", {actions.f24, actions.f21, }},
  {"234", events.f0, "282", {actions.f20, actions.f21, }},
  {"234", events.f23, "272", {actions.f24, actions.f21, }},
  {"234", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"234", events.f35, "271", {actions.f20, actions.f21, }},
  {"234", events.f22, "281", nil},
  {"234", events.f30, "278", {actions.f24, actions.f21, }},
  {"234", events.f26, "254", {actions.f27, actions.f21, }},
  {"234", events.f33, "276", {actions.f20, actions.f21, }},
  {"234", events.f13, "277", {actions.f24, actions.f21, }},
  {"234", events.f19, "274", {actions.f20, actions.f21, }},
  {"234", events.f36, "252", {actions.f24, actions.f21, }},
  {"234", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"234", events.f10, "246", {actions.f20, actions.f21, }},
  {"234", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"234", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"239", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"239", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"239", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"239", events.f23, "295", {actions.f24, actions.f21, }},
  {"239", events.f30, "233", {actions.f27, actions.f21, }},
  {"239", events.f35, "299", {actions.f20, actions.f21, }},
  {"239", events.f33, "301", {actions.f20, actions.f21, }},
  {"239", events.f32, "297", {actions.f27, actions.f21, }},
  {"239", events.f22, "298", nil},
  {"239", events.f36, "252", {actions.f24, actions.f21, }},
  {"239", events.f10, "246", {actions.f20, actions.f21, }},
  {"239", events.f26, "269", {actions.f27, actions.f21, }},
  {"239", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"239", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"239", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"239", events.f13, "300", {actions.f24, actions.f21, }},
  {"240", events.f13, "253", {actions.f24, actions.f21, }},
  {"240", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"240", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"240", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"240", events.f19, "258", {actions.f20, actions.f21, }},
  {"240", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"240", events.f22, "260", nil},
  {"240", events.f10, "246", {actions.f20, actions.f21, }},
  {"240", events.f36, "252", {actions.f24, actions.f21, }},
  {"240", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"240", events.f35, "248", {actions.f20, actions.f21, }},
  {"240", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"240", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"240", events.f32, "250", {actions.f24, actions.f21, }},
  {"240", events.f26, "254", {actions.f27, actions.f21, }},
  {"240", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"237", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"237", events.f0, "282", {actions.f20, actions.f21, }},
  {"237", events.f35, "314", {actions.f20, actions.f21, }},
  {"237", events.f25, "241", nil},
  {"237", events.f30, "278", {actions.f24, actions.f21, }},
  {"237", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"237", events.f32, "307", {actions.f24, actions.f21, }},
  {"237", events.f33, "293", {actions.f20, actions.f21, }},
  {"237", events.f13, "313", {actions.f24, actions.f21, }},
  {"237", events.f23, "284", {actions.f24, actions.f21, }},
  {"237", events.f6, "309", {actions.action_ir, actions.action_kp, }},
  {"237", events.f19, "308", {actions.f20, actions.f21, }},
  {"237", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"237", events.f17, "312", nil},
  {"237", events.f22, "310", nil},
  {"237", events.f10, "224", nil},
  {"238", events.f13, "243", {actions.f27, actions.f21, }},
  {"238", events.f19, "239", {actions.action_kr, actions.action_ip, }},
  {"238", events.f33, "242", {actions.action_kr, actions.action_ip, }},
  {"238", events.f6, "236", {actions.action_ir, actions.action_kp, }},
  {"238", events.f30, "233", {actions.f27, actions.f21, }},
  {"238", events.f25, "241", nil},
  {"238", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"238", events.f17, "217", nil},
  {"238", events.f10, "224", nil},
  {"238", events.f32, "244", {actions.f27, actions.f21, }},
  {"238", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"238", events.f22, "238", nil},
  {"238", events.f35, "234", {actions.action_kr, actions.action_ip, }},
  {"238", events.f23, "240", {actions.f27, actions.f21, }},
  {"238", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"238", events.f26, "221", {actions.action_ir, actions.action_kp, }},
  {"274", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"274", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"274", events.f26, "269", {actions.f27, actions.f21, }},
  {"274", events.f10, "246", {actions.f20, actions.f21, }},
  {"274", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"274", events.f22, "298", nil},
  {"274", events.f30, "233", {actions.f27, actions.f21, }},
  {"274", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"274", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"274", events.f35, "299", {actions.f20, actions.f21, }},
  {"274", events.f32, "297", {actions.f27, actions.f21, }},
  {"274", events.f13, "300", {actions.f24, actions.f21, }},
  {"274", events.f36, "252", {actions.f24, actions.f21, }},
  {"274", events.f33, "301", {actions.f20, actions.f21, }},
  {"274", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"274", events.f23, "295", {actions.f24, actions.f21, }},
  {"273", events.f19, "274", {actions.f20, actions.f21, }},
  {"273", events.f17, "291", {actions.action_kr, actions.action_ip, }},
  {"273", events.f22, "288", nil},
  {"273", events.f6, "283", {actions.action_ir, actions.action_kp, }},
  {"273", events.f23, "284", {actions.f24, actions.f21, }},
  {"273", events.f32, "280", {actions.f24, actions.f21, }},
  {"273", events.f26, "286", {actions.f27, actions.f21, }},
  {"273", events.f35, "289", {actions.f20, actions.f21, }},
  {"273", events.f0, "282", {actions.f20, actions.f21, }},
  {"273", events.f13, "294", {actions.f24, actions.f21, }},
  {"273", events.f28, "285", {actions.action_ir, actions.action_kp, }},
  {"273", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"273", events.f25, "292", nil},
  {"273", events.f36, "290", {actions.f27, actions.f21, }},
  {"273", events.f33, "293", {actions.f20, actions.f21, }},
  {"273", events.f30, "278", {actions.f24, actions.f21, }},
  {"276", events.f32, "250", {actions.f24, actions.f21, }},
  {"276", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"276", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"276", events.f36, "252", {actions.f24, actions.f21, }},
  {"276", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"276", events.f10, "246", {actions.f20, actions.f21, }},
  {"276", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"276", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"276", events.f26, "254", {actions.f27, actions.f21, }},
  {"276", events.f35, "248", {actions.f20, actions.f21, }},
  {"276", events.f13, "253", {actions.f24, actions.f21, }},
  {"276", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"276", events.f19, "258", {actions.f20, actions.f21, }},
  {"276", events.f22, "260", nil},
  {"276", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"276", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"275", events.f33, "293", {actions.f20, actions.f21, }},
  {"275", events.f26, "286", {actions.f27, actions.f21, }},
  {"275", events.f35, "289", {actions.f20, actions.f21, }},
  {"275", events.f28, "285", {actions.action_ir, actions.action_kp, }},
  {"275", events.f19, "274", {actions.f20, actions.f21, }},
  {"275", events.f30, "278", {actions.f24, actions.f21, }},
  {"275", events.f25, "292", nil},
  {"275", events.f13, "294", {actions.f24, actions.f21, }},
  {"275", events.f22, "288", nil},
  {"275", events.f32, "280", {actions.f24, actions.f21, }},
  {"275", events.f36, "290", {actions.f27, actions.f21, }},
  {"275", events.f23, "284", {actions.f24, actions.f21, }},
  {"275", events.f17, "291", {actions.action_kr, actions.action_ip, }},
  {"275", events.f6, "283", {actions.action_ir, actions.action_kp, }},
  {"275", events.f0, "282", {actions.f20, actions.f21, }},
  {"275", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"278", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"278", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"278", events.f6, "262", {actions.action_ir, actions.action_kp, }},
  {"278", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"278", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"278", events.f35, "261", {actions.f20, actions.f21, }},
  {"278", events.f32, "268", {actions.f27, actions.f21, }},
  {"278", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"278", events.f0, "222", nil},
  {"278", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"278", events.f36, "252", {actions.f24, actions.f21, }},
  {"278", events.f26, "269", {actions.f27, actions.f21, }},
  {"278", events.f10, "246", {actions.f20, actions.f21, }},
  {"278", events.f22, "270", nil},
  {"278", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"278", events.f13, "266", {actions.f24, actions.f21, }},
  {"277", events.f19, "274", {actions.f20, actions.f21, }},
  {"277", events.f26, "254", {actions.f27, actions.f21, }},
  {"277", events.f10, "246", {actions.f20, actions.f21, }},
  {"277", events.f32, "280", {actions.f24, actions.f21, }},
  {"277", events.f35, "271", {actions.f20, actions.f21, }},
  {"277", events.f36, "252", {actions.f24, actions.f21, }},
  {"277", events.f22, "281", nil},
  {"277", events.f30, "278", {actions.f24, actions.f21, }},
  {"277", events.f23, "272", {actions.f24, actions.f21, }},
  {"277", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"277", events.f0, "282", {actions.f20, actions.f21, }},
  {"277", events.f13, "277", {actions.f24, actions.f21, }},
  {"277", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"277", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"277", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"277", events.f33, "276", {actions.f20, actions.f21, }},
  {"280", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"280", events.f13, "300", {actions.f24, actions.f21, }},
  {"280", events.f22, "298", nil},
  {"280", events.f30, "233", {actions.f27, actions.f21, }},
  {"280", events.f26, "269", {actions.f27, actions.f21, }},
  {"280", events.f35, "299", {actions.f20, actions.f21, }},
  {"280", events.f36, "252", {actions.f24, actions.f21, }},
  {"280", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"280", events.f32, "297", {actions.f27, actions.f21, }},
  {"280", events.f23, "295", {actions.f24, actions.f21, }},
  {"280", events.f33, "301", {actions.f20, actions.f21, }},
  {"280", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"280", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"280", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"280", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"280", events.f10, "246", {actions.f20, actions.f21, }},
  {"279", events.f33, "276", {actions.f20, actions.f21, }},
  {"279", events.f30, "278", {actions.f24, actions.f21, }},
  {"279", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"279", events.f32, "280", {actions.f24, actions.f21, }},
  {"279", events.f19, "274", {actions.f20, actions.f21, }},
  {"279", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"279", events.f13, "277", {actions.f24, actions.f21, }},
  {"279", events.f35, "271", {actions.f20, actions.f21, }},
  {"279", events.f26, "254", {actions.f27, actions.f21, }},
  {"279", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"279", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"279", events.f10, "246", {actions.f20, actions.f21, }},
  {"279", events.f0, "282", {actions.f20, actions.f21, }},
  {"279", events.f23, "272", {actions.f24, actions.f21, }},
  {"279", events.f22, "281", nil},
  {"279", events.f36, "252", {actions.f24, actions.f21, }},
  {"282", events.f36, "252", {actions.f24, actions.f21, }},
  {"282", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"282", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"282", events.f10, "246", {actions.f20, actions.f21, }},
  {"282", events.f6, "262", {actions.action_ir, actions.action_kp, }},
  {"282", events.f35, "261", {actions.f20, actions.f21, }},
  {"282", events.f0, "222", nil},
  {"282", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"282", events.f22, "270", nil},
  {"282", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"282", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"282", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"282", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"282", events.f26, "269", {actions.f27, actions.f21, }},
  {"282", events.f13, "266", {actions.f24, actions.f21, }},
  {"282", events.f32, "268", {actions.f27, actions.f21, }},
  {"281", events.f36, "252", {actions.f24, actions.f21, }},
  {"281", events.f0, "282", {actions.f20, actions.f21, }},
  {"281", events.f19, "274", {actions.f20, actions.f21, }},
  {"281", events.f26, "254", {actions.f27, actions.f21, }},
  {"281", events.f35, "271", {actions.f20, actions.f21, }},
  {"281", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"281", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"281", events.f30, "278", {actions.f24, actions.f21, }},
  {"281", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"281", events.f23, "272", {actions.f24, actions.f21, }},
  {"281", events.f33, "276", {actions.f20, actions.f21, }},
  {"281", events.f10, "246", {actions.f20, actions.f21, }},
  {"281", events.f32, "280", {actions.f24, actions.f21, }},
  {"281", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"281", events.f13, "277", {actions.f24, actions.f21, }},
  {"281", events.f22, "281", nil},
  {"284", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"284", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"284", events.f36, "252", {actions.f24, actions.f21, }},
  {"284", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"284", events.f10, "246", {actions.f20, actions.f21, }},
  {"284", events.f32, "250", {actions.f24, actions.f21, }},
  {"284", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"284", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"284", events.f26, "254", {actions.f27, actions.f21, }},
  {"284", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"284", events.f22, "260", nil},
  {"284", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"284", events.f19, "258", {actions.f20, actions.f21, }},
  {"284", events.f13, "253", {actions.f24, actions.f21, }},
  {"284", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"284", events.f35, "248", {actions.f20, actions.f21, }},
  {"283", events.f23, "284", {actions.f24, actions.f21, }},
  {"283", events.f22, "288", nil},
  {"283", events.f28, "285", {actions.action_ir, actions.action_kp, }},
  {"283", events.f19, "274", {actions.f20, actions.f21, }},
  {"283", events.f17, "291", {actions.action_kr, actions.action_ip, }},
  {"283", events.f25, "292", nil},
  {"283", events.f30, "278", {actions.f24, actions.f21, }},
  {"283", events.f13, "294", {actions.f24, actions.f21, }},
  {"283", events.f32, "280", {actions.f24, actions.f21, }},
  {"283", events.f36, "290", {actions.f27, actions.f21, }},
  {"283", events.f33, "293", {actions.f20, actions.f21, }},
  {"283", events.f35, "289", {actions.f20, actions.f21, }},
  {"283", events.f0, "282", {actions.f20, actions.f21, }},
  {"283", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"283", events.f26, "286", {actions.f27, actions.f21, }},
  {"283", events.f6, "283", {actions.action_ir, actions.action_kp, }},
  {"286", events.f22, "310", nil},
  {"286", events.f35, "314", {actions.f20, actions.f21, }},
  {"286", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"286", events.f13, "313", {actions.f24, actions.f21, }},
  {"286", events.f33, "293", {actions.f20, actions.f21, }},
  {"286", events.f19, "308", {actions.f20, actions.f21, }},
  {"286", events.f25, "241", nil},
  {"286", events.f17, "312", nil},
  {"286", events.f10, "224", nil},
  {"286", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"286", events.f0, "282", {actions.f20, actions.f21, }},
  {"286", events.f32, "307", {actions.f24, actions.f21, }},
  {"286", events.f23, "284", {actions.f24, actions.f21, }},
  {"286", events.f30, "278", {actions.f24, actions.f21, }},
  {"286", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"286", events.f6, "309", {actions.action_ir, actions.action_kp, }},
  {"285", events.f23, "284", {actions.f24, actions.f21, }},
  {"285", events.f0, "282", {actions.f20, actions.f21, }},
  {"285", events.f6, "283", {actions.action_ir, actions.action_kp, }},
  {"285", events.f28, "285", {actions.action_ir, actions.action_kp, }},
  {"285", events.f13, "294", {actions.f24, actions.f21, }},
  {"285", events.f35, "289", {actions.f20, actions.f21, }},
  {"285", events.f26, "286", {actions.f27, actions.f21, }},
  {"285", events.f25, "292", nil},
  {"285", events.f33, "293", {actions.f20, actions.f21, }},
  {"285", events.f17, "291", {actions.action_kr, actions.action_ip, }},
  {"285", events.f19, "274", {actions.f20, actions.f21, }},
  {"285", events.f22, "288", nil},
  {"285", events.f36, "290", {actions.f27, actions.f21, }},
  {"285", events.f32, "280", {actions.f24, actions.f21, }},
  {"285", events.f30, "278", {actions.f24, actions.f21, }},
  {"285", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"288", events.f22, "288", nil},
  {"288", events.f6, "283", {actions.action_ir, actions.action_kp, }},
  {"288", events.f30, "278", {actions.f24, actions.f21, }},
  {"288", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"288", events.f23, "284", {actions.f24, actions.f21, }},
  {"288", events.f17, "291", {actions.action_kr, actions.action_ip, }},
  {"288", events.f0, "282", {actions.f20, actions.f21, }},
  {"288", events.f33, "293", {actions.f20, actions.f21, }},
  {"288", events.f36, "290", {actions.f27, actions.f21, }},
  {"288", events.f35, "289", {actions.f20, actions.f21, }},
  {"288", events.f28, "285", {actions.action_ir, actions.action_kp, }},
  {"288", events.f25, "292", nil},
  {"288", events.f26, "286", {actions.f27, actions.f21, }},
  {"288", events.f13, "294", {actions.f24, actions.f21, }},
  {"288", events.f19, "274", {actions.f20, actions.f21, }},
  {"288", events.f32, "280", {actions.f24, actions.f21, }},
  {"287", events.f19, "308", {actions.f20, actions.f21, }},
  {"287", events.f0, "282", {actions.f20, actions.f21, }},
  {"287", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"287", events.f13, "313", {actions.f24, actions.f21, }},
  {"287", events.f33, "293", {actions.f20, actions.f21, }},
  {"287", events.f32, "307", {actions.f24, actions.f21, }},
  {"287", events.f25, "241", nil},
  {"287", events.f22, "310", nil},
  {"287", events.f10, "224", nil},
  {"287", events.f6, "309", {actions.action_ir, actions.action_kp, }},
  {"287", events.f30, "278", {actions.f24, actions.f21, }},
  {"287", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"287", events.f35, "314", {actions.f20, actions.f21, }},
  {"287", events.f17, "312", nil},
  {"287", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"287", events.f23, "284", {actions.f24, actions.f21, }},
  {"257", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"257", events.f26, "286", {actions.f27, actions.f21, }},
  {"257", events.f35, "339", {actions.f20, actions.f21, }},
  {"257", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"257", events.f28, "343", {actions.action_ir, actions.action_kp, }},
  {"257", events.f32, "250", {actions.f24, actions.f21, }},
  {"257", events.f17, "291", {actions.action_kr, actions.action_ip, }},
  {"257", events.f25, "342", nil},
  {"257", events.f13, "344", {actions.f24, actions.f21, }},
  {"257", events.f6, "340", {actions.action_ir, actions.action_kp, }},
  {"257", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"257", events.f33, "346", {actions.action_dr, actions.action_kp, }},
  {"257", events.f36, "290", {actions.f27, actions.f21, }},
  {"257", events.f22, "341", nil},
  {"257", events.f19, "258", {actions.f20, actions.f21, }},
  {"257", events.f23, "345", {actions.f16, actions.action_kp, }},
  {"258", events.f26, "269", {actions.f27, actions.f21, }},
  {"258", events.f32, "297", {actions.f27, actions.f21, }},
  {"258", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"258", events.f30, "233", {actions.f27, actions.f21, }},
  {"258", events.f10, "246", {actions.f20, actions.f21, }},
  {"258", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"258", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"258", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"258", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"258", events.f33, "301", {actions.f20, actions.f21, }},
  {"258", events.f36, "252", {actions.f24, actions.f21, }},
  {"258", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"258", events.f23, "295", {actions.f24, actions.f21, }},
  {"258", events.f35, "299", {actions.f20, actions.f21, }},
  {"258", events.f22, "298", nil},
  {"258", events.f13, "300", {actions.f24, actions.f21, }},
  {"259", events.f13, "344", {actions.f24, actions.f21, }},
  {"259", events.f22, "341", nil},
  {"259", events.f28, "343", {actions.action_ir, actions.action_kp, }},
  {"259", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"259", events.f25, "342", nil},
  {"259", events.f23, "345", {actions.f16, actions.action_kp, }},
  {"259", events.f36, "290", {actions.f27, actions.f21, }},
  {"259", events.f35, "339", {actions.f20, actions.f21, }},
  {"259", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"259", events.f19, "258", {actions.f20, actions.f21, }},
  {"259", events.f26, "286", {actions.f27, actions.f21, }},
  {"259", events.f33, "346", {actions.action_dr, actions.action_kp, }},
  {"259", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"259", events.f6, "340", {actions.action_ir, actions.action_kp, }},
  {"259", events.f17, "291", {actions.action_kr, actions.action_ip, }},
  {"259", events.f32, "250", {actions.f24, actions.f21, }},
  {"260", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"260", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"260", events.f13, "253", {actions.f24, actions.f21, }},
  {"260", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"260", events.f36, "252", {actions.f24, actions.f21, }},
  {"260", events.f10, "246", {actions.f20, actions.f21, }},
  {"260", events.f32, "250", {actions.f24, actions.f21, }},
  {"260", events.f26, "254", {actions.f27, actions.f21, }},
  {"260", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"260", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"260", events.f22, "260", nil},
  {"260", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"260", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"260", events.f35, "248", {actions.f20, actions.f21, }},
  {"260", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"260", events.f19, "258", {actions.f20, actions.f21, }},
  {"261", events.f36, "252", {actions.f24, actions.f21, }},
  {"261", events.f22, "281", nil},
  {"261", events.f26, "254", {actions.f27, actions.f21, }},
  {"261", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"261", events.f23, "272", {actions.f24, actions.f21, }},
  {"261", events.f32, "280", {actions.f24, actions.f21, }},
  {"261", events.f30, "278", {actions.f24, actions.f21, }},
  {"261", events.f10, "246", {actions.f20, actions.f21, }},
  {"261", events.f19, "274", {actions.f20, actions.f21, }},
  {"261", events.f33, "276", {actions.f20, actions.f21, }},
  {"261", events.f0, "282", {actions.f20, actions.f21, }},
  {"261", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"261", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"261", events.f35, "271", {actions.f20, actions.f21, }},
  {"261", events.f13, "277", {actions.f24, actions.f21, }},
  {"261", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"262", events.f32, "268", {actions.f27, actions.f21, }},
  {"262", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"262", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"262", events.f0, "222", nil},
  {"262", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"262", events.f35, "261", {actions.f20, actions.f21, }},
  {"262", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"262", events.f26, "269", {actions.f27, actions.f21, }},
  {"262", events.f6, "262", {actions.action_ir, actions.action_kp, }},
  {"262", events.f10, "246", {actions.f20, actions.f21, }},
  {"262", events.f13, "266", {actions.f24, actions.f21, }},
  {"262", events.f22, "270", nil},
  {"262", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"262", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"262", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"262", events.f36, "252", {actions.f24, actions.f21, }},
  {"263", events.f22, "298", nil},
  {"263", events.f35, "299", {actions.f20, actions.f21, }},
  {"263", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"263", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"263", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"263", events.f23, "295", {actions.f24, actions.f21, }},
  {"263", events.f33, "301", {actions.f20, actions.f21, }},
  {"263", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"263", events.f32, "297", {actions.f27, actions.f21, }},
  {"263", events.f26, "269", {actions.f27, actions.f21, }},
  {"263", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"263", events.f13, "300", {actions.f24, actions.f21, }},
  {"263", events.f30, "233", {actions.f27, actions.f21, }},
  {"263", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"263", events.f10, "246", {actions.f20, actions.f21, }},
  {"263", events.f36, "252", {actions.f24, actions.f21, }},
  {"264", events.f10, "246", {actions.f20, actions.f21, }},
  {"264", events.f32, "250", {actions.f24, actions.f21, }},
  {"264", events.f22, "260", nil},
  {"264", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"264", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"264", events.f13, "253", {actions.f24, actions.f21, }},
  {"264", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"264", events.f35, "248", {actions.f20, actions.f21, }},
  {"264", events.f36, "252", {actions.f24, actions.f21, }},
  {"264", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"264", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"264", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"264", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"264", events.f26, "254", {actions.f27, actions.f21, }},
  {"264", events.f19, "258", {actions.f20, actions.f21, }},
  {"264", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"265", events.f35, "333", {actions.f20, actions.f21, }},
  {"265", events.f32, "244", {actions.f27, actions.f21, }},
  {"265", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"265", events.f6, "334", {actions.action_ir, actions.action_kp, }},
  {"265", events.f13, "332", {actions.f24, actions.f21, }},
  {"265", events.f30, "233", {actions.f27, actions.f21, }},
  {"265", events.f19, "239", {actions.action_kr, actions.action_ip, }},
  {"265", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"265", events.f28, "323", {actions.f16, actions.action_kp, }},
  {"265", events.f26, "330", {actions.action_ir, actions.action_kp, }},
  {"265", events.f22, "329", nil},
  {"265", events.f25, "321", {actions.action_dr, actions.action_kp, }},
  {"265", events.f17, "331", nil},
  {"265", events.f23, "295", {actions.f24, actions.f21, }},
  {"265", events.f33, "301", {actions.f20, actions.f21, }},
  {"265", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"266", events.f19, "274", {actions.f20, actions.f21, }},
  {"266", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"266", events.f0, "282", {actions.f20, actions.f21, }},
  {"266", events.f33, "276", {actions.f20, actions.f21, }},
  {"266", events.f10, "246", {actions.f20, actions.f21, }},
  {"266", events.f22, "281", nil},
  {"266", events.f30, "278", {actions.f24, actions.f21, }},
  {"266", events.f26, "254", {actions.f27, actions.f21, }},
  {"266", events.f13, "277", {actions.f24, actions.f21, }},
  {"266", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"266", events.f35, "271", {actions.f20, actions.f21, }},
  {"266", events.f32, "280", {actions.f24, actions.f21, }},
  {"266", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"266", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"266", events.f23, "272", {actions.f24, actions.f21, }},
  {"266", events.f36, "252", {actions.f24, actions.f21, }},
  {"267", events.f19, "258", {actions.f20, actions.f21, }},
  {"267", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"267", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"267", events.f13, "253", {actions.f24, actions.f21, }},
  {"267", events.f22, "260", nil},
  {"267", events.f36, "252", {actions.f24, actions.f21, }},
  {"267", events.f10, "246", {actions.f20, actions.f21, }},
  {"267", events.f26, "254", {actions.f27, actions.f21, }},
  {"267", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"267", events.f35, "248", {actions.f20, actions.f21, }},
  {"267", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"267", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"267", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"267", events.f32, "250", {actions.f24, actions.f21, }},
  {"267", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"267", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"268", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"268", events.f30, "233", {actions.f27, actions.f21, }},
  {"268", events.f22, "298", nil},
  {"268", events.f26, "269", {actions.f27, actions.f21, }},
  {"268", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"268", events.f33, "301", {actions.f20, actions.f21, }},
  {"268", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"268", events.f23, "295", {actions.f24, actions.f21, }},
  {"268", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"268", events.f32, "297", {actions.f27, actions.f21, }},
  {"268", events.f13, "300", {actions.f24, actions.f21, }},
  {"268", events.f35, "299", {actions.f20, actions.f21, }},
  {"268", events.f10, "246", {actions.f20, actions.f21, }},
  {"268", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"268", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"268", events.f36, "252", {actions.f24, actions.f21, }},
  {"269", events.f28, "323", {actions.f16, actions.action_kp, }},
  {"269", events.f13, "332", {actions.f24, actions.f21, }},
  {"269", events.f25, "321", {actions.action_dr, actions.action_kp, }},
  {"269", events.f35, "333", {actions.f20, actions.f21, }},
  {"269", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"269", events.f30, "233", {actions.f27, actions.f21, }},
  {"269", events.f6, "334", {actions.action_ir, actions.action_kp, }},
  {"269", events.f19, "239", {actions.action_kr, actions.action_ip, }},
  {"269", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"269", events.f26, "330", {actions.action_ir, actions.action_kp, }},
  {"269", events.f32, "244", {actions.f27, actions.f21, }},
  {"269", events.f17, "331", nil},
  {"269", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"269", events.f33, "301", {actions.f20, actions.f21, }},
  {"269", events.f22, "329", nil},
  {"269", events.f23, "295", {actions.f24, actions.f21, }},
  {"270", events.f26, "269", {actions.f27, actions.f21, }},
  {"270", events.f0, "222", nil},
  {"270", events.f36, "252", {actions.f24, actions.f21, }},
  {"270", events.f13, "266", {actions.f24, actions.f21, }},
  {"270", events.f6, "262", {actions.action_ir, actions.action_kp, }},
  {"270", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"270", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"270", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"270", events.f22, "270", nil},
  {"270", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"270", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"270", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"270", events.f35, "261", {actions.f20, actions.f21, }},
  {"270", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"270", events.f32, "268", {actions.f27, actions.f21, }},
  {"270", events.f10, "246", {actions.f20, actions.f21, }},
  {"271", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"271", events.f26, "254", {actions.f27, actions.f21, }},
  {"271", events.f32, "280", {actions.f24, actions.f21, }},
  {"271", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"271", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"271", events.f30, "278", {actions.f24, actions.f21, }},
  {"271", events.f33, "276", {actions.f20, actions.f21, }},
  {"271", events.f0, "282", {actions.f20, actions.f21, }},
  {"271", events.f13, "277", {actions.f24, actions.f21, }},
  {"271", events.f23, "272", {actions.f24, actions.f21, }},
  {"271", events.f35, "271", {actions.f20, actions.f21, }},
  {"271", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"271", events.f19, "274", {actions.f20, actions.f21, }},
  {"271", events.f10, "246", {actions.f20, actions.f21, }},
  {"271", events.f36, "252", {actions.f24, actions.f21, }},
  {"271", events.f22, "281", nil},
  {"272", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"272", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"272", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"272", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"272", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"272", events.f13, "253", {actions.f24, actions.f21, }},
  {"272", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"272", events.f26, "254", {actions.f27, actions.f21, }},
  {"272", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"272", events.f22, "260", nil},
  {"272", events.f19, "258", {actions.f20, actions.f21, }},
  {"272", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"272", events.f32, "250", {actions.f24, actions.f21, }},
  {"272", events.f10, "246", {actions.f20, actions.f21, }},
  {"272", events.f35, "248", {actions.f20, actions.f21, }},
  {"272", events.f36, "252", {actions.f24, actions.f21, }},
  {"312", events.f14, "318", {actions.f24, actions.f21, }},
  {"312", events.f18, "312", nil},
  {"312", events.f34, "315", {actions.f20, actions.f21, }},
  {"312", events.f11, "224", nil},
  {"312", events.f31, "317", {actions.f24, actions.f21, }},
  {"312", events.f29, "220", {actions.action_ir, actions.action_kp, }},
  {"312", events.f7, "311", {actions.action_ir, actions.action_kp, }},
  {"312", events.f1, "316", {actions.f20, actions.f21, }},
  {"311", events.f19, "308", {actions.f20, actions.f21, }},
  {"311", events.f17, "312", nil},
  {"311", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"311", events.f25, "241", nil},
  {"311", events.f22, "310", nil},
  {"311", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"311", events.f10, "224", nil},
  {"311", events.f13, "313", {actions.f24, actions.f21, }},
  {"311", events.f23, "284", {actions.f24, actions.f21, }},
  {"311", events.f32, "307", {actions.f24, actions.f21, }},
  {"311", events.f0, "282", {actions.f20, actions.f21, }},
  {"311", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"311", events.f6, "309", {actions.action_ir, actions.action_kp, }},
  {"311", events.f35, "314", {actions.f20, actions.f21, }},
  {"311", events.f33, "293", {actions.f20, actions.f21, }},
  {"311", events.f30, "278", {actions.f24, actions.f21, }},
  {"310", events.f35, "314", {actions.f20, actions.f21, }},
  {"310", events.f19, "308", {actions.f20, actions.f21, }},
  {"310", events.f10, "224", nil},
  {"310", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"310", events.f13, "313", {actions.f24, actions.f21, }},
  {"310", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"310", events.f23, "284", {actions.f24, actions.f21, }},
  {"310", events.f0, "282", {actions.f20, actions.f21, }},
  {"310", events.f25, "241", nil},
  {"310", events.f22, "310", nil},
  {"310", events.f6, "309", {actions.action_ir, actions.action_kp, }},
  {"310", events.f33, "293", {actions.f20, actions.f21, }},
  {"310", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"310", events.f30, "278", {actions.f24, actions.f21, }},
  {"310", events.f17, "312", nil},
  {"310", events.f32, "307", {actions.f24, actions.f21, }},
  {"309", events.f0, "282", {actions.f20, actions.f21, }},
  {"309", events.f6, "309", {actions.action_ir, actions.action_kp, }},
  {"309", events.f30, "278", {actions.f24, actions.f21, }},
  {"309", events.f13, "313", {actions.f24, actions.f21, }},
  {"309", events.f35, "314", {actions.f20, actions.f21, }},
  {"309", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"309", events.f22, "310", nil},
  {"309", events.f33, "293", {actions.f20, actions.f21, }},
  {"309", events.f32, "307", {actions.f24, actions.f21, }},
  {"309", events.f17, "312", nil},
  {"309", events.f23, "284", {actions.f24, actions.f21, }},
  {"309", events.f19, "308", {actions.f20, actions.f21, }},
  {"309", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"309", events.f10, "224", nil},
  {"309", events.f25, "241", nil},
  {"309", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"308", events.f22, "298", nil},
  {"308", events.f33, "301", {actions.f20, actions.f21, }},
  {"308", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"308", events.f35, "299", {actions.f20, actions.f21, }},
  {"308", events.f36, "252", {actions.f24, actions.f21, }},
  {"308", events.f30, "233", {actions.f27, actions.f21, }},
  {"308", events.f13, "300", {actions.f24, actions.f21, }},
  {"308", events.f23, "295", {actions.f24, actions.f21, }},
  {"308", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"308", events.f10, "246", {actions.f20, actions.f21, }},
  {"308", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"308", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"308", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"308", events.f26, "269", {actions.f27, actions.f21, }},
  {"308", events.f32, "297", {actions.f27, actions.f21, }},
  {"308", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"307", events.f10, "246", {actions.f20, actions.f21, }},
  {"307", events.f32, "297", {actions.f27, actions.f21, }},
  {"307", events.f35, "299", {actions.f20, actions.f21, }},
  {"307", events.f33, "301", {actions.f20, actions.f21, }},
  {"307", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"307", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"307", events.f26, "269", {actions.f27, actions.f21, }},
  {"307", events.f13, "300", {actions.f24, actions.f21, }},
  {"307", events.f30, "233", {actions.f27, actions.f21, }},
  {"307", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"307", events.f36, "252", {actions.f24, actions.f21, }},
  {"307", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"307", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"307", events.f23, "295", {actions.f24, actions.f21, }},
  {"307", events.f22, "298", nil},
  {"307", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"306", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"306", events.f35, "299", {actions.f20, actions.f21, }},
  {"306", events.f30, "233", {actions.f27, actions.f21, }},
  {"306", events.f32, "297", {actions.f27, actions.f21, }},
  {"306", events.f13, "300", {actions.f24, actions.f21, }},
  {"306", events.f33, "301", {actions.f20, actions.f21, }},
  {"306", events.f26, "269", {actions.f27, actions.f21, }},
  {"306", events.f23, "295", {actions.f24, actions.f21, }},
  {"306", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"306", events.f22, "298", nil},
  {"306", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"306", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"306", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"306", events.f10, "246", {actions.f20, actions.f21, }},
  {"306", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"306", events.f36, "252", {actions.f24, actions.f21, }},
  {"305", events.f10, "246", {actions.f20, actions.f21, }},
  {"305", events.f26, "269", {actions.f27, actions.f21, }},
  {"305", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"305", events.f36, "252", {actions.f24, actions.f21, }},
  {"305", events.f22, "270", nil},
  {"305", events.f13, "266", {actions.f24, actions.f21, }},
  {"305", events.f32, "268", {actions.f27, actions.f21, }},
  {"305", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"305", events.f0, "222", nil},
  {"305", events.f6, "262", {actions.action_ir, actions.action_kp, }},
  {"305", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"305", events.f35, "261", {actions.f20, actions.f21, }},
  {"305", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"305", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"305", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"305", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"320", events.f19, "274", {actions.f20, actions.f21, }},
  {"320", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"320", events.f36, "252", {actions.f24, actions.f21, }},
  {"320", events.f35, "271", {actions.f20, actions.f21, }},
  {"320", events.f32, "280", {actions.f24, actions.f21, }},
  {"320", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"320", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"320", events.f0, "282", {actions.f20, actions.f21, }},
  {"320", events.f10, "246", {actions.f20, actions.f21, }},
  {"320", events.f13, "277", {actions.f24, actions.f21, }},
  {"320", events.f33, "276", {actions.f20, actions.f21, }},
  {"320", events.f23, "272", {actions.f24, actions.f21, }},
  {"320", events.f22, "281", nil},
  {"320", events.f26, "254", {actions.f27, actions.f21, }},
  {"320", events.f30, "278", {actions.f24, actions.f21, }},
  {"320", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"319", events.f30, "278", {actions.f24, actions.f21, }},
  {"319", events.f35, "314", {actions.f20, actions.f21, }},
  {"319", events.f23, "284", {actions.f24, actions.f21, }},
  {"319", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"319", events.f25, "241", nil},
  {"319", events.f17, "312", nil},
  {"319", events.f32, "307", {actions.f24, actions.f21, }},
  {"319", events.f6, "309", {actions.action_ir, actions.action_kp, }},
  {"319", events.f33, "293", {actions.f20, actions.f21, }},
  {"319", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"319", events.f13, "313", {actions.f24, actions.f21, }},
  {"319", events.f10, "224", nil},
  {"319", events.f22, "310", nil},
  {"319", events.f0, "282", {actions.f20, actions.f21, }},
  {"319", events.f19, "308", {actions.f20, actions.f21, }},
  {"319", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"318", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"318", events.f35, "248", {actions.f20, actions.f21, }},
  {"318", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"318", events.f32, "250", {actions.f24, actions.f21, }},
  {"318", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"318", events.f36, "252", {actions.f24, actions.f21, }},
  {"318", events.f26, "254", {actions.f27, actions.f21, }},
  {"318", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"318", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"318", events.f10, "246", {actions.f20, actions.f21, }},
  {"318", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"318", events.f13, "253", {actions.f24, actions.f21, }},
  {"318", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"318", events.f22, "260", nil},
  {"318", events.f19, "258", {actions.f20, actions.f21, }},
  {"318", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"317", events.f6, "262", {actions.action_ir, actions.action_kp, }},
  {"317", events.f0, "222", nil},
  {"317", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"317", events.f26, "269", {actions.f27, actions.f21, }},
  {"317", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"317", events.f22, "270", nil},
  {"317", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"317", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"317", events.f13, "266", {actions.f24, actions.f21, }},
  {"317", events.f36, "252", {actions.f24, actions.f21, }},
  {"317", events.f32, "268", {actions.f27, actions.f21, }},
  {"317", events.f35, "261", {actions.f20, actions.f21, }},
  {"317", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"317", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"317", events.f10, "246", {actions.f20, actions.f21, }},
  {"317", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"316", events.f32, "268", {actions.f27, actions.f21, }},
  {"316", events.f35, "261", {actions.f20, actions.f21, }},
  {"316", events.f13, "266", {actions.f24, actions.f21, }},
  {"316", events.f6, "262", {actions.action_ir, actions.action_kp, }},
  {"316", events.f36, "252", {actions.f24, actions.f21, }},
  {"316", events.f22, "270", nil},
  {"316", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"316", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"316", events.f0, "222", nil},
  {"316", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"316", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"316", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"316", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"316", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"316", events.f10, "246", {actions.f20, actions.f21, }},
  {"316", events.f26, "269", {actions.f27, actions.f21, }},
  {"315", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"315", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"315", events.f13, "253", {actions.f24, actions.f21, }},
  {"315", events.f22, "260", nil},
  {"315", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"315", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"315", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"315", events.f35, "248", {actions.f20, actions.f21, }},
  {"315", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"315", events.f32, "250", {actions.f24, actions.f21, }},
  {"315", events.f26, "254", {actions.f27, actions.f21, }},
  {"315", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"315", events.f36, "252", {actions.f24, actions.f21, }},
  {"315", events.f19, "258", {actions.f20, actions.f21, }},
  {"315", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"315", events.f10, "246", {actions.f20, actions.f21, }},
  {"314", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"314", events.f23, "272", {actions.f24, actions.f21, }},
  {"314", events.f30, "278", {actions.f24, actions.f21, }},
  {"314", events.f36, "252", {actions.f24, actions.f21, }},
  {"314", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"314", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"314", events.f10, "246", {actions.f20, actions.f21, }},
  {"314", events.f32, "280", {actions.f24, actions.f21, }},
  {"314", events.f0, "282", {actions.f20, actions.f21, }},
  {"314", events.f13, "277", {actions.f24, actions.f21, }},
  {"314", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"314", events.f35, "271", {actions.f20, actions.f21, }},
  {"314", events.f33, "276", {actions.f20, actions.f21, }},
  {"314", events.f19, "274", {actions.f20, actions.f21, }},
  {"314", events.f26, "254", {actions.f27, actions.f21, }},
  {"314", events.f22, "281", nil},
  {"313", events.f32, "280", {actions.f24, actions.f21, }},
  {"313", events.f0, "282", {actions.f20, actions.f21, }},
  {"313", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"313", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"313", events.f10, "246", {actions.f20, actions.f21, }},
  {"313", events.f13, "277", {actions.f24, actions.f21, }},
  {"313", events.f26, "254", {actions.f27, actions.f21, }},
  {"313", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"313", events.f33, "276", {actions.f20, actions.f21, }},
  {"313", events.f30, "278", {actions.f24, actions.f21, }},
  {"313", events.f23, "272", {actions.f24, actions.f21, }},
  {"313", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"313", events.f22, "281", nil},
  {"313", events.f19, "274", {actions.f20, actions.f21, }},
  {"313", events.f35, "271", {actions.f20, actions.f21, }},
  {"313", events.f36, "252", {actions.f24, actions.f21, }},
  {"295", events.f32, "250", {actions.f24, actions.f21, }},
  {"295", events.f36, "252", {actions.f24, actions.f21, }},
  {"295", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"295", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"295", events.f13, "253", {actions.f24, actions.f21, }},
  {"295", events.f22, "260", nil},
  {"295", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"295", events.f19, "258", {actions.f20, actions.f21, }},
  {"295", events.f10, "246", {actions.f20, actions.f21, }},
  {"295", events.f35, "248", {actions.f20, actions.f21, }},
  {"295", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"295", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"295", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"295", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"295", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"295", events.f26, "254", {actions.f27, actions.f21, }},
  {"296", events.f23, "295", {actions.f24, actions.f21, }},
  {"296", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"296", events.f35, "299", {actions.f20, actions.f21, }},
  {"296", events.f30, "233", {actions.f27, actions.f21, }},
  {"296", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"296", events.f26, "269", {actions.f27, actions.f21, }},
  {"296", events.f33, "301", {actions.f20, actions.f21, }},
  {"296", events.f32, "297", {actions.f27, actions.f21, }},
  {"296", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"296", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"296", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"296", events.f36, "252", {actions.f24, actions.f21, }},
  {"296", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"296", events.f22, "298", nil},
  {"296", events.f10, "246", {actions.f20, actions.f21, }},
  {"296", events.f13, "300", {actions.f24, actions.f21, }},
  {"293", events.f19, "258", {actions.f20, actions.f21, }},
  {"293", events.f35, "248", {actions.f20, actions.f21, }},
  {"293", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"293", events.f10, "246", {actions.f20, actions.f21, }},
  {"293", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"293", events.f26, "254", {actions.f27, actions.f21, }},
  {"293", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"293", events.f13, "253", {actions.f24, actions.f21, }},
  {"293", events.f36, "252", {actions.f24, actions.f21, }},
  {"293", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"293", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"293", events.f32, "250", {actions.f24, actions.f21, }},
  {"293", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"293", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"293", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"293", events.f22, "260", nil},
  {"294", events.f35, "271", {actions.f20, actions.f21, }},
  {"294", events.f0, "282", {actions.f20, actions.f21, }},
  {"294", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"294", events.f10, "246", {actions.f20, actions.f21, }},
  {"294", events.f19, "274", {actions.f20, actions.f21, }},
  {"294", events.f13, "277", {actions.f24, actions.f21, }},
  {"294", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"294", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"294", events.f23, "272", {actions.f24, actions.f21, }},
  {"294", events.f26, "254", {actions.f27, actions.f21, }},
  {"294", events.f33, "276", {actions.f20, actions.f21, }},
  {"294", events.f36, "252", {actions.f24, actions.f21, }},
  {"294", events.f30, "278", {actions.f24, actions.f21, }},
  {"294", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"294", events.f22, "281", nil},
  {"294", events.f32, "280", {actions.f24, actions.f21, }},
  {"291", events.f32, "307", {actions.f24, actions.f21, }},
  {"291", events.f33, "293", {actions.f20, actions.f21, }},
  {"291", events.f6, "309", {actions.action_ir, actions.action_kp, }},
  {"291", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"291", events.f10, "224", nil},
  {"291", events.f13, "313", {actions.f24, actions.f21, }},
  {"291", events.f22, "310", nil},
  {"291", events.f35, "314", {actions.f20, actions.f21, }},
  {"291", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"291", events.f19, "308", {actions.f20, actions.f21, }},
  {"291", events.f0, "282", {actions.f20, actions.f21, }},
  {"291", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"291", events.f25, "241", nil},
  {"291", events.f30, "278", {actions.f24, actions.f21, }},
  {"291", events.f23, "284", {actions.f24, actions.f21, }},
  {"291", events.f17, "312", nil},
  {"292", events.f54, "290", {actions.f27, actions.f21, }},
  {"292", events.f41, "380", {actions.f24, actions.f21, }},
  {"292", events.f56, "305", {actions.f20, actions.f21, }},
  {"292", events.f57, "292", nil},
  {"292", events.f37, "285", {actions.action_ir, actions.action_kp, }},
  {"292", events.f46, "287", {actions.action_kr, actions.action_ip, }},
  {"292", events.f52, "304", {actions.f24, actions.f21, }},
  {"292", events.f50, "379", {actions.f20, actions.f21, }},
  {"289", events.f0, "282", {actions.f20, actions.f21, }},
  {"289", events.f32, "280", {actions.f24, actions.f21, }},
  {"289", events.f35, "271", {actions.f20, actions.f21, }},
  {"289", events.f26, "254", {actions.f27, actions.f21, }},
  {"289", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"289", events.f30, "278", {actions.f24, actions.f21, }},
  {"289", events.f19, "274", {actions.f20, actions.f21, }},
  {"289", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"289", events.f13, "277", {actions.f24, actions.f21, }},
  {"289", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"289", events.f10, "246", {actions.f20, actions.f21, }},
  {"289", events.f33, "276", {actions.f20, actions.f21, }},
  {"289", events.f23, "272", {actions.f24, actions.f21, }},
  {"289", events.f36, "252", {actions.f24, actions.f21, }},
  {"289", events.f22, "281", nil},
  {"289", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"290", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"290", events.f22, "310", nil},
  {"290", events.f0, "282", {actions.f20, actions.f21, }},
  {"290", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"290", events.f17, "312", nil},
  {"290", events.f25, "241", nil},
  {"290", events.f19, "308", {actions.f20, actions.f21, }},
  {"290", events.f35, "314", {actions.f20, actions.f21, }},
  {"290", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"290", events.f33, "293", {actions.f20, actions.f21, }},
  {"290", events.f13, "313", {actions.f24, actions.f21, }},
  {"290", events.f32, "307", {actions.f24, actions.f21, }},
  {"290", events.f10, "224", nil},
  {"290", events.f6, "309", {actions.action_ir, actions.action_kp, }},
  {"290", events.f30, "278", {actions.f24, actions.f21, }},
  {"290", events.f23, "284", {actions.f24, actions.f21, }},
  {"303", events.f10, "246", {actions.f20, actions.f21, }},
  {"303", events.f33, "301", {actions.f20, actions.f21, }},
  {"303", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"303", events.f22, "298", nil},
  {"303", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"303", events.f23, "295", {actions.f24, actions.f21, }},
  {"303", events.f32, "297", {actions.f27, actions.f21, }},
  {"303", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"303", events.f26, "269", {actions.f27, actions.f21, }},
  {"303", events.f36, "252", {actions.f24, actions.f21, }},
  {"303", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"303", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"303", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"303", events.f13, "300", {actions.f24, actions.f21, }},
  {"303", events.f30, "233", {actions.f27, actions.f21, }},
  {"303", events.f35, "299", {actions.f20, actions.f21, }},
  {"304", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"304", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"304", events.f32, "268", {actions.f27, actions.f21, }},
  {"304", events.f26, "269", {actions.f27, actions.f21, }},
  {"304", events.f0, "222", nil},
  {"304", events.f22, "270", nil},
  {"304", events.f10, "246", {actions.f20, actions.f21, }},
  {"304", events.f36, "252", {actions.f24, actions.f21, }},
  {"304", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"304", events.f13, "266", {actions.f24, actions.f21, }},
  {"304", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"304", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"304", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"304", events.f35, "261", {actions.f20, actions.f21, }},
  {"304", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"304", events.f6, "262", {actions.action_ir, actions.action_kp, }},
  {"301", events.f32, "250", {actions.f24, actions.f21, }},
  {"301", events.f19, "258", {actions.f20, actions.f21, }},
  {"301", events.f36, "252", {actions.f24, actions.f21, }},
  {"301", events.f26, "254", {actions.f27, actions.f21, }},
  {"301", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"301", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"301", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"301", events.f13, "253", {actions.f24, actions.f21, }},
  {"301", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"301", events.f10, "246", {actions.f20, actions.f21, }},
  {"301", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"301", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"301", events.f35, "248", {actions.f20, actions.f21, }},
  {"301", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"301", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"301", events.f22, "260", nil},
  {"302", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"302", events.f22, "298", nil},
  {"302", events.f32, "297", {actions.f27, actions.f21, }},
  {"302", events.f33, "301", {actions.f20, actions.f21, }},
  {"302", events.f26, "269", {actions.f27, actions.f21, }},
  {"302", events.f30, "233", {actions.f27, actions.f21, }},
  {"302", events.f10, "246", {actions.f20, actions.f21, }},
  {"302", events.f13, "300", {actions.f24, actions.f21, }},
  {"302", events.f35, "299", {actions.f20, actions.f21, }},
  {"302", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"302", events.f23, "295", {actions.f24, actions.f21, }},
  {"302", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"302", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"302", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"302", events.f36, "252", {actions.f24, actions.f21, }},
  {"302", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"299", events.f10, "246", {actions.f20, actions.f21, }},
  {"299", events.f22, "281", nil},
  {"299", events.f36, "252", {actions.f24, actions.f21, }},
  {"299", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"299", events.f35, "271", {actions.f20, actions.f21, }},
  {"299", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"299", events.f26, "254", {actions.f27, actions.f21, }},
  {"299", events.f33, "276", {actions.f20, actions.f21, }},
  {"299", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"299", events.f0, "282", {actions.f20, actions.f21, }},
  {"299", events.f19, "274", {actions.f20, actions.f21, }},
  {"299", events.f23, "272", {actions.f24, actions.f21, }},
  {"299", events.f30, "278", {actions.f24, actions.f21, }},
  {"299", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"299", events.f32, "280", {actions.f24, actions.f21, }},
  {"299", events.f13, "277", {actions.f24, actions.f21, }},
  {"300", events.f23, "272", {actions.f24, actions.f21, }},
  {"300", events.f13, "277", {actions.f24, actions.f21, }},
  {"300", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"300", events.f10, "246", {actions.f20, actions.f21, }},
  {"300", events.f19, "274", {actions.f20, actions.f21, }},
  {"300", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"300", events.f26, "254", {actions.f27, actions.f21, }},
  {"300", events.f36, "252", {actions.f24, actions.f21, }},
  {"300", events.f32, "280", {actions.f24, actions.f21, }},
  {"300", events.f22, "281", nil},
  {"300", events.f33, "276", {actions.f20, actions.f21, }},
  {"300", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"300", events.f30, "278", {actions.f24, actions.f21, }},
  {"300", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"300", events.f0, "282", {actions.f20, actions.f21, }},
  {"300", events.f35, "271", {actions.f20, actions.f21, }},
  {"297", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"297", events.f22, "298", nil},
  {"297", events.f23, "295", {actions.f24, actions.f21, }},
  {"297", events.f26, "269", {actions.f27, actions.f21, }},
  {"297", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"297", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"297", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"297", events.f13, "300", {actions.f24, actions.f21, }},
  {"297", events.f32, "297", {actions.f27, actions.f21, }},
  {"297", events.f10, "246", {actions.f20, actions.f21, }},
  {"297", events.f36, "252", {actions.f24, actions.f21, }},
  {"297", events.f33, "301", {actions.f20, actions.f21, }},
  {"297", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"297", events.f30, "233", {actions.f27, actions.f21, }},
  {"297", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"297", events.f35, "299", {actions.f20, actions.f21, }},
  {"298", events.f10, "246", {actions.f20, actions.f21, }},
  {"298", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"298", events.f30, "233", {actions.f27, actions.f21, }},
  {"298", events.f35, "299", {actions.f20, actions.f21, }},
  {"298", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"298", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"298", events.f36, "252", {actions.f24, actions.f21, }},
  {"298", events.f26, "269", {actions.f27, actions.f21, }},
  {"298", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"298", events.f23, "295", {actions.f24, actions.f21, }},
  {"298", events.f33, "301", {actions.f20, actions.f21, }},
  {"298", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"298", events.f32, "297", {actions.f27, actions.f21, }},
  {"298", events.f22, "298", nil},
  {"298", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"298", events.f13, "300", {actions.f24, actions.f21, }},
  {"342", events.f41, "349", {actions.f24, actions.f21, }},
  {"342", events.f37, "343", {actions.action_ir, actions.action_kp, }},
  {"342", events.f52, "350", {actions.f16, actions.action_kp, }},
  {"342", events.f57, "342", nil},
  {"342", events.f46, "287", {actions.action_kr, actions.action_ip, }},
  {"342", events.f50, "348", {actions.f20, actions.f21, }},
  {"342", events.f54, "290", {actions.f27, actions.f21, }},
  {"342", events.f56, "347", {actions.action_dr, actions.action_kp, }},
  {"341", events.f32, "250", {actions.f24, actions.f21, }},
  {"341", events.f25, "342", nil},
  {"341", events.f22, "341", nil},
  {"341", events.f36, "290", {actions.f27, actions.f21, }},
  {"341", events.f28, "343", {actions.action_ir, actions.action_kp, }},
  {"341", events.f26, "286", {actions.f27, actions.f21, }},
  {"341", events.f23, "345", {actions.f16, actions.action_kp, }},
  {"341", events.f17, "291", {actions.action_kr, actions.action_ip, }},
  {"341", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"341", events.f19, "258", {actions.f20, actions.f21, }},
  {"341", events.f35, "339", {actions.f20, actions.f21, }},
  {"341", events.f33, "346", {actions.action_dr, actions.action_kp, }},
  {"341", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"341", events.f6, "340", {actions.action_ir, actions.action_kp, }},
  {"341", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"341", events.f13, "344", {actions.f24, actions.f21, }},
  {"344", events.f26, "254", {actions.f27, actions.f21, }},
  {"344", events.f10, "246", {actions.f20, actions.f21, }},
  {"344", events.f0, "282", {actions.f20, actions.f21, }},
  {"344", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"344", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"344", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"344", events.f13, "277", {actions.f24, actions.f21, }},
  {"344", events.f35, "271", {actions.f20, actions.f21, }},
  {"344", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"344", events.f32, "280", {actions.f24, actions.f21, }},
  {"344", events.f19, "274", {actions.f20, actions.f21, }},
  {"344", events.f30, "278", {actions.f24, actions.f21, }},
  {"344", events.f22, "281", nil},
  {"344", events.f23, "272", {actions.f24, actions.f21, }},
  {"344", events.f33, "276", {actions.f20, actions.f21, }},
  {"344", events.f36, "252", {actions.f24, actions.f21, }},
  {"343", events.f35, "339", {actions.f20, actions.f21, }},
  {"343", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"343", events.f32, "250", {actions.f24, actions.f21, }},
  {"343", events.f22, "341", nil},
  {"343", events.f13, "344", {actions.f24, actions.f21, }},
  {"343", events.f23, "345", {actions.f16, actions.action_kp, }},
  {"343", events.f36, "290", {actions.f27, actions.f21, }},
  {"343", events.f6, "340", {actions.action_ir, actions.action_kp, }},
  {"343", events.f26, "286", {actions.f27, actions.f21, }},
  {"343", events.f19, "258", {actions.f20, actions.f21, }},
  {"343", events.f28, "343", {actions.action_ir, actions.action_kp, }},
  {"343", events.f17, "291", {actions.action_kr, actions.action_ip, }},
  {"343", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"343", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"343", events.f25, "342", nil},
  {"343", events.f33, "346", {actions.action_dr, actions.action_kp, }},
  {"338", events.f32, "268", {actions.f27, actions.f21, }},
  {"338", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"338", events.f22, "270", nil},
  {"338", events.f36, "252", {actions.f24, actions.f21, }},
  {"338", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"338", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"338", events.f6, "262", {actions.action_ir, actions.action_kp, }},
  {"338", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"338", events.f0, "222", nil},
  {"338", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"338", events.f35, "261", {actions.f20, actions.f21, }},
  {"338", events.f10, "246", {actions.f20, actions.f21, }},
  {"338", events.f26, "269", {actions.f27, actions.f21, }},
  {"338", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"338", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"338", events.f13, "266", {actions.f24, actions.f21, }},
  {"337", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"337", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"337", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"337", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"337", events.f19, "258", {actions.f20, actions.f21, }},
  {"337", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"337", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"337", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"337", events.f32, "250", {actions.f24, actions.f21, }},
  {"337", events.f35, "248", {actions.f20, actions.f21, }},
  {"337", events.f10, "246", {actions.f20, actions.f21, }},
  {"337", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"337", events.f26, "254", {actions.f27, actions.f21, }},
  {"337", events.f36, "252", {actions.f24, actions.f21, }},
  {"337", events.f13, "253", {actions.f24, actions.f21, }},
  {"337", events.f22, "260", nil},
  {"340", events.f23, "345", {actions.f16, actions.action_kp, }},
  {"340", events.f22, "341", nil},
  {"340", events.f35, "339", {actions.f20, actions.f21, }},
  {"340", events.f36, "290", {actions.f27, actions.f21, }},
  {"340", events.f13, "344", {actions.f24, actions.f21, }},
  {"340", events.f32, "250", {actions.f24, actions.f21, }},
  {"340", events.f17, "291", {actions.action_kr, actions.action_ip, }},
  {"340", events.f6, "340", {actions.action_ir, actions.action_kp, }},
  {"340", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"340", events.f33, "346", {actions.action_dr, actions.action_kp, }},
  {"340", events.f25, "342", nil},
  {"340", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"340", events.f19, "258", {actions.f20, actions.f21, }},
  {"340", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"340", events.f26, "286", {actions.f27, actions.f21, }},
  {"340", events.f28, "343", {actions.action_ir, actions.action_kp, }},
  {"339", events.f19, "274", {actions.f20, actions.f21, }},
  {"339", events.f33, "276", {actions.f20, actions.f21, }},
  {"339", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"339", events.f23, "272", {actions.f24, actions.f21, }},
  {"339", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"339", events.f36, "252", {actions.f24, actions.f21, }},
  {"339", events.f26, "254", {actions.f27, actions.f21, }},
  {"339", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"339", events.f35, "271", {actions.f20, actions.f21, }},
  {"339", events.f32, "280", {actions.f24, actions.f21, }},
  {"339", events.f0, "282", {actions.f20, actions.f21, }},
  {"339", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"339", events.f10, "246", {actions.f20, actions.f21, }},
  {"339", events.f22, "281", nil},
  {"339", events.f13, "277", {actions.f24, actions.f21, }},
  {"339", events.f30, "278", {actions.f24, actions.f21, }},
  {"350", events.f36, "252", {actions.f24, actions.f21, }},
  {"350", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"350", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"350", events.f22, "270", nil},
  {"350", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"350", events.f10, "246", {actions.f20, actions.f21, }},
  {"350", events.f13, "266", {actions.f24, actions.f21, }},
  {"350", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"350", events.f35, "261", {actions.f20, actions.f21, }},
  {"350", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"350", events.f32, "268", {actions.f27, actions.f21, }},
  {"350", events.f6, "262", {actions.action_ir, actions.action_kp, }},
  {"350", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"350", events.f0, "222", nil},
  {"350", events.f26, "269", {actions.f27, actions.f21, }},
  {"350", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"349", events.f30, "233", {actions.f27, actions.f21, }},
  {"349", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"349", events.f33, "301", {actions.f20, actions.f21, }},
  {"349", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"349", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"349", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"349", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"349", events.f35, "299", {actions.f20, actions.f21, }},
  {"349", events.f22, "298", nil},
  {"349", events.f32, "297", {actions.f27, actions.f21, }},
  {"349", events.f26, "269", {actions.f27, actions.f21, }},
  {"349", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"349", events.f23, "295", {actions.f24, actions.f21, }},
  {"349", events.f10, "246", {actions.f20, actions.f21, }},
  {"349", events.f13, "300", {actions.f24, actions.f21, }},
  {"349", events.f36, "252", {actions.f24, actions.f21, }},
  {"352", events.f22, "281", nil},
  {"352", events.f0, "282", {actions.f20, actions.f21, }},
  {"352", events.f23, "272", {actions.f24, actions.f21, }},
  {"352", events.f30, "278", {actions.f24, actions.f21, }},
  {"352", events.f33, "276", {actions.f20, actions.f21, }},
  {"352", events.f10, "246", {actions.f20, actions.f21, }},
  {"352", events.f19, "274", {actions.f20, actions.f21, }},
  {"352", events.f32, "280", {actions.f24, actions.f21, }},
  {"352", events.f35, "271", {actions.f20, actions.f21, }},
  {"352", events.f26, "254", {actions.f27, actions.f21, }},
  {"352", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"352", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"352", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"352", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"352", events.f13, "277", {actions.f24, actions.f21, }},
  {"352", events.f36, "252", {actions.f24, actions.f21, }},
  {"351", events.f23, "345", {actions.f16, actions.action_kp, }},
  {"351", events.f25, "230", nil},
  {"351", events.f10, "224", nil},
  {"351", events.f28, "225", {actions.action_ir, actions.action_kp, }},
  {"351", events.f17, "312", nil},
  {"351", events.f33, "346", {actions.action_dr, actions.action_kp, }},
  {"351", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"351", events.f35, "352", {actions.action_dr, actions.action_kp, }},
  {"351", events.f19, "356", {actions.action_dr, actions.action_kp, }},
  {"351", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"351", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"351", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"351", events.f6, "353", {actions.action_ir, actions.action_kp, }},
  {"351", events.f32, "354", {actions.f16, actions.action_kp, }},
  {"351", events.f13, "355", {actions.f16, actions.action_kp, }},
  {"351", events.f22, "351", nil},
  {"346", events.f36, "252", {actions.f24, actions.f21, }},
  {"346", events.f19, "258", {actions.f20, actions.f21, }},
  {"346", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"346", events.f35, "248", {actions.f20, actions.f21, }},
  {"346", events.f26, "254", {actions.f27, actions.f21, }},
  {"346", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"346", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"346", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"346", events.f32, "250", {actions.f24, actions.f21, }},
  {"346", events.f10, "246", {actions.f20, actions.f21, }},
  {"346", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"346", events.f22, "260", nil},
  {"346", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"346", events.f13, "253", {actions.f24, actions.f21, }},
  {"346", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"346", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"345", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"345", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"345", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"345", events.f22, "260", nil},
  {"345", events.f13, "253", {actions.f24, actions.f21, }},
  {"345", events.f35, "248", {actions.f20, actions.f21, }},
  {"345", events.f10, "246", {actions.f20, actions.f21, }},
  {"345", events.f32, "250", {actions.f24, actions.f21, }},
  {"345", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"345", events.f26, "254", {actions.f27, actions.f21, }},
  {"345", events.f19, "258", {actions.f20, actions.f21, }},
  {"345", events.f36, "252", {actions.f24, actions.f21, }},
  {"345", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"345", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"345", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"345", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"348", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"348", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"348", events.f23, "295", {actions.f24, actions.f21, }},
  {"348", events.f33, "301", {actions.f20, actions.f21, }},
  {"348", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"348", events.f10, "246", {actions.f20, actions.f21, }},
  {"348", events.f35, "299", {actions.f20, actions.f21, }},
  {"348", events.f26, "269", {actions.f27, actions.f21, }},
  {"348", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"348", events.f22, "298", nil},
  {"348", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"348", events.f13, "300", {actions.f24, actions.f21, }},
  {"348", events.f30, "233", {actions.f27, actions.f21, }},
  {"348", events.f32, "297", {actions.f27, actions.f21, }},
  {"348", events.f36, "252", {actions.f24, actions.f21, }},
  {"348", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"347", events.f32, "268", {actions.f27, actions.f21, }},
  {"347", events.f22, "270", nil},
  {"347", events.f26, "269", {actions.f27, actions.f21, }},
  {"347", events.f35, "261", {actions.f20, actions.f21, }},
  {"347", events.f36, "252", {actions.f24, actions.f21, }},
  {"347", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"347", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"347", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"347", events.f13, "266", {actions.f24, actions.f21, }},
  {"347", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"347", events.f0, "222", nil},
  {"347", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"347", events.f10, "246", {actions.f20, actions.f21, }},
  {"347", events.f6, "262", {actions.action_ir, actions.action_kp, }},
  {"347", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"347", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"325", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"325", events.f25, "321", {actions.action_dr, actions.action_kp, }},
  {"325", events.f19, "308", {actions.f20, actions.f21, }},
  {"325", events.f6, "327", {actions.action_ir, actions.action_kp, }},
  {"325", events.f32, "307", {actions.f24, actions.f21, }},
  {"325", events.f17, "324", nil},
  {"325", events.f23, "272", {actions.f24, actions.f21, }},
  {"325", events.f28, "323", {actions.f16, actions.action_kp, }},
  {"325", events.f35, "320", {actions.f20, actions.f21, }},
  {"325", events.f13, "326", {actions.f24, actions.f21, }},
  {"325", events.f26, "322", {actions.action_ir, actions.action_kp, }},
  {"325", events.f33, "276", {actions.f20, actions.f21, }},
  {"325", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"325", events.f0, "282", {actions.f20, actions.f21, }},
  {"325", events.f22, "325", nil},
  {"325", events.f30, "278", {actions.f24, actions.f21, }},
  {"326", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"326", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"326", events.f22, "281", nil},
  {"326", events.f35, "271", {actions.f20, actions.f21, }},
  {"326", events.f13, "277", {actions.f24, actions.f21, }},
  {"326", events.f36, "252", {actions.f24, actions.f21, }},
  {"326", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"326", events.f26, "254", {actions.f27, actions.f21, }},
  {"326", events.f0, "282", {actions.f20, actions.f21, }},
  {"326", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"326", events.f19, "274", {actions.f20, actions.f21, }},
  {"326", events.f30, "278", {actions.f24, actions.f21, }},
  {"326", events.f33, "276", {actions.f20, actions.f21, }},
  {"326", events.f32, "280", {actions.f24, actions.f21, }},
  {"326", events.f10, "246", {actions.f20, actions.f21, }},
  {"326", events.f23, "272", {actions.f24, actions.f21, }},
  {"327", events.f23, "272", {actions.f24, actions.f21, }},
  {"327", events.f30, "278", {actions.f24, actions.f21, }},
  {"327", events.f32, "307", {actions.f24, actions.f21, }},
  {"327", events.f28, "323", {actions.f16, actions.action_kp, }},
  {"327", events.f22, "325", nil},
  {"327", events.f35, "320", {actions.f20, actions.f21, }},
  {"327", events.f26, "322", {actions.action_ir, actions.action_kp, }},
  {"327", events.f13, "326", {actions.f24, actions.f21, }},
  {"327", events.f33, "276", {actions.f20, actions.f21, }},
  {"327", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"327", events.f25, "321", {actions.action_dr, actions.action_kp, }},
  {"327", events.f6, "327", {actions.action_ir, actions.action_kp, }},
  {"327", events.f0, "282", {actions.f20, actions.f21, }},
  {"327", events.f17, "324", nil},
  {"327", events.f19, "308", {actions.f20, actions.f21, }},
  {"327", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"328", events.f17, "312", nil},
  {"328", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"328", events.f13, "313", {actions.f24, actions.f21, }},
  {"328", events.f35, "314", {actions.f20, actions.f21, }},
  {"328", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"328", events.f19, "308", {actions.f20, actions.f21, }},
  {"328", events.f25, "241", nil},
  {"328", events.f30, "278", {actions.f24, actions.f21, }},
  {"328", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"328", events.f22, "310", nil},
  {"328", events.f0, "282", {actions.f20, actions.f21, }},
  {"328", events.f10, "224", nil},
  {"328", events.f23, "284", {actions.f24, actions.f21, }},
  {"328", events.f32, "307", {actions.f24, actions.f21, }},
  {"328", events.f6, "309", {actions.action_ir, actions.action_kp, }},
  {"328", events.f33, "293", {actions.f20, actions.f21, }},
  {"321", events.f17, "312", nil},
  {"321", events.f35, "314", {actions.f20, actions.f21, }},
  {"321", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"321", events.f10, "224", nil},
  {"321", events.f22, "310", nil},
  {"321", events.f30, "278", {actions.f24, actions.f21, }},
  {"321", events.f19, "308", {actions.f20, actions.f21, }},
  {"321", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"321", events.f0, "282", {actions.f20, actions.f21, }},
  {"321", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"321", events.f6, "309", {actions.action_ir, actions.action_kp, }},
  {"321", events.f33, "293", {actions.f20, actions.f21, }},
  {"321", events.f25, "241", nil},
  {"321", events.f13, "313", {actions.f24, actions.f21, }},
  {"321", events.f23, "284", {actions.f24, actions.f21, }},
  {"321", events.f32, "307", {actions.f24, actions.f21, }},
  {"322", events.f13, "326", {actions.f24, actions.f21, }},
  {"322", events.f28, "323", {actions.f16, actions.action_kp, }},
  {"322", events.f22, "325", nil},
  {"322", events.f32, "307", {actions.f24, actions.f21, }},
  {"322", events.f6, "327", {actions.action_ir, actions.action_kp, }},
  {"322", events.f25, "321", {actions.action_dr, actions.action_kp, }},
  {"322", events.f30, "278", {actions.f24, actions.f21, }},
  {"322", events.f23, "272", {actions.f24, actions.f21, }},
  {"322", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"322", events.f0, "282", {actions.f20, actions.f21, }},
  {"322", events.f33, "276", {actions.f20, actions.f21, }},
  {"322", events.f26, "322", {actions.action_ir, actions.action_kp, }},
  {"322", events.f17, "324", nil},
  {"322", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"322", events.f19, "308", {actions.f20, actions.f21, }},
  {"322", events.f35, "320", {actions.f20, actions.f21, }},
  {"323", events.f32, "307", {actions.f24, actions.f21, }},
  {"323", events.f17, "312", nil},
  {"323", events.f25, "241", nil},
  {"323", events.f22, "310", nil},
  {"323", events.f19, "308", {actions.f20, actions.f21, }},
  {"323", events.f23, "284", {actions.f24, actions.f21, }},
  {"323", events.f6, "309", {actions.action_ir, actions.action_kp, }},
  {"323", events.f30, "278", {actions.f24, actions.f21, }},
  {"323", events.f0, "282", {actions.f20, actions.f21, }},
  {"323", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"323", events.f13, "313", {actions.f24, actions.f21, }},
  {"323", events.f10, "224", nil},
  {"323", events.f33, "293", {actions.f20, actions.f21, }},
  {"323", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"323", events.f35, "314", {actions.f20, actions.f21, }},
  {"323", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"324", events.f18, "324", nil},
  {"324", events.f1, "316", {actions.f20, actions.f21, }},
  {"324", events.f29, "319", {actions.f16, actions.action_kp, }},
  {"324", events.f14, "358", {actions.f24, actions.f21, }},
  {"324", events.f7, "322", {actions.action_ir, actions.action_kp, }},
  {"324", events.f11, "328", {actions.action_dr, actions.action_kp, }},
  {"324", events.f31, "317", {actions.f24, actions.f21, }},
  {"324", events.f34, "357", {actions.f20, actions.f21, }},
  {"333", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"333", events.f19, "274", {actions.f20, actions.f21, }},
  {"333", events.f22, "281", nil},
  {"333", events.f36, "252", {actions.f24, actions.f21, }},
  {"333", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"333", events.f0, "282", {actions.f20, actions.f21, }},
  {"333", events.f30, "278", {actions.f24, actions.f21, }},
  {"333", events.f26, "254", {actions.f27, actions.f21, }},
  {"333", events.f13, "277", {actions.f24, actions.f21, }},
  {"333", events.f35, "271", {actions.f20, actions.f21, }},
  {"333", events.f33, "276", {actions.f20, actions.f21, }},
  {"333", events.f23, "272", {actions.f24, actions.f21, }},
  {"333", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"333", events.f10, "246", {actions.f20, actions.f21, }},
  {"333", events.f32, "280", {actions.f24, actions.f21, }},
  {"333", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"334", events.f32, "244", {actions.f27, actions.f21, }},
  {"334", events.f13, "332", {actions.f24, actions.f21, }},
  {"334", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"334", events.f30, "233", {actions.f27, actions.f21, }},
  {"334", events.f28, "323", {actions.f16, actions.action_kp, }},
  {"334", events.f26, "330", {actions.action_ir, actions.action_kp, }},
  {"334", events.f19, "239", {actions.action_kr, actions.action_ip, }},
  {"334", events.f25, "321", {actions.action_dr, actions.action_kp, }},
  {"334", events.f17, "331", nil},
  {"334", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"334", events.f22, "329", nil},
  {"334", events.f33, "301", {actions.f20, actions.f21, }},
  {"334", events.f35, "333", {actions.f20, actions.f21, }},
  {"334", events.f23, "295", {actions.f24, actions.f21, }},
  {"334", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"334", events.f6, "334", {actions.action_ir, actions.action_kp, }},
  {"335", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"335", events.f36, "252", {actions.f24, actions.f21, }},
  {"335", events.f22, "270", nil},
  {"335", events.f0, "222", nil},
  {"335", events.f26, "269", {actions.f27, actions.f21, }},
  {"335", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"335", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"335", events.f6, "262", {actions.action_ir, actions.action_kp, }},
  {"335", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"335", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"335", events.f32, "268", {actions.f27, actions.f21, }},
  {"335", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"335", events.f13, "266", {actions.f24, actions.f21, }},
  {"335", events.f10, "246", {actions.f20, actions.f21, }},
  {"335", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"335", events.f35, "261", {actions.f20, actions.f21, }},
  {"336", events.f36, "252", {actions.f24, actions.f21, }},
  {"336", events.f26, "254", {actions.f27, actions.f21, }},
  {"336", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"336", events.f19, "258", {actions.f20, actions.f21, }},
  {"336", events.f32, "250", {actions.f24, actions.f21, }},
  {"336", events.f35, "248", {actions.f20, actions.f21, }},
  {"336", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"336", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"336", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"336", events.f10, "246", {actions.f20, actions.f21, }},
  {"336", events.f13, "253", {actions.f24, actions.f21, }},
  {"336", events.f22, "260", nil},
  {"336", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"336", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"336", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"336", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"329", events.f28, "323", {actions.f16, actions.action_kp, }},
  {"329", events.f13, "332", {actions.f24, actions.f21, }},
  {"329", events.f17, "331", nil},
  {"329", events.f22, "329", nil},
  {"329", events.f30, "233", {actions.f27, actions.f21, }},
  {"329", events.f35, "333", {actions.f20, actions.f21, }},
  {"329", events.f26, "330", {actions.action_ir, actions.action_kp, }},
  {"329", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"329", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"329", events.f19, "239", {actions.action_kr, actions.action_ip, }},
  {"329", events.f25, "321", {actions.action_dr, actions.action_kp, }},
  {"329", events.f6, "334", {actions.action_ir, actions.action_kp, }},
  {"329", events.f33, "301", {actions.f20, actions.f21, }},
  {"329", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"329", events.f23, "295", {actions.f24, actions.f21, }},
  {"329", events.f32, "244", {actions.f27, actions.f21, }},
  {"330", events.f26, "330", {actions.action_ir, actions.action_kp, }},
  {"330", events.f19, "239", {actions.action_kr, actions.action_ip, }},
  {"330", events.f17, "331", nil},
  {"330", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"330", events.f35, "333", {actions.f20, actions.f21, }},
  {"330", events.f6, "334", {actions.action_ir, actions.action_kp, }},
  {"330", events.f33, "301", {actions.f20, actions.f21, }},
  {"330", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"330", events.f32, "244", {actions.f27, actions.f21, }},
  {"330", events.f30, "233", {actions.f27, actions.f21, }},
  {"330", events.f22, "329", nil},
  {"330", events.f13, "332", {actions.f24, actions.f21, }},
  {"330", events.f28, "323", {actions.f16, actions.action_kp, }},
  {"330", events.f23, "295", {actions.f24, actions.f21, }},
  {"330", events.f25, "321", {actions.action_dr, actions.action_kp, }},
  {"330", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"331", events.f1, "338", {actions.action_kr, actions.action_ip, }},
  {"331", events.f34, "337", {actions.f20, actions.f21, }},
  {"331", events.f29, "319", {actions.f16, actions.action_kp, }},
  {"331", events.f14, "336", {actions.f24, actions.f21, }},
  {"331", events.f31, "335", {actions.f27, actions.f21, }},
  {"331", events.f18, "331", nil},
  {"331", events.f7, "330", {actions.action_ir, actions.action_kp, }},
  {"331", events.f11, "328", {actions.action_dr, actions.action_kp, }},
  {"332", events.f19, "274", {actions.f20, actions.f21, }},
  {"332", events.f0, "282", {actions.f20, actions.f21, }},
  {"332", events.f35, "271", {actions.f20, actions.f21, }},
  {"332", events.f23, "272", {actions.f24, actions.f21, }},
  {"332", events.f30, "278", {actions.f24, actions.f21, }},
  {"332", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"332", events.f36, "252", {actions.f24, actions.f21, }},
  {"332", events.f33, "276", {actions.f20, actions.f21, }},
  {"332", events.f32, "280", {actions.f24, actions.f21, }},
  {"332", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"332", events.f26, "254", {actions.f27, actions.f21, }},
  {"332", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"332", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"332", events.f22, "281", nil},
  {"332", events.f13, "277", {actions.f24, actions.f21, }},
  {"332", events.f10, "246", {actions.f20, actions.f21, }},
  {"379", events.f22, "298", nil},
  {"379", events.f10, "246", {actions.f20, actions.f21, }},
  {"379", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"379", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"379", events.f13, "300", {actions.f24, actions.f21, }},
  {"379", events.f32, "297", {actions.f27, actions.f21, }},
  {"379", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"379", events.f26, "269", {actions.f27, actions.f21, }},
  {"379", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"379", events.f33, "301", {actions.f20, actions.f21, }},
  {"379", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"379", events.f35, "299", {actions.f20, actions.f21, }},
  {"379", events.f23, "295", {actions.f24, actions.f21, }},
  {"379", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"379", events.f36, "252", {actions.f24, actions.f21, }},
  {"379", events.f30, "233", {actions.f27, actions.f21, }},
  {"380", events.f23, "295", {actions.f24, actions.f21, }},
  {"380", events.f35, "299", {actions.f20, actions.f21, }},
  {"380", events.f30, "233", {actions.f27, actions.f21, }},
  {"380", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"380", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"380", events.f36, "252", {actions.f24, actions.f21, }},
  {"380", events.f10, "246", {actions.f20, actions.f21, }},
  {"380", events.f33, "301", {actions.f20, actions.f21, }},
  {"380", events.f22, "298", nil},
  {"380", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"380", events.f13, "300", {actions.f24, actions.f21, }},
  {"380", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"380", events.f26, "269", {actions.f27, actions.f21, }},
  {"380", events.f32, "297", {actions.f27, actions.f21, }},
  {"380", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"380", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"377", events.f26, "254", {actions.f27, actions.f21, }},
  {"377", events.f36, "252", {actions.f24, actions.f21, }},
  {"377", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"377", events.f30, "278", {actions.f24, actions.f21, }},
  {"377", events.f23, "272", {actions.f24, actions.f21, }},
  {"377", events.f10, "246", {actions.f20, actions.f21, }},
  {"377", events.f33, "276", {actions.f20, actions.f21, }},
  {"377", events.f19, "274", {actions.f20, actions.f21, }},
  {"377", events.f0, "282", {actions.f20, actions.f21, }},
  {"377", events.f32, "280", {actions.f24, actions.f21, }},
  {"377", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"377", events.f22, "281", nil},
  {"377", events.f13, "277", {actions.f24, actions.f21, }},
  {"377", events.f35, "271", {actions.f20, actions.f21, }},
  {"377", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"377", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"378", events.f19, "239", {actions.action_kr, actions.action_ip, }},
  {"378", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"378", events.f23, "240", {actions.f27, actions.f21, }},
  {"378", events.f6, "236", {actions.action_ir, actions.action_kp, }},
  {"378", events.f33, "242", {actions.action_kr, actions.action_ip, }},
  {"378", events.f35, "234", {actions.action_kr, actions.action_ip, }},
  {"378", events.f10, "224", nil},
  {"378", events.f25, "241", nil},
  {"378", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"378", events.f32, "244", {actions.f27, actions.f21, }},
  {"378", events.f26, "221", {actions.action_ir, actions.action_kp, }},
  {"378", events.f17, "217", nil},
  {"378", events.f30, "233", {actions.f27, actions.f21, }},
  {"378", events.f22, "238", nil},
  {"378", events.f13, "243", {actions.f27, actions.f21, }},
  {"378", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"383", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"383", events.f33, "301", {actions.f20, actions.f21, }},
  {"383", events.f30, "233", {actions.f27, actions.f21, }},
  {"383", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"383", events.f23, "295", {actions.f24, actions.f21, }},
  {"383", events.f28, "323", {actions.f16, actions.action_kp, }},
  {"383", events.f22, "329", nil},
  {"383", events.f13, "332", {actions.f24, actions.f21, }},
  {"383", events.f17, "331", nil},
  {"383", events.f6, "334", {actions.action_ir, actions.action_kp, }},
  {"383", events.f35, "333", {actions.f20, actions.f21, }},
  {"383", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"383", events.f32, "244", {actions.f27, actions.f21, }},
  {"383", events.f26, "330", {actions.action_ir, actions.action_kp, }},
  {"383", events.f19, "239", {actions.action_kr, actions.action_ip, }},
  {"383", events.f25, "321", {actions.action_dr, actions.action_kp, }},
  {"384", events.f35, "333", {actions.f20, actions.f21, }},
  {"384", events.f6, "334", {actions.action_ir, actions.action_kp, }},
  {"384", events.f22, "329", nil},
  {"384", events.f33, "301", {actions.f20, actions.f21, }},
  {"384", events.f32, "244", {actions.f27, actions.f21, }},
  {"384", events.f26, "330", {actions.action_ir, actions.action_kp, }},
  {"384", events.f23, "295", {actions.f24, actions.f21, }},
  {"384", events.f19, "239", {actions.action_kr, actions.action_ip, }},
  {"384", events.f28, "323", {actions.f16, actions.action_kp, }},
  {"384", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"384", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"384", events.f13, "332", {actions.f24, actions.f21, }},
  {"384", events.f30, "233", {actions.f27, actions.f21, }},
  {"384", events.f17, "331", nil},
  {"384", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"384", events.f25, "321", {actions.action_dr, actions.action_kp, }},
  {"381", events.f26, "254", {actions.f27, actions.f21, }},
  {"381", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"381", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"381", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"381", events.f19, "258", {actions.f20, actions.f21, }},
  {"381", events.f35, "248", {actions.f20, actions.f21, }},
  {"381", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"381", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"381", events.f36, "252", {actions.f24, actions.f21, }},
  {"381", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"381", events.f13, "253", {actions.f24, actions.f21, }},
  {"381", events.f10, "246", {actions.f20, actions.f21, }},
  {"381", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"381", events.f32, "250", {actions.f24, actions.f21, }},
  {"381", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"381", events.f22, "260", nil},
  {"382", events.f13, "253", {actions.f24, actions.f21, }},
  {"382", events.f35, "248", {actions.f20, actions.f21, }},
  {"382", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"382", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"382", events.f32, "250", {actions.f24, actions.f21, }},
  {"382", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"382", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"382", events.f22, "260", nil},
  {"382", events.f26, "254", {actions.f27, actions.f21, }},
  {"382", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"382", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"382", events.f19, "258", {actions.f20, actions.f21, }},
  {"382", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"382", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"382", events.f36, "252", {actions.f24, actions.f21, }},
  {"382", events.f10, "246", {actions.f20, actions.f21, }},
  {"371", events.f26, "286", {actions.f27, actions.f21, }},
  {"371", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"371", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"371", events.f32, "250", {actions.f24, actions.f21, }},
  {"371", events.f19, "258", {actions.f20, actions.f21, }},
  {"371", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"371", events.f6, "340", {actions.action_ir, actions.action_kp, }},
  {"371", events.f33, "346", {actions.action_dr, actions.action_kp, }},
  {"371", events.f25, "342", nil},
  {"371", events.f28, "343", {actions.action_ir, actions.action_kp, }},
  {"371", events.f23, "345", {actions.f16, actions.action_kp, }},
  {"371", events.f36, "290", {actions.f27, actions.f21, }},
  {"371", events.f35, "339", {actions.f20, actions.f21, }},
  {"371", events.f13, "344", {actions.f24, actions.f21, }},
  {"371", events.f22, "341", nil},
  {"371", events.f17, "291", {actions.action_kr, actions.action_ip, }},
  {"372", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"372", events.f23, "284", {actions.f24, actions.f21, }},
  {"372", events.f25, "241", nil},
  {"372", events.f19, "308", {actions.f20, actions.f21, }},
  {"372", events.f10, "224", nil},
  {"372", events.f22, "310", nil},
  {"372", events.f17, "312", nil},
  {"372", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"372", events.f32, "307", {actions.f24, actions.f21, }},
  {"372", events.f0, "282", {actions.f20, actions.f21, }},
  {"372", events.f30, "278", {actions.f24, actions.f21, }},
  {"372", events.f33, "293", {actions.f20, actions.f21, }},
  {"372", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"372", events.f35, "314", {actions.f20, actions.f21, }},
  {"372", events.f13, "313", {actions.f24, actions.f21, }},
  {"372", events.f6, "309", {actions.action_ir, actions.action_kp, }},
  {"369", events.f13, "243", {actions.f27, actions.f21, }},
  {"369", events.f32, "244", {actions.f27, actions.f21, }},
  {"369", events.f19, "239", {actions.action_kr, actions.action_ip, }},
  {"369", events.f33, "242", {actions.action_kr, actions.action_ip, }},
  {"369", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"369", events.f17, "217", nil},
  {"369", events.f26, "221", {actions.action_ir, actions.action_kp, }},
  {"369", events.f30, "233", {actions.f27, actions.f21, }},
  {"369", events.f25, "241", nil},
  {"369", events.f10, "224", nil},
  {"369", events.f23, "240", {actions.f27, actions.f21, }},
  {"369", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"369", events.f6, "236", {actions.action_ir, actions.action_kp, }},
  {"369", events.f22, "238", nil},
  {"369", events.f35, "234", {actions.action_kr, actions.action_ip, }},
  {"369", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"370", events.f13, "374", {actions.f27, actions.f21, }},
  {"370", events.f23, "232", {actions.action_ir, actions.action_kp, }},
  {"370", events.f25, "342", nil},
  {"370", events.f0, "222", nil},
  {"370", events.f35, "377", {actions.action_kr, actions.action_ip, }},
  {"370", events.f22, "375", nil},
  {"370", events.f26, "373", {actions.f27, actions.f21, }},
  {"370", events.f33, "229", nil},
  {"370", events.f6, "376", {actions.action_ir, actions.action_kp, }},
  {"370", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"370", events.f28, "343", {actions.action_ir, actions.action_kp, }},
  {"370", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"370", events.f36, "290", {actions.f27, actions.f21, }},
  {"370", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"370", events.f17, "378", {actions.action_kr, actions.action_ip, }},
  {"370", events.f32, "268", {actions.f27, actions.f21, }},
  {"375", events.f25, "342", nil},
  {"375", events.f13, "374", {actions.f27, actions.f21, }},
  {"375", events.f17, "378", {actions.action_kr, actions.action_ip, }},
  {"375", events.f0, "222", nil},
  {"375", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"375", events.f28, "343", {actions.action_ir, actions.action_kp, }},
  {"375", events.f36, "290", {actions.f27, actions.f21, }},
  {"375", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"375", events.f26, "373", {actions.f27, actions.f21, }},
  {"375", events.f22, "375", nil},
  {"375", events.f6, "376", {actions.action_ir, actions.action_kp, }},
  {"375", events.f33, "229", nil},
  {"375", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"375", events.f35, "377", {actions.action_kr, actions.action_ip, }},
  {"375", events.f23, "232", {actions.action_ir, actions.action_kp, }},
  {"375", events.f32, "268", {actions.f27, actions.f21, }},
  {"376", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"376", events.f22, "375", nil},
  {"376", events.f28, "343", {actions.action_ir, actions.action_kp, }},
  {"376", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"376", events.f13, "374", {actions.f27, actions.f21, }},
  {"376", events.f0, "222", nil},
  {"376", events.f32, "268", {actions.f27, actions.f21, }},
  {"376", events.f35, "377", {actions.action_kr, actions.action_ip, }},
  {"376", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"376", events.f23, "232", {actions.action_ir, actions.action_kp, }},
  {"376", events.f25, "342", nil},
  {"376", events.f6, "376", {actions.action_ir, actions.action_kp, }},
  {"376", events.f26, "373", {actions.f27, actions.f21, }},
  {"376", events.f36, "290", {actions.f27, actions.f21, }},
  {"376", events.f17, "378", {actions.action_kr, actions.action_ip, }},
  {"376", events.f33, "229", nil},
  {"373", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"373", events.f32, "244", {actions.f27, actions.f21, }},
  {"373", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"373", events.f13, "243", {actions.f27, actions.f21, }},
  {"373", events.f30, "233", {actions.f27, actions.f21, }},
  {"373", events.f19, "239", {actions.action_kr, actions.action_ip, }},
  {"373", events.f22, "238", nil},
  {"373", events.f23, "240", {actions.f27, actions.f21, }},
  {"373", events.f10, "224", nil},
  {"373", events.f35, "234", {actions.action_kr, actions.action_ip, }},
  {"373", events.f33, "242", {actions.action_kr, actions.action_ip, }},
  {"373", events.f17, "217", nil},
  {"373", events.f6, "236", {actions.action_ir, actions.action_kp, }},
  {"373", events.f26, "221", {actions.action_ir, actions.action_kp, }},
  {"373", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"373", events.f25, "241", nil},
  {"374", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"374", events.f22, "281", nil},
  {"374", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"374", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"374", events.f35, "271", {actions.f20, actions.f21, }},
  {"374", events.f13, "277", {actions.f24, actions.f21, }},
  {"374", events.f30, "278", {actions.f24, actions.f21, }},
  {"374", events.f36, "252", {actions.f24, actions.f21, }},
  {"374", events.f32, "280", {actions.f24, actions.f21, }},
  {"374", events.f26, "254", {actions.f27, actions.f21, }},
  {"374", events.f19, "274", {actions.f20, actions.f21, }},
  {"374", events.f10, "246", {actions.f20, actions.f21, }},
  {"374", events.f33, "276", {actions.f20, actions.f21, }},
  {"374", events.f23, "272", {actions.f24, actions.f21, }},
  {"374", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"374", events.f0, "282", {actions.f20, actions.f21, }},
  {"364", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"364", events.f32, "268", {actions.f27, actions.f21, }},
  {"364", events.f35, "377", {actions.action_kr, actions.action_ip, }},
  {"364", events.f25, "342", nil},
  {"364", events.f13, "374", {actions.f27, actions.f21, }},
  {"364", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"364", events.f33, "229", nil},
  {"364", events.f6, "376", {actions.action_ir, actions.action_kp, }},
  {"364", events.f17, "378", {actions.action_kr, actions.action_ip, }},
  {"364", events.f0, "222", nil},
  {"364", events.f26, "373", {actions.f27, actions.f21, }},
  {"364", events.f23, "232", {actions.action_ir, actions.action_kp, }},
  {"364", events.f36, "290", {actions.f27, actions.f21, }},
  {"364", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"364", events.f28, "343", {actions.action_ir, actions.action_kp, }},
  {"364", events.f22, "375", nil},
  {"363", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"363", events.f30, "233", {actions.f27, actions.f21, }},
  {"363", events.f19, "239", {actions.action_kr, actions.action_ip, }},
  {"363", events.f33, "301", {actions.f20, actions.f21, }},
  {"363", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"363", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"363", events.f13, "332", {actions.f24, actions.f21, }},
  {"363", events.f17, "331", nil},
  {"363", events.f26, "330", {actions.action_ir, actions.action_kp, }},
  {"363", events.f25, "321", {actions.action_dr, actions.action_kp, }},
  {"363", events.f22, "329", nil},
  {"363", events.f35, "333", {actions.f20, actions.f21, }},
  {"363", events.f28, "323", {actions.f16, actions.action_kp, }},
  {"363", events.f32, "244", {actions.f27, actions.f21, }},
  {"363", events.f6, "334", {actions.action_ir, actions.action_kp, }},
  {"363", events.f23, "295", {actions.f24, actions.f21, }},
  {"362", events.f0, "282", {actions.f20, actions.f21, }},
  {"362", events.f19, "308", {actions.f20, actions.f21, }},
  {"362", events.f17, "312", nil},
  {"362", events.f13, "313", {actions.f24, actions.f21, }},
  {"362", events.f35, "314", {actions.f20, actions.f21, }},
  {"362", events.f22, "310", nil},
  {"362", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"362", events.f33, "293", {actions.f20, actions.f21, }},
  {"362", events.f23, "284", {actions.f24, actions.f21, }},
  {"362", events.f6, "309", {actions.action_ir, actions.action_kp, }},
  {"362", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"362", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"362", events.f25, "241", nil},
  {"362", events.f32, "307", {actions.f24, actions.f21, }},
  {"362", events.f10, "224", nil},
  {"362", events.f30, "278", {actions.f24, actions.f21, }},
  {"361", events.f28, "323", {actions.f16, actions.action_kp, }},
  {"361", events.f13, "332", {actions.f24, actions.f21, }},
  {"361", events.f6, "334", {actions.action_ir, actions.action_kp, }},
  {"361", events.f22, "329", nil},
  {"361", events.f35, "333", {actions.f20, actions.f21, }},
  {"361", events.f33, "301", {actions.f20, actions.f21, }},
  {"361", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"361", events.f17, "331", nil},
  {"361", events.f32, "244", {actions.f27, actions.f21, }},
  {"361", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"361", events.f25, "321", {actions.action_dr, actions.action_kp, }},
  {"361", events.f30, "233", {actions.f27, actions.f21, }},
  {"361", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"361", events.f19, "239", {actions.action_kr, actions.action_ip, }},
  {"361", events.f26, "330", {actions.action_ir, actions.action_kp, }},
  {"361", events.f23, "295", {actions.f24, actions.f21, }},
  {"368", events.f17, "324", nil},
  {"368", events.f28, "323", {actions.f16, actions.action_kp, }},
  {"368", events.f32, "307", {actions.f24, actions.f21, }},
  {"368", events.f13, "326", {actions.f24, actions.f21, }},
  {"368", events.f26, "322", {actions.action_ir, actions.action_kp, }},
  {"368", events.f22, "325", nil},
  {"368", events.f25, "321", {actions.action_dr, actions.action_kp, }},
  {"368", events.f23, "272", {actions.f24, actions.f21, }},
  {"368", events.f0, "282", {actions.f20, actions.f21, }},
  {"368", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"368", events.f19, "308", {actions.f20, actions.f21, }},
  {"368", events.f30, "278", {actions.f24, actions.f21, }},
  {"368", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"368", events.f6, "327", {actions.action_ir, actions.action_kp, }},
  {"368", events.f33, "276", {actions.f20, actions.f21, }},
  {"368", events.f35, "320", {actions.f20, actions.f21, }},
  {"367", events.f35, "339", {actions.f20, actions.f21, }},
  {"367", events.f25, "342", nil},
  {"367", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"367", events.f36, "290", {actions.f27, actions.f21, }},
  {"367", events.f23, "345", {actions.f16, actions.action_kp, }},
  {"367", events.f6, "340", {actions.action_ir, actions.action_kp, }},
  {"367", events.f13, "344", {actions.f24, actions.f21, }},
  {"367", events.f28, "343", {actions.action_ir, actions.action_kp, }},
  {"367", events.f19, "258", {actions.f20, actions.f21, }},
  {"367", events.f17, "291", {actions.action_kr, actions.action_ip, }},
  {"367", events.f33, "346", {actions.action_dr, actions.action_kp, }},
  {"367", events.f22, "341", nil},
  {"367", events.f26, "286", {actions.f27, actions.f21, }},
  {"367", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"367", events.f32, "250", {actions.f24, actions.f21, }},
  {"367", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"366", events.f33, "276", {actions.f20, actions.f21, }},
  {"366", events.f26, "322", {actions.action_ir, actions.action_kp, }},
  {"366", events.f30, "278", {actions.f24, actions.f21, }},
  {"366", events.f28, "323", {actions.f16, actions.action_kp, }},
  {"366", events.f6, "327", {actions.action_ir, actions.action_kp, }},
  {"366", events.f35, "320", {actions.f20, actions.f21, }},
  {"366", events.f32, "307", {actions.f24, actions.f21, }},
  {"366", events.f23, "272", {actions.f24, actions.f21, }},
  {"366", events.f25, "321", {actions.action_dr, actions.action_kp, }},
  {"366", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"366", events.f13, "326", {actions.f24, actions.f21, }},
  {"366", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"366", events.f19, "308", {actions.f20, actions.f21, }},
  {"366", events.f17, "324", nil},
  {"366", events.f22, "325", nil},
  {"366", events.f0, "282", {actions.f20, actions.f21, }},
  {"365", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"365", events.f35, "234", {actions.action_kr, actions.action_ip, }},
  {"365", events.f26, "221", {actions.action_ir, actions.action_kp, }},
  {"365", events.f10, "224", nil},
  {"365", events.f30, "233", {actions.f27, actions.f21, }},
  {"365", events.f19, "239", {actions.action_kr, actions.action_ip, }},
  {"365", events.f6, "236", {actions.action_ir, actions.action_kp, }},
  {"365", events.f22, "238", nil},
  {"365", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"365", events.f33, "242", {actions.action_kr, actions.action_ip, }},
  {"365", events.f13, "243", {actions.f27, actions.f21, }},
  {"365", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"365", events.f32, "244", {actions.f27, actions.f21, }},
  {"365", events.f25, "241", nil},
  {"365", events.f23, "240", {actions.f27, actions.f21, }},
  {"365", events.f17, "217", nil},
  {"356", events.f30, "233", {actions.f27, actions.f21, }},
  {"356", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"356", events.f23, "295", {actions.f24, actions.f21, }},
  {"356", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"356", events.f10, "246", {actions.f20, actions.f21, }},
  {"356", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"356", events.f26, "269", {actions.f27, actions.f21, }},
  {"356", events.f22, "298", nil},
  {"356", events.f35, "299", {actions.f20, actions.f21, }},
  {"356", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"356", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"356", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"356", events.f33, "301", {actions.f20, actions.f21, }},
  {"356", events.f36, "252", {actions.f24, actions.f21, }},
  {"356", events.f13, "300", {actions.f24, actions.f21, }},
  {"356", events.f32, "297", {actions.f27, actions.f21, }},
  {"355", events.f0, "282", {actions.f20, actions.f21, }},
  {"355", events.f23, "272", {actions.f24, actions.f21, }},
  {"355", events.f30, "278", {actions.f24, actions.f21, }},
  {"355", events.f35, "271", {actions.f20, actions.f21, }},
  {"355", events.f36, "252", {actions.f24, actions.f21, }},
  {"355", events.f22, "281", nil},
  {"355", events.f33, "276", {actions.f20, actions.f21, }},
  {"355", events.f19, "274", {actions.f20, actions.f21, }},
  {"355", events.f13, "277", {actions.f24, actions.f21, }},
  {"355", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"355", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"355", events.f26, "254", {actions.f27, actions.f21, }},
  {"355", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"355", events.f32, "280", {actions.f24, actions.f21, }},
  {"355", events.f10, "246", {actions.f20, actions.f21, }},
  {"355", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"354", events.f36, "252", {actions.f24, actions.f21, }},
  {"354", events.f26, "269", {actions.f27, actions.f21, }},
  {"354", events.f13, "300", {actions.f24, actions.f21, }},
  {"354", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"354", events.f22, "298", nil},
  {"354", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"354", events.f33, "301", {actions.f20, actions.f21, }},
  {"354", events.f30, "233", {actions.f27, actions.f21, }},
  {"354", events.f32, "297", {actions.f27, actions.f21, }},
  {"354", events.f23, "295", {actions.f24, actions.f21, }},
  {"354", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"354", events.f35, "299", {actions.f20, actions.f21, }},
  {"354", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"354", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"354", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"354", events.f10, "246", {actions.f20, actions.f21, }},
  {"353", events.f10, "224", nil},
  {"353", events.f19, "356", {actions.action_dr, actions.action_kp, }},
  {"353", events.f6, "353", {actions.action_ir, actions.action_kp, }},
  {"353", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"353", events.f17, "312", nil},
  {"353", events.f23, "345", {actions.f16, actions.action_kp, }},
  {"353", events.f32, "354", {actions.f16, actions.action_kp, }},
  {"353", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"353", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"353", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"353", events.f13, "355", {actions.f16, actions.action_kp, }},
  {"353", events.f22, "351", nil},
  {"353", events.f28, "225", {actions.action_ir, actions.action_kp, }},
  {"353", events.f35, "352", {actions.action_dr, actions.action_kp, }},
  {"353", events.f25, "230", nil},
  {"353", events.f33, "346", {actions.action_dr, actions.action_kp, }},
  {"360", events.f22, "298", nil},
  {"360", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"360", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"360", events.f32, "297", {actions.f27, actions.f21, }},
  {"360", events.f33, "301", {actions.f20, actions.f21, }},
  {"360", events.f26, "269", {actions.f27, actions.f21, }},
  {"360", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"360", events.f23, "295", {actions.f24, actions.f21, }},
  {"360", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"360", events.f30, "233", {actions.f27, actions.f21, }},
  {"360", events.f13, "300", {actions.f24, actions.f21, }},
  {"360", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"360", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"360", events.f36, "252", {actions.f24, actions.f21, }},
  {"360", events.f35, "299", {actions.f20, actions.f21, }},
  {"360", events.f10, "246", {actions.f20, actions.f21, }},
  {"359", events.f30, "233", {actions.f27, actions.f21, }},
  {"359", events.f35, "299", {actions.f20, actions.f21, }},
  {"359", events.f32, "297", {actions.f27, actions.f21, }},
  {"359", events.f23, "295", {actions.f24, actions.f21, }},
  {"359", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"359", events.f13, "300", {actions.f24, actions.f21, }},
  {"359", events.f10, "246", {actions.f20, actions.f21, }},
  {"359", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"359", events.f26, "269", {actions.f27, actions.f21, }},
  {"359", events.f36, "252", {actions.f24, actions.f21, }},
  {"359", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"359", events.f33, "301", {actions.f20, actions.f21, }},
  {"359", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"359", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"359", events.f22, "298", nil},
  {"359", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"358", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"358", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"358", events.f26, "254", {actions.f27, actions.f21, }},
  {"358", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"358", events.f35, "248", {actions.f20, actions.f21, }},
  {"358", events.f13, "253", {actions.f24, actions.f21, }},
  {"358", events.f32, "250", {actions.f24, actions.f21, }},
  {"358", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"358", events.f22, "260", nil},
  {"358", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"358", events.f36, "252", {actions.f24, actions.f21, }},
  {"358", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"358", events.f10, "246", {actions.f20, actions.f21, }},
  {"358", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"358", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"358", events.f19, "258", {actions.f20, actions.f21, }},
  {"357", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"357", events.f13, "253", {actions.f24, actions.f21, }},
  {"357", events.f35, "248", {actions.f20, actions.f21, }},
  {"357", events.f36, "252", {actions.f24, actions.f21, }},
  {"357", events.f26, "254", {actions.f27, actions.f21, }},
  {"357", events.f19, "258", {actions.f20, actions.f21, }},
  {"357", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"357", events.f33, "251", {actions.action_dr, actions.action_kp, }},
  {"357", events.f23, "245", {actions.f16, actions.action_kp, }},
  {"357", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"357", events.f32, "250", {actions.f24, actions.f21, }},
  {"357", events.f22, "260", nil},
  {"357", events.f6, "255", {actions.action_ir, actions.action_kp, }},
  {"357", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"357", events.f10, "246", {actions.f20, actions.f21, }},
  {"357", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"401", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"401", events.f32, "223", {actions.action_ir, actions.action_kp, }},
  {"401", events.f17, "331", nil},
  {"401", events.f0, "222", nil},
  {"401", events.f25, "393", {actions.action_dr, actions.action_kp, }},
  {"401", events.f22, "396", nil},
  {"401", events.f28, "398", {actions.f16, actions.action_kp, }},
  {"401", events.f35, "394", {actions.action_dr, actions.action_kp, }},
  {"401", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"401", events.f19, "228", nil},
  {"401", events.f13, "397", {actions.f16, actions.action_kp, }},
  {"401", events.f26, "330", {actions.action_ir, actions.action_kp, }},
  {"401", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"401", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"401", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"401", events.f6, "395", {actions.action_ir, actions.action_kp, }},
  {"402", events.f25, "342", nil},
  {"402", events.f17, "378", {actions.action_kr, actions.action_ip, }},
  {"402", events.f28, "343", {actions.action_ir, actions.action_kp, }},
  {"402", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"402", events.f36, "290", {actions.f27, actions.f21, }},
  {"402", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"402", events.f22, "375", nil},
  {"402", events.f0, "222", nil},
  {"402", events.f35, "377", {actions.action_kr, actions.action_ip, }},
  {"402", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"402", events.f33, "229", nil},
  {"402", events.f13, "374", {actions.f27, actions.f21, }},
  {"402", events.f6, "376", {actions.action_ir, actions.action_kp, }},
  {"402", events.f26, "373", {actions.f27, actions.f21, }},
  {"402", events.f23, "232", {actions.action_ir, actions.action_kp, }},
  {"402", events.f32, "268", {actions.f27, actions.f21, }},
  {"403", events.f6, "231", {actions.action_ir, actions.action_kp, }},
  {"403", events.f0, "222", nil},
  {"403", events.f23, "232", {actions.action_ir, actions.action_kp, }},
  {"403", events.f28, "225", {actions.action_ir, actions.action_kp, }},
  {"403", events.f35, "226", nil},
  {"403", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"403", events.f13, "227", {actions.action_ir, actions.action_kp, }},
  {"403", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"403", events.f32, "223", {actions.action_ir, actions.action_kp, }},
  {"403", events.f17, "217", nil},
  {"403", events.f33, "229", nil},
  {"403", events.f19, "228", nil},
  {"403", events.f26, "221", {actions.action_ir, actions.action_kp, }},
  {"403", events.f10, "224", nil},
  {"403", events.f22, "218", nil},
  {"403", events.f25, "230", nil},
  {"404", events.f28, "343", {actions.action_ir, actions.action_kp, }},
  {"404", events.f6, "376", {actions.action_ir, actions.action_kp, }},
  {"404", events.f32, "268", {actions.f27, actions.f21, }},
  {"404", events.f23, "232", {actions.action_ir, actions.action_kp, }},
  {"404", events.f17, "378", {actions.action_kr, actions.action_ip, }},
  {"404", events.f0, "222", nil},
  {"404", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"404", events.f33, "229", nil},
  {"404", events.f35, "377", {actions.action_kr, actions.action_ip, }},
  {"404", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"404", events.f13, "374", {actions.f27, actions.f21, }},
  {"404", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"404", events.f22, "375", nil},
  {"404", events.f26, "373", {actions.f27, actions.f21, }},
  {"404", events.f25, "342", nil},
  {"404", events.f36, "290", {actions.f27, actions.f21, }},
  {"405", events.f17, "217", nil},
  {"405", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"405", events.f33, "229", nil},
  {"405", events.f26, "221", {actions.action_ir, actions.action_kp, }},
  {"405", events.f28, "225", {actions.action_ir, actions.action_kp, }},
  {"405", events.f22, "218", nil},
  {"405", events.f19, "228", nil},
  {"405", events.f13, "227", {actions.action_ir, actions.action_kp, }},
  {"405", events.f32, "223", {actions.action_ir, actions.action_kp, }},
  {"405", events.f0, "222", nil},
  {"405", events.f23, "232", {actions.action_ir, actions.action_kp, }},
  {"405", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"405", events.f25, "230", nil},
  {"405", events.f10, "224", nil},
  {"405", events.f6, "231", {actions.action_ir, actions.action_kp, }},
  {"405", events.f35, "226", nil},
  {"406", events.f13, "397", {actions.f16, actions.action_kp, }},
  {"406", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"406", events.f28, "398", {actions.f16, actions.action_kp, }},
  {"406", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"406", events.f35, "394", {actions.action_dr, actions.action_kp, }},
  {"406", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"406", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"406", events.f19, "228", nil},
  {"406", events.f26, "330", {actions.action_ir, actions.action_kp, }},
  {"406", events.f17, "331", nil},
  {"406", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"406", events.f25, "393", {actions.action_dr, actions.action_kp, }},
  {"406", events.f32, "223", {actions.action_ir, actions.action_kp, }},
  {"406", events.f22, "396", nil},
  {"406", events.f0, "222", nil},
  {"406", events.f6, "395", {actions.action_ir, actions.action_kp, }},
  {"394", events.f19, "274", {actions.f20, actions.f21, }},
  {"394", events.f35, "271", {actions.f20, actions.f21, }},
  {"394", events.f30, "278", {actions.f24, actions.f21, }},
  {"394", events.f23, "272", {actions.f24, actions.f21, }},
  {"394", events.f33, "276", {actions.f20, actions.f21, }},
  {"394", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"394", events.f32, "280", {actions.f24, actions.f21, }},
  {"394", events.f22, "281", nil},
  {"394", events.f26, "254", {actions.f27, actions.f21, }},
  {"394", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"394", events.f36, "252", {actions.f24, actions.f21, }},
  {"394", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"394", events.f10, "246", {actions.f20, actions.f21, }},
  {"394", events.f0, "282", {actions.f20, actions.f21, }},
  {"394", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"394", events.f13, "277", {actions.f24, actions.f21, }},
  {"393", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"393", events.f25, "230", nil},
  {"393", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"393", events.f35, "352", {actions.action_dr, actions.action_kp, }},
  {"393", events.f6, "353", {actions.action_ir, actions.action_kp, }},
  {"393", events.f33, "346", {actions.action_dr, actions.action_kp, }},
  {"393", events.f32, "354", {actions.f16, actions.action_kp, }},
  {"393", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"393", events.f23, "345", {actions.f16, actions.action_kp, }},
  {"393", events.f19, "356", {actions.action_dr, actions.action_kp, }},
  {"393", events.f28, "225", {actions.action_ir, actions.action_kp, }},
  {"393", events.f17, "312", nil},
  {"393", events.f22, "351", nil},
  {"393", events.f13, "355", {actions.f16, actions.action_kp, }},
  {"393", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"393", events.f10, "224", nil},
  {"396", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"396", events.f28, "398", {actions.f16, actions.action_kp, }},
  {"396", events.f26, "330", {actions.action_ir, actions.action_kp, }},
  {"396", events.f32, "223", {actions.action_ir, actions.action_kp, }},
  {"396", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"396", events.f13, "397", {actions.f16, actions.action_kp, }},
  {"396", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"396", events.f6, "395", {actions.action_ir, actions.action_kp, }},
  {"396", events.f0, "222", nil},
  {"396", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"396", events.f17, "331", nil},
  {"396", events.f19, "228", nil},
  {"396", events.f35, "394", {actions.action_dr, actions.action_kp, }},
  {"396", events.f22, "396", nil},
  {"396", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"396", events.f25, "393", {actions.action_dr, actions.action_kp, }},
  {"395", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"395", events.f25, "393", {actions.action_dr, actions.action_kp, }},
  {"395", events.f22, "396", nil},
  {"395", events.f32, "223", {actions.action_ir, actions.action_kp, }},
  {"395", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"395", events.f19, "228", nil},
  {"395", events.f35, "394", {actions.action_dr, actions.action_kp, }},
  {"395", events.f6, "395", {actions.action_ir, actions.action_kp, }},
  {"395", events.f17, "331", nil},
  {"395", events.f28, "398", {actions.f16, actions.action_kp, }},
  {"395", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"395", events.f26, "330", {actions.action_ir, actions.action_kp, }},
  {"395", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"395", events.f13, "397", {actions.f16, actions.action_kp, }},
  {"395", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"395", events.f0, "222", nil},
  {"398", events.f33, "346", {actions.action_dr, actions.action_kp, }},
  {"398", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"398", events.f23, "345", {actions.f16, actions.action_kp, }},
  {"398", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"398", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"398", events.f17, "312", nil},
  {"398", events.f19, "356", {actions.action_dr, actions.action_kp, }},
  {"398", events.f22, "351", nil},
  {"398", events.f25, "230", nil},
  {"398", events.f35, "352", {actions.action_dr, actions.action_kp, }},
  {"398", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"398", events.f28, "225", {actions.action_ir, actions.action_kp, }},
  {"398", events.f6, "353", {actions.action_ir, actions.action_kp, }},
  {"398", events.f10, "224", nil},
  {"398", events.f13, "355", {actions.f16, actions.action_kp, }},
  {"398", events.f32, "354", {actions.f16, actions.action_kp, }},
  {"397", events.f6, "279", {actions.action_ir, actions.action_kp, }},
  {"397", events.f0, "282", {actions.f20, actions.f21, }},
  {"397", events.f35, "271", {actions.f20, actions.f21, }},
  {"397", events.f26, "254", {actions.f27, actions.f21, }},
  {"397", events.f13, "277", {actions.f24, actions.f21, }},
  {"397", events.f23, "272", {actions.f24, actions.f21, }},
  {"397", events.f33, "276", {actions.f20, actions.f21, }},
  {"397", events.f22, "281", nil},
  {"397", events.f19, "274", {actions.f20, actions.f21, }},
  {"397", events.f10, "246", {actions.f20, actions.f21, }},
  {"397", events.f32, "280", {actions.f24, actions.f21, }},
  {"397", events.f30, "278", {actions.f24, actions.f21, }},
  {"397", events.f17, "247", {actions.action_kr, actions.action_ip, }},
  {"397", events.f36, "252", {actions.f24, actions.f21, }},
  {"397", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"397", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"400", events.f32, "268", {actions.f27, actions.f21, }},
  {"400", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"400", events.f0, "222", nil},
  {"400", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"400", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"400", events.f22, "270", nil},
  {"400", events.f36, "252", {actions.f24, actions.f21, }},
  {"400", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"400", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"400", events.f13, "266", {actions.f24, actions.f21, }},
  {"400", events.f6, "262", {actions.action_ir, actions.action_kp, }},
  {"400", events.f10, "246", {actions.f20, actions.f21, }},
  {"400", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"400", events.f35, "261", {actions.f20, actions.f21, }},
  {"400", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"400", events.f26, "269", {actions.f27, actions.f21, }},
  {"399", events.f32, "268", {actions.f27, actions.f21, }},
  {"399", events.f13, "266", {actions.f24, actions.f21, }},
  {"399", events.f35, "261", {actions.f20, actions.f21, }},
  {"399", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"399", events.f36, "252", {actions.f24, actions.f21, }},
  {"399", events.f22, "270", nil},
  {"399", events.f10, "246", {actions.f20, actions.f21, }},
  {"399", events.f26, "269", {actions.f27, actions.f21, }},
  {"399", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"399", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"399", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"399", events.f6, "262", {actions.action_ir, actions.action_kp, }},
  {"399", events.f0, "222", nil},
  {"399", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"399", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"399", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"386", events.f13, "294", {actions.f24, actions.f21, }},
  {"386", events.f17, "291", {actions.action_kr, actions.action_ip, }},
  {"386", events.f25, "292", nil},
  {"386", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"386", events.f35, "289", {actions.f20, actions.f21, }},
  {"386", events.f23, "284", {actions.f24, actions.f21, }},
  {"386", events.f36, "290", {actions.f27, actions.f21, }},
  {"386", events.f26, "286", {actions.f27, actions.f21, }},
  {"386", events.f30, "278", {actions.f24, actions.f21, }},
  {"386", events.f28, "285", {actions.action_ir, actions.action_kp, }},
  {"386", events.f33, "293", {actions.f20, actions.f21, }},
  {"386", events.f22, "288", nil},
  {"386", events.f32, "280", {actions.f24, actions.f21, }},
  {"386", events.f6, "283", {actions.action_ir, actions.action_kp, }},
  {"386", events.f0, "282", {actions.f20, actions.f21, }},
  {"386", events.f19, "274", {actions.f20, actions.f21, }},
  {"385", events.f28, "225", {actions.action_ir, actions.action_kp, }},
  {"385", events.f25, "230", nil},
  {"385", events.f13, "355", {actions.f16, actions.action_kp, }},
  {"385", events.f22, "351", nil},
  {"385", events.f10, "224", nil},
  {"385", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"385", events.f35, "352", {actions.action_dr, actions.action_kp, }},
  {"385", events.f33, "346", {actions.action_dr, actions.action_kp, }},
  {"385", events.f17, "312", nil},
  {"385", events.f6, "353", {actions.action_ir, actions.action_kp, }},
  {"385", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"385", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"385", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"385", events.f19, "356", {actions.action_dr, actions.action_kp, }},
  {"385", events.f23, "345", {actions.f16, actions.action_kp, }},
  {"385", events.f32, "354", {actions.f16, actions.action_kp, }},
  {"388", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"388", events.f35, "394", {actions.action_dr, actions.action_kp, }},
  {"388", events.f19, "228", nil},
  {"388", events.f17, "331", nil},
  {"388", events.f6, "395", {actions.action_ir, actions.action_kp, }},
  {"388", events.f13, "397", {actions.f16, actions.action_kp, }},
  {"388", events.f22, "396", nil},
  {"388", events.f25, "393", {actions.action_dr, actions.action_kp, }},
  {"388", events.f28, "398", {actions.f16, actions.action_kp, }},
  {"388", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"388", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"388", events.f26, "330", {actions.action_ir, actions.action_kp, }},
  {"388", events.f32, "223", {actions.action_ir, actions.action_kp, }},
  {"388", events.f0, "222", nil},
  {"388", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"388", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"387", events.f19, "258", {actions.f20, actions.f21, }},
  {"387", events.f6, "340", {actions.action_ir, actions.action_kp, }},
  {"387", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"387", events.f28, "343", {actions.action_ir, actions.action_kp, }},
  {"387", events.f32, "250", {actions.f24, actions.f21, }},
  {"387", events.f23, "345", {actions.f16, actions.action_kp, }},
  {"387", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"387", events.f22, "341", nil},
  {"387", events.f13, "344", {actions.f24, actions.f21, }},
  {"387", events.f35, "339", {actions.f20, actions.f21, }},
  {"387", events.f36, "290", {actions.f27, actions.f21, }},
  {"387", events.f25, "342", nil},
  {"387", events.f17, "291", {actions.action_kr, actions.action_ip, }},
  {"387", events.f26, "286", {actions.f27, actions.f21, }},
  {"387", events.f33, "346", {actions.action_dr, actions.action_kp, }},
  {"387", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"390", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"390", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"390", events.f6, "353", {actions.action_ir, actions.action_kp, }},
  {"390", events.f13, "355", {actions.f16, actions.action_kp, }},
  {"390", events.f22, "351", nil},
  {"390", events.f32, "354", {actions.f16, actions.action_kp, }},
  {"390", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"390", events.f25, "230", nil},
  {"390", events.f17, "312", nil},
  {"390", events.f33, "346", {actions.action_dr, actions.action_kp, }},
  {"390", events.f35, "352", {actions.action_dr, actions.action_kp, }},
  {"390", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"390", events.f23, "345", {actions.f16, actions.action_kp, }},
  {"390", events.f10, "224", nil},
  {"390", events.f28, "225", {actions.action_ir, actions.action_kp, }},
  {"390", events.f19, "356", {actions.action_dr, actions.action_kp, }},
  {"389", events.f33, "293", {actions.f20, actions.f21, }},
  {"389", events.f26, "286", {actions.f27, actions.f21, }},
  {"389", events.f25, "292", nil},
  {"389", events.f30, "278", {actions.f24, actions.f21, }},
  {"389", events.f0, "282", {actions.f20, actions.f21, }},
  {"389", events.f32, "280", {actions.f24, actions.f21, }},
  {"389", events.f36, "290", {actions.f27, actions.f21, }},
  {"389", events.f23, "284", {actions.f24, actions.f21, }},
  {"389", events.f22, "288", nil},
  {"389", events.f13, "294", {actions.f24, actions.f21, }},
  {"389", events.f28, "285", {actions.action_ir, actions.action_kp, }},
  {"389", events.f17, "291", {actions.action_kr, actions.action_ip, }},
  {"389", events.f6, "283", {actions.action_ir, actions.action_kp, }},
  {"389", events.f35, "289", {actions.f20, actions.f21, }},
  {"389", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"389", events.f19, "274", {actions.f20, actions.f21, }},
  {"392", events.f6, "340", {actions.action_ir, actions.action_kp, }},
  {"392", events.f32, "250", {actions.f24, actions.f21, }},
  {"392", events.f33, "346", {actions.action_dr, actions.action_kp, }},
  {"392", events.f10, "287", {actions.action_kr, actions.action_ip, }},
  {"392", events.f26, "286", {actions.f27, actions.f21, }},
  {"392", events.f30, "256", {actions.f16, actions.action_kp, }},
  {"392", events.f23, "345", {actions.f16, actions.action_kp, }},
  {"392", events.f19, "258", {actions.f20, actions.f21, }},
  {"392", events.f28, "343", {actions.action_ir, actions.action_kp, }},
  {"392", events.f0, "249", {actions.action_dr, actions.action_kp, }},
  {"392", events.f22, "341", nil},
  {"392", events.f25, "342", nil},
  {"392", events.f35, "339", {actions.f20, actions.f21, }},
  {"392", events.f13, "344", {actions.f24, actions.f21, }},
  {"392", events.f17, "291", {actions.action_kr, actions.action_ip, }},
  {"392", events.f36, "290", {actions.f27, actions.f21, }},
  {"391", events.f6, "395", {actions.action_ir, actions.action_kp, }},
  {"391", events.f19, "228", nil},
  {"391", events.f25, "393", {actions.action_dr, actions.action_kp, }},
  {"391", events.f26, "330", {actions.action_ir, actions.action_kp, }},
  {"391", events.f22, "396", nil},
  {"391", events.f36, "319", {actions.f16, actions.action_kp, }},
  {"391", events.f28, "398", {actions.f16, actions.action_kp, }},
  {"391", events.f17, "331", nil},
  {"391", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"391", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"391", events.f0, "222", nil},
  {"391", events.f10, "328", {actions.action_dr, actions.action_kp, }},
  {"391", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"391", events.f32, "223", {actions.action_ir, actions.action_kp, }},
  {"391", events.f13, "397", {actions.f16, actions.action_kp, }},
  {"391", events.f35, "394", {actions.action_dr, actions.action_kp, }},
  {"223", events.f28, "275", {actions.f16, actions.action_kp, }},
  {"223", events.f35, "299", {actions.f20, actions.f21, }},
  {"223", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"223", events.f36, "252", {actions.f24, actions.f21, }},
  {"223", events.f10, "246", {actions.f20, actions.f21, }},
  {"223", events.f22, "298", nil},
  {"223", events.f30, "233", {actions.f27, actions.f21, }},
  {"223", events.f19, "302", {actions.action_kr, actions.action_ip, }},
  {"223", events.f25, "273", {actions.action_dr, actions.action_kp, }},
  {"223", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"223", events.f33, "301", {actions.f20, actions.f21, }},
  {"223", events.f32, "297", {actions.f27, actions.f21, }},
  {"223", events.f26, "269", {actions.f27, actions.f21, }},
  {"223", events.f13, "300", {actions.f24, actions.f21, }},
  {"223", events.f23, "295", {actions.f24, actions.f21, }},
  {"223", events.f6, "296", {actions.action_ir, actions.action_kp, }},
  {"224", events.f51, "400", {actions.f20, actions.f21, }},
  {"224", events.f42, "399", {actions.f24, actions.f21, }},
  {"224", events.f38, "220", {actions.action_ir, actions.action_kp, }},
  {"224", events.f47, "224", nil},
  {"221", events.f13, "243", {actions.f27, actions.f21, }},
  {"221", events.f35, "234", {actions.action_kr, actions.action_ip, }},
  {"221", events.f33, "242", {actions.action_kr, actions.action_ip, }},
  {"221", events.f19, "239", {actions.action_kr, actions.action_ip, }},
  {"221", events.f32, "244", {actions.f27, actions.f21, }},
  {"221", events.f0, "235", {actions.action_kr, actions.action_ip, }},
  {"221", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"221", events.f22, "238", nil},
  {"221", events.f25, "241", nil},
  {"221", events.f17, "217", nil},
  {"221", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"221", events.f23, "240", {actions.f27, actions.f21, }},
  {"221", events.f26, "221", {actions.action_ir, actions.action_kp, }},
  {"221", events.f30, "233", {actions.f27, actions.f21, }},
  {"221", events.f10, "224", nil},
  {"221", events.f6, "236", {actions.action_ir, actions.action_kp, }},
  {"222", events.f43, "372", {actions.f20, actions.f21, }},
  {"222", events.f53, "383", {actions.f27, actions.f21, }},
  {"222", events.f55, "371", {actions.action_dr, actions.action_kp, }},
  {"222", events.f39, "222", nil},
  {"222", events.f58, "367", {actions.f16, actions.action_kp, }},
  {"222", events.f48, "219", {actions.action_ir, actions.action_kp, }},
  {"222", events.f45, "384", {actions.action_kr, actions.action_ip, }},
  {"222", events.f60, "362", {actions.f24, actions.f21, }},
  {"219", events.f0, "222", nil},
  {"219", events.f6, "262", {actions.action_ir, actions.action_kp, }},
  {"219", events.f13, "266", {actions.f24, actions.f21, }},
  {"219", events.f36, "252", {actions.f24, actions.f21, }},
  {"219", events.f32, "268", {actions.f27, actions.f21, }},
  {"219", events.f25, "259", {actions.action_dr, actions.action_kp, }},
  {"219", events.f28, "257", {actions.f16, actions.action_kp, }},
  {"219", events.f26, "269", {actions.f27, actions.f21, }},
  {"219", events.f17, "265", {actions.action_kr, actions.action_ip, }},
  {"219", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"219", events.f19, "263", {actions.action_kr, actions.action_ip, }},
  {"219", events.f22, "270", nil},
  {"219", events.f35, "261", {actions.f20, actions.f21, }},
  {"219", events.f23, "264", {actions.f16, actions.action_kp, }},
  {"219", events.f33, "267", {actions.action_dr, actions.action_kp, }},
  {"219", events.f10, "246", {actions.f20, actions.f21, }},
  {"220", events.f6, "309", {actions.action_ir, actions.action_kp, }},
  {"220", events.f35, "314", {actions.f20, actions.f21, }},
  {"220", events.f32, "307", {actions.f24, actions.f21, }},
  {"220", events.f26, "311", {actions.action_ir, actions.action_kp, }},
  {"220", events.f13, "313", {actions.f24, actions.f21, }},
  {"220", events.f0, "282", {actions.f20, actions.f21, }},
  {"220", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"220", events.f17, "312", nil},
  {"220", events.f25, "241", nil},
  {"220", events.f33, "293", {actions.f20, actions.f21, }},
  {"220", events.f30, "278", {actions.f24, actions.f21, }},
  {"220", events.f10, "224", nil},
  {"220", events.f23, "284", {actions.f24, actions.f21, }},
  {"220", events.f19, "308", {actions.f20, actions.f21, }},
  {"220", events.f22, "310", nil},
  {"220", events.f28, "237", {actions.action_ir, actions.action_kp, }},
  {"217", events.f11, "224", nil},
  {"217", events.f1, "338", {actions.action_kr, actions.action_ip, }},
  {"217", events.f7, "221", {actions.action_ir, actions.action_kp, }},
  {"217", events.f34, "382", {actions.action_kr, actions.action_ip, }},
  {"217", events.f29, "220", {actions.action_ir, actions.action_kp, }},
  {"217", events.f31, "335", {actions.f27, actions.f21, }},
  {"217", events.f14, "381", {actions.f27, actions.f21, }},
  {"217", events.f18, "217", nil},
  {"218", events.f10, "224", nil},
  {"218", events.f17, "217", nil},
  {"218", events.f32, "223", {actions.action_ir, actions.action_kp, }},
  {"218", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"218", events.f13, "227", {actions.action_ir, actions.action_kp, }},
  {"218", events.f25, "230", nil},
  {"218", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"218", events.f28, "225", {actions.action_ir, actions.action_kp, }},
  {"218", events.f0, "222", nil},
  {"218", events.f26, "221", {actions.action_ir, actions.action_kp, }},
  {"218", events.f6, "231", {actions.action_ir, actions.action_kp, }},
  {"218", events.f33, "229", nil},
  {"218", events.f19, "228", nil},
  {"218", events.f35, "226", nil},
  {"218", events.f22, "218", nil},
  {"218", events.f23, "232", {actions.action_ir, actions.action_kp, }},
  {"216", events.f28, "225", {actions.action_ir, actions.action_kp, }},
  {"216", events.f10, "224", nil},
  {"216", events.f33, "229", nil},
  {"216", events.f19, "228", nil},
  {"216", events.f0, "222", nil},
  {"216", events.f22, "218", nil},
  {"216", events.f35, "226", nil},
  {"216", events.f30, "219", {actions.action_ir, actions.action_kp, }},
  {"216", events.f13, "227", {actions.action_ir, actions.action_kp, }},
  {"216", events.f25, "230", nil},
  {"216", events.f23, "232", {actions.action_ir, actions.action_kp, }},
  {"216", events.f6, "231", {actions.action_ir, actions.action_kp, }},
  {"216", events.f36, "220", {actions.action_ir, actions.action_kp, }},
  {"216", events.f26, "221", {actions.action_ir, actions.action_kp, }},
  {"216", events.f32, "223", {actions.action_ir, actions.action_kp, }},
  {"216", events.f17, "217", nil},
}

--final states
local is_accept =   {
['244']=true,
['243']=true,
['242']=true,
['248']=true,
['247']=true,
['246']=true,
['245']=true,
['252']=true,
['251']=true,
['250']=true,
['249']=true,
['256']=true,
['255']=true,
['254']=true,
['253']=true,
['227']=true,
['225']=true,
['231']=true,
['232']=true,
['235']=true,
['236']=true,
['233']=true,
['234']=true,
['239']=true,
['240']=true,
['237']=true,
['274']=true,
['273']=true,
['276']=true,
['275']=true,
['278']=true,
['277']=true,
['280']=true,
['279']=true,
['282']=true,
['284']=true,
['283']=true,
['286']=true,
['285']=true,
['287']=true,
['257']=true,
['258']=true,
['259']=true,
['261']=true,
['262']=true,
['263']=true,
['264']=true,
['265']=true,
['266']=true,
['267']=true,
['268']=true,
['269']=true,
['271']=true,
['272']=true,
['311']=true,
['309']=true,
['308']=true,
['307']=true,
['306']=true,
['305']=true,
['320']=true,
['319']=true,
['318']=true,
['317']=true,
['316']=true,
['315']=true,
['314']=true,
['313']=true,
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
['300']=true,
['297']=true,
['344']=true,
['343']=true,
['338']=true,
['337']=true,
['340']=true,
['339']=true,
['350']=true,
['349']=true,
['352']=true,
['346']=true,
['345']=true,
['348']=true,
['347']=true,
['326']=true,
['327']=true,
['328']=true,
['321']=true,
['322']=true,
['323']=true,
['333']=true,
['334']=true,
['335']=true,
['336']=true,
['330']=true,
['332']=true,
['379']=true,
['380']=true,
['377']=true,
['378']=true,
['383']=true,
['384']=true,
['381']=true,
['382']=true,
['371']=true,
['372']=true,
['369']=true,
['370']=true,
['376']=true,
['373']=true,
['374']=true,
['364']=true,
['363']=true,
['362']=true,
['361']=true,
['368']=true,
['367']=true,
['366']=true,
['365']=true,
['356']=true,
['355']=true,
['354']=true,
['353']=true,
['360']=true,
['359']=true,
['358']=true,
['357']=true,
['401']=true,
['402']=true,
['403']=true,
['404']=true,
['405']=true,
['406']=true,
['394']=true,
['393']=true,
['395']=true,
['398']=true,
['397']=true,
['400']=true,
['399']=true,
['386']=true,
['385']=true,
['388']=true,
['387']=true,
['390']=true,
['389']=true,
['392']=true,
['391']=true,
['223']=true,
['221']=true,
['219']=true,
['220']=true,
['216']=true,
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
	print ("NEW STATE:", current_state, "#TRANS:", #fsm[current_state],  "#RETS:", #ret_call, "ACCEPT:", is_accept[current_state], "FINAL:", #fsm[current_state]==0)
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

