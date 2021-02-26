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

-- code

local isLoggedIn = false 

RegisterNetEvent('RLCore:Client:OnPlayerLoaded')
AddEventHandler('RLCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

Citizen.CreateThread(function()
    while true do
        local InRange = false
        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)
        
            local dist = GetDistanceBetweenCoords(PlayerPos, 1116.2709, 218.53176, -49.43515)
            if dist < 10 then
                InRange = true
                DrawMarker(2, 1116.2709, 218.53176, -49.43515, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.2, 0.1, 255, 0, 0, 155, 0, 0, 0, 1, 0, 0, 0)
                if dist < 1 then
                    DrawText3Ds(1116.2709, 218.53176, -49.43515 + 0.15, '[E] Sell chips')
                    if IsControlJustPressed(0, Config.Keys["E"]) then
                        TriggerServerEvent('rl-casino:sharlock:sell')
                    end
                end
            end

        if not InRange then
            Citizen.Wait(5000)
        end
        Citizen.Wait(5)
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


-- all credits goes to Sharlock and Lua Leaks
-- https://www.twitch.tv/Sharlock Lua Leaks | discord.gg/Ngx5M6S

local inCasino = false
local carOnShow = `bdragon`
local polyEntryTimeout = false
local enterFirstTime = true
local entranceTeleportCoords = vector3(1089.73,206.36,-48.99 + 0.05)
local exitTeleportCoords = vector3(934.46, 45.83, 81.1 + 0.05)

local spinningObject = nil
local spinningCar = nil

-- CAR FOR WINS
function drawCarForWins()
  if DoesEntityExist(spinningCar) then
    DeleteEntity(spinningCar)
  end
  RequestModel(carOnShow)
  while not HasModelLoaded(carOnShow) do
	Citizen.Wait(0)
  end
  SetModelAsNoLongerNeeded(carOnShow)
  spinningCar = CreateVehicle(carOnShow, 1100.0, 220.0, -51.0 + 0.08, 0.0, 0, 0)
  Wait(0)
  SetVehicleDirtLevel(spinningCar, 0.0)
  SetVehicleOnGroundProperly(spinningCar)
  SetVehicleColours(spinningCar, 1, 1)
  Wait(0)
  FreezeEntityPosition(spinningCar, 1)
end

RegisterNetEvent("casino:client:enter")
AddEventHandler("casino:client:enter", function()
	enterCasino(zone == "casino_entrance", false, entranceTeleportCoords, heading)
end)

function enterCasino(pIsInCasino, pFromElevator, pCoords, pHeading)
    inCasino = true --Start process
    if DoesEntityExist(spinningCar) then
        DeleteEntity(spinningCar)
    end
    local function doInitStuff()
        spinMeRightRoundBaby()
        showDiamondsOnScreenBaby()
        playSomeBackgroundAudioBaby()
    end
    if not pFromElevator then
        DoScreenFadeOut(500)
        Wait(500)
        NetworkFadeOutEntity(PlayerPedId(), true, true)
        Wait(300)
        SetPedCoordsKeepVehicle(PlayerPedId(), pCoords)
        SetEntityHeading(PlayerPedId(), pHeading)
        Citizen.CreateThread(function()
        Citizen.Wait(500)
        SetPedCoordsKeepVehicle(PlayerPedId(), exitTeleportCoords)
        Citizen.Wait(500)
        SetPedCoordsKeepVehicle(PlayerPedId(), entranceTeleportCoords)
        handlePedCoordsBaby(pedCoords)
        Citizen.Wait(800)

        ClearPedTasksImmediately(PlayerPedId())
        SetGameplayCamRelativeHeading(0.0)
        NetworkFadeInEntity(PlayerPedId(), true)
        if inCasino then
            doInitStuff()
        end
        Citizen.Wait(500)
        DoScreenFadeIn(500)
        end)
    end

    

    TriggerEvent("np-casino:casinoEnteredEvent")
end

function spinMeRightRoundBaby()
  Citizen.CreateThread(function()
    while inCasino do
      if not spinningObject or spinningObject == 0 or not DoesEntityExist(spinningObject) then
        spinningObject = GetClosestObjectOfType(1100.0, 220.0, -51.0, 10.0, -1561087446, 0, 0, 0)
        drawCarForWins()
      end
      if spinningObject ~= nil and spinningObject ~= 0 then
        local curHeading = GetEntityHeading(spinningObject)
        local curHeadingCar = GetEntityHeading(spinningCar)
        if curHeading >= 360 then
          curHeading = 0.0
          curHeadingCar = 0.0
        elseif curHeading ~= curHeadingCar then
          curHeadingCar = curHeading
        end
        SetEntityHeading(spinningObject, curHeading + 0.075)
        SetEntityHeading(spinningCar, curHeadingCar + 0.075)
      end
      Wait(0)
    end
    spinningObject = nil
  end)
end

-- Casino Screens
local Playlists = {
  "CASINO_DIA_PL", -- diamonds
  "CASINO_SNWFLK_PL", -- snowflakes
  "CASINO_WIN_PL", -- win
  "CASINO_HLW_PL", -- skull
}
-- Render
function CreateNamedRenderTargetForModel(name, model)
  local handle = 0
  if not IsNamedRendertargetRegistered(name) then
      RegisterNamedRendertarget(name, 0)
  end
  if not IsNamedRendertargetLinked(model) then
      LinkNamedRendertarget(model)
  end
  if IsNamedRendertargetRegistered(name) then
      handle = GetNamedRendertargetRenderId(name)
  end

  return handle
end
-- render tv stuff
function showDiamondsOnScreenBaby()
  Citizen.CreateThread(function()
    local model = GetHashKey("vw_vwint01_video_overlay")
    local timeout = 21085 -- 5000 / 255

    local handle = CreateNamedRenderTargetForModel("CasinoScreen_01", model)

    RegisterScriptWithAudio(0)
    SetTvChannel(-1)
    SetTvVolume(0)
    SetScriptGfxDrawOrder(4)
    SetTvChannelPlaylist(2, "CASINO_DIA_PL", 0)
    SetTvChannel(2)
    EnableMovieSubtitles(1)

    function doAlpha()
      Citizen.SetTimeout(timeout, function()
        SetTvChannelPlaylist(2, "CASINO_DIA_PL", 0)
        SetTvChannel(2)
        doAlpha()
      end)
    end
    doAlpha()

    Citizen.CreateThread(function()
      while inCasino do
        SetTextRenderId(handle)
        DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
        SetTextRenderId(GetDefaultScriptRendertargetRenderId())
        Citizen.Wait(0)
      end
      SetTvChannel(-1)
      ReleaseNamedRendertarget(GetHashKey("CasinoScreen_01"))
      SetTextRenderId(GetDefaultScriptRendertargetRenderId())
    end)
  end)
end

function playSomeBackgroundAudioBaby()
  Citizen.CreateThread(function()
    local function audioBanks()
      while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_GENERAL", false, -1) do
        Citizen.Wait(0)
      end
      while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_01", false, -1) do
        Citizen.Wait(0)
      end
      while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_02", false, -1) do
        Citizen.Wait(0)
      end
      while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_03", false, -1) do
        Citizen.Wait(0)
      end
      -- while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_INTERIOR_STEMS", false, -1) do
      --   print('load 5')
      --   Wait(0)
      -- end
    end
    audioBanks()
    while inCasino do
      if not IsStreamPlaying() and LoadStream("casino_walla", "DLC_VW_Casino_Interior_Sounds") then
        PlayStreamFromPosition(1111, 230, -47)
      end
      if IsStreamPlaying() and not IsAudioSceneActive("DLC_VW_Casino_General") then
        StartAudioScene("DLC_VW_Casino_General")
      end
      Citizen.Wait(1000)
    end
    if IsStreamPlaying() then
      StopStream()
    end
    if IsAudioSceneActive("DLC_VW_Casino_General") then
      StopAudioScene("DLC_VW_Casino_General")
    end
  end)
end

local myPeds = {}
function handlePedCoordsBaby(pPedCoords)
  if not pPedCoords or not inCasino then return end
  for _, pedData in pairs(pPedCoords) do
    RequestModel(pedData.model)
    while not HasModelLoaded(pedData.model) do
      Wait(0)
    end
    SetModelAsNoLongerNeeded(pedData.model)
    local ped = CreatePed(pedData._pedType, pedData.model, pedData.coords, pedData.heading, 1, 1)
    while not DoesEntityExist(ped) do
      Wait(0)
    end
    SetPedRandomComponentVariation(ped, 0)
    local pedNetId = 0
    while NetworkGetNetworkIdFromEntity(ped) == 0 do
      Wait(0)
    end
    TaskSetBlockingOfNonTemporaryEvents(ped, true)
    pedNetId = NetworkGetNetworkIdFromEntity(ped)
    SetNetworkIdCanMigrate(ped, true)
    myPeds[#myPeds + 1] = { entity = ped, scenario = pedData.scenario, netId = pedNetId }
    Wait(0)
  end
  RPC.execute("np-casino:handoffPedData", myPeds)
  Citizen.CreateThread(function()
    while inCasino do
      for _, ped in pairs(myPeds) do
        if math.random() < 0.01 then
          TaskWanderStandard(ped.entity)
        elseif not IsPedActiveInScenario(ped.entity) then
          ClearPedTasks(ped.entity)
          TaskStartScenarioInPlace(ped.entity, ped.scenario, 0, 1)
        end
      end
      Wait(15000)
    end
  end)
  -- debug
  -- Citizen.CreateThread(function()
  --   while inCasino do
  --     for _, ped in pairs(myPeds) do
  --       if #(GetEntityCoords(ped.entity) - GetEntityCoords(PlayerPedId())) < 1.2 then
  --         print(ped.entity, ped.scenario)
  --       end
  --     end
  --     Wait(1000)
  --   end
  -- end)
end

-- luccky wheel
--[[ local _wheel = nil
local _lambo = nil
local _isShowCar = false
local _wheelPos = vector3(1109.76, 227.89, -49.64)
local _baseWheelPos = vector3(1111.05, 229.81, -50.38)
local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}
local _isRolling = false

Citizen.CreateThread(function()

    if RLCore then
        local model = GetHashKey('vw_prop_vw_luckywheel_02a')
        local baseWheelModel GetHashKey('vw_prop_vw_luckywheel_01a')
        local carmodel = GetHashKey('lp700r')

        Citizen.CreateThread(function()
            -- Base wheel
            RequestModel(baseWheelModel)
            while not HasModelLoaded(baseWheelModel) do
                Citizen.Wait(0)
            end

            _basewheel = CreateObject(baseWheelModel, _baseWheelPos.x, _baseWheelPos.y, _baseWheelPos.z, false, false, true)
            SetEntityHeading(_basewheel, 0.0)
            SetModelAsNoLongerNeeded(baseWheelModel)

            -- Wheel
            RequestModel(model)

            while not HasModelLoaded(model) do
                Citizen.Wait(0)
            end

            _wheel = CreateObject(model, 1111.05, 229.81, -50.38, false, false, true)
            SetEntityHeading(_wheel, 0.0)
            SetModelAsNoLongerNeeded(model)
            
        end)
    end
end)

Citizen.CreateThread(function() 
    while true do
        if _lambo ~= nil then
            local _heading = GetEntityHeading(_lambo)
            local _z = _heading - 0.3
            SetEntityHeading(_lambo, _z)
        end
        Citizen.Wait(5)
    end
end)

RegisterNetEvent("esx_tpnrp_luckywheel:doRoll")
AddEventHandler("esx_tpnrp_luckywheel:doRoll", function(_priceIndex) 
    _isRolling = true
    SetEntityHeading(_wheel, -30.0)
    SetEntityRotation(_wheel, 0.0, 0.0, 0.0, 1, true)
    Citizen.CreateThread(function()
        local speedIntCnt = 1
        local rollspeed = 1.0
        -- local _priceIndex = math.random(1, 20)
        local _winAngle = (_priceIndex - 1) * 18
        local _rollAngle = _winAngle + (360 * 8)
        local _midLength = (_rollAngle / 2)
        local intCnt = 0
        while speedIntCnt > 0 do
            local retval = GetEntityRotation(_wheel, 1)
            if _rollAngle > _midLength then
                speedIntCnt = speedIntCnt + 1
            else
                speedIntCnt = speedIntCnt - 1
                if speedIntCnt < 0 then
                    speedIntCnt = 0
                    
                end
            end
            intCnt = intCnt + 1
            rollspeed = speedIntCnt / 10
            local _y = retval.y - rollspeed
            _rollAngle = _rollAngle - rollspeed
            -- if _rollAngle < 5.0 then
            --     if _y > _winAngle then
            --         _y = _winAngle
            --     end
            -- end
            SetEntityRotation(_wheel, 0.0, _y, 0.0, 1, true)
            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent("esx_tpnrp_luckywheel:rollFinished")
AddEventHandler("esx_tpnrp_luckywheel:rollFinished", function() 
    _isRolling = false
end)


function doRoll()
    if not _isRolling then
        _isRolling = true
        local playerPed = PlayerPedId()
        local _lib = 'anim_casino_a@amb@casino@games@lucky7wheel@female'
        if IsPedMale(playerPed) then
            _lib = 'anim_casino_a@amb@casino@games@lucky7wheel@male'
        end
        local lib, anim = _lib, 'enter_right_to_baseidle'
        --ESX.Streaming.RequestAnimDict(lib, function() 
            local _movePos = vector3(1109.55, 228.88, -49.64)
            TaskGoStraightToCoord(playerPed,  _movePos.x,  _movePos.y,  _movePos.z,  1.0,  -1,  312.2,  0.0)
            local _isMoved = false
            while not _isMoved do
                local coords = GetEntityCoords(PlayerPedId())
                if coords.x >= (_movePos.x - 0.01) and coords.x <= (_movePos.x + 0.01) and coords.y >= (_movePos.y - 0.01) and coords.y <= (_movePos.y + 0.01) then
                    _isMoved = true
                end
                Citizen.Wait(0)
            end
            TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
                    Citizen.Wait(0)
                    DisableAllControlActions(0)
            end
            TaskPlayAnim(playerPed, lib, 'enter_to_armraisedidle', 8.0, -8.0, -1, 0, 0, false, false, false)
            while IsEntityPlayingAnim(playerPed, lib, 'enter_to_armraisedidle', 3) do
                Citizen.Wait(0)
                DisableAllControlActions(0)
            end
            TriggerServerEvent("esx_tpnrp_luckywheel:getLucky")
            TaskPlayAnim(playerPed, lib, 'armraisedidle_to_spinningidle_high', 8.0, -8.0, -1, 0, 0, false, false, false)
        --end)
    end
end

-- Menu Controls
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1)
        local coords = GetEntityCoords(PlayerPedId())

        if(GetDistanceBetweenCoords(coords, _wheelPos.x, _wheelPos.y, _wheelPos.z, true) < 1.5) and not _isRolling then
            --ESX.ShowHelpNotification("Bấm E để thử vận may với Vòng Quay 1 lần 100,000$")
            if IsControlJustReleased(0, Keys['E']) then
                doRoll()
            end
        end		
	end
end)
 ]]