-- Player joined
RegisterServerEvent("RLCore:PlayerJoined")
AddEventHandler('RLCore:PlayerJoined', function()
	local src = source
end)

AddEventHandler('playerDropped', function(reason) 
	local src = source
	print("^1[player-dropped]^7 "..GetPlayerName(src) .. '.')
	TriggerEvent("RL-log:server:CreateLog", "joinleave", "Dropped", "red", "**".. GetPlayerName(src) .. "** ("..GetPlayerIdentifiers(src)[1]..") left..")
	TriggerEvent("RL-log:server:sendLog", GetPlayerIdentifiers(src)[1], "joined", {})
	if reason ~= "Reconnecting" and src > 60000 then return false end
	if(src==nil or (RLCore.Players[src] == nil)) then return false end
	RLCore.Players[src].Functions.Save()
	RLCore.Players[src] = nil
	TriggerEvent("scoreboard:RemovePlayer", src)
end)

-- Checking everything before joining
AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
	deferrals.defer()
	local src = source
	deferrals.update("\nChecking name...")
	local name = GetPlayerName(src)
	if name == nil then 
		RLCore.Functions.Kick(src, 'Please do not use an empty steam name.', setKickReason, deferrals)
        CancelEvent()
        return false
	end

	if(string.match(name, "[*%%'=`\"]")) then
        RLCore.Functions.Kick(src, '\nYou have a sign in your name ('..string.match(name, "[*%%'=`\"]")..') what is not allowed.\nPlease remove it from your steam name.', setKickReason, deferrals)
        CancelEvent()
        return false
	end

	if (string.match(name, "drop") or string.match(name, "table") or string.match(name, "database")) then
        RLCore.Functions.Kick(src, '\nYou have a word in your named (drop/table/database) are not allowed.\nPlease change your steam name.', setKickReason, deferrals)
        CancelEvent()
        return false
	end
	deferrals.update("\nChecking identifiers...")
    local identifiers = GetPlayerIdentifiers(src)
	local steamid = identifiers[1]
	local license = identifiers[2]
    if (RLConfig.IdentifierType == "steam" and (steamid:sub(1,6) == "steam:") == false) then
        RLCore.Functions.Kick(src, '\nYou must have steam on to play.', setKickReason, deferrals)
        CancelEvent()
		return false
	elseif (RLConfig.IdentifierType == "license" and (steamid:sub(1,6) == "license:") == false) then
		RLCore.Functions.Kick(src, '\nNo social club license found.', setKickReason, deferrals)
        CancelEvent()
		return false
	end

--	deferrals.update("\nChecking whitelist...")
--	if not (RLCore.Functions.IsWhitelisted(src)) then
--		RLCore.Functions.Kick(src, RLConfig.Server.closed and RLConfig.Server.closedReason or 'You are not whitelisted.', setKickReason, deferrals)
--      CancelEvent()
--		return false
--	end

	deferrals.update("\nChecking ban status...")
	local isBanned, Reason = RLCore.Functions.IsPlayerBanned(src)
	if(isBanned) then
        RLCore.Functions.Kick(src, Reason, setKickReason, deferrals)
        CancelEvent()
        return false
	end

	deferrals.done()
end)

RegisterServerEvent("RLCore:server:CloseServer")
AddEventHandler('RLCore:server:CloseServer', function(reason)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    if RLCore.Functions.HasPermission(source, "admin") or RLCore.Functions.HasPermission(source, "god") then 
        local reason = reason ~= nil and reason or "No reason given..."
        RLCore.Config.Server.closed = true
        RLCore.Config.Server.closedReason = reason
        TriggerClientEvent("RLadmin:client:SetServerStatus", -1, true)
	else
		RLCore.Functions.Kick(src, "You have no permission for loser here..", nil, nil)
    end
end)

RegisterServerEvent("RLCore:server:OpenServer")
AddEventHandler('RLCore:server:OpenServer', function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    if RLCore.Functions.HasPermission(source, "admin") or RLCore.Functions.HasPermission(source, "god") then
        RLCore.Config.Server.closed = false
        TriggerClientEvent("RLadmin:client:SetServerStatus", -1, false)
    else
        RLCore.Functions.Kick(src, "You have no permission for loser here..", nil, nil)
    end
end)

RegisterServerEvent("RLCore:UpdatePlayer")
AddEventHandler('RLCore:UpdatePlayer', function(data)
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	
	if Player ~= nil then
		Player.PlayerData.position = data.position

		local newHunger = Player.PlayerData.metadata["hunger"] - 4.2
		local newThirst = Player.PlayerData.metadata["thirst"] - 3.8
		if newHunger <= 0 then newHunger = 0 end
		if newThirst <= 0 then newThirst = 0 end
		Player.Functions.SetMetaData("thirst", newThirst)
		Player.Functions.SetMetaData("hunger", newHunger)

		TriggerClientEvent("hud:client:UpdateNeeds", src, newHunger, newThirst)

		Player.Functions.Save()
	end
end)

