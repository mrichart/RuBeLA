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

-- out_test_pdp_aux_manual.lua  --

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

local init_state="124"
--shares

--events
-----------------------------------------------
--          BEGIN COMPOSITE EVENTS           --
-----------------------------------------------
-- (hp∧ll)
events.f6 = function(e) 
	local left= events.event_hp(e)
	local right= events.event_ll(e)
	if left < right then return left else return right end
end
-- (hp∧¬ll)
events.f7 = function(e) 
	local left= events.event_hp(e)
	local right= events.f2(e)
	if left < right then return left else return right end
end
-- ¬hp
events.f1 = function(e) 
	local nonneg = events.event_hp(e)
	return 1-nonneg
end
-- (¬hp∧¬ll)
events.f0 = function(e) 
	local left= events.f1(e)
	local right= events.f2(e)
	if left < right then return left else return right end
end
-- (¬hp∧ll)
events.f3 = function(e) 
	local left= events.f1(e)
	local right= events.event_ll(e)
	if left < right then return left else return right end
end
-- ¬ll
events.f2 = function(e) 
	local nonneg = events.event_ll(e)
	return 1-nonneg
end
-----------------------------------------------
--           END COMPOSITE EVENTS            --
-----------------------------------------------

--actions
-----------------------------------------------
--          BEGIN COMPOSITE ACTIONS          --
-----------------------------------------------
-- f8
actions.f8 = function(e)
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
-- f5
actions.f5 = function(e)
	local levels = getDomain('power')
	local retMax = -100
	local lp
	for _,l in ipairs(levels) do
		local ret = functions.fAnd(functions.action_ip(lp), functions.action_kp(lp))
		if ret > retMax then
			retMax = ret
			l = lr
		end
	end
	return notifs.change_power(l,e)
