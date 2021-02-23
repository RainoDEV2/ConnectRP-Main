local cruiseOn = false
local Speed = 0.0
local cruiseSpeed = 0.0
local lastVehicle = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(7)
        if IsPedInAnyVehicle(PlayerPedId()) then
            Speed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId()))

            if IsControlJustReleased(0, Keys["Z"]) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then 
                if IsPedInAnyVehicle(PlayerPedId()) then
                    cruiseSpeed = Speed
                    if cruiseOn then
                        RLCore.Functions.Notify("Limiter switched off!")
                    else
                        RLCore.Functions.Notify("Limiter set to "..tostring(math.floor(cruiseSpeed * 3.6)).."km/h")
                    end
                    TriggerEvent("seatbelt:client:ToggleCruise")
                end
            end
        elseif lastVehicle ~= nil then
            local maxSpeed = GetVehicleHandlingFloat(lastVehicle,"CHandlingData","fInitialDriveMaxFlatVel")
            SetEntityMaxSpeed(lastVehicle, maxSpeed)
            lastVehicle = nil
            Citizen.Wait(1500)
        end
    end
end)

RegisterNetEvent("seatbelt:client:ToggleCruise")
AddEventHandler("seatbelt:client:ToggleCruise", function()
    cruiseOn = not cruiseOn
    local maxSpeed = cruiseOn and cruiseSpeed or GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(), false),"CHandlingData","fInitialDriveMaxFlatVel")
    SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), maxSpeed)
    lastVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
end)