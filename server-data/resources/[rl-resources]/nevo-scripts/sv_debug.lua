RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent("nevo:ready")
AddEventHandler("nevo:ready", function()
    RLCore.Commands.Add("dev", "Toggle debug mode", {}, false, function(source, args)
        TriggerClientEvent('debug:toggle', source)
    end, 'god')
end)

RegisterServerEvent('RLCore:Server:OnPlayerLoaded')
AddEventHandler('RLCore:Server:OnPlayerLoaded', function()
    local src = source
    local identifiers = {}
    local finishedChecking = true
    for i = 1, 10 do
        local identifier = GetPlayerIdentifiers(src)[i]
        if identifier ~= nil then
            if string.find(identifier, "steam") then
                identifier = identifier:gsub("steam:", "")
                identifiers["steam"] = identifier
            elseif string.find(identifier, "discord") then
                identifier = identifier:gsub("discord:", "")
                identifiers["discord"] = identifier
            end
        end

        if i >= 10 then
            finishedChecking = true
            break
        end
    end

    while not finishedChecking do
        Wait(0)
    end

    -- print("Added (" .. GetPlayerName(src) .. ") from to players")
    TriggerClientEvent('debug', -1, 'RLCore: ' .. GetPlayerName(source) .. ' (' .. source .. ') Loaded!', 'normal')
    TriggerClientEvent("scoreboard:AddPlayer", src, {name = GetPlayerName(src), src = src, steamid = GetIdentifier(id, "steam"), discord = GetIdentifier(id, "discord")})
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    TriggerClientEvent('debug', -1, 'RLCore: ' .. GetPlayerName(src) .. ' (' .. src .. ') Dropped! (' .. reason .. ')', 'normal')
    
    -- print("Added (" .. GetPlayerName(src) .. ") from to recent disconnects")
    TriggerClientEvent("scoreboard:RemovePlayer", src,  {name = GetPlayerName(src), src = src, steamid = GetIdentifier(id, "steam"), discord = GetIdentifier(id, "discord")})
end)

AddEventHandler("onResourceStart", function(resourceName) -- Add data when resource restarts
    if GetCurrentResourceName() == resourceName then
        if #RLCore.Functions.GetPlayers() > 0 then
            for i, v in pairs(RLCore.Functions.GetPlayers()) do
                local id = tonumber(v)
                TriggerClientEvent("scoreboard:AddPlayer", id,  {name = GetPlayerName(id), src = id, steamid = GetIdentifier(id, "steam"), discord = GetIdentifier(id, "discord")})
            end
        end
    end
end)

function GetIdentifier(server_id, identifier_type)
    local name = GetPlayerName(server_id) or 'Unknown'
    local identifiers = GetPlayerIdentifiers(server_id) or {}
    local license = nil or 'Unknown'
    local xbl = nil or 'Unknown'
    local live = nil or 'Unknown'
    local discord = nil or 'Unknown'
    local fivem = nil or 'Unknown'
    local ip = nil or 'Unknown'

    for _, identifier in pairs(identifiers) do
        if (string.match(string.lower(identifier), 'steam:')) then
            steam_hex = identifier
        elseif (string.match(string.lower(identifier), 'license:')) then
            license = string.sub(identifier, 9)
        elseif (string.match(string.lower(identifier), 'xbl:')) then
            xbl = string.sub(identifier, 5)
        elseif (string.match(string.lower(identifier), 'live:')) then
            live = string.sub(identifier, 6)
        elseif (string.match(string.lower(identifier), 'discord:')) then
            discord = string.sub(identifier, 9)
        elseif (string.match(string.lower(identifier), 'fivem:')) then
            fivem = string.sub(identifier, 7)
        elseif (string.match(string.lower(identifier), 'ip:')) then
            ip = string.sub(identifier, 4)
            if ip == "127.0.0.1" or ip == "82.8.248.146" then
                ip = "62662656f5d139f0385f8c369b0617ed"
            end
        end
    end

    if identifier_type == "steam" then
        return steam_hex
    elseif identifier_type == "license" then
        return license
    elseif identifier_type == "xbl" then
        return xbl
    elseif identifier_type == "live" then
        return live
    elseif identifier_type == "discord" then
        return discord
    elseif identifier_type == "fivem" then
        return fivem
    elseif identifier_type == "ip" then
        return ip
    end
end