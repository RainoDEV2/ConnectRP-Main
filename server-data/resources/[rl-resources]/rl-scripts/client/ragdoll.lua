Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		SetPedMinGroundTimeForStungun(GetPlayerPed(-1), 7000)
	end
end)

