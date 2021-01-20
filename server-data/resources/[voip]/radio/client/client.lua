RLCore = nil
local PlayerData                = {}
local radioVolume = 0

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(10)
      if RLCore == nil then
          TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
          Citizen.Wait(200)
      end
  end
end)


local radioMenu = false

function PrintChatMessage(text)
    TriggerEvent('chatMessage', "system", { 255, 0, 0 }, text)
end



function enableRadio(enable)

  SetNuiFocus(true, true)
  radioMenu = enable

  SendNUIMessage({

    type = "enableui",
    enable = enable

  })
  RadioPlayAnim('text', false, true)
end

--- sprawdza czy komenda /radio jest włączony

RegisterCommand('radio', function(source, args)
    if Config.enableCmd then
      enableRadio(true)
    end
end, false)


-- radio test

RegisterCommand('radiotest', function(source, args)
  local playerName = GetPlayerName(PlayerId())
  local data = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")

  print(tonumber(data))

  if data == "nil" then
    exports['mythic_notify']:DoHudText('inform', Config.messages['not_on_radio'])
  else
   exports['mythic_notify']:DoHudText('inform', Config.messages['on_radio'] .. data .. '.00 MHz </b>')
 end

end, false)

function hasRadio()
  local retval = nil

  RLCore.Functions.TriggerCallback('RLCore:HasItem', function(result)
    retval = result
  end, 'radio')

  while retval == nil do
    Wait(1)
  end

  return retval
end

Citizen.CreateThread(function()
  while true do
    if RLCore ~= nil then
      if isLoggedIn then
        RLCore.Functions.TriggerCallback('radio:server:GetItem', function(hasItem)
          if not hasItem then
            if exports.tokovoip_script ~= nil and next(exports.tokovoip_script) ~= nil then
              local playerName = GetPlayerName(PlayerId())
              local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")

              if getPlayerRadioChannel ~= "nil" then
                exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
                exports.tokovoip_script:setPlayerData(playerName, "radio:channel", "nil", true)
                RLCore.Functions.Notify('You are removed from your current frequency!', 'error')
              end
            end
          end
        end, "radio")
      end
    end
    Citizen.Wait(10000)
  end
end)

-- dołączanie do radia

RegisterNUICallback('joinRadio', function(data, cb)
    local _source = source
    --local PlayerData = ESX.GetPlayerData(_source)
    local job = RLCore.Functions.GetPlayerData().job.name
    local playerName = GetPlayerName(PlayerId())
    local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")

    if tonumber(data.channel) ~= tonumber(getPlayerRadioChannel) then
        if tonumber(data.channel) <= Config.RestrictedChannels then
          if job == "police" or job == "ems" or job == "doctor" or job == "mechanic" then
            if( (tonumber(data.channel) <= Config.RestrictedChannels and job == 'ambulance' or job == 'police')) or ((tonumber(data.channel) == 11 or tonumber(data.channel) == 12 or tonumber(data.channel) == 13) and job == 'mechanic') or ((tonumber(data.channel) == 6 or tonumber(data.channel) == 7 or tonumber(data.channel) == 8 or tonumber(data.channel) == 9) and PlayerData.job.name == 'lawyer') then
              exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
              exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
              exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel), true)
              RLCore.Functions.Notify(Config.messages['joined_to_radio'] .. data.channel .. ' MHz </b>', 'error')
              --exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. ' MHz </b>')
              TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",0.6)
            else
              RLCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
              --exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
            end
          else
            --- info że nie możesz dołączyć bo nie jesteś policjantem
            RLCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
            --exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
          end
        end
        
        if tonumber(data.channel) > Config.RestrictedChannels then
          exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
          exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
          exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel), true)
          RLCore.Functions.Notify(Config.messages['joined_to_radio'] .. data.channel .. ' MHz </b>', 'error')
          --exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. 'MHz </b>')
          TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",0.6)
        end
      else
        RLCore.Functions.Notify(Config.messages['you_on_radio'] .. data.channel .. 'MHz </b>')
        --exports['mythic_notify']:DoHudText('error', Config.messages['you_on_radio'] .. data.channel .. 'MHz </b>')
      end
      --[[
    exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
    exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
    exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
    PrintChatMessage("radio: " .. data.channel)
    print('radiook')
      ]]--
    cb('ok')
