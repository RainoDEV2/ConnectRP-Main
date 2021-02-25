local Models = {}
local Zones = {}

Citizen.CreateThread(function()
    RegisterKeyMapping("+playerTarget", "Player Targeting", "keyboard", "LMENU") --Removed Bind System and added standalone version
    RegisterCommand('+playerTarget', playerTargetEnable, false)
    RegisterCommand('-playerTarget', playerTargetDisable, false)
    TriggerEvent("chat:removeSuggestion", "/+playerTarget")
    TriggerEvent("chat:removeSuggestion", "/-playerTarget")
end)

function playerTargetEnable()
    if success then return end
    if IsPedArmed(PlayerPedId(), 6) then return end
    if IsPedInAnyVehicle(PlayerPedId()) then return end

    targetActive = true

    SendNUIMessage({response = "openTarget"})

    while targetActive do
        local plyCoords = GetEntityCoords(GetPlayerPed(-1))
        local hit, coords, entity = RayCastGamePlayCamera(20.0)

        if hit == 1 then
            if GetEntityType(entity) ~= 0 then
                for _, model in pairs(Models) do
                    if _ == GetEntityModel(entity) then
                        if #(plyCoords - coords) <= Models[_]["distance"] then

                            success = true

                            SendNUIMessage({response = "validTarget", data = Models[_]["options"]})

                            while success and targetActive do
                                local plyCoords = GetEntityCoords(GetPlayerPed(-1))
                                local hit, coords, entity = RayCastGamePlayCamera(20.0)

                                DisablePlayerFiring(PlayerPedId(), true)

                                if (IsControlJustReleased(0, 24) or IsDisabledControlJustReleased(0, 24)) then
                                    SetNuiFocus(true, true)
                                    SetCursorLocation(0.5, 0.5)
                                end

                                if GetEntityType(entity) == 0 or #(plyCoords - coords) > Models[_]["distance"] then
                                    success = false
                                end

                                Citizen.Wait(1)
                            end
                            SendNUIMessage({response = "leftTarget"})
                        end
                    end
                end
            end

            for _, zone in pairs(Zones) do
                if Zones[_]:isPointInside(coords) then
                    if #(plyCoords - Zones[_].center) <= zone["targetoptions"]["distance"] then

                        success = true

                        SendNUIMessage({response = "validTarget", data = Zones[_]["targetoptions"]["options"]})

                        while success and targetActive do
                            local plyCoords = GetEntityCoords(GetPlayerPed(-1))
                            local hit, coords, entity = RayCastGamePlayCamera(20.0)

                            DisablePlayerFiring(PlayerPedId(), true)

                            if (IsControlJustReleased(0, 24) or IsDisabledControlJustReleased(0, 24)) then
                                SetNuiFocus(true, true)
                                SetCursorLocation(0.5, 0.5)
                            end
                            
                            if not Zones[_]:isPointInside(coords) or #(plyCoords - Zones[_].center) > zone.targetoptions.distance then
                                success = false
                            end

                            Citizen.Wait(1)
                        end
                        SendNUIMessage({response = "leftTarget"})
                    end
                end
            end
        end
        Citizen.Wait(250)
    end
end

function playerTargetDisable()
    if success then return end

    targetActive = false

    SendNUIMessage({response = "closeTarget"})
end

--NUI CALL BACKS

RegisterNUICallback('selectTarget', function(data, cb)
    SetNuiFocus(false, false)

    success = false

    targetActive = false

    TriggerEvent(data.event)
end)

RegisterNUICallback('closeTarget', function(data, cb)
    SetNuiFocus(false, false)

    success = false

    targetActive = false
end)

--Functions from https://forum.cfx.re/t/get-camera-coordinates/183555/14

function RotationToDirection(rotation)
    local adjustedRotation =
    {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction =
    {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

function RayCastGamePlayCamera(distance)
    local cameraRotation = GetGameplayCamRot()
    local cameraCoord = GetGameplayCamCoord()
    local direction = RotationToDirection(cameraRotation)
    local destination =
    {
        x = cameraCoord.x + direction.x * distance,
        y = cameraCoord.y + direction.y * distance,
        z = cameraCoord.z + direction.z * distance
    }
    local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 0))
    return b, c, e
end

--Exports

function AddCircleZone(name, center, radius, options, targetoptions)
    Zones[name] = CircleZone:Create(center, radius, options)
    Zones[name].targetoptions = targetoptions
end

function AddBoxZone(name, center, length, width, options, targetoptions)
    Zones[name] = BoxZone:Create(center, length, width, options)
    Zones[name].targetoptions = targetoptions
end

function AddPolyzone(name, points, options, targetoptions)
    Zones[name] = PolyZone:Create(points, options)
    Zones[name].targetoptions = targetoptions
end

function AddTargetModel(models, parameteres)
    for _, model in pairs(models) do
        Models[model] = parameteres
    end
end

exports("AddCircleZone", AddCircleZone)

exports("AddBoxZone", AddBoxZone)

exports("AddPolyzone", AddPolyzone)

exports("AddTargetModel", AddTargetModel)


