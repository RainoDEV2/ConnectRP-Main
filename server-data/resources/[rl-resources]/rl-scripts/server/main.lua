RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent('CrashTackle')
AddEventHandler('CrashTackle', function(target)
	TriggerClientEvent("playerTackled", target)
end)

RLCore.Functions.CreateUseableItem("harness", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent('seatbelt:client:UseHarness', source, item)
end)

RegisterServerEvent('equip:harness')
AddEventHandler('equip:harness', function(item)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    if Player.PlayerData.items[item.slot].info.uses - 1 == 0 then
        TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['harness'], "remove")
        Player.Functions.RemoveItem('harness', 1)
    else
        Player.PlayerData.items[item.slot].info.uses = Player.PlayerData.items[item.slot].info.uses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

RegisterServerEvent('seatbelt:DoHarnessDamage')
AddEventHandler('seatbelt:DoHarnessDamage', function(hp, data)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    if hp == 0 then
        Player.Functions.RemoveItem('harness', 1, data.slot)
    else
        Player.PlayerData.items[data.slot].info.uses = Player.PlayerData.items[data.slot].info.uses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

RegisterServerEvent('carhud:ejection:server')
AddEventHandler('carhud:ejection:server', function(plyID, veloc)
    TriggerClientEvent("carhud:ejection:client", plyID, veloc)
end)