RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local PaymentTax = 15

local Bail = {}

RegisterServerEvent('rl-trucker:server:DoBail')
AddEventHandler('rl-trucker:server:DoBail', function(bool, vehInfo)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    if bool then
        if Player.PlayerData.money.cash >= Config.BailPrice then
            Bail[Player.PlayerData.citizenid] = Config.BailPrice
            Player.Functions.RemoveMoney('cash', Config.BailPrice, "tow-received-bail")
            TriggerClientEvent('RLCore:Notify', src, 'You have paid the deposit of 1000, - (Cash)', 'success')
            TriggerClientEvent('rl-trucker:client:SpawnVehicle', src, vehInfo)
        elseif Player.PlayerData.money.bank >= Config.BailPrice then
            Bail[Player.PlayerData.citizenid] = Config.BailPrice
            Player.Functions.RemoveMoney('bank', Config.BailPrice, "tow-received-bail")
            TriggerClientEvent('RLCore:Notify', src, 'You have paid the deposit of 1000, - (Bank)', 'success')
            TriggerClientEvent('rl-trucker:client:SpawnVehicle', src, vehInfo)
        else
            TriggerClientEvent('RLCore:Notify', src, 'You do not have enough cash, the deposit is 1000, -', 'error')
        end
    else
        if Bail[Player.PlayerData.citizenid] ~= nil then
            Player.Functions.AddMoney('cash', Bail[Player.PlayerData.citizenid], "trucker-bail-paid")
            Bail[Player.PlayerData.citizenid] = nil
            TriggerClientEvent('RLCore:Notify', src, 'You got the deposit of 1000, - back', 'success')
        end
    end
end)

RegisterNetEvent('rl-trucker:server:01101110')
AddEventHandler('rl-trucker:server:01101110', function(drops)
    local src = source 
    local Player = RLCore.Functions.GetPlayer(src)
    local drops = tonumber(drops)
    local bonus = 0
    local DropPrice = math.random(300, 500)
    if drops > 5 then 
        bonus = math.ceil((DropPrice / 100) * 5) + 100
    elseif drops > 10 then
        bonus = math.ceil((DropPrice / 100) * 7) + 300
    elseif drops > 15 then
        bonus = math.ceil((DropPrice / 100) * 10) + 400
    elseif drops > 20 then
        bonus = math.ceil((DropPrice / 100) * 12) + 500
    end
    local price = (DropPrice * drops) + bonus
    local taxAmount = math.ceil((price / 100) * PaymentTax)
    local payment = price - taxAmount
    Player.Functions.AddJobReputation(1)
    Player.Functions.AddMoney("bank", payment, "trucker-salary")
    TriggerClientEvent('chatMessage', source, "BAAN", "warning", "You have received your salary of: $"..payment..", bruto: $"..price.." (of which $"..bonus.." bonus) with $"..taxAmount.." tax ("..PaymentTax.."%)")
end)