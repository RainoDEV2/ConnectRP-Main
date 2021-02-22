-- TO USE DO exports["rl-core"]:RobberyActive() and it will return either true or false.

-- CLIENT
local cooldownActive = false
local timer = 0

-- Export to check if active
exports("RobberyActive", function()
    return cooldownActive
end)

RegisterNetEvent("rl-core:client:RobberyCooldown")
AddEventHandler("rl-core:client:RobberyCooldown", function(bool, time)
    cooldownActive = bool
    timer = time
end)










