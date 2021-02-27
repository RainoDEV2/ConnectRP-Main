local eveh = {
	'NEON', 
	'RAIDEN',
	'CYCLONE',
	'SURGE',
	'DILETTANTE',
	'TEZERACT',
	'KHAMELION',
	'IMORGON',
	'VOLTIC',
	'VENTOSO',
	'AIRTUG',
	'CADDY',
	'MODELS'
}

local autop = false 
local idcoord = nil
local pedveh = nil

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if autop then
			if IsControlPressed(1, 72) then
				autop = false
				local input = 'stop'
				auto(input)
			end
		else
			Wait(1200)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if autop then
			local pedcoords = GetEntityCoords(GetPlayerPed(-1))
        	local distance = GetDistanceBetweenCoords(idcoord.x, idcoord.y, idcoord.z, pedcoords["x"], pedcoords["y"], pedcoords["z"], true)
        	if distance <= 35 then
        		SetVehicleBrake(pedveh, true)
        		Citizen.Wait(2500)
        		autop = false
				local input = 'stop'
				auto(input)
			end
		else
			Wait(1200)
		end
	end
end)

function auto(speed)
	local drivestyle  
	local pedspeed
	if speed == "1" then
		drivestyle = 786603
		pedspeed = tonumber(20.0)
	elseif speed == "2" then
		drivestyle = 786603
		pedspeed = tonumber(50.0)
	elseif speed == "3" then
		drivestyle = 786603
		pedspeed = tonumber(80.0)
	elseif speed == "4" then
		drivestyle = 2883621
		pedspeed = tonumber(150.0)
	elseif speed == "69" then
		drivestyle = 1076
		pedspeed = tonumber(100.0)
	end

	local player = GetPlayerPed(-1)
	local blipI = GetBlipInfoIdIterator(8)
	local blipInfo = GetFirstBlipInfoId(8, blipI)
	idcoord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, blipInfo, Citizen.ResultAsVector())
	print(idcoord)
	ClearPedTasks(player)
	pedveh = GetVehiclePedIsIn(player, false)
	if speed ~= 'stop' then
		autop = true
		RLCore.Functions.Notify("Autopilot Enabled. Press [S] to disable", "success")
		TaskVehicleDriveToCoord(player, pedveh, idcoord.x, idcoord.y, idcoord.z, pedspeed, 156, pedveh, drivestyle, 5.5, true)
	else
		RLCore.Functions.Notify("Autopilot Disabled", "error")
		ClearPedTasks(GetPlayerPed(-1))
	end
end

RegisterCommand("autopilot", function(source, args, rawCommand)
	local input = args[1]
	local player = GetPlayerPed(-1)
	local canStart = false

	if IsPedInAnyVehicle(player) then
		currveh = GetVehiclePedIsUsing(player)

		local model = GetEntityModel(currveh)
		local modelName = GetDisplayNameFromVehicleModel(model)

		for k,v in pairs(eveh) do 
			if modelName == v then
				canStart = true
			end
		end

		if canStart then
			canStart = false
			auto(input)
		else
			RLCore.Functions.Notify("This car does not have autopilot", "error")
		end					
	else
		RLCore.Functions.Notify("You are not in a vehicle", "error")
	end
end, false)