end
-- f4
actions.f4 = function(e)
	local levels = getDomain('rate')
	local retMax = -100
	local l
	for _,lr in ipairs(levels) do
		local ret = functions.fAnd(functions.action_kr(lr), functions.action_ir(lr))
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
  {"106", events.event_ll, "106", {actions.action_ir, actions.action_kp, }},
  {"106", events.f2, "92", nil},
  {"106", events.event_ll, "95", nil},
  {"105", events.event_hp, "103", nil},
  {"105", events.f1, "104", nil},
  {"105", events.event_hp, "116", {actions.action_dr, actions.action_kp, }},
  {"105", events.f1, "117", {actions.action_kr, actions.action_ip, }},
  {"108", events.f2, "105", nil},
  {"108", events.event_ll, "108", nil},
  {"107", events.event_ll, "106", {actions.action_ir, actions.action_kp, }},
  {"107", events.f2, "92", nil},
  {"107", events.event_ll, "95", nil},
  {"110", events.event_ll, "106", {actions.action_ir, actions.action_kp, }},
  {"110", events.f2, "92", nil},
  {"110", events.event_ll, "95", nil},
  {"109", events.f0, "118", {actions.action_kr, actions.action_ip, }},
  {"109", events.f0, "98", nil},
  {"109", events.f7, "109", nil},
  {"109", events.f6, "119", {actions.action_ir, actions.action_kp, }},
  {"109", events.f3, "107", {actions.f4, actions.f5, }},
  {"109", events.f6, "97", nil},
  {"112", events.f2, "112", nil},
  {"112", events.event_ll, "123", {actions.action_ir, actions.action_kp, }},
  {"111", events.event_ll, "106", {actions.action_ir, actions.action_kp, }},
  {"111", events.f2, "92", nil},
  {"111", events.event_ll, "95", nil},
  {"98", events.f2, "112", nil},
  {"98", events.event_ll, "123", {actions.action_ir, actions.action_kp, }},
  {"97", events.event_hp, "102", nil},
  {"97", events.f1, "101", {actions.action_kr, actions.action_ip, }},
  {"100", events.event_ll, "106", {actions.action_ir, actions.action_kp, }},
  {"100", events.f2, "92", nil},
  {"100", events.event_ll, "95", nil},
  {"99", events.event_ll, "106", {actions.action_ir, actions.action_kp, }},
  {"99", events.f2, "92", nil},
  {"99", events.event_ll, "95", nil},
  {"102", events.f1, "101", {actions.action_kr, actions.action_ip, }},
  {"102", events.event_hp, "102", nil},
  {"101", events.event_ll, "106", {actions.action_ir, actions.action_kp, }},
  {"101", events.f2, "92", nil},
  {"101", events.event_ll, "95", nil},
  {"104", events.event_hp, "100", {actions.action_dr, actions.action_kp, }},
  {"104", events.f1, "90", nil},
  {"103", events.f1, "101", {actions.action_kr, actions.action_ip, }},
  {"103", events.event_hp, "102", nil},
  {"121", events.event_ll, "106", {actions.action_ir, actions.action_kp, }},
  {"121", events.f2, "92", nil},
  {"121", events.event_ll, "95", nil},
  {"122", events.event_ll, "106", {actions.action_ir, actions.action_kp, }},
  {"122", events.f2, "92", nil},
  {"122", events.event_ll, "95", nil},
  {"123", events.event_ll, "106", {actions.action_ir, actions.action_kp, }},
  {"123", events.f2, "92", nil},
  {"123", events.event_ll, "95", nil},
  {"124", events.event_ll, "106", {actions.action_ir, actions.action_kp, }},
  {"124", events.f2, "92", nil},
  {"124", events.event_ll, "95", nil},
  {"113", events.event_ll, "123", {actions.action_ir, actions.action_kp, }},
  {"113", events.f2, "112", nil},
  {"114", events.f1, "90", nil},
  {"114", events.event_hp, "100", {actions.action_dr, actions.action_kp, }},
  {"115", events.f0, "115", nil},
  {"115", events.f3, "114", nil},
  {"115", events.f3, "121", {actions.action_ir, actions.action_kp, }},
  {"115", events.f7, "113", nil},
  {"115", events.f7, "122", {actions.action_dr, actions.action_kp, }},
  {"115", events.f6, "120", {actions.f8, actions.action_kp, }},
  {"116", events.event_ll, "106", {actions.action_ir, actions.action_kp, }},
  {"116", events.f2, "92", nil},
  {"116", events.event_ll, "95", nil},
  {"117", events.event_ll, "106", {actions.action_ir, actions.action_kp, }},
  {"117", events.f2, "92", nil},
  {"117", events.event_ll, "95", nil},
  {"118", events.event_ll, "106", {actions.action_ir, actions.action_kp, }},
  {"118", events.f2, "92", nil},
  {"118", events.event_ll, "95", nil},
  {"119", events.event_ll, "106", {actions.action_ir, actions.action_kp, }},
  {"119", events.f2, "92", nil},
  {"119", events.event_ll, "95", nil},
  {"120", events.event_ll, "106", {actions.action_ir, actions.action_kp, }},
  {"120", events.f2, "92", nil},
  {"120", events.event_ll, "95", nil},
  {"88", events.event_hp, "100", {actions.action_dr, actions.action_kp, }},
  {"88", events.f1, "90", nil},
  {"96", events.event_ll, "106", {actions.action_ir, actions.action_kp, }},
  {"96", events.f2, "92", nil},
  {"96", events.event_ll, "95", nil},
  {"95", events.event_ll, "108", nil},
  {"95", events.f2, "105", nil},
  {"94", events.f6, "120", {actions.f8, actions.action_kp, }},
  {"94", events.f0, "115", nil},
  {"94", events.f3, "114", nil},
  {"94", events.f7, "122", {actions.action_dr, actions.action_kp, }},
  {"94", events.f7, "113", nil},
  {"94", events.f3, "121", {actions.action_ir, actions.action_kp, }},
  {"92", events.f0, "94", nil},
  {"92", events.f7, "91", nil},
  {"92", events.f0, "111", {actions.action_kr, actions.action_ip, }},
  {"92", events.f7, "110", {actions.action_dr, actions.action_kp, }},
  {"92", events.f6, "89", nil},
  {"92", events.f6, "96", {actions.f8, actions.action_kp, }},
  {"92", events.f3, "99", {actions.f4, actions.f5, }},
  {"92", events.f3, "88", nil},
  {"91", events.f0, "118", {actions.action_kr, actions.action_ip, }},
  {"91", events.f0, "98", nil},
  {"91", events.f3, "107", {actions.f4, actions.f5, }},
  {"91", events.f6, "97", nil},
  {"91", events.f7, "109", nil},
  {"91", events.f6, "119", {actions.action_ir, actions.action_kp, }},
  {"90", events.f1, "90", nil},
  {"90", events.event_hp, "100", {actions.action_dr, actions.action_kp, }},
  {"89", events.f1, "101", {actions.action_kr, actions.action_ip, }},
  {"89", events.event_hp, "102", nil},
}

--final states
local is_accept =   {
['106']=true,
['107']=true,
['110']=true,
['111']=true,
['100']=true,
['99']=true,
['101']=true,
['121']=true,
['122']=true,
['123']=true,
['124']=true,
['116']=true,
['117']=true,
['118']=true,
['119']=true,
['120']=true,
['96']=true,
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

