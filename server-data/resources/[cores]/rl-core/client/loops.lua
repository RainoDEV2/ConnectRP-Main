
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		if NetworkIsSessionStarted() then
			Citizen.Wait(10)
			TriggerServerEvent('RLCore:PlayerJoined')
			return
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if isLoggedIn then
			Citizen.Wait((1000 * 60) * 30)
			TriggerServerEvent("RLCore:ReceivedSalary")
		else
			Citizen.Wait(5000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		if isLoggedIn then
			Citizen.Wait((1000 * 60) * 10)
			TriggerEvent("RLCore:Player:UpdatePlayerData")
			TriggerEvent("debug", 'RLCore: Update Player Data!', 'normal')
		else
			Citizen.Wait(5000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		if isLoggedIn then
			Citizen.Wait(30000)
			TriggerEvent("RLCore:Player:UpdatePlayerPosition")
			TriggerEvent("debug", 'RLCore: Update Player Position!', 'normal')
		else
			Citizen.Wait(5000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(math.random(3000, 5000))
		if isLoggedIn then
			if RLCore.Functions.GetPlayerData().metadata["hunger"] <= 0 or RLCore.Functions.GetPlayerData().metadata["thirst"] <= 0 then
				local ped = PlayerPedId()
				local currentHealth = GetEntityHealth(ped)

				SetEntityHealth(ped, currentHealth - math.random(5, 10))
			end
		end
	end
end)