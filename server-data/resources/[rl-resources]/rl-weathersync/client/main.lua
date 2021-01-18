CurrentWeather = 'EXTRASUNNY'
local lastWeather = CurrentWeather
local baseTime = 0
local timeOffset = 0
local timer = 0
local freezeTime = false
local blackout = false

local disable = false

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

--- CODE

RegisterNetEvent('RLCore:Client:OnPlayerLoaded')
AddEventHandler('RLCore:Client:OnPlayerLoaded', function()
	disable = false
    TriggerServerEvent('rl-weathersync:server:RequestStateSync')
end)

RegisterNetEvent('rl-weathersync:client:EnableSync')
AddEventHandler('rl-weathersync:client:EnableSync', function()
	disable = false
    TriggerServerEvent('rl-weathersync:server:RequestStateSync')
	SetRainFxIntensity(-1.0)
end)

RegisterNetEvent('rl-weathersync:client:DisableSync')
AddEventHandler('rl-weathersync:client:DisableSync', function()
	disable = true

	Citizen.CreateThread(function() 
		TriggerEvent("debug", 'Server: Sync Disabled', 'error')

		while disable do
			SetRainFxIntensity(0.0)
			SetWeatherTypePersist('EXTRASUNNY')
			SetWeatherTypeNow('EXTRASUNNY')
			SetWeatherTypeNowPersist('EXTRASUNNY')
			NetworkOverrideClockTime(22, 0, 0)
			Citizen.Wait(5000)
		end
	end)
end)

RegisterNetEvent('rl-weathersync:client:SyncTime')
AddEventHandler('rl-weathersync:client:SyncTime', function(base, offset, freeze)
    freezeTime = freeze
    timeOffset = offset
	baseTime = base
	
	TriggerEvent("debug", 'Server: Sync Time', 'success')
end)

RegisterNetEvent('rl-weathersync:client:SyncWeather')
AddEventHandler('rl-weathersync:client:SyncWeather', function(NewWeather, newblackout)
    CurrentWeather = NewWeather
	blackout = newblackout
	TriggerEvent("debug", 'Server: Sync Weather', 'success')
end)

Citizen.CreateThread(function()
    local hour = 0
    local minute = 0
    while true do
		if not disable then
			local newBaseTime = baseTime
			if GetGameTimer() - 500  > timer then
				newBaseTime = newBaseTime + 0.10
				timer = GetGameTimer()
			end
			if freezeTime then
				timeOffset = timeOffset + baseTime - newBaseTime			
			end
			baseTime = newBaseTime
			hour = math.floor(((baseTime+timeOffset)/60)%24)
			minute = math.floor((baseTime+timeOffset)%60)
			NetworkOverrideClockTime(hour, minute, 0)

			Citizen.Wait(2000)
		else
			Citizen.Wait(1000)
		end
    end
end)

Citizen.CreateThread(function()
    while true do
		if not disable then
			if lastWeather ~= CurrentWeather then
				lastWeather = CurrentWeather
				SetWeatherTypeOverTime(CurrentWeather, 15.0)
				Citizen.Wait(15000)
			end
			Citizen.Wait(100) -- Wait 0 seconds to prevent crashing.
			SetBlackout(blackout)
			ClearOverrideWeather()
			ClearWeatherTypePersist()
			SetWeatherTypePersist(lastWeather)
			SetWeatherTypeNow(lastWeather)
			SetWeatherTypeNowPersist(lastWeather)
			if lastWeather == 'XMAS' then
				SetForceVehicleTrails(true)
				SetForcePedFootstepsTracks(true)
			else
				SetForceVehicleTrails(false)
				SetForcePedFootstepsTracks(false)
			end
		else
			Citizen.Wait(1000)
		end
    end
end)