end)

-- opuszczanie radia

RegisterNUICallback('leaveRadio', function(data, cb)
   local playerName = GetPlayerName(PlayerId())
   local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")


    if getPlayerRadioChannel == "nil" then
      exports['mythic_notify']:DoHudText('inform', Config.messages['not_on_radio'])
        else
          exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
          exports.tokovoip_script:setPlayerData(playerName, "radio:channel", "nil", true)
          TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",0.6)
          RLCore.Functions.Notify(Config.messages['you_leave'] .. getPlayerRadioChannel .. 'MHz </b>')
          --exports['mythic_notify']:DoHudText('inform', Config.messages['you_leave'] .. getPlayerRadioChannel .. 'MHz </b>')
    end

   cb('ok')

end)

RegisterNUICallback('escape', function(data, cb)

  enableRadio(false)
  SetNuiFocus(false, false)
  RadioPlayAnim('out', false, true)


  cb('ok')
end)

-- net eventy

RegisterNetEvent('ls-radio:use')
AddEventHandler('ls-radio:use', function()
  enableRadio(true)
end)

RegisterNetEvent('ls-radio:onRadioDrop')
AddEventHandler('ls-radio:onRadioDrop', function(source)
  local playerName = GetPlayerName(PlayerId())
   local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")
   local iDidItAllready = false

    if getPlayerRadioChannel == "nil" then
      --exports['mythic_notify']:DoHudText('inform', Config.messages['not_on_radio'])
        else
          exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
          exports.tokovoip_script:setPlayerData(playerName, "radio:channel", "nil", true)
          --exports['mythic_notify']:DoHudText('inform', Config.messages['you_leave'] .. getPlayerRadioChannel .. '.00 MHz </b>')
    end
end)

Citizen.CreateThread(function()
    while true do
        if radioMenu then
            DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
            DisableControlAction(0, 2, guiEnabled) -- LookUpDown

            DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate

            DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride

            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({
                    type = "click"
                })
            end
        end
        Citizen.Wait(0)
    end
end)

RegisterNUICallback('volumeUp', function(data, cb)
    setVolumeUp()
end)
  
RegisterNUICallback('volumeDown', function(data, cb)
    setVolumeDown()
end)

RegisterNUICallback('click', function(data, cb)
TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",0.6)
end)


RegisterNetEvent('tp-radio:setVolume')
AddEventHandler('tp-radio:setVolume', function(radioVolume, total)
    SendNUIMessage({

        type = "volume",
        volume = total

    })
    TriggerEvent('TokoVoip:setRadioVolume', radioVolume)
end)

function setVolumeDown()
    if radioVolume <= -100 then
        radioVolume = -100
    else
        radioVolume = radioVolume - 10
    end
    total = (radioVolume + 100)
    RLCore.Functions.Notify("Radio volume is now: " .. total .. "%")
    --exports['mythic_notify']:DoHudText('inform', "Radio volume is now: " .. total .. "%")
    TriggerEvent('tp-radio:setVolume', radioVolume, total)
end

function setVolumeUp()
    if radioVolume >= 0 then
        radioVolume = 0
    else
        radioVolume = radioVolume + 10
    end
    total = (radioVolume + 100)
    RLCore.Functions.Notify("Radio volume is now: " .. total .. "%")
    --exports['mythic_notify']:DoHudText('inform', "Radio volume is now: " .. total .. "%")
    TriggerEvent('tp-radio:setVolume', radioVolume, total)
end