RegisterServerEvent("RLCore:ReceivedSalary")
AddEventHandler('RLCore:ReceivedSalary', function()
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	
	if Player ~= nil then
		Player.Functions.AddMoney("bank", Player.PlayerData.job.payment, 'salary-update')
		TriggerClientEvent('RLCore:Notify', src, "You received your salary. [$"..Player.PlayerData.job.payment .. "]")
	end
end)

RegisterServerEvent("RLCore:UpdatePlayerPosition")
AddEventHandler("RLCore:UpdatePlayerPosition", function(position)
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	if Player ~= nil then
		Player.PlayerData.position = position
	end
end)

RegisterServerEvent("RLCore:Server:TriggerCallback")
AddEventHandler('RLCore:Server:TriggerCallback', function(name, ...)
	local src = source
	RLCore.Functions.TriggerCallback(name, src, function(...)
		TriggerClientEvent("RLCore:Client:TriggerCallback", src, name, ...)
	end, ...)
end)

RegisterServerEvent("RLCore:Server:UseItem")
AddEventHandler('RLCore:Server:UseItem', function(item)
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	if item ~= nil and item.amount > 0 then
		if RLCore.Functions.CanUseItem(item.name) then
			RLCore.Functions.UseItem(src, item)
		end
	end
end)

RegisterServerEvent("RLCore:Server:RemoveItem")
AddEventHandler('RLCore:Server:RemoveItem', function(itemName, amount, slot)
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	Player.Functions.RemoveItem(itemName, amount, slot)
end)

RegisterServerEvent("RLCore:Server:AddItem")
AddEventHandler('RLCore:Server:AddItem', function(itemName, amount, slot, info)
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	Player.Functions.AddItem(itemName, amount, slot, info)
end)

RegisterServerEvent('RLCore:Server:SetMetaData')
AddEventHandler('RLCore:Server:SetMetaData', function(meta, data)
    local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	if meta == "hunger" or meta == "thirst" then
		if data > 100 then
			data = 100
		end
	end
	if Player ~= nil then 
		Player.Functions.SetMetaData(meta, data)
	end
	TriggerClientEvent("hud:client:UpdateNeeds", src, Player.PlayerData.metadata["hunger"], Player.PlayerData.metadata["thirst"])
end)

AddEventHandler('chatMessage', function(source, n, message)
	if string.sub(message, 1, 1) == "/" then
		local args = RLCore.Shared.SplitStr(message, " ")
		local command = string.gsub(args[1]:lower(), "/", "")
		CancelEvent()
		if RLCore.Commands.List[command] ~= nil then
			local Player = RLCore.Functions.GetPlayer(tonumber(source))
			if Player ~= nil then
				TriggerClientEvent("debug", source, 'Commands: ' .. message, 'normal')
				table.remove(args, 1)
				if (RLCore.Functions.HasPermission(source, "god") or RLCore.Functions.HasPermission(source, RLCore.Commands.List[command].permission)) then
					if (RLCore.Commands.List[command].argsrequired and #RLCore.Commands.List[command].arguments ~= 0 and args[#RLCore.Commands.List[command].arguments] == nil) then
						TriggerClientEvent('chat:addMessage', source , {
							template = '<div class="chat-message server"><b>SYSTEM:</b> {0}</div>',
							args = { "All arguments must be completed!" }
						})
					else
						RLCore.Commands.List[command].callback(source, args)
					end
				else
					TriggerClientEvent('chat:addMessage', source , {
						template = '<div class="chat-message server"><b>SYSTEM:</b> {0}</div>',
						args = { "Access Denied" }
					})
				end
			end
		end
	end
end)

RegisterServerEvent('RLCore:CallCommand')
AddEventHandler('RLCore:CallCommand', function(command, args)
	if RLCore.Commands.List[command] ~= nil then
		local Player = RLCore.Functions.GetPlayer(tonumber(source))
		if Player ~= nil then
			if (RLCore.Functions.HasPermission(source, "god")) or (RLCore.Functions.HasPermission(source, RLCore.Commands.List[command].permission)) or (RLCore.Commands.List[command].permission == Player.PlayerData.job.name) then
				if (RLCore.Commands.List[command].argsrequired and #RLCore.Commands.List[command].arguments ~= 0 and args[#RLCore.Commands.List[command].arguments] == nil) then
					TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "All arguments must be completed!")
					local agus = ""
					for name, help in pairs(RLCore.Commands.List[command].arguments) do
						agus = agus .. " ["..help.name.."]"
					end
					TriggerClientEvent('chatMessage', source, "/"..command, false, agus)
				else
					RLCore.Commands.List[command].callback(source, args)
				end
			else
				TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "No access to this command!")
			end
		end
	end
end)

RegisterServerEvent("RLCore:AddCommand")
AddEventHandler('RLCore:AddCommand', function(name, help, arguments, argsrequired, callback, persmission)
	RLCore.Commands.Add(name, help, arguments, argsrequired, callback, persmission)
end)

