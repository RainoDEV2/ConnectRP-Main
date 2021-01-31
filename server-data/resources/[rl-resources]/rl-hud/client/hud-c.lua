local oxygenTank = 25.0
local oxyOn = false
local attachedProp = 0
local attachedProp2 = 0
local lownotify = 0
local toghud = false
local mumbleInfo = 2
local svrId = GetPlayerServerId(PlayerId())
local zoomLevels = { 900, 1000, 1100, 1200, 1300, 1400 }
local currZoom = 1

local speed = 0.0
local seatbeltOn = false
local cruiseOn = false
local bleedingPercentage = 0
local hunger = 100
local thirst = 100
Fuel = 0
stress = 0

RegisterNetEvent("rl-hud-player:client:SpawnedIn")
AddEventHandler("rl-hud-player:client:SpawnedIn", function(bool) -- Handles setting hud once you have spawned in, instead of always 
    toghud = bool
end)

RegisterCommand('hud', function()
	if toghud then 
		TriggerEvent('hud:toggleui', false)
	else 
		TriggerEvent('hud:toggleui', true)
	end 
end)

RegisterNetEvent('hud:toggleui')
AddEventHandler('hud:toggleui', function(show)
    toghud = show
end)

RegisterNetEvent('mumble:updateMumbleInfo')
AddEventHandler('mumble:updateMumbleInfo', function(mode)
	mumbleInfo = mode
end)

RegisterNetEvent("hud:client:UpdateNeeds")
AddEventHandler("hud:client:UpdateNeeds", function(newHunger, newThirst)
    hunger = newHunger
    thirst = newThirst
end)

--General UI Updates
Citizen.CreateThread(function()
    -- Hide North Blip (Only need to call on resource start)
	local northBlip = GetNorthRadarBlip()
    SetBlipAlpha(northBlip, 0)

    Citizen.Wait(0)
    while true do
        local player = PlayerPedId()
        local health = (GetEntityHealth(player) - 100)
        local armor = GetPedArmour(player)
		local oxy = oxygenTank
        local talking = false
        local iTalking = exports['tokovoip_script']:getPlayerDataS(GetPlayerServerId(PlayerId()), 'radio:talking') ~= nil and exports['tokovoip_script']:getPlayerDataS(GetPlayerServerId(PlayerId()), 'radio:talking') == true and 'radio' or exports['tokovoip_script']:getPlayerDataS(GetPlayerServerId(PlayerId()), "voip:talking") ~= nil and exports['tokovoip_script']:getPlayerDataS(GetPlayerServerId(PlayerId()), "voip:talking") == 1 and 'normal' or false
        
        SendNUIMessage({
            action = 'updateStatusHud',
            show = toghud,
            health = health,
            armour = armor,
			oxygen = oxy,
			--mumble = mumbleInfo,
			talking = iTalking,
		})
		
        Citizen.Wait(200)
    end
end)

--Food Thirst
Citizen.CreateThread(function()
	while true do
        SendNUIMessage({
            action = "updateStatusHud",
            show = toghud,
            hunger = hunger,
            thirst = thirst,
            stress = stress,
        })
        Citizen.Wait(5000)
    end
end)

-- Map Zoom Handler
Citizen.CreateThread(function()
    SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0) -- Level 0
    SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 1
    SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
    SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
    SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0) -- Level 4
    Wait(500)
    SetRadarZoom(zoomLevels[currZoom])
end)

RegisterCommand( "map_zoom_in", function()
    if currZoom == 1 then
        currZoom = #zoomLevels
    else
        currZoom = currZoom - 1
    end
    SetRadarZoom(zoomLevels[currZoom])
end)

RegisterCommand( "map_zoom_out", function()
    if currZoom == 1 then
        currZoom = #zoomLevels
    else
        currZoom = currZoom - 1
    end
    SetRadarZoom(zoomLevels[currZoom])
end)

RegisterKeyMapping( "map_zoom_in", "Zoom in your mini map", "keyboard", "")
RegisterKeyMapping( "map_zoom_out", "Zoom out your mini map", "keyboard", "")

--[[ Citizen.CreateThread(function()
    while true do
        local player = PlayerPedId()
        local health = (GetEntityHealth(player) - 100)
        print(health)
        Citizen.Wait(5000)
    end
end) ]]