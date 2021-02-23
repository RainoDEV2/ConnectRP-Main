-- RLCore Command Events
RegisterNetEvent('RLCore:Command:TeleportToPlayer')
AddEventHandler('RLCore:Command:TeleportToPlayer', function(othersource)
	local coords = RLCore.Functions.GetCoords(GetPlayerPed(GetPlayerFromServerId(othersource)))
	local entity = PlayerPedId()
	if IsPedInAnyVehicle(Entity, false) then
		entity = GetVehiclePedIsUsing(entity)
	end
	SetEntityCoords(entity, coords.x, coords.y, coords.z)
	SetEntityHeading(entity, coords.a)
end)

RegisterNetEvent('RLCore:Command:TeleportToCoords')
AddEventHandler('RLCore:Command:TeleportToCoords', function(x, y, z)
	local entity = PlayerPedId()
	if IsPedInAnyVehicle(entity, false) then
		entity = GetVehiclePedIsUsing(entity)
	end
	SetEntityCoords(entity, x, y, z)
end)

RegisterNetEvent('RLCore:Command:SpawnVehicle')
AddEventHandler('RLCore:Command:SpawnVehicle', function(model)
	RLCore.Functions.SpawnVehicle(model, function(vehicle)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
		TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle), vehicle)
	end)
end)

RegisterNetEvent('RLCore:Command:DeleteVehicle')
AddEventHandler('RLCore:Command:DeleteVehicle', function()
	local vehicle = RLCore.Functions.GetClosestVehicle()
	if IsPedInAnyVehicle(PlayerPedId()) then vehicle = GetVehiclePedIsIn(PlayerPedId(), false) else vehicle = RLCore.Functions.GetClosestVehicle() end
	-- TriggerServerEvent('RLCore:Command:CheckOwnedVehicle', GetVehicleNumberPlateText(vehicle))
	RLCore.Functions.DeleteVehicle(vehicle)
end)

RegisterNetEvent('RLCore:Command:Revive')
AddEventHandler('RLCore:Command:Revive', function()
	local coords = RLCore.Functions.GetCoords(PlayerPedId())
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z+0.2, coords.a, true, false)
	SetPlayerInvincible(PlayerPedId(), false)
	ClearPedBloodDamage(PlayerPedId())
end)

RegisterCommand("jobstats", function()
	RLCore.Functions.GetPlayerData(function(PlayerData)
		for k, v in pairs(PlayerData.job) do
			print('Key: ' .. k .. ' ||| Value: ' .. tostring(v))
			if k == 'grade' then
				print('     K: ' .. k .. ' ||| V: ' .. PlayerData.job.grade.name)
				print('     K: ' .. k .. ' ||| V: ' .. PlayerData.job.grade.level)
			end
		end
	end)
  end)
  
RegisterNetEvent('RLCore:Command:GoToMarker')
AddEventHandler('RLCore:Command:GoToMarker', function()
	Citizen.CreateThread(function()
		local entity = PlayerPedId()
		if IsPedInAnyVehicle(entity, false) then
			entity = GetVehiclePedIsUsing(entity)
		end
		local success = false
		local blipFound = false
		local blipIterator = GetBlipInfoIdIterator()
		local blip = GetFirstBlipInfoId(8)

		while DoesBlipExist(blip) do
			if GetBlipInfoIdType(blip) == 4 then
				cx, cy, cz = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ReturnResultAnyway(), Citizen.ResultAsVector())) --GetBlipInfoIdCoord(blip)
				blipFound = true
				break
			end
			blip = GetNextBlipInfoId(blipIterator)
		end

		if blipFound then
			DoScreenFadeOut(250)
			while IsScreenFadedOut() do
				Citizen.Wait(250)
			end
			local groundFound = false
			local yaw = GetEntityHeading(entity)
			
			for i = 0, 1000, 1 do
				SetEntityCoordsNoOffset(entity, cx, cy, ToFloat(i), false, false, false)
				SetEntityRotation(entity, 0, 0, 0, 0 ,0)
				SetEntityHeading(entity, yaw)
				SetGameplayCamRelativeHeading(0)
				Citizen.Wait(0)
				--groundFound = true
				if GetGroundZFor_3dCoord(cx, cy, ToFloat(i), cz, false) then --GetGroundZFor3dCoord(cx, cy, i, 0, 0) GetGroundZFor_3dCoord(cx, cy, i)
					cz = ToFloat(i)
					groundFound = true
					break
				end
			end
			if not groundFound then
				cz = -300.0
			end
			success = true
		end

		if success then
			SetEntityCoordsNoOffset(entity, cx, cy, cz, false, false, true)
			SetGameplayCamRelativeHeading(0)
			if IsPedSittingInAnyVehicle(PlayerPedId()) then
				if GetPedInVehicleSeat(GetVehiclePedIsUsing(PlayerPedId()), -1) == PlayerPedId() then
					SetVehicleOnGroundProperly(GetVehiclePedIsUsing(PlayerPedId()))
				end
			end
			--HideLoadingPromt()
			DoScreenFadeIn(250)
		end
	end)
