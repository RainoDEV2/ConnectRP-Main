Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		SetPedMinGroundTimeForStungun(PlayerPedId(), 7000)
	end
end)

