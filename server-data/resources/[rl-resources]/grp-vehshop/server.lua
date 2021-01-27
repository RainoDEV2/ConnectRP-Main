RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local repayTime = 168 * 60 -- hours * 60
local timer = ((60 * 1000) * 10) -- 10 minute timer

local carTable = {
	[1] = { ["model"] = "gauntlet", ["baseprice"] = 100000, ["commission"] = 15 }, 
	[2] = { ["model"] = "dubsta3", ["baseprice"] = 100000, ["commission"] = 15 },
	[3] = { ["model"] = "landstalker", ["baseprice"] = 100000, ["commission"] = 15 },
	[4] = { ["model"] = "bobcatxl", ["baseprice"] = 100000, ["commission"] = 15 },
	[5] = { ["model"] = "surfer", ["baseprice"] = 100000, ["commission"] = 15 },
	[6] = { ["model"] = "glendale", ["baseprice"] = 100000, ["commission"] = 15 },
	[7] = { ["model"] = "washington", ["baseprice"] = 100000, ["commission"] = 15 },
}

-- Update car table to server
RegisterServerEvent('carshop:table')
AddEventHandler('carshop:table', function(table)
    if table ~= nil then
        carTable = table
        TriggerClientEvent('veh_shop:returnTable', -1, carTable)
        updateDisplayVehicles()
    end
end)

-- Enables finance for 60 seconds
RegisterServerEvent('finance:enable')
AddEventHandler('finance:enable', function(plate)
    if plate ~= nil then
        TriggerClientEvent('finance:enableOnClient', -1, plate)
    end
end)

RegisterServerEvent('buy:enable')
AddEventHandler('buy:enable', function(plate)
    if plate ~= nil then
        TriggerClientEvent('buy:enableOnClient', -1, plate)
    end
end)

-- return table
-- TODO (return db table)
RegisterServerEvent('carshop:requesttable')
AddEventHandler('carshop:requesttable', function()
    local xPlayer = RLCore.Functions.GetPlayer(source)
    local display = RLCore.Functions.ExecuteSql(false,'SELECT * FROM vehicles_display')
    for k,v in pairs(display) do
        carTable[v.ID] = v
        v.price = carTable[v.ID].baseprice
    end
    TriggerClientEvent('veh_shop:returnTable',source, carTable)
end)

-- Check if player has enough money
RegisterServerEvent('CheckMoneyForVeh')
AddEventHandler('CheckMoneyForVeh', function(name, model,price,financed)
	local xPlayer = RLCore.Functions.GetPlayer(source)
    local money = xPlayer.PlayerData.money['cash']  
    if financed then
        local financedPrice = math.ceil(price / 4)
        if money >= financedPrice then
            xPlayer.Functions.RemoveMoney('cash',financedPrice)
            TriggerClientEvent('FinishMoneyCheckForVeh', source, name, model, price, financed)
        else
            TriggerClientEvent("RLCore:Notify",source, "You dont have enough money on you!")
            TriggerClientEvent('carshop:failedpurchase',source)
        end
    else
        if money >= price then
            xPlayer.Functions.RemoveMoney('cash',price)
            TriggerClientEvent('FinishMoneyCheckForVeh', source, name, model, price, financed)
            print('finish money check')
        else
            TriggerClientEvent("RLCore:Notify", source, "You dont have enough money on you!")
            TriggerClientEvent('carshop:failedpurchase', source)
        end 
    end
end)

