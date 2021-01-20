function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local currentGarage = 1
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if isLoggedIn and RLCore ~= nil then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            if PlayerJob.name == "doctor" or PlayerJob.name == "ambulance" then

                for k, v in pairs(Config.Locations["duty"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 5) then
                        if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                            if not onDuty then
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ - On Duty")
                            else
                                DrawText3D(v.x, v.y, v.z, "~r~E~w~ - Off Duty")
                            end
                            if IsControlJustReleased(0, Keys["E"]) then
                                onDuty = not onDuty
                                TriggerServerEvent("RLCore:ToggleDuty")
                                TriggerServerEvent("police:server:UpdateBlips")
                            end
                        elseif (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 4.5) then
                            DrawText3D(v.x, v.y, v.z, "Duty Docs")
                        end  
                    end
                end

                for k, v in pairs(Config.Locations["armory"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 4.5) then
                        if onDuty then
                            if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Safe")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    TriggerServerEvent("inventory:server:OpenInventory", "shop", "hospital", Config.Items)
                                end
                            elseif (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2.5) then
                                DrawText3D(v.x, v.y, v.z, "Safe")
                            end  
                        end
                    end
                end
        
                for k, v in pairs(Config.Locations["vehicle"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 4.5) then
                        DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                        if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Store the vehicle")
                            else
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Vehicles")
                            end
                            if IsControlJustReleased(0, Keys["E"]) then
                                if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                    RLCore.Functions.DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
                                else
                                    MenuGarage()
                                    currentGarage = k
                                    Menu.hidden = not Menu.hidden
                                end
                            end
                            Menu.renderGUI()
                        end
                    end
                end
        
                for k, v in pairs(Config.Locations["helicopter"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 7.5) then
                        if onDuty then
                            DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                            if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                                if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                    DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Store the helicopter")
                                else
                                    DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Spawn Helicopter")
                                end
                                if IsControlJustReleased(0, Keys["E"]) then
                                    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                        RLCore.Functions.DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
                                    else
                                        local coords = Config.Locations["helicopter"][k]
                                        RLCore.Functions.SpawnVehicle(Config.Helicopter, function(veh)
                                            SetVehicleLivery(veh, 1)
                                            SetVehicleNumberPlateText(veh, "LIFE"..tostring(math.random(1000, 9999)))
                                            SetEntityHeading(veh, coords.h)
                                            exports['rl-hud']:SetFuel(veh, 100)
                                            closeMenuFull()
                                            TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                                            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
                                            SetVehicleEngineOn(veh, true, true)
                                        end, coords, true)
                                    end
                                end
                            end  
                        end
                    end
                end
                
                for k, v in pairs(Config.Locations["boss"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 4.5) then
                        if onDuty and PlayerJob.isboss then
                            if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Boss Menu")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    TriggerServerEvent("bb-bossmenu:server:openMenu")
                                end
                            elseif (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2.5) then
                                DrawText3D(v.x, v.y, v.z, "Boss Menu")
                            end  
                        end
                    end
                end

            end

            local currentHospital = 1

            for k, v in pairs(Config.Locations["main"]) do
                if (GetDistanceBetweenCoords(pos,v.x,v.y,v.z, true) < 1.5) then
                    DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Take the elevator to the roof")
                    if IsControlJustReleased(0, Keys["E"]) then
                        DoScreenFadeOut(500)
                        while not IsScreenFadedOut() do
                            Citizen.Wait(10)
                        end

                        currentHospital = k

                        local coords = Config.Locations["roof"][currentHospital]
                        SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, 0, 0, 0, false)
                        SetEntityHeading(PlayerPedId(), coords.h)

                        Citizen.Wait(100)

                        DoScreenFadeIn(1000)
                    end
                end
            end

            for k, v in pairs(Config.Locations["roof"]) do
                if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                    DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Take the elevator down")
                    if IsControlJustReleased(0, Keys["E"]) then
                        DoScreenFadeOut(500)
                        while not IsScreenFadedOut() do
                            Citizen.Wait(10)
                        end

                        currentHospital = k

                        local coords = Config.Locations["main"][currentHospital]
                        SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, 0, 0, 0, false)
                        SetEntityHeading(PlayerPedId(), coords.h)

                        Citizen.Wait(100)

                        DoScreenFadeIn(1000)
                    end
                end
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if isStatusChecking then
            for k, v in pairs(statusChecks) do
                local x,y,z = table.unpack(GetPedBoneCoords(statusCheckPed, v.bone))
                DrawText3D(x, y, z, v.label)
            end
        end

        if isHealingPerson then
            if not IsEntityPlayingAnim(GetPlayerPed(-1), healAnimDict, healAnim, 3) then
                loadAnimDict(healAnimDict)	
                TaskPlayAnim(GetPlayerPed(-1), healAnimDict, healAnim, 3.0, 3.0, -1, 49, 0, 0, 0, 0)
            end
        end
    end
end)

RegisterNetEvent('hospital:client:SendAlert')
AddEventHandler('hospital:client:SendAlert', function(msg)
    PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
    TriggerEvent("chatMessage", "PAGER", "error", msg)
end)

RegisterNetEvent('hospital:client:AiCall')
AddEventHandler('hospital:client:AiCall', function()
    local PlayerPeds = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        table.insert(PlayerPeds, ped)
    end
    local player = GetPlayerPed(-1)
    local coords = GetEntityCoords(player)
    local closestPed, closestDistance = RLCore.Functions.GetClosestPed(coords, PlayerPeds)
    local gender = RLCore.Functions.GetPlayerData().gender
    if closestDistance < 50.0 and closestPed ~= 0 then
        MakeCall(closestPed, gender)
    end
end)

function MakeCall(ped, male)
    local callAnimDict = "cellphone@"
    local callAnim = "cellphone_call_listen_base"
    local rand = (math.random(6,9) / 100) + 0.3
    local rand2 = (math.random(6,9) / 100) + 0.3
    local coords = GetEntityCoords(GetPlayerPed(-1))
    local blipsettings = {
        x = coords.x,
        y = coords.y,
        z = coords.z,
        sprite = 280,
        color = 4,
        scale = 0.9,
        text = "Injured person"
    }

    if math.random(10) > 5 then
        rand = 0.0 - rand
    end

    if math.random(10) > 5 then
        rand2 = 0.0 - rand2
    end

    local moveto = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), rand, rand2, 0.0)

    TaskGoStraightToCoord(ped, moveto, 2.5, -1, 0.0, 0.0)
    SetPedKeepTask(ped, true) 

    local dist = GetDistanceBetweenCoords(moveto, GetEntityCoords(ped), false)

    while dist > 3.5 and isDead do
        TaskGoStraightToCoord(ped, moveto, 2.5, -1, 0.0, 0.0)
        dist = GetDistanceBetweenCoords(moveto, GetEntityCoords(ped), false)
        Citizen.Wait(100)
    end

    ClearPedTasksImmediately(ped)
    TaskLookAtEntity(ped, GetPlayerPed(-1), 5500.0, 2048, 3)
    TaskTurnPedToFaceEntity(ped, GetPlayerPed(-1), 5500)

    Citizen.Wait(3000)

    --TaskStartScenarioInPlace(ped,"WORLD_HUMAN_STAND_MOBILE", 0, 1)
    loadAnimDict(callAnimDict)
    TaskPlayAnim(ped, callAnimDict, callAnim, 1.0, 1.0, -1, 49, 0, 0, 0, 0)

    SetPedKeepTask(ped, true) 

    Citizen.Wait(5000)

    TriggerServerEvent("hospital:server:MakeDeadCall", blipsettings, male)

    SetEntityAsNoLongerNeeded(ped)
    ClearPedTasks(ped)
