--[[ Citizen.CreateThread(function()
    while true do 
        if RLCore ~= nil then
            if not IsPedInAnyVehicle(GetPlayerPed(-1), false) and GetEntitySpeed(GetPlayerPed(-1)) > 2.5 then
                if IsControlJustPressed(1, Keys["G"]) and not spacePressed then
                    Tackle()
                end
            else
                Citizen.Wait(250)
            end
        end

        Citizen.Wait(1)
    end
end)

RegisterNetEvent('tackle:client:GetTackled')
AddEventHandler('tackle:client:GetTackled', function()
	SetPedToRagdoll(GetPlayerPed(-1), math.random(1000, 6000), math.random(1000, 6000), 0, 0, 0, 0) 
	TimerEnabled = true
	Citizen.Wait(1500)
    TimerEnabled = false
    
    TriggerEvent("debug", 'Tackled: Got', 'success')
end)

function Tackle()
    closestPlayer, distance = RLCore.Functions.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if(distance ~= -1 and distance < 2) then
        TriggerServerEvent("tackle:server:TacklePlayer", GetPlayerServerId(closestPlayer))
        TackleAnim()
        TriggerEvent("debug", 'Tackled: Animation', 'success')
    end
end

function TackleAnim()
    if not RLCore.Functions.GetPlayerData().metadata["ishandcuffed"] and not IsPedRagdoll(GetPlayerPed(-1)) then
        RequestAnimDict("swimming@first_person@diving")
        while not HasAnimDictLoaded("swimming@first_person@diving") do
            Citizen.Wait(1)
        end
        if IsEntityPlayingAnim(GetPlayerPed(-1), "swimming@first_person@diving", "dive_run_fwd_-45_loop", 3) then
            ClearPedTasksImmediately(GetPlayerPed(-1))
        else
            TaskPlayAnim(GetPlayerPed(-1), "swimming@first_person@diving", "dive_run_fwd_-45_loop" ,3.0, 3.0, -1, 49, 0, false, false, false)
            Citizen.Wait(250)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            SetPedToRagdoll(GetPlayerPed(-1), 150, 150, 0, 0, 0, 0)
        end
    end
end ]]

TimerEnabled = false

function TryTackle()
		if not TimerEnabled then
			--print("attempting a tackle.")
			t, distance = RLCore.Functions.GetClosestPlayer()
			if(distance ~= -1 and distance < 2) then
				local maxheading = (GetEntityHeading(PlayerPedId()) + 15.0)
				local minheading = (GetEntityHeading(PlayerPedId()) - 15.0)
				local theading = (GetEntityHeading(t))

				TriggerServerEvent('CrashTackle',GetPlayerServerId(t))
				TriggerEvent("animation:tacklelol") 

				TimerEnabled = true
				Citizen.Wait(4500)
				TimerEnabled = false

			else
				TimerEnabled = true
				Citizen.Wait(1000)
				TimerEnabled = false

			end

		end
--SetPedToRagdoll(PlayerPedId(), 500, 500, 0, 0, 0, 0) 
end

RegisterNetEvent('playerTackled')
AddEventHandler('playerTackled', function()
	SetPedToRagdoll(PlayerPedId(), math.random(8500), math.random(8500), 0, 0, 0, 0) 

	TimerEnabled = true
	Citizen.Wait(1500)
	TimerEnabled = false
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)

		if IsControlPressed(0, 61) and IsControlPressed(0, 47) then --SHIFT G
			--print('key pressed')
			Citizen.Wait(10)
			closestPlayer, distance = RLCore.Functions.GetClosestPlayer()

			if not IsPedInAnyVehicle(GetPlayerPed(-1)) and not IsPedInAnyVehicle(GetPlayerPed(closestPlayer)) and not IsPedRagdoll(PlayerPedId()) then
				TryTackle()
			end
		end
	end
end)

RegisterNetEvent('animation:tacklelol')
AddEventHandler('animation:tacklelol', function()
		if not IsPedRagdoll(PlayerPedId()) then
			local lPed = PlayerPedId()
			RequestAnimDict("swimming@first_person@diving")
			while not HasAnimDictLoaded("swimming@first_person@diving") do
				Citizen.Wait(1)
			end
			
			if IsEntityPlayingAnim(lPed, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 3) then
				ClearPedSecondaryTask(lPed)
			else
				TaskPlayAnim(lPed, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 8.0, -8, -1, 49, 0, 0, 0, 0)
				seccount = 3
				while seccount > 0 do
					Citizen.Wait(100)
					seccount = seccount - 1
				end
				ClearPedSecondaryTask(lPed)
				SetPedToRagdoll(PlayerPedId(), 150, 150, 0, 0, 0, 0) 
			end
		end
end)
