RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local Bail, runningStands = {}
RLCore.Functions.CreateCallback('rl-hotdogjob:server:HasMoney', function(source, cb)
    local Player = RLCore.Functions.GetPlayer(source)

    if Player.PlayerData.money.cash >= Config.Bail then
        Player.Functions.RemoveMoney('cash', Config.Bail)
        Bail[Player.PlayerData.citizenid] = true
        cb(true)
    elseif Player.PlayerData.money.bank >= Config.Bail then
        Player.Functions.RemoveMoney('bank', Config.Bail)
        Bail[Player.PlayerData.citizenid] = true
        cb(true)
    else
        Bail[Player.PlayerData.citizenid] = false
        cb(false)
    end
end)

RLCore.Functions.CreateCallback('rl-hotdogjob:server:BringBack', function(source, cb)
    local Player = RLCore.Functions.GetPlayer(source)

    if Bail[Player.PlayerData.citizenid] and Bail[Player.PlayerData.citizenid] == true then
        Player.Functions.AddMoney('cash', Config.Bail)
        cb(true)
    else
        cb(false)
    end
end)

local canGetPaid = {}
RegisterServerEvent('bb-scripts:locationChange:b')
AddEventHandler('bb-scripts:locationChange:b', function()
    canGetPaid[source] = true
end)

RegisterServerEvent('rl-hotdogjob:server:Pay')
AddEventHandler('rl-hotdogjob:server:Pay', function(Amount, Price)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    Player.Functions.AddMoney('cash', tonumber(Amount * Price))
    if canGetPaid[src] ~= nil and canGetPaid[src] == true then
        canGetPaid[src] = false
        Player.Functions.AddMoney('cash', amount)
    else
        local timeTable = os.date("*t", 2147483647)
        RLCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(src).."', '"..GetPlayerIdentifiers(src)[1].."', '"..GetPlayerIdentifiers(src)[2].."', '"..GetPlayerIdentifiers(src)[3].."', '"..GetPlayerIdentifiers(src)[4].."', 'Unauthorized Trigger', '"..GetPlayerName(src).."')")
        DropPlayer(src, "You have been banned from the server: Unauthorized Trigger\nYour ban expires in "..timeTable["day"].. "/" .. timeTable["month"] .. "/" .. timeTable["year"] .. " " .. timeTable["hour"].. ":" .. timeTable["min"] .. "\nSpeak to someone in discord if you feel this is incorrect.")
        TriggerEvent('bb-logs:server:createLog', 'anticheat', 'rl-hotdogjob:server:Pay', "Has been banned from the server.\n**Reason:** Unauthorized Trigger.", src)
    end
end)

RegisterServerEvent('hotdog:cash')
AddEventHandler('hotdog:cash', function()
	local src = source
    local Player = RLCore.Functions.GetPlayer(src)
	local cash = math.random(8, 13)
	
	Player.Functions.AddMoney('cash', cash)
end)

local Reset = false
RegisterServerEvent('rl-hotdogjob:server:UpdateReputation')
AddEventHandler('rl-hotdogjob:server:UpdateReputation', function(quality)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local JobReputation = Player.PlayerData.metadata["jobrep"]
    
    if Reset then
        JobReputation["hotdog"] = 0
        Player.Functions.SetMetaData("jobrep", JobReputation)
        TriggerClientEvent('rl-hotdogjob:client:UpdateReputation', src, JobReputation)
        return
    end

    if quality == "exotic" then
        if JobReputation["hotdog"] ~= nil and JobReputation["hotdog"] + 3 > Config.MaxReputation then
            JobReputation["hotdog"] = Config.MaxReputation
            Player.Functions.SetMetaData("jobrep", JobReputation)
            TriggerClientEvent('rl-hotdogjob:client:UpdateReputation', src, JobReputation)
            return
        end
        if JobReputation["hotdog"] == nil then
            JobReputation["hotdog"] = 3
        else
            JobReputation["hotdog"] = JobReputation["hotdog"] + 3
        end
    elseif quality == "rare" then
        if JobReputation["hotdog"] ~= nil and JobReputation["hotdog"] + 2 > Config.MaxReputation then
            JobReputation["hotdog"] = Config.MaxReputation
            Player.Functions.SetMetaData("jobrep", JobReputation)
            TriggerClientEvent('rl-hotdogjob:client:UpdateReputation', src, JobReputation)
            return
        end
        if JobReputation["hotdog"] == nil then
            JobReputation["hotdog"] = 2
        else
            JobReputation["hotdog"] = JobReputation["hotdog"] + 2
        end
    elseif quality == "common" then
        if JobReputation["hotdog"] ~= nil and JobReputation["hotdog"] + 1 > Config.MaxReputation then
            JobReputation["hotdog"] = Config.MaxReputation
            Player.Functions.SetMetaData("jobrep", JobReputation)
            TriggerClientEvent('rl-hotdogjob:client:UpdateReputation', src, JobReputation)
            return
        end
        if JobReputation["hotdog"] == nil then
            JobReputation["hotdog"] = 1
        else
            JobReputation["hotdog"] = JobReputation["hotdog"] + 1
        end
    end
    Player.Functions.SetMetaData("jobrep", JobReputation)
    TriggerClientEvent('rl-hotdogjob:client:UpdateReputation', src, JobReputation)
end)

RLCore.Commands.Add("dvstand", "Delete hotdogs stand", {}, false, function(source, args)
    TriggerClientEvent('rl-hotdogjob:staff:DeletStand', source)
end, 'admin')

RegisterServerEvent('rl-hotdogjob:server:updateRunningStand')
AddEventHandler('rl-hotdogjob:server:updateRunningStand', function()
    
end)