-- Add the car to database when completed purchase
RegisterServerEvent('BuyForVeh')
AddEventHandler('BuyForVeh', function(vehicleProps,name, vehicle, price, financed)
    local xPlayer = RLCore.Functions.GetPlayer(source)
    if financed then
        print(vehicleProps.plate)
        print(json.encode(price))
        --local cols = 'citizenid, plate, vehicle, buy_price, finance, financetimer, vehiclename, shop'
        --local val = '@citizenid, @plate, @vehicle, @buy_price, @finance, @financetimer, @vehiclename, @shop'
        local downPay = math.ceil(price / 4)
        --local data = RLCore.Functions.ExecuteSql(false,"SELECT money FROM addon_account_data WHERE account_name=@account_name",{['@account_name'] = 'pdm'})
        --local curSociety = data[1].money
       -- MySQL.Async.execute('INSERT INTO bbvehicles (citizenid, plate, vehicle, buy_price, finance, financetimer, vehiclename, shop) VALUES (@citizenid, @plate, @vehicle, @buy_price, @finance, @financetimer, @vehiclename, @shop)',
       local plate = vehicleProps.plate
        RLCore.Functions.ExecuteSql(false,"INSERT INTO `bbvehicles` (`citizenid`, `plate`, `props`, `buy_price`, `finance`, `financetimer`, `vehiclename`) VALUES ('"..xPlayer.PlayerData.citizenid.."', '"..plate.."', '"..json.encode(vehicleProps).."', '"..price.."', '"..price - downPay.."', '"..repayTime.."', '"..vehicle.."')")
        --RLCore.Functions.ExecuteSql(false,'UPDATE addon_account_data SET money=@money WHERE account_name=@account_name',{['@money'] = curSociety + downPay,['@account_name'] = 'pdm'})
    else
        --local data = RLCore.Functions.ExecuteSql(false,"SELECT money FROM addon_account_data WHERE account_name=@account_name",{['@account_name'] = 'pdm'})
        --local curSociety = data[1].money
        local nig = {damage = 10, fuel = 98}
        RLCore.Functions.ExecuteSql(false,"INSERT INTO `bbvehicles` (`citizenid`, `plate`, `model`, `props`, `stats`, `state`) VALUES ('"..xPlayer.PlayerData.citizenid.."', '"..vehicleProps.plate.."', '"..vehicle.."', '"..json.encode(vehicleProps).."', '"..json.encode(nig).."', 'unknown')"--[[,{
            ['@citizenid']   = xPlayer.PlayerData.citizenid,
            ['@plate']   = vehicleProps.plate,
            ['@props'] = json.encode(vehicleProps),
            ['@vehiclename'] = vehicle,
            ['@buy_price'] = price
        }]])
        --RLCore.Functions.ExecuteSql(false,'UPDATE addon_account_data SET money=@money WHERE account_name=@account_name',{['@money'] = curSociety + price,['@account_name'] = 'pdm'})
    end
end)

-- Get All finance > 0 then take 10min off
-- Every 10 Min
function updateFinance()
    RLCore.Functions.ExecuteSql(false,'SELECT financetimer, plate FROM bbvehicles WHERE financetimer > @financetimer', {
        ["@financetimer"] = 0
    }, function(result)
        for i=1, #result do
            local financeTimer = result[i].financetimer
            local plate = result[i].plate
            local newTimer = financeTimer - 10
            if financeTimer ~= nil then
                RLCore.Functions.ExecuteSql(false,'UPDATE bbvehicles SET financetimer=@financetimer WHERE plate=@plate', {
                    ['@plate'] = plate,
                    ['@financetimer'] = newTimer
                })
            end
        end
    end)
    SetTimeout(timer, updateFinance)
end
SetTimeout(timer, updateFinance)

RegisterNetEvent('RS7x:phonePayment')
AddEventHandler('RS7x:phonePayment', function(plate)
    local src = source
    local pPlate = plate
    local xPlayer = RLCore.Functions.GetPlayer(src)
    local group = RLCore.Functions.ExecuteSql(false,"SELECT shop FROM bbvehicles WHERE plate=@plate", {['@plate'] = plate})
    print(group[1].shop)
    if pPlate ~= nil then
        local pData = RLCore.Functions.ExecuteSql(false,"SELECT buy_price, plate FROM bbvehicles WHERE plate=@plate", {['@plate'] = pPlate})
        for k,v in pairs(pData) do
            if pData ~= nil then 
                if pPlate == v.plate then
                    local price = (v.buy_price / 10)
                    if xPlayer.PlayerData.money['cash'] >= price then
                        xPlayer.Functions.RemoveMoney('cash',price)
                        fuck = true
                        TriggerClientEvent('chatMessagess', src, 'IMPORTANT: ', 1, 'Please see pdm dealer for reimbursement. Take a screen shot of the payment or you will not receive any money back!')
                        TriggerClientEvent('chatMessagess', src, 'IMPORTANT: ', 1, 'You payed $'.. price .. ' on your vehicle.')
                    else
                        fuck = false
                        TriggerClientEvent('DoLongHudText', src, 'You don\'t have enough money to pay on this vehicle!', 2)
                        TriggerClientEvent('DoLongHudText', src, 'You need $'.. price .. ' to pay for your vehicle!', 1)
                    end

                    if fuck then
                        local data = RLCore.Functions.ExecuteSql(false,"SELECT finance FROM bbvehicles WHERE plate=@plate",{['@plate'] = plate})
                        if not data or not data[1] then return; end
                        local prevAmount = data[1].finance
                        if prevAmount - price <= 0 or prevAmount - price <= 0.0 then
                            settimer = 0
                        else
                            settimer = repayTime
                        end
                        if prevAmount < price then
                            RLCore.Functions.ExecuteSql(false,'UPDATE bbvehicles SET finance=@finance WHERE plate=@plate',{['@finance'] = 0, ['@plate'] = plate})
                            RLCore.Functions.ExecuteSql(false,'UPDATE bbvehicles SET financetimer=@financetimer WHERE plate=@plate',{['@financetimer'] = 0, ['@plate'] = plate})
                        else
                            RLCore.Functions.ExecuteSql(false,'UPDATE bbvehicles SET finance=@finance WHERE plate=@plate',{['@finance'] = prevAmount - price, ['@plate'] = plate})
                            RLCore.Functions.ExecuteSql(false,'UPDATE bbvehicles SET financetimer=@financetimer WHERE plate=@plate',{['@financetimer'] = settimer, ['@plate'] = plate})
                        end
                    end

                    --[[ local data = RLCore.Functions.ExecuteSql(false,"SELECT money FROM addon_account_data WHERE account_name=@account_name",{['@account_name'] = 'society_cardealer'})
                    if not data then return; end
                    local curSociety = data[1].money
                    RLCore.Functions.ExecuteSql(false,'UPDATE addon_account_data SET money=@money WHERE account_name=@account_name',{['@money'] = curSociety + price,['@account_name'] = 'society_cardealer'}) ]]
                end
                return
            end
        end
    end
end)

function updateDisplayVehicles()
    for i=1, #carTable do
        RLCore.Functions.ExecuteSql(false,"UPDATE vehicles_display SET model='"..carTable[i]["model"].."', commission='"..carTable[i]["commission"].."', baseprice='"..carTable[i]["baseprice"].."' WHERE ID='"..i.."'")
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        updateDisplayVehicles()
    end
end)

Citizen.CreateThread(function()
    updateFinance()
end)

--[[
        MySQL.Async.fetchAll('SELECT finance, plate FROM bbvehicles WHERE finance < @finance', {
        ["@finance"] = os.date('%Y-%m-%d %H:%M:%S', os.time())
    }, function(result)
        local finance = result[1].finance
        local plate = result[1].plate
        if finance ~= nil then
            local reference = finance
            local daysfrom = os.difftime(os.time(), reference) / (24 * 60 * 60)
            local wholedays = math.floor(daysfrom)
            if wholedays < 0 then
                MySQL.Async.execute('UPDATE bbvehicles SET finance = @finance WHERE plate=@plate', {
                    ['plate'] = e
                    ['@finance'] = fi
                })
            end
        end
    end)
    --RLCore.Functions.ExecuteSql(false,'UPDATE finance FROM bbvehicles WHERE ')
]]