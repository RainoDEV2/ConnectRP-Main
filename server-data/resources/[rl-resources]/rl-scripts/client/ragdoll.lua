Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		SetPedMinGroundTimeForStungun(GetPlayerPed(-1), 3500)
	end
end)

