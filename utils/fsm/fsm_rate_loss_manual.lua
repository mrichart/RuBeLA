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

