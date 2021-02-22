-- TO USE DO exports["rl-core"]:RobberyActive() and it will return either true or false.

-- USE LIKE > local canRob = not exports["rl-core"]:RobberyActive()

-- How to trigger the timer.
-- TriggerServerEvent("rl-core:server:heistTimerSet", true, 500) -- 500 being the seconds.


-- SERVER
local debug = false -- Enable if you need to debug
local cooldownActive = false --Dont touch
local timer = 5 -- Time it takes to reset the heists
local defaultTimer = timer

-- Export to check if active
exports("RobberyActive", function()
    return cooldownActive
end)

exports("ResetTimer", function()
    cooldownActive = false
    timer = defaultTimer
end)

-- Start timer down
Citizen.CreateThread(function()
    while true do
        Wait(1500)
        if cooldownActive then
            while timer > 0 do
                Wait(1000) -- Wait 1 second
                timer = timer - 1
                if debug then
                    print("SECONDS: " .. tostring(timer))
                end
            end
            -- will run here now since timer is over
            cooldownActive = false
            timer = defaultTimer
            TriggerClientEvent("rl-core:client:RobberyCooldown", -1, cooldownActive, timer) -- Update once the cooldown is removed on all clients
        end
    end
end)

-- Set timer active
RegisterNetEvent("rl-core:server:heistTimerSet")
AddEventHandler("rl-core:server:heistTimerSet", function(bool, time)
    if debug then 
        print("heistTimerSet triggered") 
        print(cooldownActive)
    end

    cooldownActive = bool
    timer = time
    defaultTimer = time
    TriggerClientEvent("rl-core:client:RobberyCooldown", -1, bool, timer) -- Sync robbery cooldown to all clients
end)