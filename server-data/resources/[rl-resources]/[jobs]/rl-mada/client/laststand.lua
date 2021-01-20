RLCore = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if RLCore == nil then
            TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
            Citizen.Wait(200)
        end
    end
end)

-- Config
LaststandCarObject = {}
Laststand = Laststand or {}
Laststand.ReviveInterval = 120
Laststand.MinimumRevive = 90

-- Code

InLaststand = false
CanBePickuped = false
LaststandTime = 0

lastStandDict = "combat@damage@writhe"
lastStandAnim = "writhe_loop"

isEscorted = false
isEscorting = false

RegisterNetEvent('hospital:client:SetEscortingState')
AddEventHandler('hospital:client:SetEscortingState', function(bool)
    isEscorting = bool
end)

RegisterNetEvent('hospital:client:isEscorted')
AddEventHandler('hospital:client:isEscorted', function(bool)
    isEscorted = bool
end)

function SetLaststand(bool, spawn)
    local ped = GetPlayerPed(-1)
    if bool then
        Wait(1000)
        local isincar = IsPedInAnyVehicle(GetPlayerPed(-1), false)
        if isincar then
            LaststandCarObject = {
                ['obj'] = GetVehiclePedIsIn(GetPlayerPed(-1), false),
                ['seat'] = getSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), ped)
            }
        end

        while GetEntitySpeed(ped) > 0.5 or IsPedRagdoll(ped) do
            Citizen.Wait(10)
        end

        TriggerServerEvent("InteractSound_SV:PlayOnSource", "demo", 0.1)

        LaststandTime = Laststand.ReviveInterval

        local pos = GetEntityCoords(ped)
        local heading = GetEntityHeading(ped)
        NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, heading, true, false)
        SetEntityHealth(ped, 150)
        print('in vehicle1')
        
        if isincar then
            TaskWarpPedIntoVehicle(ped, LaststandCarObject['obj'], LaststandCarObject['seat'])
            LoadAnimation("veh@low@front_ps@idle_duck")
            TaskPlayAnim(ped, "veh@low@front_ps@idle_duck", "sit", 2.0, 2.0, -1, 51, 0, false, false, false)
        else
            LoadAnimation(lastStandDict)
            TaskPlayAnim(ped, lastStandDict, lastStandAnim, 1.0, 8.0, -1, 1, -1, false, false, false)
        end

        InLaststand = true

        Citizen.CreateThread(function()
            while InLaststand do
                if LaststandTime - 1 > Laststand.MinimumRevive then
                    LaststandTime = LaststandTime - 1
                    Config.DeathTime = LaststandTime
                elseif LaststandTime - 1 <= Laststand.MinimumRevive and LaststandTime - 1 ~= 0 then
                    LaststandTime = LaststandTime - 1
                    CanBePickuped = true
                    Config.DeathTime = LaststandTime
                elseif LaststandTime - 1 <= 0 then
                    RLCore.Functions.Notify("You've bled out..", "error")
                    SetLaststand(false)
                    local killer_2, killerWeapon = NetworkGetEntityKillerOfPlayer(player)
                    local killer = GetPedSourceOfDeath(playerPed)
                    
                    if killer_2 ~= 0 and killer_2 ~= -1 then
                        killer = killer_2
                    end
    
                    local killerId = NetworkGetPlayerIndexFromPed(killer)
                    local killerName = killerId ~= -1 and GetPlayerName(killerId) .. " " .. "("..GetPlayerServerId(killerId)..")" or "Zichzelf of NPC"
                    local weaponLabel = RLCore.Shared.Weapons[killerWeapon] ~= nil and RLCore.Shared.Weapons[killerWeapon]["label"] or "Unknown"
                    local weaponName = RLCore.Shared.Weapons[killerWeapon] ~= nil and RLCore.Shared.Weapons[killerWeapon]["name"] or "Unknown_Weapon"
                    TriggerServerEvent("rl-log:server:CreateLog", "death", GetPlayerName(player) .. " ("..GetPlayerServerId(player)..") is dead", "red", "**".. killerName .. "** has ".. GetPlayerName(player) .." killed by **".. weaponLabel .. "** (" .. weaponName .. ")")
                    deathTime = 0
                    OnDeath()
                    DeathTimer()
                end
                Citizen.Wait(1000)
            end
        end)
    else
        InLaststand = false
        CanBePickuped = false
        LaststandTime = 0
    end
    TriggerServerEvent("hospital:server:SetLaststandStatus", bool)
end

function LoadAnimation(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(100)
    end
end

function getSeat(isincar, ped)
    for v = -1, 6 do
        local sped = GetPedInVehicleSeat(isincar, v)
        if sped == ped then
            return v
        end
    end
    return nil
end

RegisterNetEvent('hospital:client:CanHelp')
AddEventHandler('hospital:client:CanHelp', function(helperId)
    if InLaststand then
        if LaststandTime <= 90 then
            TriggerServerEvent('hospital:server:CanHelp', helperId, true)
        else
            TriggerServerEvent('hospital:server:CanHelp', helperId, false)
        end
    else
        TriggerServerEvent('hospital:server:CanHelp', helperId, false)
    end
end)

RegisterNetEvent('hospital:client:HelpPerson')
AddEventHandler('hospital:client:HelpPerson', function(targetId)
    local ped = GetPlayerPed(-1)
    isHealingPerson = true
    RLCore.Functions.Progressbar("hospital_revive", "Help person up..", math.random(30000, 60000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = healAnimDict,
        anim = healAnim,
        flags = 1,
    }, {}, {}, function() -- Done
        isHealingPerson = false
        ClearPedTasks(ped)
        RLCore.Functions.Notify("You helped the person up.")
        TriggerServerEvent("hospital:server:RevivePlayer", targetId)
    end, function() -- Cancel
        isHealingPerson = false
        ClearPedTasks(ped)
        RLCore.Functions.Notify("Canceled!", "error")
    end)
end)