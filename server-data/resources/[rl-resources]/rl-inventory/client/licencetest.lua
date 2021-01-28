RLCore = nil
Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if RLCore == nil then
            TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)    
            Citizen.Wait(200)
        else
            print('---- Licence Test ----')
            CheckForLicence1()
            Citizen.Wait(200)
            CheckForLicence2()
            Citizen.Wait(200)
            CheckForLicence3()
            --CheckForAllLicences()
            Citizen.Wait(2000)
        end
    end
end)

function CheckForLicence1()
    RLCore.Functions.TriggerCallback('nigger-callback', function(result, type)
        local k;
        if result == 0 then
            k = 'no licence'
        elseif result == 1 then
            k = 'has licence'
        elseif result == 2 then
            k = 'revoked'
        end
        print(k, 'driver')
    end, 'driver')
end

function CheckForLicence2()
    RLCore.Functions.TriggerCallback('nigger-callback', function(result, type)
        local k;
        if result == 0 then
            k = 'no licence'
        elseif result == 1 then
            k = 'has licence'
        elseif result == 2 then
            k = 'revoked'
        end
        print(k, 'weapon1')
    end, 'weapon1')
end

function CheckForLicence3()
    RLCore.Functions.TriggerCallback('nigger-callback', function(result, type)
        local k;
        if result == 0 then
            k = 'no licence'
        elseif result == 1 then
            k = 'has licence'
        elseif result == 2 then
            k = 'revoked'
        end
        print(k, 'weapon2')
    end, 'weapon2')
end


function CheckForAllLicences()
    RLCore.Functions.TriggerCallback('nigger-callback-test', function(result)
        print(json.encode(result))
    end)
end