end)

-- Other stuff
RegisterNetEvent('RLCore:Player:SetPlayerData')
AddEventHandler('RLCore:Player:SetPlayerData', function(val)
	RLCore.PlayerData = val
end)

RegisterNetEvent('RLCore:Player:UpdatePlayerData')
AddEventHandler('RLCore:Player:UpdatePlayerData', function()
	local data = {}
	data.position = RLCore.Functions.GetCoords(PlayerPedId())
	TriggerServerEvent('RLCore:UpdatePlayer', data)
end)

RegisterNetEvent('RLCore:Player:UpdatePlayerPosition')
AddEventHandler('RLCore:Player:UpdatePlayerPosition', function()
	local position = RLCore.Functions.GetCoords(PlayerPedId())
	TriggerServerEvent('RLCore:UpdatePlayerPosition', position)
end)

RegisterNetEvent('RLCore:Client:LocalOutOfCharacter')
AddEventHandler('RLCore:Client:LocalOutOfCharacter', function(playerId, playerName, message)
	local sourcePos = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerId)), false)
    local pos = GetEntityCoords(PlayerPedId(), false)
    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, sourcePos.x, sourcePos.y, sourcePos.z, true) < 20.0) then
		TriggerEvent("chatMessage", "OOC " .. playerName, "normal", message)
    end
end)

RegisterNetEvent('RLCore:Notify')
AddEventHandler('RLCore:Notify', function(text, type, length)
	RLCore.Functions.Notify(text, type, length)
end)

RegisterNetEvent('RLCore:Client:TriggerCallback')
AddEventHandler('RLCore:Client:TriggerCallback', function(name, ...)
	if RLCore.ServerCallbacks[name] ~= nil then
		RLCore.ServerCallbacks[name](...)
		RLCore.ServerCallbacks[name] = nil
	end
end)

RegisterNetEvent("RLCore:Client:UseItem")
AddEventHandler('RLCore:Client:UseItem', function(item)
	TriggerServerEvent("RLCore:Server:UseItem", item)
end)

RegisterNetEvent('drp-framework:setArmour')
AddEventHandler('drp-framework:setArmour', function(armour)
    Citizen.Wait(6000)  -- Give ESX time to load their stuff. Because some how ESX remove the armour when load the ped.
                        -- If there is a better way to do this, make an pull request with 'Tu eres una papa' (you are a potato) as a subject
    SetPedArmour(PlayerPedId(), tonumber(armour))
end)

RegisterNetEvent('RLCore:Client:OnPlayerLoaded')
AddEventHandler('RLCore:Client:OnPlayerLoaded', function()
	TriggerServerEvent("tc-armour:update")
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        TriggerServerEvent('drp-framework:updateArmour', GetPedArmour(PlayerPedId()))
        Citizen.Wait(1000)
    end
end)