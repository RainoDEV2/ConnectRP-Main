RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

-- Code
RLCore.Functions.CreateUseableItem("fitbit", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent('rl-fitbit:use', source)
end)

RegisterServerEvent('rl-fitbit:server:setValue')
AddEventHandler('rl-fitbit:server:setValue', function(type, value)
    local src = source
    local ply = RLCore.Functions.GetPlayer(src)
    local fitbitData = {}

    if type == "thirst" then
        local currentMeta = ply.PlayerData.metadata["fitbit"]
        fitbitData = {
            thirst = value,
            food = currentMeta.food
        }
    elseif type == "food" then
        local currentMeta = ply.PlayerData.metadata["fitbit"]
        fitbitData = {
            thirst = currentMeta.thirst,
            food = value
        }
    end

    ply.Functions.SetMetaData('fitbit', fitbitData)
end)

RLCore.Functions.CreateCallback('rl-fitbit:server:HasFitbit', function(source, cb)
    local Ply = RLCore.Functions.GetPlayer(source)
    local Fitbit = Ply.Functions.GetItemByName("fitbit")

    if Fitbit ~= nil then
        cb(true)
    else
        cb(false)
    end
end)