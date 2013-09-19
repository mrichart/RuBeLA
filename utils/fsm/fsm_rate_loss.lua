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

local init_state="100"
--shares
local shared_0 = {}

--events
-----------------------------------------------
--          BEGIN COMPOSITE EVENTS           --
-----------------------------------------------
-- (¬hp∧¬ll)
events.f6 = function(e) 
	local left= events.f1(e)
	local right= events.f0(e)
	if left < right then return left else return right end
end
-- (hp∧ll)
events.f7 = function(e) 
	local left= events.event_hp(e)
	local right= events.event_ll(e)
	if left < right then return left else return right end
end
-- ¬hp
events.f1 = function(e) 
	local nonneg = events.event_hp(e)
	return 1-nonneg
end
-- ¬ll
events.f0 = function(e) 
	local nonneg = events.event_ll(e)
	return 1-nonneg
end
-- (¬hp∧ll)
events.f2 = function(e) 
	local left= events.f1(e)
	local right= events.event_ll(e)
	if left < right then return left else return right end
end
-- (hp∧¬ll)
events.f5 = function(e) 
	local left= events.event_hp(e)
	local right= events.f0(e)
	if left < right then return left else return right end
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
-- f3
actions.f3 = function(e)
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
-- f4
actions.f4 = function(e)
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
-----------------------------------------------
--           END COMPOSITE ACTIONS           --
-----------------------------------------------

--transitions
local fsm = FSM{
  {"79", events.f0, "88", nil},
  {"79", events.f0, "94", nil},
  {"79", events.event_ll, "91", {actions.action_ir, actions.action_kp, }},
  {"79", events.event_ll, "81", {actions.action_ir, actions.action_kp, }},
  {"98", events.f0, "88", nil},
  {"98", events.event_ll, "91", {actions.action_ir, actions.action_kp, }},
  {"80", events.f0, "88", nil},
  {"80", events.f1, "99", {actions.action_kr, actions.action_ip, }},
  {"80", events.event_hp, "96", nil},
  {"80", events.event_ll, "91", {actions.action_ir, actions.action_kp, }},
  {"97", events.f1, "97", nil},
  {"97", events.event_hp, "86", {actions.action_dr, actions.action_kp, }},
  {"77", events.f6, "79", {actions.action_kr, actions.action_ip, }},
  {"77", events.f5, "77", nil},
  {"77", events.f7, "80", {actions.action_ir, actions.action_kp, }},
  {"77", events.f2, "82", {actions.f3, actions.f4, }},
  {"100", events.f0, "88", nil},
  {"100", events.event_ll, "91", {actions.action_ir, actions.action_kp, }},
  {"99", events.f0, "88", nil},
  {"99", events.event_ll, "91", {actions.action_ir, actions.action_kp, }},
  {"78", events.event_hp, "83", {actions.action_dr, actions.action_kp, }},
  {"78", events.f1, "76", {actions.action_kr, actions.action_ip, }},
  {"75", events.f0, "78", nil},
  {"75", events.event_ll, "75", nil},
  {"76", events.f0, "88", nil},
  {"76", events.event_hp, "86", {actions.action_dr, actions.action_kp, }},
  {"76", events.event_ll, "91", {actions.action_ir, actions.action_kp, }},
  {"76", events.f1, "97", nil},
  {"88", events.f6, "84", {actions.action_kr, actions.action_ip, }},
  {"88", events.f7, "85", {actions.f8, actions.action_kp, }},
  {"88", events.f2, "87", {actions.f3, actions.f4, }},
  {"88", events.f5, "90", {actions.action_dr, actions.action_kp, }},
  {"87", events.f0, "88", nil},
  {"87", events.f1, "97", nil},
  {"87", events.event_ll, "91", {actions.action_ir, actions.action_kp, }},
  {"87", events.event_hp, "86", {actions.action_dr, actions.action_kp, }},
  {"86", events.f0, "88", nil},
  {"86", events.event_ll, "91", {actions.action_ir, actions.action_kp, }},
  {"85", events.f0, "88", nil},
  {"85", events.event_hp, "96", nil},
  {"85", events.f1, "99", {actions.action_kr, actions.action_ip, }},
  {"85", events.event_ll, "91", {actions.action_ir, actions.action_kp, }},
  {"84", events.f2, "95", {actions.action_ir, actions.action_kp, }},
  {"84", events.f0, "88", nil},
  {"84", events.f7, "98", {actions.f8, actions.action_kp, }},
  {"84", events.f6, "93", nil},
  {"84", events.f5, "92", {actions.action_dr, actions.action_kp, }},
  {"84", events.event_ll, "91", {actions.action_ir, actions.action_kp, }},
  {"83", events.f0, "88", nil},
  {"83", events.event_hp, "96", nil},
  {"83", events.event_ll, "91", {actions.action_ir, actions.action_kp, }},
  {"83", events.f1, "99", {actions.action_kr, actions.action_ip, }},
  {"82", events.f0, "88", nil},
  {"82", events.event_ll, "91", {actions.action_ir, actions.action_kp, }},
  {"81", events.f0, "88", nil},
  {"81", events.event_ll, "91", {actions.action_ir, actions.action_kp, }},
  {"96", events.f1, "99", {actions.action_kr, actions.action_ip, }},
  {"96", events.event_hp, "96", nil},
  {"95", events.f0, "88", nil},
  {"95", events.f1, "97", nil},
  {"95", events.event_ll, "91", {actions.action_ir, actions.action_kp, }},
  {"95", events.event_hp, "86", {actions.action_dr, actions.action_kp, }},
  {"94", events.f0, "94", nil},
  {"94", events.event_ll, "81", {actions.action_ir, actions.action_kp, }},
  {"93", events.f6, "93", nil},
  {"93", events.f5, "92", {actions.action_dr, actions.action_kp, }},
  {"93", events.f2, "95", {actions.action_ir, actions.action_kp, }},
  {"93", events.f7, "98", {actions.f8, actions.action_kp, }},
  {"92", events.f0, "88", nil},
  {"92", events.event_ll, "81", {actions.action_ir, actions.action_kp, }},
  {"92", events.f0, "94", nil},
  {"92", events.event_ll, "91", {actions.action_ir, actions.action_kp, }},
  {"91", events.f0, "88", nil},
  {"91", events.event_ll, "75", nil},
  {"91", events.f0, "78", nil},
  {"91", events.event_ll, "91", {actions.action_ir, actions.action_kp, }},
  {"90", events.f2, "82", {actions.f3, actions.f4, }},
  {"90", events.f0, "88", nil},
  {"90", events.f6, "79", {actions.action_kr, actions.action_ip, }},
  {"90", events.event_ll, "91", {actions.action_ir, actions.action_kp, }},
  {"90", events.f5, "77", nil},
  {"90", events.f7, "80", {actions.action_ir, actions.action_kp, }},
}

--final states
local is_accept =   {
['79']=true,
['98']=true,
['80']=true,
['100']=true,
['99']=true,
['76']=true,
['87']=true,
['86']=true,
['85']=true,
['84']=true,
['83']=true,
['82']=true,
['81']=true,
['95']=true,
['92']=true,
['91']=true,
['90']=true,
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

