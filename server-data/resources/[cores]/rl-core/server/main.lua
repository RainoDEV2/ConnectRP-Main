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