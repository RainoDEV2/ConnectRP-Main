--[[ function AddTextEntry(key, value)
    Citizen.InvokeNative(GetHashKey(ADD_TEXT_ENTRY), key, value)
end ]]

Citizen.CreateThread(function()
	Citizen.Wait(0)
    AddTextEntry('explorer', '2016 Ford Explorer')
    AddTextEntry('2015polstang', '2015 Ford Mustang GT500')
end) 