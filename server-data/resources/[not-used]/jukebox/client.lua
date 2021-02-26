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