Citizen.CreateThread(function()
    local peds = {
        `a_f_m_bevhills_02`,
    }
    AddTargetModel(peds, {
        options = {
            {
                event = "Random 1event",
                icon = "fas fa-dumpster",
                label = "Random 1",
            },
            {
                event = "Random 2event",
                icon = "fas fa-dumpster",
                label = "Random 2",
            },
            {
                event = "Random 3event",
                icon = "fas fa-dumpster",
                label = "Random 3",
            },
            {
                event = "Random 4event",
                icon = "fas fa-dumpster",
                label = "Random 4",
            },
        },
        distance = 2.5
    })

    local coffee = {
        690372739,
    }
    AddTargetModel(coffee, {
        options = {
            {
                event = "coffeeevent",
                icon = "fas fa-coffee",
                label = "Coffee",
            },
        },
        distance = 2.5
    })
    
    AddBoxZone("PoliceDuty", vector3(441.79, -982.07, 30.69), 0.4, 0.6, {
	name="PoliceDuty",
	heading=91,
	debugPoly=false,
	minZ=30.79,
	maxZ=30.99
    }, {
        options = {
            {
                event = "signon",
                icon = "far fa-clipboard",
                label = "Sign On",
            },
            {
                event = "signoff",
                icon = "far fa-clipboard",
                label = "Sign Off",
            },
        },
        distance = 1.5
    })
    --BurgerShot
    AddBoxZone("BurgerTray", vector3(-1193.86, -894.379, 14.01), 0.4, 0.6, {
	name="BurgerTray",
	heading=138,
	debugPoly=false,
	minZ=14.00,
	maxZ=14.15
    }, {
        options = {
            {
                event = "inventory:OpenInventoryBurger",
                icon = "far fa-clipboard",
                label = "Grab food",
            },
        },
        distance = 1.5
    })

    --Taco
    AddBoxZone("TacoTray", vector3(10.298, -1605.146, 29.53), 3.0, 2.5, {
        name="TacoTray",
        heading=-141,
        debugPoly=false,
        minZ=29.50,
        maxZ=29.73
        }, {
            options = {
                {
                    event = "inventory:OpenInventoryTaco",
                    icon = "far fa-clipboard",
                    label = "Grab food",
                },
            },
            distance = 2.5
        })
end)

local other = {}
other.maxweight = 25000
other.slots = 5

RegisterNetEvent("inventory:OpenInventoryBurger")
AddEventHandler("inventory:OpenInventoryBurger", function()
	TriggerServerEvent("inventory:server:OpenInventory", "stash", "burger", other)
    TriggerEvent("inventory:client:SetCurrentStash", "burger")
end)

RegisterNetEvent("inventory:OpenInventoryTaco")
AddEventHandler("inventory:OpenInventoryTaco", function()
	TriggerServerEvent("inventory:server:OpenInventory", "stash", "taco", other)
    TriggerEvent("inventory:client:SetCurrentStash", "taco")
end)

-- Irish Bar JukeBox

xSound = exports.xsound

DrawText3D = function(x, y, z, text)
	local onScreen, _x,_y = World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local scale = 0.30
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
	end
end



local musicId
local playing = false
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    musicId = "music_id_" .. PlayerPedId()
    local pos
    while true do
        Citizen.Wait(100)
        if xSound:soundExists(musicId) and playing then
            if xSound:isPlaying(musicId) then
                pos = GetEntityCoords(PlayerPedId())
                TriggerServerEvent("myevent:soundStatus", "position", musicId, { position = pos })
            else
                Citizen.Wait(1000)
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

RegisterNetEvent("myevent:soundStatus")
AddEventHandler("myevent:soundStatus", function(type, musicId, data)
    if type == "position" then
        if xSound:soundExists(musicId) then
            xSound:Position(musicId, data.position)
        end
    end

    if type == "play" then
        xSound:PlayUrlPos(musicId, data.link, 1, data.position, false)
        xSound:Distance(musicId, 20)
        xSound:setVolumeMax(musicId,0.1)
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local post = GetEntityCoords(ped)
        local spawnplek = "JukeBox"
        local InVehicle = IsPedInAnyVehicle(ped, false)

        local distance = GetDistanceBetweenCoords(post.x, post.y, post.z, 840.73089, -118.1886, 79.774665, true)
        
        if distance < 1.5 then
            if distance < 15.0 then
                if not InVehicle then
                    DrawText3D(840.73089, -118.1886, 79.774665, "[E] Play a song")
                    if IsControlJustReleased(0, 38) then
                        local pos = vector3(838.3164, -110.9021, 79.774673)
                        playing = true
                        -- copuright free background
                        local math = math.random(1,60)
                        if math <= 10 then
                            TriggerServerEvent("myevent:soundStatus", "play", musicId, { position = pos, link = "https://www.youtube.com/watch?v=IwBYlLnzYtc" })
                        elseif math <= 20 then 
                            TriggerServerEvent("myevent:soundStatus", "play", musicId, { position = pos, link = "https://www.youtube.com/watch?v=7AapRSeRo7s" })
                        elseif math <= 30 then
                            TriggerServerEvent("myevent:soundStatus", "play", musicId, { position = pos, link = "https://www.youtube.com/watch?v=G6VOT0V4jaU" })
                        elseif math <= 40 then
                            TriggerServerEvent("myevent:soundStatus", "play", musicId, { position = pos, link = "https://www.youtube.com/watch?v=NZ0ErjrKqmY" })
                        elseif math <= 50 then
                            TriggerServerEvent("myevent:soundStatus", "play", musicId, { position = pos, link = "https://www.youtube.com/watch?v=yE9Zn9b__9o" })
                        elseif math <= 60 then
                            TriggerServerEvent("myevent:soundStatus", "play", musicId, { position = pos, link = "https://www.youtube.com/watch?v=NBo_frdI_2g" })
                        end
                    end
                end
            end
        end
        Citizen.Wait(1)
    end
end)