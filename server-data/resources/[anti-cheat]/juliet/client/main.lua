 -- lenguages --
 local transs = {
     ["EN"] = {
        ["DiscordMessage_WeaponUserHadInInv"] = "The user had a blacklisted weapon in his inventory",
        ["DiscordMessage_FoundCheater"] = "Found cheater using: %s",
        ["DiscordMessage_SpectatingWho"] = "User found spectating by spectator mode",
        ["DiscordMessage_DifferentResourceCount"] = "The user had a different resource count **%s/%s**",
        ["DiscordMEssage_TriedToStop"] = "The user tried to stop a resource **%s**",
        ["DiscordMessage_GNIL"] = 'The user tried to turn the global value **_G** into nil',
        ['DiscordMessage_RegisteredBlCommand'] = 'The user registered a blacklisted command **%s**'
     },
 }
 
 -- config loader --
local acleng = "EN"
local weaponlist = {}
local weaponblacklsittoggle = false;
local weaponpunishment = "none";
local AntiSpectateData = {};
local AntiStopperData = {};
local AntiStartData = {};
local LoadedResources = 1
RegisterNetEvent("Juliet:RecieveConfig")
AddEventHandler("Juliet:RecieveConfig", function(leng, weapon, antispectate, antistopper, antistart)
    weaponlist = {};
    weaponblacklsittoggle = weapon.toggle;
    weaponlist = weapon.weaponlist;
    weaponpunishment = weapon.punishment;
    AntiSpectateData = antispectate;
    AntiStopperData = antistopper;
    AntiStartData = antistart;
end)
TriggerServerEvent("Juliet:RequestConfig")


RegisterNetEvent('Juliet:askForHeartBeat')
AddEventHandler('Juliet:askForHeartBeat', function()
    TriggerServerEvent('Juliet:GiveBackHeartBeat')
end)


RegisterNetEvent('Juliet:resourceloaded')
AddEventHandler('Juliet:resourceloaded', function()
    LoadedResources = LoadedResources + 1
end)
-- banned sprite -- 

local ShowBan = function()
    local dui = GetDuiHandle(CreateDui('https://cdn.discordapp.com/attachments/763922964982530079/785735021863501874/banned.png', 1920, 1080))
    CreateRuntimeTextureFromDuiHandle(CreateRuntimeTxd('Juliet'), 'Banned', dui)


    for i = 1, 255 / 3 do
        local alpha = math.floor(i * 3)
        DrawSprite('Juliet', 'Banned', 0.5, 0.5, 1.35, 1.35, 0, 255, 255, 255, alpha)
        Wait(0)
    end

    local timer = GetGameTimer() + 150
    while timer >= GetGameTimer() do
        DrawSprite('Juliet', 'Banned', 0.5, 0.5, 1.35, 1.35, 0, 255, 255, 255, 255)
        Wait(0)
    end

    local HasOpened = false

    for i = 1, 255 / 2 do
        if not menuvisible and not HasOpened then
            AddTextEntry(GetCurrentResourceName(), '~INPUT_VEH_FLY_ATTACK_CAMERA~ Open menu')
            DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
        else
            HasOpened = true
        end

        local alpha = math.floor(255 - i * 2)
        DrawSprite('Juliet', 'Banned', 0.5, 0.5, 1.35, 1.35, 0, 255, 255, 255, alpha)
        Wait(0)
    end
end

RegisterNetEvent("Juliet:DrawSpriteBanned")
AddEventHandler("Juliet:DrawSpriteBanned", function()
    ShowBan()
end)


-- self weapon blacklist --
Citizen.CreateThread(function()
    Citizen.Wait(5000)
    if weaponblacklsittoggle then
        while true do
            Citizen.Wait(3000)
            local userped = PlayerPedId()
            for k, v in pairs(weaponlist) do
                Citizen.Wait(40)
                if HasPedGotWeapon(userped, GetHashKey(v.id), false) and not v.allowed then
                    RemoveWeaponFromPed(userped, GetHashKey(v.id))
                    Citizen.Wait(100)
                    if weaponpunishment:lower() == "kick" then
                        TriggerServerEvent("dce48765ec56ec5bdd239de389fbd277", "Weapon blacklist", transs[acleng]["DiscordMessage_WeaponUserHadInInv"] .. ' ' .. v.id, true, false, "weapon")
                    end
                    if weaponpunishment:lower() == "ban" then
                        TriggerServerEvent("dce48765ec56ec5bdd239de389fbd277", "Weapon blacklist", transs[acleng]["DiscordMessage_WeaponUserHadInInv"] .. ' ' .. v.id, true, true, "weapon")
                    end
                    if weaponpunishment:lower() == "none" then
                        TriggerServerEvent("dce48765ec56ec5bdd239de389fbd277", "Weapon blacklist", transs[acleng]["DiscordMessage_WeaponUserHadInInv"] .. ' ' .. v.id, false, false, "weapon")
                    end
                end
            end
        end
    end
end)

