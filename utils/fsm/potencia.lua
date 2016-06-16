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

-- potencia_manual.lua  --

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

	notifs.change_power = function(l,e)
  if l>0 then
    return {
    {target_host="127.0.0.1", target_service="NS3-PEP", notification_id=math.random(2^30), 
      command="increase_power", level=l, station=e.station},
    } 
  else
      return {
      {target_host="127.0.0.1", target_service="NS3-PEP", notification_id=math.random(2^30), 
      command="decrease_power", level=-l, station=e.station},
    }
  end
end
	
		
	
	
	-- function action_decreasePower(e)
actions.action_decreasePower = function(e)
	e = shared["incomming_event"]
	------------------------------------------------
	-- TODO: Complete this with your action code. --
	------------------------------------------------
local levels = getDomain('power')
  local retMax = -100
  local l
  for _,lp in ipairs(levels) do
    local ret = functions.action_dr(lp)
    if ret > retMax then
      retMax = ret
      l = lp
    end
  end
  return notifs.change_rate(l,e)
end
  -- Membership function for action_dr
functions.action_dr = function(l)
  return lineal_func(-1/6,0.5,l)
end


	-- function action_IncreasePower(e)
actions.action_IncreasePower = function(e)
	e = shared["incomming_event"]
	------------------------------------------------
	-- TODO: Complete this with your action code. --
	------------------------------------------------
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


	-- function event_TwoClientsNotConnected(e)
events.event_TwoClientsNotConnected = function(e) 
	shared["incomming_event"] = e
	-----------------------------------------------
	-- TODO: Complete this with your event code. --
	-----------------------------------------------
  if e.mib and e.value and string.match(e.mib, "TwoClientsNotConnected", 1) then
   
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


	-- function event_TwoClientsConnected(e)
events.event_TwoClientsConnected = function(e) 
	shared["incomming_event"] = e
	-----------------------------------------------
	-- TODO: Complete this with your event code. --
	-----------------------------------------------

-- function event_lp(e)
  if e.mib and e.value and string.match(e.mib, "TwoClientsConnected", 1) then
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

-------------------------------

-- End of functions        ----

-------------------------------

local init_state="30"
--shares
local shared_0 = {}

--events
-----------------------------------------------
--          BEGIN COMPOSITE EVENTS           --
-----------------------------------------------
-----------------------------------------------
--           END COMPOSITE EVENTS            --
-----------------------------------------------

--actions
-----------------------------------------------
--          BEGIN COMPOSITE ACTIONS          --
-----------------------------------------------
-----------------------------------------------
--           END COMPOSITE ACTIONS           --
-----------------------------------------------

--transitions
local fsm = FSM{
  {"28", events.event_TwoClientsNotConnected, "29", {actions.action_IncreasePower, }},
  {"28", events.event_TwoClientsConnected, "28", {actions.action_decreasePower, }},
  {"30", events.event_TwoClientsNotConnected, "29", {actions.action_IncreasePower, }},
  {"30", events.event_TwoClientsConnected, "28", {actions.action_decreasePower, }},
  {"29", events.event_TwoClientsNotConnected, "29", {actions.action_IncreasePower, }},
  {"29", events.event_TwoClientsConnected, "28", {actions.action_decreasePower, }},
}

--final states
local is_accept =   {
['28']=true,
['30']=true,
['29']=true,
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

