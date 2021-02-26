RLCore = nil
local _wheel = nil
local _lambo = nil
local _isShowCar = false
local _wheelPos = vector3(1111.052, 229.849, -50.64)


local _baseWheelPos = vector3(1111.052, 229.849, -50.64)
local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}
local _isRolling = false


Citizen.CreateThread(function() 
    while true do 
        Citizen.Wait(10)
        if RLCore == nil then
            TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

local model = GetHashKey('vw_prop_vw_luckywheel_02a')
local baseWheelModel = GetHashKey('vw_prop_vw_luckywheel_01a')

Citizen.CreateThread(function()

    RequestModel(model)

    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end

    _wheel = CreateObject(model, 1111.052, 229.849, -50.40, false, false, true)
    SetEntityHeading(_wheel, 0.9754)
    SetModelAsNoLongerNeeded(model)    
end)


RegisterNetEvent("esx_tpnrp_luckywheel:doRoll")
AddEventHandler("esx_tpnrp_luckywheel:doRoll", function(_priceIndex) 
    _isRolling = true
	SetEntityHeading(_wheel, 0.9754)
    Citizen.CreateThread(function()
        local speedIntCnt = 1
        local rollspeed = 1.0
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
			SetEntityHeading(_wheel, 0.9754)
            SetEntityRotation(_wheel, 0.0, _y, 0.9754, 2, true)
            Citizen.Wait(5)
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

        RequestAnimDict('anim_casino_a@amb@casino@games@lucky7wheel@male')
        while not HasAnimDictLoaded('anim_casino_a@amb@casino@games@lucky7wheel@male') do
            RequestAnimDict('anim_casino_a@amb@casino@games@lucky7wheel@male')
            Citizen.Wait(100)
        end
        
        local _movePos = vector3(1109.729, 229.22052, -49.63581)
        TaskGoStraightToCoord(playerPed,  _movePos.x,  _movePos.y,  _movePos.z,  1.0,  -1,  312.2,  0.0)
        local _isMoved = false
        while not _isMoved do
            local coords = GetEntityCoords(PlayerPedId())
            if coords.x >= (_movePos.x - 0.01) and coords.x <= (_movePos.x + 0.01) and coords.y >= (_movePos.y - 0.01) and coords.y <= (_movePos.y + 0.01) then
                _isMoved = true
            end
            Citizen.Wait(0)
        end
        TaskPlayAnim(PlayerPedId(), 'anim_casino_a@amb@casino@games@lucky7wheel@male', 'enter_right_to_baseidle' ,8.0, -8.0, -1, 0, 0, false, false, false)
        while IsEntityPlayingAnim(playerPed, 'anim_casino_a@amb@casino@games@lucky7wheel@male', 'enter_right_to_baseidle', 3) do
                Citizen.Wait(0)
                DisableAllControlActions(0)
        end
        TaskPlayAnim(PlayerPedId(), 'anim_casino_a@amb@casino@games@lucky7wheel@male', 'enter_to_armraisedidle', 8.0, -8.0, -1, 0, 0, false, false, false)
        while IsEntityPlayingAnim(playerPed, 'anim_casino_a@amb@casino@games@lucky7wheel@male', 'enter_to_armraisedidle', 3) do
            Citizen.Wait(0)
            DisableAllControlActions(0)
        end
        TriggerServerEvent("esx_tpnrp_luckywheel:getLucky")
        TaskPlayAnim(playerPed, 'anim_casino_a@amb@casino@games@lucky7wheel@male', 'armraisedidle_to_spinningidle_high', 8.0, -8.0, -1, 0, 0, false, false, false)

    end
end

-- Menu Controls
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1)
        local coords = GetEntityCoords(PlayerPedId())

        if(GetDistanceBetweenCoords(coords, _wheelPos.x, _wheelPos.y, _wheelPos.z, true) < 1.5) and not _isRolling then
            DisplayHelpText("Press ~INPUT_CONTEXT~ to test your luck with the $50,000 Wheel")
            if IsControlJustReleased(0, Keys['E']) then
                doRoll()
            end
        end		
	end
end)

function DisplayHelpText(helpText, time)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentSubstringWebsite(helpText)
	EndTextCommandDisplayHelp(0, 0, 1, time or -1)
end