local KnownNiggerCommands = {
    "chocolate",
    "pk",
    "haha",
    "lol",
    "panickey",
    "killmenu",
    "panik",
    "ssssss",
    "brutan",
    "panic",
    "brutanpremium",
    "hammafia",
    "hamhaxia",
    "redstonia",
    "hoax",
    "desudo",
    "jd",
    "ham",
    "hammafia",
    "hamhaxia",
    "redstonia",
    "hoax",
    "lua options",
    "God Mode",
    "Maestro",
    "FunCtionOk",
    "tiago",
    "lynx9_fixed",
    "SovietH4X",
    "AlkoMenu",
    "WarMenu",
    "FiveM",
    "SwagUI",
    "chocolate",
    "pk",
    "haha",
    "lol",
    "panickey",
    "killmenu",
    "panik",
    "ssssss",
    "brutanpremium",
    "panic",
    "desudo",
    "jd",
    "ham",
    "hammafia",
    "hamhaxia",
    "redstonia",
    "hoax",
    "lua options",
    "God Mode",
    "Maestro",
    "FunCtionOk"
}

local KnownDirectories = {
    {dict = "absolute", menuname = "Absolute"},
    {dict = "fm", menuname = "Fallout"},
    {dict = "rampage_tr_main", menuname = "Rampage trainer"},
    {dict = "MenyooExtras", menuname = "Menyoo trainer"},
    {dict = 'wave', menuname = 'Wave cheats'}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(6000)
        for k, v in pairs(KnownDirectories) do
            Citizen.Wait(10)
            if HasStreamedTextureDictLoaded(v.dict) then
                TriggerServerEvent("dce48765ec56ec5bdd239de389fbd277", "Injection #11", transs[acleng]["DiscordMessage_FoundCheater"]:format(v.menuname), true, true, "general")
            end
        end
        if NetworkIsInSpectatorMode() and AntiSpectateData.Toggle then
            if AntiSpectateData.Punishment:lower() == "kick" then
                TriggerServerEvent("dce48765ec56ec5bdd239de389fbd277", "Found spectating", transs[acleng]["DiscordMessage_SpectatingWho"], true, false, "general")
            end
            if AntiSpectateData.Punishment:lower() == "ban" then
                TriggerServerEvent("dce48765ec56ec5bdd239de389fbd277", "Found spectating", transs[acleng]["DiscordMessage_SpectatingWho"], true, true, "general")
            end
            if AntiSpectateData.Punishment:lower() == "none" then
                TriggerServerEvent("dce48765ec56ec5bdd239de389fbd277", "Found spectating", transs[acleng]["DiscordMessage_SpectatingWho"], false, false, "general")
            end
        end
        Citizen.Wait(1500)
        if _G == nil then
            TriggerServerEvent('dce48765ec56ec5bdd239de389fbd277', "Injection #7", transs[acleng]['DiscordMessage_GNIL'], true, true, "general")
        end
        Citizen.Wait(1500)
        for k, v in pairs(GetRegisteredCommands()) do
            for h, j in pairs(KnownNiggerCommands) do
                Citizen.Wait(1000)
                if v.name:lower() == j:lower() then
                    TriggerServerEvent("dce48765ec56ec5bdd239de389fbd277", "Injection #8", transs[acleng]["DiscordMessage_RegisteredBlCommand"]:format(v.name), false, false, "general")
                end
            end
            Citizen.Wait(50)
        end
    end
end)


    -- anti stopper --

local GetResources = function()
    local resources = {}
    for i=0, GetNumResources() do
      resources[i] = GetResourceByFindIndex(i)
    end
    return resources
end


local RSS = function(resource_name)
    if GetResourceState(resource_name) == "started" or string.upper(GetResourceState(resource_name)) == "started" or string.lower(GetResourceState(resource_name)) == "started"
     then
        return "started"
    else
        return "notstarted"
    end
end


