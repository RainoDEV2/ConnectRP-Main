RLCore = nil

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if RLCore == nil then
            TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
    while true do
        local InRange = false
        local PlayerPed = GetPlayerPed(-1)
        local PlayerPos = GetEntityCoords(PlayerPed)

        for shop, _ in pairs(Config.Locations) do
            local position = Config.Locations[shop]["coords"]
            for _, loc in pairs(position) do
                local dist = GetDistanceBetweenCoords(PlayerPos, loc["x"], loc["y"], loc["z"])
                if dist < 10 then
                    InRange = true
					DrawMarker(27, loc["x"], loc["y"], loc["z"] -0.8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.001, 1.0001, 0.5001, 0, 25, 165, 100, false, true, 2, false , false, false, false)
                    if dist < 1 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
                        --DrawText3Ds(loc["x"], loc["y"], loc["z"], '[E] - ' .. Config.Locations[shop]["label"])
                        if IsControlJustPressed(0, Config.Keys["E"]) then
                            local ShopItems = {}
                            ShopItems.label = Config.Locations[shop]["label"]
                            ShopItems.items = Config.Locations[shop]["products"]
                            ShopItems.slots = 30
                            if Config.Locations[shop]["type"] == 'dede' then
                                TriggerServerEvent("inventory:server:OpenInventory", "dede", "Itemshop_"..shop, ShopItems)
                            else
                                TriggerServerEvent("inventory:server:OpenInventory", "shop", "Itemshop_"..shop, ShopItems)
                            end
                            TriggerEvent("debug", 'Shops: ' .. Config.Locations[shop]["label"], 'success')
                        end
                    end
                end
            end
        end

        if not InRange then
            Citizen.Wait(5000)
        end
        Citizen.Wait(5)
    end
end)

RegisterNetEvent('rl-shops:client:UpdateShop')
AddEventHandler('rl-shops:client:UpdateShop', function(shop, itemData, amount)
    TriggerServerEvent('rl-shops:server:UpdateShopItems', shop, itemData, amount)
    TriggerEvent("debug", 'Shops: Updated', 'success')
end)

RegisterNetEvent('rl-shops:client:SetShopItems')
AddEventHandler('rl-shops:client:SetShopItems', function(shop, shopProducts)
    Config.Locations[shop]["products"] = shopProducts
end)

RegisterNetEvent('rl-shops:client:RestockShopItems')
AddEventHandler('rl-shops:client:RestockShopItems', function(shop, amount)
    if Config.Locations[shop]["products"] ~= nil then 
        for k, v in pairs(Config.Locations[shop]["products"]) do 
            Config.Locations[shop]["products"][k].amount = Config.Locations[shop]["products"][k].amount + amount
        end
    end
end)

Citizen.CreateThread(function()
    for store,_ in pairs(Config.Locations) do
        StoreBlip = AddBlipForCoord(Config.Locations[store]["coords"][1]["x"], Config.Locations[store]["coords"][1]["y"], Config.Locations[store]["coords"][1]["z"])
        SetBlipColour(StoreBlip, 0)

        if Config.Locations[store]["products"] == Config.Products["normal"] then
            SetBlipSprite(StoreBlip, 52)
            SetBlipScale(StoreBlip, 0.7)
            SetBlipColour(StoreBlip, 2)
        elseif Config.Locations[store]["products"] == Config.Products["hardware"] then
            SetBlipSprite(StoreBlip, 52)
            SetBlipScale(StoreBlip, 0.7)
            SetBlipColour(StoreBlip, 2)
        elseif Config.Locations[store]["products"] == Config.Products["gsgasoline"] then
            SetBlipSprite(StoreBlip, 52)
            SetBlipScale(StoreBlip, 0.7)
            SetBlipColour(StoreBlip, 2)
        elseif Config.Locations[store]["products"] == Config.Products["casinohb"] then
            SetBlipSprite(StoreBlip, 431)
            SetBlipScale(StoreBlip, 0.7)
            SetBlipColour(StoreBlip, 5)
        elseif Config.Locations[store]["products"] == Config.Products["coffeelounge"] then
            SetBlipSprite(StoreBlip, 89)
            SetBlipScale(StoreBlip, 0.7)
            SetBlipColour(StoreBlip, 16)
        elseif Config.Locations[store]["products"] == Config.Products["casino"] then
            SetBlipSprite(StoreBlip, 207)
            SetBlipScale(StoreBlip, 0.5)
            SetBlipColour(StoreBlip, 2)
        elseif Config.Locations[store]["products"] == Config.Products["weapons"] then
            SetBlipSprite(StoreBlip, 110)
            SetBlipScale(StoreBlip, 0.85)
            SetBlipColour(StoreBlip, 17)                     
        elseif Config.Locations[store]["products"] == Config.Products["coffeeshop"] then
            SetBlipSprite(StoreBlip, 140)
            SetBlipScale(StoreBlip, 0.7)
        end

        SetBlipDisplay(StoreBlip, 4)
        SetBlipAsShortRange(StoreBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.Locations[store]["label"])
        EndTextCommandSetBlipName(StoreBlip)
    end
end)