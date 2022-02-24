
local bicBoiVaultDoorStates = nil





RegisterCommand('casinovault', function(source, args, rawCommand)
	RequestIpl("np_int_placement_ch_interior_6_dlc_casino_vault_milo_")
    local interiorid = GetInteriorAtCoords(259.2812, 203.5071, 96.77954)
    for k, s in pairs(bicBoiVaultDoorStates) do
        DisableInteriorProp(interiorid, k)
    end
    for k, s in pairs(bicBoiVaultDoorStates) do
        if s then
            EnableInteriorProp(interiorid, k)
        end
    end
    RefreshInterior(interiorid)

    RequestIpl("hei_hw1_02_interior_2_heist_ornate_bank_milo_")
    interiorid = GetInteriorAtCoords(247.913, 218.042, 105.283)
    for k, s in pairs(upperVaultEntityState) do
      DisableInteriorProp(interiorid, k)
    end
    for k, s in pairs(upperVaultEntityState) do
      if s then
        EnableInteriorProp(interiorid, k)
      end
    end
    RefreshInterior(interiorid)
end, false)


Citizen.CreateThread(function()
  exports["np-polytarget"]:AddBoxZone("lower_vault_keypad", vector3(286.53, 220.17, 97.69), 0.4, 0.4, {
    heading=0,
    minZ=98.09,
    maxZ=98.49,
    data = {
      id = "kp_1",
    },
  })
  exports["np-polytarget"]:AddBoxZone("lower_vault_keypad", vector3(284.7, 221.63, 97.69), 0.4, 0.4, {
    heading=340,
    minZ=98.09,
    maxZ=98.49,
    data = {
      id = "kp_2",
    },
  })
  exports["np-polytarget"]:AddBoxZone("lower_vault_keypad", vector3(286.83, 227.45, 97.69), 0.4, 0.4, {
    heading=340,
    minZ=98.09,
    maxZ=98.49,
    data = {
      id = "kp_3",
    },
  })
  exports["np-polytarget"]:AddBoxZone("lower_vault_keypad", vector3(289.21, 227.46, 97.69), 0.4, 0.4, {
    heading=325,
    minZ=98.09,
    maxZ=98.49,
    data = {
      id = "kp_4",
    },
  })
  exports['np-interact']:AddPeekEntryByPolyTarget('lower_vault_keypad', {{
    event = "np-heists:lowerVaultPanelPush",
    id = "lowervaultpanelpush",
    icon = "circle",
    label = "Enter Code",
    parameters = {},
  }}, {
    distance = { radius = 1.5 },
  })
end)


--hotel floor
{
  info = "casino hotel room",
  active = true,
  id = getDoorId(),
  coords = vector3(935.57,-52.71,21.8),
  model = -2603300,
  lock = true,
  desc = "",
  access = {
      job = {},
      business = {
          ["casino_staff"] = true,
      },
  },
  forceUnlocked = false,
  hidden = true,
  keyFob = false,
  sceneRef = "CKCVA5",
  ignoreDetCord = true,
},

--geny room 
{
  info = "casino utility door before elevators",
  active = true,
  id = getDoorId(),
  coords = vector3(1006.89,25.96,63.6),
  model = 217447762,
  lock = true,
  desc = "",
  access = {
      job = {},
      business = {},
  },
  forceUnlocked = false,
  hidden = false,
  keyFob = false,
  sceneRef = "KJGZ24",
  ignoreDetCord = true,
},

--management/lift floor 
{
  info = "casino exec suite elevator right 1",
  active = true,
  id = getDoorId(),
  coords = vector3(1012.01,32.04,74.06),
  model = -1240156945,
  lock = true,
  desc = "",
  access = {
      job = {},
      business = {},
  },
  forceUnlocked = false,
  hidden = true,
  keyFob = false,
  sceneRef = "CCORTM",
  ignoreDetCord = true,
},