RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterNetEvent("platecheck:checkLicensePlate")
AddEventHandler("platecheck:checkLicensePlate", function(plate, model)
    local src = source

    if not plate or plate == "No Lock" then
        return
    end

    RLCore.Functions.ExecuteSql(true, "SELECT * FROM `bbvehicles` WHERE `plate`='" .. plate .. "'", function(result)
        local owner = "Unknown"
        if (result and result[1] and result[1].citizenid) then
            owner = result[1].citizenid
        end

        TriggerClientEvent('chat:addMessage', src, {
            template = '<div class="chat-message server"><strong>Vehicle Scanner:</strong> <br>Plate: ' .. plate .. '<br>Model: ' .. model .. '<br>Owner CID: ' .. owner .. '</div>',
            args = {}
        })
    end)
end)