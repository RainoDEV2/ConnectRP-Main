RLCore.Functions = {}

RLCore.Functions.ExecuteSql = function(wait, query, cb)
	local rtndata = {}
	local waiting = true
	exports['ghmattimysql']:execute(query, {}, function(data)
		if cb ~= nil and wait == false then
			cb(data)
		end
		rtndata = data
		waiting = false
	end)
	if wait then
		while waiting do
			Citizen.Wait(5)
		end
		if cb ~= nil and wait == true then
			cb(rtndata)
		end
	end
	return rtndata
end

RLCore.Functions.GetIdentifier = function(source, idtype)
	local idtype = idtype ~=nil and idtype or RLConfig.IdentifierType
	for _, identifier in pairs(GetPlayerIdentifiers(source)) do
		if string.find(identifier, idtype) then
			return identifier
		end
	end
	return nil
end

RLCore.Functions.GetSource = function(identifier)
	for src, player in pairs(RLCore.Players) do
		local idens = GetPlayerIdentifiers(src)
		for _, id in pairs(idens) do
			if identifier == id then
				return src
			end
		end
	end
	return 0
end

RLCore.Functions.GetPlayer = function(source)
	if type(source) == "number" then
		return RLCore.Players[source]
	else
		return RLCore.Players[RLCore.Functions.GetSource(source)]
	end
end

RLCore.Functions.GetPlayerByCitizenId = function(citizenid)
	for src, player in pairs(RLCore.Players) do
		local cid = citizenid
		if RLCore.Players[src].PlayerData.citizenid == cid then
			return RLCore.Players[src]
		end
	end
	return nil
end

RLCore.Functions.GetPlayerByPhone = function(number)
	for src, player in pairs(RLCore.Players) do
		local cid = citizenid
		if RLCore.Players[src].PlayerData.charinfo.phone == number then
			return RLCore.Players[src]
		end
	end
	return nil
end

RLCore.Functions.GetPlayers = function()
	local sources = {}
	for k, v in pairs(RLCore.Players) do
		table.insert(sources, k)
	end
	return sources
end

RLCore.Functions.CreateCallback = function(name, cb)
	RLCore.ServerCallbacks[name] = cb
end

RLCore.Functions.TriggerCallback = function(name, source, cb, ...)
	if RLCore.ServerCallbacks[name] ~= nil then
		RLCore.ServerCallbacks[name](source, cb, ...)
	end
end

RLCore.Functions.CreateUseableItem = function(item, cb)
	RLCore.UseableItems[item] = cb
end

RLCore.Functions.CanUseItem = function(item)
	return RLCore.UseableItems[item] ~= nil
end

RLCore.Functions.UseItem = function(source, item)
	RLCore.UseableItems[item.name](source, item)
end


RLCore.Functions.Kick = function(source, reason, setKickReason, deferrals)
	local src = source

	if (reason == nil) then
		reason = "You kicked out of the server."
	end

	if(setKickReason ~=nil) then
		setKickReason(reason)
	end
	Citizen.CreateThread(function()
		if(deferrals ~= nil)then
			deferrals.update(reason)
			Citizen.Wait(2500)
		end
		if src ~= nil then
			DropPlayer(src, reason)
		end
		local i = 0
		while (i <= 4) do
			i = i + 1
			while true do
				if src ~= nil then
					if(GetPlayerPing(src) >= 0) then
						break
					end
					Citizen.Wait(100)
					Citizen.CreateThread(function() 
						DropPlayer(src, reason)
					end)
				end
			end
			Citizen.Wait(5000)
		end
	end)
end

RLCore.Functions.IsWhitelisted = function(source)
	local rtn = nil
	local discord = nil
	local role = "783793138128650304"
	local identifiers = GetPlayerIdentifiers(source)

	for k,v in pairs(identifiers) do
		if string.find(v, "discord:") then
			discord = v
		end
	end

	if discord then
		PerformHttpRequest("https://discordapp.com/api/guilds/632994117986549760/members/"..string.sub(discord, 9), function(err, text, headers)
			if err == 200 then
				local data = json.decode(text)
				print(json.encode(data['roles']))
				for k,v in pairs(data['roles']) do
					if v == role then
						rtn = true
					end
				end

				if rtn == nil then
					rtn = false
				end
			else
				rtn = false
			end
		end, "GET", "", {["Content-type"] = "application/json", ["Authorization"] = "Bot NzMxMDM5NDEzNTA0ODM1NjQ3.XwgPgg.O144uVibwvoyQWTRljF6JXK3rPM"})
	else
		rtn = false
	end

	while rtn == nil do
		Wait(1)
	end

	return rtn
