--[[ function AddTextEntry(key, value)
    Citizen.InvokeNative(GetHashKey(ADD_TEXT_ENTRY), key, value)
end ]]

Citizen.CreateThread(function()
	AddTextEntry('hemicuda', '1971 Plymouth Hemi Cuda')
	AddTextEntry('titanic2', 'RMS Titanic')
end) 