RegisterServerEvent("RLCore:ToggleDuty")
AddEventHandler('RLCore:ToggleDuty', function()
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	if Player.PlayerData.job.onduty then
		Player.Functions.SetJobDuty(false)
		TriggerClientEvent('RLCore:Notify', src, "You went off duty!")
		TriggerClientEvent("debug", src, 'RLCore: You went off duty!', 'error')
	else
		Player.Functions.SetJobDuty(true)
		TriggerClientEvent('RLCore:Notify', src, "You went on duty!")
		TriggerClientEvent("debug", src, 'RLCore: You went on duty!', 'success')

	end
	TriggerClientEvent("RLCore:Client:SetDuty", src, Player.PlayerData.job.onduty)
end)

Citizen.CreateThread(function()
	RLCore.Functions.ExecuteSql(true, "SELECT * FROM `permissions`", function(result)
		if result[1] ~= nil then
			for k, v in pairs(result) do
				RLCore.Config.Server.PermissionList[v.steam] = {
					steam = v.steam,
					license = v.license,
					permission = v.permission,
					optin = true,
				}
			end
		end
	end)
end)

RLCore.Functions.CreateCallback('RLCore:HasItem', function(source, cb, itemName)
	local retval = false
	local Player = RLCore.Functions.GetPlayer(source)
	if Player ~= nil then 
		if Player.Functions.GetItemByName(itemName) ~= nil then
			retval = true
		end
	end
	
	cb(retval)
end)

RLCore.Functions.CreateCallback('RLCore:HasMoney', function(source, cb, moneyType, Count, Remove)
	local retval = false
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	if Player ~= nil then 
		if Player.Functions.HasMoney(moneyType, Count, Remove) == true then
			retval = true
		end
	end
	
	cb(retval)
end)

RegisterServerEvent('RLCore:Command:CheckOwnedVehicle')
AddEventHandler('RLCore:Command:CheckOwnedVehicle', function(VehiclePlate)
	if VehiclePlate ~= nil then
		RLCore.Functions.ExecuteSql(false, "SELECT * FROM `player_vehicles` WHERE `plate` = '"..VehiclePlate.."'", function(result)
			if result[1] ~= nil then
				RLCore.Functions.ExecuteSql(false, "UPDATE `player_vehicles` SET `state` = '1' WHERE `citizenid` = '"..result[1].citizenid.."'")
				TriggerEvent('RL-garages:server:RemoveVehicle', result[1].citizenid, VehiclePlate)
			end
		end)
	end
end)

local currentArmour = {}

--[[ Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(2500)
		print(json.encode(currentArmour))
	end
end)	
 ]]
RegisterNetEvent('drp-framework:updateArmour')
AddEventHandler('drp-framework:updateArmour', function(updateArmour)
	local src = source
	currentArmour[src] = updateArmour
end)

RegisterNetEvent('tc-armour:update')
AddEventHandler('tc-armour:update', function(playerId)
    local xPlayer = RLCore.Functions.GetPlayer(playerId)
    while not xPlayer do
        xPlayer = RLCore.Functions.GetPlayer(playerId)
        Wait(0)
	end
	
    RLCore.Functions.ExecuteSql(false, "SELECT `armour` FROM `players` WHERE `citizenid` = '"..xPlayer.PlayerData.citizenid.."'", function(result)
        if (data ~= nil) then
            TriggerClientEvent('drp-framework:setArmour', playerId, data)
		end
    end)
end)

RegisterServerEvent('drp-framework:loadArmour')
AddEventHandler('drp-framework:loadArmour', function()
	local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    while not xPlayer do
        xPlayer = RLCore.Functions.GetPlayer(src)
        Wait(0)
	end
	
    RLCore.Functions.ExecuteSql(false, "SELECT `armour` FROM `players` WHERE `citizenid` = '"..xPlayer.PlayerData.citizenid.."'", function(result)
        if (data ~= nil) then 
            TriggerClientEvent('drp-framework:setArmour', src, data)
		end
    end)
end)



AddEventHandler('playerDropped', function(playerId)
	local src = playerId
	local xPlayer = RLCore.Functions.GetPlayer(src)
	while not xPlayer do
        xPlayer = RLCore.Functions.GetPlayer(src)
        Wait(0) 
	end
	if currentArmour[src] > 0 then
		exports.ghmattimysql:execute("UPDATE players SET `armour` = @armour WHERE `citizenid` = @citizenid", {
			['@armour'] = currentArmour[src],
			['@citizenid'] = xPlayer.PlayerData.citizenid
		}, function ()
		end)
	end
end)

--[[ RegisterCommand("testa", function(source, args, raw)
    local src = source
	local xPlayer = RLCore.Functions.GetPlayer(src)
	while not xPlayer do
        xPlayer = RLCore.Functions.GetPlayer(src)
        Wait(0)
	end 
	if currentArmour[src] > 0 then
		exports.ghmattimysql:execute("UPDATE players SET `armour` = @armour WHERE `citizenid` = @citizenid", {
			['@armour'] = currentArmour[src],
			['@citizenid'] = xPlayer.PlayerData.citizenid
		}, function ()
		end)
	end
end) ]]