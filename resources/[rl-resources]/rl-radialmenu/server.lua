RLCore = nil
TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)    

local trunkBusy = {}

RegisterServerEvent('rl-trunk:server:setTrunkBusy')
AddEventHandler('rl-trunk:server:setTrunkBusy', function(plate, busy)
    trunkBusy[plate] = busy
end)

RLCore.Functions.CreateCallback('rl-trunk:server:getTrunkBusy', function(source, cb, plate)
    if trunkBusy[plate] then
        cb(true)
    end
    cb(false)
end)

RegisterServerEvent('rl-trunk:server:KidnapTrunk')
AddEventHandler('rl-trunk:server:KidnapTrunk', function(targetId, closestVehicle)
    TriggerClientEvent('rl-trunk:client:KidnapGetIn', targetId, closestVehicle)
end)

RegisterNetEvent('vehicle:flipit')
AddEventHandler('vehicle:flipit', function()
	TriggerClientEvent('vehicle:flipit')
end)