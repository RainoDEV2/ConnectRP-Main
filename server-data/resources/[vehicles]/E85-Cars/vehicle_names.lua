--[[ function AddTextEntry(key, value)
    Citizen.InvokeNative(GetHashKey(ADD_TEXT_ENTRY), key, value)
end ]]

Citizen.CreateThread(function()
	Citizen.Wait(0)
	AddTextEntry('hemicuda', '1971 Plymouth Hemi Cuda')
end) 