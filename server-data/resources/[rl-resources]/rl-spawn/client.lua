RLCore = nil

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if RLCore == nil then
            TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

--CODE
local camZPlus1 = 1500
local camZPlus2 = 50
local pointCamCoords = 75
local pointCamCoords2 = 0
local cam1Time = 500
local cam2Time = 1000
local timer = 0

local choosingSpawn = false

RegisterNUICallback("exit", function(data)
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "ui",
        status = false
    })
    choosingSpawn = false
end)

RegisterNUICallback('chooseAppa', function(data)
    local appaYeet = data.appType

    SetDisplay(false)
    DoScreenFadeOut(250)
    Citizen.Wait(250)
    TriggerServerEvent("apartments:server:CreateApartment", appaYeet, Apartments.Locations[appaYeet].label)
    FreezeEntityPosition(GetPlayerPed(-1), false)
    SetEntityVisible(GetPlayerPed(-1), true)
    TriggerServerEvent('RLCore:Server:OnPlayerLoaded')
    TriggerEvent('RLCore:Client:OnPlayerLoaded')
    DoScreenFadeOut(500)
        Citizen.Wait(2000)
        StopPlayerSwitch()
        DoScreenFadeIn(500)
end)

RegisterNUICallback('spawnplayer', function(data)
    local location = tostring(data.spawnloc)
    local type = tostring(data.typeLoc)
    local ped = GetPlayerPed(-1)
    local PlayerData = RLCore.Functions.GetPlayerData()
    local insideMeta = PlayerData.metadata["inside"]

    if type == "current" then
        TriggerEvent("debug", 'Spawn: Last Location', 'success')

        SetDisplay(false)
        Citizen.Wait(250)
        RLCore.Functions.GetPlayerData(function(PlayerData)
            SetEntityCoords(GetPlayerPed(-1), PlayerData.position.x, PlayerData.position.y, PlayerData.position.z)
            SetEntityHeading(GetPlayerPed(-1), PlayerData.position.a)
            FreezeEntityPosition(GetPlayerPed(-1), false)
        end)
        if insideMeta.house ~= nil then
            local houseId = insideMeta.house
            TriggerEvent('rl-houses:client:LastLocationHouse', houseId)
        elseif insideMeta.apartment.apartmentType ~= nil or insideMeta.apartment.apartmentId ~= nil then
            local apartmentType = insideMeta.apartment.apartmentType
            local apartmentId = insideMeta.apartment.apartmentId
            TriggerEvent('rl-apartments:client:LastLocationHouse', apartmentType, apartmentId)
        end
        FreezeEntityPosition(ped, false)
        SetEntityVisible(GetPlayerPed(-1), true)
        TriggerServerEvent('RLCore:Server:OnPlayerLoaded')
        TriggerEvent('RLCore:Client:OnPlayerLoaded')
        DoScreenFadeOut(500)
        Citizen.Wait(2000)
        TriggerEvent("rl-hud-player:client:SpawnedIn", true)
        StopPlayerSwitch()
        DoScreenFadeIn(4500)
        SwitchIN()
    elseif type == "house" then
        TriggerEvent("debug", 'Spawn: Owned House', 'success')

        SetDisplay(false)
        Citizen.Wait(250)
        TriggerEvent('rl-houses:client:enterOwnedHouse', location)
        TriggerServerEvent('rl-houses:server:SetInsideMeta', 0, false)
        TriggerServerEvent('rl-apartments:server:SetInsideMeta', 0, 0, false)
        FreezeEntityPosition(ped, false)
        TriggerServerEvent('RLCore:Server:OnPlayerLoaded')
        TriggerEvent('RLCore:Client:OnPlayerLoaded')
        SetEntityVisible(GetPlayerPed(-1), true)
        DoScreenFadeOut(500)
        Citizen.Wait(2000)
        TriggerEvent("rl-hud-player:client:SpawnedIn", true)
        StopPlayerSwitch()
        DoScreenFadeIn(4500)
        SwitchIN()
    elseif type == "normal" then
        TriggerEvent("debug", 'Spawn: ' .. Config.Spawns[location].label, 'success')

        local pos = Config.Spawns[location].coords
        SetDisplay(false)
        Citizen.Wait(250)
        SetEntityCoords(ped, pos.x, pos.y, pos.z)
        TriggerServerEvent('rl-houses:server:SetInsideMeta', 0, false)
        TriggerServerEvent('rl-apartments:server:SetInsideMeta', 0, 0, false)
        Citizen.Wait(250)
        SetEntityCoords(ped, pos.x, pos.y, pos.z)
        SetEntityHeading(ped, pos.h)
        FreezeEntityPosition(ped, false)
        SetEntityVisible(GetPlayerPed(-1), true)
        TriggerServerEvent('RLCore:Server:OnPlayerLoaded')
        TriggerEvent('RLCore:Client:OnPlayerLoaded')
        DoScreenFadeOut(500)
        Citizen.Wait(2000)
        TriggerEvent("rl-hud-player:client:SpawnedIn", true)
        StopPlayerSwitch()
        DoScreenFadeIn(4500)
        SwitchIN()
    end
end)

