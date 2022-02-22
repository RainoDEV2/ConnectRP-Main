RLCore = {}
RLCore.Config = RLConfig
RLCore.Shared = RLShared
RLCore.ServerCallbacks = {}
RLCore.UseableItems = {}

function GetCoreObject()
	return RLCore
end

RegisterServerEvent('RLCore:GetObject')
AddEventHandler('RLCore:GetObject', function(cb)
	cb(GetCoreObject())
end)


exports('GetCoreObject', function()
    return RLCore
end)

-- To use this export in a script instead of manifest method
-- Just put this line of code below at the very top of the script
-- local RLCore = exports['rl-core']:GetCoreObject()