end

RegisterNetEvent('hospital:client:RevivePlayer')
AddEventHandler('hospital:client:RevivePlayer', function()
    RLCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerJob.name == "ambulance" or PlayerJob.name == "police" then
            local player, distance = RLCore.Functions.GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                isHealingPerson = true
                RLCore.Functions.Progressbar("hospital_revive", "Help person up..", 5000, false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = healAnimDict,
                    anim = healAnim,
                    flags = 16,
                }, {}, {}, function() -- Done
                    isHealingPerson = false
                    StopAnimTask(GetPlayerPed(-1), healAnimDict, "exit", 1.0)
                    RLCore.Functions.Notify("You helped the person!")
                    TriggerServerEvent("hospital:server:RevivePlayer", playerId)
                end, function() -- Cancel
                    isHealingPerson = false
                    StopAnimTask(GetPlayerPed(-1), healAnimDict, "exit", 1.0)
                    RLCore.Functions.Notify("Failed!", "error")
                end)
            end
        end
    end)
end)

RegisterNetEvent('hospital:client:CheckStatus')
AddEventHandler('hospital:client:CheckStatus', function()
    RLCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerJob.name == "doctor" or PlayerJob.name == "ambulance" or PlayerJob.name == "police" then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                statusCheckPed = GetPlayerPed(player)
            end
        end
    end)
end)

RegisterNetEvent('hospital:client:TreatWounds')
AddEventHandler('hospital:client:TreatWounds', function()
    RLCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.job.name == "doctor" or PlayerData.job.name == "ambulance" then
            local player, distance = RLCore.Functions.GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                isHealingPerson = true
                RLCore.Functions.Progressbar("hospital_heal", "Healing", 6000, false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = healAnimDict,
                    anim = healAnim,
                    flags = 16,
                }, {}, {}, function() -- Done
                    isHealingPerson = false
                    StopAnimTask(GetPlayerPed(-1), healAnimDict, "exit", 1.0)
                    RLCore.Functions.Notify("You helped the person!")
                    TriggerServerEvent("hospital:server:TreatWounds", playerId)
                end, function() -- Cancel
                    isHealingPerson = false
                    StopAnimTask(GetPlayerPed(-1), healAnimDict, "exit", 1.0)
                    RLCore.Functions.Notify("Failed!", "error")
                end)
            end
        end
    end)
end)

function MenuGarage(isDown)
    ped = GetPlayerPed(-1);
    MenuTitle = "Garage"
    ClearMenu()
    Menu.addButton("Vehicles", "VehicleList", isDown)
    Menu.addButton("Close Menu", "closeMenuFull", nil) 
end

function VehicleList(isDown)
    ped = GetPlayerPed(-1);
    MenuTitle = "Vehicles:"
    ClearMenu()
    for k, v in pairs(Config.Vehicles) do
        Menu.addButton(Config.Vehicles[k], "TakeOutVehicle", {k, isDown}, "Garage", " Motor: 100%", " Body: 100%", " Fuel: 100%")
    end
        
    Menu.addButton("Back", "MenuGarage",nil)
end

function TakeOutVehicle(vehicleInfo)
    local coords = Config.Locations["vehicle"][currentGarage]

    if not IsModelValid(vehicleInfo[1]) then
        RLCore.Functions.Notify("Invaild Vehicle Model", "error")
        return false
    end

    RLCore.Functions.SpawnVehicle(vehicleInfo[1], function(veh)
        SetVehicleNumberPlateText(veh, "AMBU"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.h)
        exports['rl-hud']:SetFuel(veh, 100)
        closeMenuFull()
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)

    return true
end

function closeMenuFull()
    Menu.hidden = true
    currentGarage = nil
    ClearMenu()
end