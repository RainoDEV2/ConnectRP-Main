-- This resource was made by plesalex100#7387
-- Please respect it, don't repost it without my permission
-- This Resource started from: https://codepen.io/AdrianSandu/pen/MyBQYz
-- ESX Version: saNhje & wUNDER

RLCore = nil

TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent("tc-slots:BetsAndMoney")
AddEventHandler("tc-slots:BetsAndMoney", function(bets)
    local _source   = source
    local xPlayer   = RLCore.Functions.GetPlayer(_source) 
    local money     = xPlayer.PlayerData.money['cash'] 
    if xPlayer then 
        if bets % 50 == 0 and bets >= 50 then
            if money >= bets then
                xPlayer.Functions.removeMoney('cash',bets)
                TriggerClientEvent("tc-slots:UpdateSlots", _source, bets)
            else
                TriggerClientEvent("RLCore:Notify",_source, "Not enought money")
            end
        else
            TriggerClientEvent("RLCore:Notify",_source, "You have to insert a multiple of 50. ex: 100, 350, 2500")
        end

    end
end)

RegisterServerEvent("tc-slots:PayOutRewards")
AddEventHandler("tc-slots:PayOutRewards", function(amount)
    local _source   = source
    local xPlayer   = RLCore.Functions.GetPlayer(_source) 
    if xPlayer then
        amount = tonumber(amount)
        if amount > 0 then
            xPlayer.Functions.addMoney('cash',amount)
            TriggerClientEvent("RLCore:Notify",_source, "Slots: You won $"..amount.." not bad at all!")
        else
            TriggerClientEvent("RLCore:Notify",_source, "Slots: Unfortunately you've lost all the money, maybe next time.")
        end
    end
end)