end

RLCore.Functions.AddPermission = function(source, permission)
	local Player = RLCore.Functions.GetPlayer(source)
	if Player ~= nil then 
		RLCore.Config.Server.PermissionList[GetPlayerIdentifiers(source)[1]] = {
			steam = GetPlayerIdentifiers(source)[1],
			license = GetPlayerIdentifiers(source)[2],
			permission = permission:lower(),
		}
		RLCore.Functions.ExecuteSql(true, "DELETE FROM `permissions` WHERE `steam` = '"..GetPlayerIdentifiers(source)[1].."'")
		RLCore.Functions.ExecuteSql(true, "INSERT INTO `permissions` (`name`, `steam`, `license`, `permission`) VALUES ('"..GetPlayerName(source).."', '"..GetPlayerIdentifiers(source)[1].."', '"..GetPlayerIdentifiers(source)[2].."', '"..permission:lower().."')")
		Player.Functions.UpdatePlayerData()
		TriggerClientEvent('RLCore:Client:OnPermissionUpdate', source, permission)
	end
end

RLCore.Functions.RemovePermission = function(source)
	local Player = RLCore.Functions.GetPlayer(source)
	if Player ~= nil then 
		RLCore.Config.Server.PermissionList[GetPlayerIdentifiers(source)[1]] = nil	
		RLCore.Functions.ExecuteSql(true, "DELETE FROM `permissions` WHERE `steam` = '"..GetPlayerIdentifiers(source)[1].."'")
		Player.Functions.UpdatePlayerData()
	end
end

RLCore.Functions.HasPermission = function(source, permission)
	local retval = false
	local steamid = GetPlayerIdentifiers(source)[1]
	local licenseid = GetPlayerIdentifiers(source)[2]
	local permission = tostring(permission:lower())
	if permission == "user" then
		retval = true
	else
		if RLCore.Config.Server.PermissionList[steamid] ~= nil then 
			if RLCore.Config.Server.PermissionList[steamid].steam == steamid and RLCore.Config.Server.PermissionList[steamid].license == licenseid then
				if RLCore.Config.Server.PermissionList[steamid].permission == permission or RLCore.Config.Server.PermissionList[steamid].permission == "god" then
					retval = true
				end
			end
		end
	end
	return retval
end

RLCore.Functions.GetPermission = function(source)
	local retval = "user"
	Player = RLCore.Functions.GetPlayer(source)
	local steamid = GetPlayerIdentifiers(source)[1]
	local licenseid = GetPlayerIdentifiers(source)[2]
	if Player ~= nil then
		if RLCore.Config.Server.PermissionList[Player.PlayerData.steam] ~= nil then 
			if RLCore.Config.Server.PermissionList[Player.PlayerData.steam].steam == steamid and RLCore.Config.Server.PermissionList[Player.PlayerData.steam].license == licenseid then
				retval = RLCore.Config.Server.PermissionList[Player.PlayerData.steam].permission
			end
		end
	end
	return retval
end

RLCore.Functions.IsOptin = function(source)
	local retval = false
	local steamid = GetPlayerIdentifiers(source)[1]
	if RLCore.Functions.HasPermission(source, "admin") then
		retval = RLCore.Config.Server.PermissionList[steamid].optin
	end
	return retval
end

RLCore.Functions.ToggleOptin = function(source)
	local steamid = GetPlayerIdentifiers(source)[1]
	if RLCore.Functions.HasPermission(source, "admin") then
		RLCore.Config.Server.PermissionList[steamid].optin = not RLCore.Config.Server.PermissionList[steamid].optin
	end
end

RLCore.Functions.IsPlayerBanned = function (source)
	local retval = false
	local message = ""
	RLCore.Functions.ExecuteSql(true, "SELECT * FROM `bans` WHERE `steam` = '"..GetPlayerIdentifiers(source)[1].."' OR `license` = '"..GetPlayerIdentifiers(source)[2].."' OR `ip` = '"..GetPlayerIdentifiers(source)[3].."'", function(result)
		if result[1] ~= nil then 
			if os.time() < result[1].expire then
				retval = true
				local timeTable = os.date("*t", tonumber(result[1].expire))
				message = "You have been banned from the server:\n"..result[1].reason.."\nYour ban expires "..timeTable.day.. "/" .. timeTable.month .. "/" .. timeTable.year .. " " .. timeTable.hour.. ":" .. timeTable.min .. "\n"
			else
				RLCore.Functions.ExecuteSql(true, "DELETE FROM `bans` WHERE `id` = "..result[1].id)
			end
		end
	end)
	return retval, message
end

