RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent('rh:bank:balance')
AddEventHandler('rh:bank:balance', function()    
    local _source = source
    local xPlayer = RLCore.Functions.GetPlayer(_source)
    local balance = xPlayer.PlayerData.money['cash']
    TriggerClientEvent('cash2', _source, balance)
    print(balance)

end)

RegisterServerEvent('delivery:success')
AddEventHandler('delivery:success', function(price)
    local _source = source
    local xPlayer = RLCore.Functions.GetPlayer(_source)
    xPlayer.Functions.AddMoney('cash', money) 

end)

RegisterServerEvent("delivery:rmoney")
AddEventHandler("delivery:rmoney", function(money)
    local _source = source
    local xPlayer = RLCore.Functions.GetPlayer(_source)
    xPlayer.Functions.RemoveMoney('cash', money) 
end)