Citizen.CreateThread(function()
    Citizen.Wait(5000)
    if AntiStopperData.Toggle then
        Citizen.Wait(2000)
        AntiStopperData.SavedResourcesSpawn = GetResources()

        AntiStopperData.SavedResourcesStatus = {};
        for k, v in pairs(AntiStopperData.SavedResourcesSpawn) do
            if RSS(v) then
                AntiStopperData.SavedResourcesStatus[v] = "started"
            else
                AntiStopperData.SavedResourcesStatus[v] = "notstarted"
            end
        end

        while true do
            Citizen.Wait(4000)
            for k, v in pairs(AntiStopperData.SavedResourcesStatus) do
                Citizen.Wait(30)
                if RSS(k) ~= v then
                    if AntiStopperData.Punishment:lower() == "kick" then
                        TriggerServerEvent("dce48765ec56ec5bdd239de389fbd277", "Anti resource stop",  transs[acleng]["DiscordMEssage_TriedToStop"]:format(k), true, false, "general", true)
                    end
                    if AntiStopperData.Punishment:lower() == "ban" then
                        TriggerServerEvent("dce48765ec56ec5bdd239de389fbd277", "Anti resource stop",  transs[acleng]["DiscordMEssage_TriedToStop"]:format(k), true, true, "general", true)
                    end
                    if AntiStopperData.Punishment:lower() == "none" then
                        TriggerServerEvent("dce48765ec56ec5bdd239de389fbd277", "Anti resource stop", transs[acleng]["DiscordMEssage_TriedToStop"]:format(k), false, false, "general", true)
                    end
                end
            end
        end
    end
end)

 -- anti starter/ anti eulen --

 Citizen.CreateThread(function()
    Citizen.Wait(5000)
    if AntiStartData.Toggle then
        local savedcount;
        savedcount = 0
        savedcount = #GetResources()
        while true do
            Citizen.Wait(5000)
            local resourcescount = #GetResources()
            if resourcescount ~= savedcount then
                if AntiStartData.Punishment:lower() == "kick" then
                    TriggerServerEvent("dce48765ec56ec5bdd239de389fbd277", "Anti resource start", transs[acleng]["DiscordMessage_DifferentResourceCount"]:format(savedcount, resourcescount), true, false, "general", true)
                end
                if AntiStartData.Punishment:lower() == "ban" then
                    TriggerServerEvent("dce48765ec56ec5bdd239de389fbd277", "Anti resource start", transs[acleng]["DiscordMessage_DifferentResourceCount"]:format(savedcount, resourcescount), true, true, "general", true)
                end
                if AntiStartData.Punishment:lower() == "none" then
                    TriggerServerEvent("dce48765ec56ec5bdd239de389fbd277", "Anti resource start", transs[acleng]["DiscordMessage_DifferentResourceCount"]:format(savedcount, resourcescount), false, false, "general", true)
                end
            end
        end
    end
 end)


function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
    local iter, id = initFunc()
    if not id or id == 0 then
      disposeFunc(iter)
      return
    end

    local enum = {handle = iter, destructor = disposeFunc}
    setmetatable(enum, entityEnumerator)

    local next = true
    repeat
      coroutine.yield(id)
      next, id = moveFunc(iter)
    until not next

    enum.destructor, enum.handle = nil, nil
    disposeFunc(iter)
    end)
end

function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

 
RegisterNetEvent('CzRqtMSNXJBbpOijaAmC:nWKMDJTmZTuVajLmeUci')
AddEventHandler('CzRqtMSNXJBbpOijaAmC:nWKMDJTmZTuVajLmeUci', function()
    for vehicle in EnumerateVehicles() do
        if not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1)) then
            SetVehicleHasBeenOwnedByPlayer(vehicle, false)
            SetEntityAsMissionEntity(vehicle, false, false)
            DeleteEntity(vehicle)
            if DoesEntityExist(vehicle) then
                DeleteEntity(vehicle)
            end
        end
    end
end)



RegisterNetEvent('klOPvMeIENUBZAYithrH:vFSaoJRAmsYlueSjPNZg')
AddEventHandler('klOPvMeIENUBZAYithrH:vFSaoJRAmsYlueSjPNZg', function()
    for pedofilis in EnumerateObjects() do
        DeleteEntity(pedofilis)
    end
end)


RegisterNetEvent('jZhvSpQGZfryDhzyJXkS:VMAticptaAduhBumkbkC')
AddEventHandler('jZhvSpQGZfryDhzyJXkS:VMAticptaAduhBumkbkC', function()
    for ped in EnumeratePeds() do
        if not IsPedAPlayer(ped) then
            RemoveAllPedWeapons(ped, true)
            DeleteEntity(ped)
        end
    end
end)


Citizen.CreateThread(function()
    Citizen.Wait(19999)
    print('Juliet loaded in ' .. LoadedResources .. ' resources')
 end)