local carorder = {
    [1] = {name = 'POLVIC2', x = 437.70855, y = -986.0989, z = 25.377687, h = 90.793922, handel = nil},
    [2] = {name = 'POLTAURUS', x = 437.70425, y = -988.8076, z = 25.264362, h = 91.674201, handel = nil},
    [3] = {name = 'POLCHAR', x = 437.70358, y = -991.5166, z = 25.393491, h = 90.150108, handel = nil},
    [4] = {name = '2015POLSTANG', x = 437.3215, y = -994.0807, z = 24.989467, h = 89.558151, handel = nil},
    [5] = {name = 'POLTAH', x = 437.49325, y = -996.7955, z = 25.227069, h = 91.912986, handel = nil},
}

local parking = {
    pullout = {x = 431.25741, y = -990.1937, z = 25.287361, h = 178.50997},
    putaway = {x = 452.40509, y = -991.1527, z = 25.287998, h = 359.06387},
    gaycar = nil,
}

RLCore = nil

Citizen.CreateThread(function()
    while RLCore == nil do
		TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
		Citizen.Wait(10)
    end
    while true do
        local ppos = GetEntityCoords(PlayerPedId(), false)
        local dist1 = GetDistanceBetweenCoords(parking.putaway.x, parking.putaway.y, parking.putaway.z, ppos.x, ppos.y, ppos.z, true)
        if dist1 <= 7.5 and IsPedInAnyVehicle(PlayerPedId(), false) then
            DrawMarker(2, parking.putaway.x, parking.putaway.y, parking.putaway.z + 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
            if IsControlJustPressed(0, 38) and dist1 <= 1.5 then
                parking.gaycar = GetVehiclePedIsIn(PlayerPedId(), false)
                TaskLeaveVehicle(PlayerPedId(), parking.gaycar, 64)
                Citizen.Wait(2000)
                DeleteEntity(parking.gaycar)
            end
        end
        for k, v in pairs(carorder) do
            if DoesEntityExist(v.handel) then
                local cpos = GetEntityCoords(v.handel, false)
                local dist2 = GetDistanceBetweenCoords(cpos.x - 2.5, cpos.y, cpos.z + 0.5, ppos.x, ppos.y, ppos.z, true)
                if dist2 <= 1 then
                    DrawText3Ds(cpos.x - 2.5, cpos.y, cpos.z + 0.5, 'Press [E] To Drive!')
                    if IsControlJustPressed(0, 38) then
                        TriggerServerEvent('rl:police:garage:jobcheck', v.name)
                    end
                end
            else
                while not HasModelLoaded(GetHashKey(v.name)) do
                    RequestModel(GetHashKey(v.name))
                    Wait(1)
                end
                v.handel = CreateVehicle(GetHashKey(v.name), v.x, v.y, v.z, v.h, false, true)
                SetEntityAsMissionEntity(v.handel, true, true)
                SetEntityInvincible(v.handel, true)
                FreezeEntityPosition(v.handel, true)
                SetVehicleDoorsLocked(v.handel, 2)
                SetVehicleLivery(v.handel, 1)
            end
        end
        Citizen.Wait(0)
    end
end)

function DrawText3Ds(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x,y,z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent('rl:police:garage:jobcheck:back')
AddEventHandler('rl:police:garage:jobcheck:back', function(name, can)
    if can == 1 then
        local v = CreateVehicle(GetHashKey(name), parking.pullout.x, parking.pullout.y, parking.pullout.z, parking.pullout.h, true, true)
        SetPedIntoVehicle(PlayerPedId(), v, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(v), v)
    elseif can == 2
        RLCore.Functions.Notify("Your Too Low Of A Rank To Drive This!", "error")
    elseif can == 3
        RLCore.Functions.Notify("Your Not A Police Officer!", "error")
    end
end)