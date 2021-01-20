local deadAnimDict = "dead"
local deadAnim = "dead_a"
local deadCarAnimDict = "veh@low@front_ps@idle_duck"
local deadCarAnim = "sit"
local hold = 5

deathTime = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        local player = PlayerId()
		if NetworkIsPlayerActive(player) then
            local playerPed = PlayerPedId()
            if IsEntityDead(playerPed) and not InLaststand then
                SetLaststand(true)
            elseif IsEntityDead(playerPed) and InLaststand and not isDead then
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
                TriggerServerEvent("rl-log:server:CreateLog", "death", GetPlayerName(player) .. " ("..GetPlayerServerId(player)..") is dead", "red", "**".. killerName .. "** has ".. GetPlayerName(player) .." murdered with **".. weaponLabel .. "** (" .. weaponName .. ")")
                deathTime = Config.DeathTime
                OnDeath()
                DeathTimer()
            end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        if isDead or InLaststand then
            DisableInputGroup(0)
            DisableInputGroup(1)
            DisableInputGroup(2)
            DisableControlAction(0, 34, true)
            DisableControlAction(0, 9, true)
            DisableControlAction(0, 301, true)
            DisableControlAction(0, 32, true)
            DisableControlAction(0, 8, true)
            DisableControlAction(0, 289, true) 
            DisableControlAction(2, 31, true)
            DisableControlAction(2, 32, true)
            DisableControlAction(1, 33, true)
            DisableControlAction(1, 34, true)
            DisableControlAction(1, 35, true)
            DisableControlAction(1, 21, true)  -- space
            DisableControlAction(1, 22, true)  -- space
            DisableControlAction(1, 23, true)  -- F
            DisableControlAction(1, 24, true)  -- F
            DisableControlAction(1, 25, true)  -- F
            DisableControlAction(1, 56, true)  -- F9
            DisableControlAction(1, 288, true)  -- F1
            DisableControlAction(1, 157, true) -- 1
            DisableControlAction(1, 158, true) -- 2
            DisableControlAction(1, 160, true) -- 3
            DisableControlAction(1, 164, true) -- 4
            DisableControlAction(1, 165, true) -- 5
            DisableControlAction(1, 159, true) -- 6
            DisableControlAction(1, 106, true) -- VehicleMouseControlOverride
            DisableControlAction(1, 140, true) --Disables Melee Actions
            DisableControlAction(1, 141, true) --Disables Melee Actions
            DisableControlAction(1, 142, true) --Disables Melee Actions 
            DisableControlAction(1, 37, true) --Disables INPUT_SELECT_WEAPON (tab) Actions
            DisablePlayerFiring(GetPlayerPed(-1), true) -- Disable weapon firing
            
            if isDead then
                if not isInHospitalBed then 
                    if deathTime > 0 then
                        DrawTxt(0.93, 1.44, 1.0,1.0,0.5, "RESPAWN IN ~r~" .. math.ceil(deathTime) .. "~w~ SECONDS", 255, 255, 255, 255)
                    else
                        DrawTxt(0.865, 1.44, 1.0, 1.0, 0.5, "HOLD ~r~E ~s~(5) TO ~r~RESPAWN ~s~OR WAIT FOR ~r~EMS (/101)", 255, 255, 255, 255)
                    end
                end

                if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                    loadAnimDict("veh@low@front_ps@idle_duck")
                    if not IsEntityPlayingAnim(PlayerPedId(), "veh@low@front_ps@idle_duck", "sit", 3) then
                        TaskPlayAnim(PlayerPedId(), "veh@low@front_ps@idle_duck", "sit", 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                    end
                else
                    if isInHospitalBed then 
                        if not IsEntityPlayingAnim(PlayerPedId(), inBedDict, inBedAnim, 3) then
                            loadAnimDict(inBedDict)
                            TaskPlayAnim(PlayerPedId(), inBedDict, inBedAnim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                        end
                    else
                        if not IsEntityPlayingAnim(PlayerPedId(), deadAnimDict, deadAnim, 3) then
                            loadAnimDict(deadAnimDict)
                            TaskPlayAnim(PlayerPedId(), deadAnimDict, deadAnim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                        end
                    end
                end

                SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
            elseif InLaststand then
                DisableInputGroup(0)
                DisableInputGroup(1)
                DisableInputGroup(2)
                DisableControlAction(0, 34, true)
                DisableControlAction(0, 9, true)
                DisableControlAction(0, 301, true)
                DisableControlAction(0, 32, true)
                DisableControlAction(0, 8, true)
                DisableControlAction(0, 289, true) 
                DisableControlAction(2, 31, true)
                DisableControlAction(2, 32, true)
                DisableControlAction(1, 33, true)
                DisableControlAction(1, 34, true)
                DisableControlAction(1, 35, true)
                DisableControlAction(1, 21, true)  -- space
                DisableControlAction(1, 22, true)  -- space
                DisableControlAction(1, 23, true)  -- F
                DisableControlAction(1, 24, true)  -- F
                DisableControlAction(1, 25, true)  -- F
                DisableControlAction(1, 56, true)  -- F9
                DisableControlAction(1, 288, true)  -- F1
                DisableControlAction(1, 157, true) -- 1
                DisableControlAction(1, 158, true) -- 2
                DisableControlAction(1, 160, true) -- 3
                DisableControlAction(1, 164, true) -- 4
                DisableControlAction(1, 165, true) -- 5
                DisableControlAction(1, 159, true) -- 6
                DisableControlAction(1, 106, true) -- VehicleMouseControlOverride
                DisableControlAction(1, 140, true) --Disables Melee Actions
                DisableControlAction(1, 141, true) --Disables Melee Actions
                DisableControlAction(1, 142, true) --Disables Melee Actions 
                DisableControlAction(1, 37, true) --Disables INPUT_SELECT_WEAPON (tab) Actions
                DisablePlayerFiring(GetPlayerPed(-1), true) -- Disable weapon firing

                if LaststandTime > Laststand.MinimumRevive then
                    DrawTxt(0.94, 1.44, 1.0, 1.0, 0.5, "BLEED OUT IN ~r~" .. math.ceil(LaststandTime) .. "~w~ SECONDS", 255, 255, 255, 255)
                else
                    DrawTxt(0.845, 1.44, 1.0, 1.0, 0.5, "BLEED OUT IN ~r~" .. math.ceil(LaststandTime) .. "~w~ SECONDS, YOU CAN BE HELPED ", 255, 255, 255, 255)
                end

                if not isEscorted and not inCarry then
                    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                        loadAnimDict("veh@low@front_ps@idle_duck")
                        if not IsEntityPlayingAnim(PlayerPedId(), "veh@low@front_ps@idle_duck", "sit", 3) then
                            TaskPlayAnim(PlayerPedId(), "veh@low@front_ps@idle_duck", "sit", 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                        end
                    else
                        loadAnimDict(lastStandDict)
                        if not IsEntityPlayingAnim(PlayerPedId(), lastStandDict, lastStandAnim, 3) then
                            TaskPlayAnim(PlayerPedId(), lastStandDict, lastStandAnim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                        end
                    end
                elseif not inCarry then
                    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                        loadAnimDict("veh@low@front_ps@idle_duck")
                        if IsEntityPlayingAnim(PlayerPedId(), "veh@low@front_ps@idle_duck", "sit", 3) then
                            StopAnimTask(PlayerPedId(), "veh@low@front_ps@idle_duck", "sit", 3)
                        end
                    else
                        loadAnimDict(lastStandDict)
                        if IsEntityPlayingAnim(PlayerPedId(), lastStandDict, lastStandAnim, 3) then
                            StopAnimTask(PlayerPedId(), lastStandDict, lastStandAnim, 3)
                        end
                    end
                end
            end
		else
			Citizen.Wait(500)
		end
	end
end)


function OnDeath(spawn)
    if not isDead then
        isDead = true
        TriggerServerEvent("hospital:server:SetDeathStatus", true)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "demo", 0.1)
        local player = GetPlayerPed(-1)

        while GetEntitySpeed(player) > 0.5 or IsPedRagdoll(player) do
            Citizen.Wait(10)
        end

        if isDead then
            local isincar = IsPedInAnyVehicle(GetPlayerPed(-1), false)
            if isincar then
                LaststandCarObject = {
                    ['obj'] = GetVehiclePedIsIn(GetPlayerPed(-1), false),
                    ['seat'] = getSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), player)
                }
            end

            local pos = GetEntityCoords(player)
            local heading = GetEntityHeading(player)
            NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, heading, true, false)
            SetEntityInvincible(player, true)
            SetEntityHealth(player, GetEntityMaxHealth(GetPlayerPed(-1)))
            if isincar then
                TaskWarpPedIntoVehicle(player, LaststandCarObject['obj'], LaststandCarObject['seat'])
                LoadAnimation("veh@low@front_ps@idle_duck")
                TaskPlayAnim(player, "veh@low@front_ps@idle_duck", "sit", 2.0, 2.0, -1, 51, 0, false, false, false)
            else
                LoadAnimation(lastStandDict)
                TaskPlayAnim(player, lastStandDict, lastStandAnim, 1.0, 8.0, -1, 1, -1, false, false, false)
            end
            TriggerEvent("hospital:client:AiCall")
        end
    end
end

function DeathTimer()
    hold = 5
    while isDead do
        Citizen.Wait(1000)
        deathTime = deathTime - 1

        if deathTime <= 0 then
            if IsControlPressed(0, Keys["E"]) and hold <= 0 and not isInHospitalBed then
                TriggerEvent("hospital:client:RespawnAtHospital")
                hold = 5
            end

            if IsControlPressed(0, Keys["E"]) then
                if hold - 1 >= 0 then
                    hold = hold - 1
                else
                    hold = 0
                end
            end

            if IsControlReleased(0, Keys["E"]) then
                hold = 5
            end
        end
    end
end

function DrawTxt(x, y, width, height, scale, text, r, g, b, a, outline)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    --SetTextDropShadow(0, 0, 0, 0,255)
    --SetTextEdge(2, 0, 0, 0, 255)
    --SetTextDropShadow()
    --SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end