RLCore = {}
RLCore.PlayerData = {}
RLCore.Config = RLConfig
RLCore.Shared = RLShared
RLCore.ServerCallbacks = {}

isLoggedIn = false

function GetCoreObject()
	return RLCore
end

RegisterNetEvent('RLCore:GetObject')
AddEventHandler('RLCore:GetObject', function(cb)
	cb(GetCoreObject())
end)

RegisterNetEvent('RLCore:Client:OnPlayerLoaded')
AddEventHandler('RLCore:Client:OnPlayerLoaded', function()
	ShutdownLoadingScreenNui()
	isLoggedIn = true
end)

RegisterNetEvent('RLCore:Client:OnPlayerUnload')
AddEventHandler('RLCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)