function SetDisplay(bool)
    choosingSpawn = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool
    })
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if choosingSpawn then
            DisableAllControlActions(0)
        else
            Citizen.Wait(1000)
        end
    end
end)

RegisterNetEvent('rl-houses:client:setHouseConfig')
AddEventHandler('rl-houses:client:setHouseConfig', function(houseConfig)
    Config.Houses = houseConfig
end)

RegisterNetEvent('rl-spawn:client:setupSpawns')
AddEventHandler('rl-spawn:client:setupSpawns', function(cData, new, apps)
    if not new then
        RLCore.Functions.TriggerCallback('rl-spawn:server:isJailed', function(lmfao, tt)
            print(lmfao)
            print(tt)
            print('+++++++++++++++++++++++++++++++++++++++++++')
            if lmfao == false then  
                RLCore.Functions.TriggerCallback('rl-spawn:server:getOwnedHouses', function(houses)
                    local myHouses = {}
                    if houses ~= nil then
                        for i = 1, (#houses), 1 do
                            table.insert(myHouses, {
                                house = houses[i].house,
                                label = Config.Houses[houses[i].house].adress,
                            })
                        end
                    end

                    Citizen.Wait(250)
                    SendNUIMessage({
                        action = "setupLocations",
                        locations = Config.Spawns,
                        houses = myHouses,
                    })
                end, cData.citizenid)
            else
                SetDisplay(false)
                Citizen.Wait(250)
                SetEntityCoords(PlayerPedId(), 1769.14, 257709, 45.72)
                TriggerServerEvent('rl-houses:server:SetInsideMeta', 0, false)
                TriggerServerEvent('rl-apartments:server:SetInsideMeta', 0, 0, false)
                Citizen.Wait(250)
                SetEntityCoords(PlayerPedId(), 1769.14, 257709, 45.72)
                SetEntityHeading(PlayerPedId(), 269.01)
                FreezeEntityPosition(PlayerPedId(), false)
                SetEntityVisible(GetPlayerPed(-1), true)
                TriggerServerEvent('RLCore:Server:OnPlayerLoaded')
                TriggerEvent('RLCore:Client:OnPlayerLoaded')
                DoScreenFadeOut(500)
                Citizen.Wait(2000)
                StopPlayerSwitch()
                DoScreenFadeIn(4500)
                SwitchIN()
                TriggerEvent('beginJail', tt)
            end
        end, cData.citizenid)
    elseif new then
        SendNUIMessage({
            action = "setupAppartements",
            locations = apps,
        })
    end

    TriggerEvent("debug", 'Spawn: Setup', 'success')
end)


-- Gta V Switch
local cloudOpacity = 0.01
local muteSound = true

function SwitchIN()
    --[[ local timer = GetGameTimer()
    while true do
        ClearScreen()
        Citizen.Wait(0)
        if GetGameTimer() - timer > 5000 then
            SwitchInPlayer(PlayerPedId())
            ClearScreen()
            while GetPlayerSwitchState() ~= 12 do
                Citizen.Wait(0)
                ClearScreen()
            end
            
            break
        end
    end ]]

    TriggerServerEvent('mumble:infinity:server:unmutePlayer')
    TriggerEvent('rl-weathersync:client:EnableSync')
	SetEntityHealth(PlayerPedId(), 200.0)
end

function ToggleSound(state)
    if state then
        StartAudioScene("MP_LEADERBOARD_SCENE");
    else
        StopAudioScene("MP_LEADERBOARD_SCENE");
    end
end

function ClearScreen()
    SetCloudHatOpacity(cloudOpacity)
    HideHudAndRadarThisFrame()
    SetDrawOrigin(0.0, 0.0, 0.0, 0)
end

RegisterNetEvent('rl-spawn:client:openUI')
AddEventHandler('rl-spawn:client:openUI', function(value)
    SetEntityVisible(GetPlayerPed(-1), false)
    ToggleSound(muteSound)
    if not IsPlayerSwitchInProgress() then
        CreateThread(function()
            Wait(250)
            DoScreenFadeIn(250)
        end)
        SwitchOutPlayer(PlayerPedId(), 1, 1)
    end
    while GetPlayerSwitchState() ~= 5 do
        Citizen.Wait(0)
        ClearScreen()
    end
    ClearScreen()
    Citizen.Wait(0)
    
    ToggleSound(false)
    SetDisplay(value)

    TriggerEvent("debug", 'Spawn: Open UI', 'success')
end)