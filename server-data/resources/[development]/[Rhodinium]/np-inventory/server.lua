RLCore = nil

TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent("cash:remove")
AddEventHandler("cash:remove", function(pSource, pAmount)
    local src = pSource
    local Player = RLCore.Functions.GetPlayer(src)

    Player.Functions.RemoveMoney("cash", pAmount) 
end)
