function Load(name)
	local resourceName = GetCurrentResourceName()
	local chunk = LoadResourceFile(resourceName, ('data/%s.lua'):format(name))
	if chunk then
		local err
		chunk, err = load(chunk, ('@@%s/data/%s.lua'):format(resourceName, name), 't')
		if err then
			error(('\n^1 %s'):format(err), 0)
		end
		return chunk()
	end
end

-------------------------------------------------------------------------------
-- Settings
-------------------------------------------------------------------------------

Config = {}

-- It's possible to interact with entities through walls so this should be low
Config.MaxDistance = 5.0

-- Enable debug options
Config.Debug = false

-- Supported values: true, false
Config.Standalone = false

-- Enable outlines around the entity you're looking at
Config.EnableOutline = false

-- Enable default options (Toggling vehicle doors)
Config.EnableDefaultOptions = false

-- Disable the target eye whilst being in a vehicle
Config.DisableInVehicle = false

-- Key to open the target
Config.OpenKey = 'LMENU' -- Left Alt
Config.OpenControlKey = 19 -- Control for keypress detection also Left Alt for the eye itself, controls are found here https://docs.fivem.net/docs/game-references/controls/

-- Key to open the menu
Config.MenuControlKey = 238 -- Control for keypress detection on the context menu, this is the Right Mouse Button, controls are found here https://docs.fivem.net/docs/game-references/controls/

-------------------------------------------------------------------------------
-- Target Configs
-------------------------------------------------------------------------------

-- These are all empty for you to fill in, refer to the .md files for help in filling these in

Config.CircleZones = {

}

Config.BoxZones = {
	--[[ ["boxzone1"] = {
        name = "IntegrityLiftOne",
        coords = vector3(282.06, -651.09, 41.10),
        length = 0.45,
        width = 0.35,
        heading = 252,
        debugPoly = true,
        minZ=42.12,
  		maxZ=42.70,
        options = {  
            {
                type = "client", 
                event = "qb-policejob:ToggleDuty",
                icon = "fas fa-arrow-circle-up", 
                label = "Go To Your Room",
            },
        },
        distance = 2.5
    }, ]]
	["boxzone1"] = {
        name = "MissionRowDutyClipboard",
        coords = vector3(441.7989, -982.0529, 30.67834),
        length = 0.45,
        width = 0.35,
        heading = 11.0,
        debugPoly = false,
        minZ = 30.77834,
        maxZ = 30.87834,
        options = { 
            {
                type = "client",
                event = "police:duty",
                icon = "fas fa-sign-in-alt",
                label = "Toggle Duty",
                job = "police", 
            }, 
        },
        distance = 2.5
    },
    ["boxzone8"] = {
        name = "MechDutyClipboard",
        coords = vector3(-1430.25, -454.24, 35.91),  
        length = 0.5,  
        width = 0.3,
        heading = 307, 
        debugPoly = false,
        minZ = 35.91,
        maxZ = 36.06,
        options = { 
            { 
                type = "client",
                event = "police:duty",
                icon = "fas fa-sign-in-alt",
                label = "Set Duty",
                job = "mechanic",  
            }, 
        }, 
        distance = 2.5
    },
	["boxzone2"] = {
        name = "pdbossmenu",
        coords = vector3(461.46, -986.19, 30.73),  
        length = 0.5,
        width = 0.6,
        heading = 351,
        debugPoly = false,
        minZ = 30.33,
        maxZ = 30.73,
        options = { 
            {
                type = "client",
                event = "qb-bossmenu:client:OpenMenu",
                icon = "fas fa-sign-in-alt",
                label = "Boss Actions",
                job = "police", 
            }, 
        },
        distance = 2.5
    },
	["boxzone3"] = {
        name = "emsbossmenu",
        coords = vector3(310.25, -597.5, 43.28),  
        length = 0.5,
        width = 0.6,
        heading = 335,
        debugPoly = false,
        minZ = 38.64,
        maxZ = 43.48,
        options = { 
            {
                type = "client",
                event = "qb-bossmenu:client:OpenMenu",
                icon = "fas fa-sign-in-alt",
                label = "Boss Actions",
                job = "ambulance", 
            }, 
        },
        distance = 2.5
    },
	["boxzone4"] = {
        name = "restatebossmenu",
        coords = vector3(-126.65, -641.76, 168.82),  
        length = 0.4, 
        width = 0.25,
        heading = 5, 
        debugPoly = false,
        minZ = 168.62,
        maxZ = 168.72,
        options = { 
            {
                type = "client",
                event = "qb-bossmenu:client:OpenMenu",
                icon = "fas fa-sign-in-alt",
                label = "Boss Actions",
                job = "realestate", 
            }, 
        },
        distance = 2.5
    },
	["boxzone5"] = {
        name = "mechbossmenu",
        coords = vector3(-1427.13, -458.27, 35.91),  
        length = 0.3, 
        width = 0.5,
        heading = 305, 
        debugPoly = false,
        minZ = 35.66,
        maxZ = 35.86,
        options = { 
            {
                type = "client",
                event = "qb-bossmenu:client:OpenMenu",
                icon = "fas fa-sign-in-alt",
                label = "Boss Actions",
                job = "mechanic", 
            }, 
        },
        distance = 2.5
    },
    --STASHES
    ["boxzone6"] = {
        name = "mechstash",
        coords = vector3(-1414.34, -452.67, 35.91),  
        length = 4.8, 
        width = 2.0,
        heading = 302, 
        debugPoly = false,
        minZ = 34.91,
        maxZ = 37.11,
        options = { 
            { 
                type = "client",
                event = "mech:openStash",
                icon = "fas fa-sign-in-alt",
                label = "Open Storage",
                job = "mechanic", 
            }, 
        },
        distance = 2.5
    },
    --OUTFITS
    ["boxzone7"] = {
        name = "mechoutfits",
        coords = vector3(-1425.59, -457.67, 35.91),  
        length = 0.8,  
        width = 2.6,
        heading = 302, 
        debugPoly = false,
        minZ = 34.91,
        maxZ = 36.91,
        options = { 
            { 
                type = "client",
                event = "rl-outfits-ido:client:forceUI",
                icon = "fas fa-sign-in-alt",
                label = "Outfits",
                job = "mechanic", 
            }, 
        }, 
        distance = 2.5
    },
    --shops
    ["boxzone10"] = {
        name = "mechshop",
        coords = vector3(-1421.58, -456.45, 35.91),  
        length = 3.8,  
        width = 1.0,
        heading = 302, 
        debugPoly = false,
        minZ = 34.91,
        maxZ = 37.31,
        options = { 
            { 
                type = "client",
                event = "inventory:client:OpenMechanicShop",
                icon = "fas fa-sign-in-alt",
                label = "Shop",
                job = "mechanic", 
            }, 
        }, 
        distance = 2.5
    },

    ["backstorerobbery"] = {
        name = "backstorerobbery",
        coords = vector3(28.24616, -1338.567, 29.4989),
        length = 0.80,
        width = 0.80,
        heading = 11.0,
        debugPoly = false,
        options = {
            {
                type = "client",
                event = "vny-shoprobbery:backrobbery",
                icon = "fas fa-circle",
                label = "Crack Password",
            },
            {
                type = "client",
                event = "vny-shoprobbery:collectmoney",
                icon = "fas fa-circle",
                label = "Collect Money",
            },
        },
        distance = 1.5
    },
    ["backstorerobbery2"] = {
        name = "backstorerobbery2",
        coords = vector3(-710.5124, -904.295, 19.07403),
        length = 0.80,
        width = 0.80,
        heading = 11.0,
        debugPoly = false,
        options = {
            {
                type = "client",
                event = "vny-shoprobbery:backrobbery",
                icon = "fas fa-circle",
                label = "Crack Password",
            },
            {
                type = "client",
                event = "vny-shoprobbery:collectmoney",
                icon = "fas fa-circle",
                label = "Collect Money",
            },
        },
        distance = 1.5
    },
    ["backstorerobbery3"] = {
        name = "backstorerobbery3",
        coords = vector3(1126.80, -979.76, 45.4157),
        length = 0.80,
        width = 0.80,
        heading = 11.0,
        debugPoly = false,
        options = {
            {
                type = "client",
                event = "vny-shoprobbery:backrobbery",
                icon = "fas fa-circle",
                label = "Crack Password",
            },
            {
                type = "client",
                event = "vny-shoprobbery:collectmoney",
                icon = "fas fa-circle",
                label = "Collect Money",
            },
        },
        distance = 1.5
    },
    ["backstorerobbery4"] = {
        name = "backstorerobbery4",
        coords = vector3(378.2701, 334.0500, 103.6725),
        length = 0.80,
        width = 0.80,
        heading = 11.0,
        debugPoly = false,
        options = {
            {
                type = "client",
                event = "vny-shoprobbery:backrobbery",
                icon = "fas fa-circle",
                label = "Crack Password",
            },
            {
                type = "client",
                event = "vny-shoprobbery:collectmoney",
                icon = "fas fa-circle",
                label = "Collect Money",
            },
        },
        distance = 1.5
    },
    ["backstorerobbery5"] = {
        name = "backstorerobbery5",
        coords = vector3(-1478.5, -375.75, 39.1634),
        length = 0.80,
        width = 0.80,
        heading = 11.0,
        debugPoly = false,
        options = {
            {
                type = "client",
                event = "vny-shoprobbery:backrobbery",
                icon = "fas fa-circle",
                label = "Crack Password",
            },
            {
                type = "client",
                event = "vny-shoprobbery:collectmoney",
                icon = "fas fa-circle",
                label = "Collect Money",
            },
        },
        distance = 1.5
    },
    ["backstorerobbery6"] = {
        name = "backstorerobbery6",
        coords = vector3(1734.99, 6421.37, 34.7778),
        length = 0.80,
        width = 0.80,
        heading = 11.0,
        debugPoly = false,
        options = {
            {
                type = "client",
                event = "vny-shoprobbery:backrobbery",
                icon = "fas fa-circle",
                label = "Crack Password",
            },
            {
                type = "client",
                event = "vny-shoprobbery:collectmoney",
                icon = "fas fa-circle",
                label = "Collect Money",
            },
        },
        distance = 1.5
    },
    ["backstorerobbery7"] = {
        name = "backstorerobbery7",
        coords = vector3(-1221.3, -916.29, 11.1923),
        length = 0.80,
        width = 0.80,
        heading = 11.0,
        debugPoly = false,
        options = {
            {
                type = "client",
                event = "vny-shoprobbery:backrobbery",
                icon = "fas fa-circle",
                label = "Crack Password",
            },
            {
                type = "client",
                event = "vny-shoprobbery:collectmoney",
                icon = "fas fa-circle",
                label = "Collect Money",
            },
        },
        distance = 1.5
    },
    ["backstorerobbery8"] = {
        name = "backstorerobbery8",
        coords = vector3(-3048.4, 585.427, 7.34192),
        length = 0.80,
        width = 0.80,
        heading = 11.0,
        debugPoly = true,
        options = {
            {
                type = "client",
                event = "vny-shoprobbery:backrobbery",
                icon = "fas fa-circle",
                label = "Crack Password",
            },
            {
                type = "client",
                event = "vny-shoprobbery:collectmoney",
                icon = "fas fa-circle",
                label = "Collect Money",
            },
        },
        distance = 1.5
    },
    

}





Config.PolyZones = {

}

Config.TargetBones = {

}

Config.TargetEntities = {

}

Config.TargetModels = {
    ["targetmodel1"] = {
        models = {
            "ig_trafficwarden"
        },
        options = {
			{
                type = "client",
                event = "dox:storecar",
                icon = "fas fa-car",
                label = "Park Vehicle",
                job = "police",
            },
            {
                type = "client",
                event = "garage:menu",
                icon = "fas fa-car",
                label = "Police Garage",
                job = "police",
            },
			
        },
        distance = 2.5,
    },
    ["targetmodelstore"] = {
        models = {
            "prop_till_01"
        },
        options = {
            {
                event = "vny-shoprobbery:onrobbery",
                icon = "fas fa-dollar-sign",
                label = "Collect Money",
            },
        },
        job = {"all"},
        distance = 1.5
    },
	
}


Config.GlobalPedOptions = {

}

Config.GlobalVehicleOptions = {

}

Config.GlobalObjectOptions = {

}

Config.GlobalPlayerOptions = {

}

Config.Peds = {

}

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------
local function JobCheck() return true end
local function GangCheck() return true end
local function ItemCount() return true end
local function CitizenCheck() return true end

CreateThread(function()
	if not Config.Standalone then
		local RLCore = exports['rl-core']:GetCoreObject()
		local PlayerData = RLCore.Functions.GetPlayerData()

		ItemCount = function(item)
			for _, v in pairs(PlayerData.items) do
				if v.name == item then
					return true
				end
			end
			return false
		end

		JobCheck = function(job)
			if type(job) == 'table' then
				job = job[PlayerData.job.name]
				if job and PlayerData.job.grade.level >= job then
					return true
				end
			elseif job == 'all' or job == PlayerData.job.name then
				return true
			end
			return false
		end

		GangCheck = function(gang)
			if type(gang) == 'table' then
				gang = gang[PlayerData.gang.name]
				if gang and PlayerData.gang.grade.level >= gang then
					return true
				end
			elseif gang == 'all' or gang == PlayerData.gang.name then
				return true
			end
			return false
		end

		CitizenCheck = function(citizenid)
			return citizenid == PlayerData.citizenid or citizenid[PlayerData.citizenid]
		end

		RegisterNetEvent('RLCore:Client:OnPlayerLoaded', function()
			PlayerData = RLCore.Functions.GetPlayerData()
			SpawnPeds()
		end)

		RegisterNetEvent('RLCore:Client:OnPlayerUnload', function()
			PlayerData = {}
			DeletePeds()
		end)

		RegisterNetEvent('RLCore:Client:OnJobUpdate', function(JobInfo)
			PlayerData.job = JobInfo
		end)

		RegisterNetEvent('RLCore:Client:OnGangUpdate', function(GangInfo)
			PlayerData.gang = GangInfo
		end)

		RegisterNetEvent('RLCore:Player:SetPlayerData', function(val)
			PlayerData = val
		end)
	else
		local firstSpawn = false
		AddEventHandler('playerSpawned', function()
			if not firstSpawn then
				SpawnPeds()
				firstSpawn = true
			end
		end)
	end
end)

function CheckOptions(data, entity, distance)
	if distance and data.distance and distance > data.distance then return false end
	if data.job and not JobCheck(data.job) then return false end
	if data.gang and not GangCheck(data.gang) then return false end
	if data.item and not ItemCount(data.item) then return false end
	if data.citizenid and not CitizenCheck(data.citizenid) then return false end
	if data.canInteract and not data.canInteract(entity, distance, data) then return false end
	return true
end

--EXAMPLE SCRIPT

--[[
    exports['qb-target']:AddBoxZone("MissionRowDutyClipboard", vector3(441.7989, -982.0529, 30.67834), 0.45, 0.35, {
        name = "MissionRowDutyClipboard",
        heading = 11.0,
        debugPoly = true,
        minZ = 30.77834,
        maxZ = 30.87834,
        }, {
            options = {
                {
                    type = "client",
                    event = "Toggle:Duty",
                    icon = "fas fa-clipboard",
                    label = "Go On/Off Duty",
                    job = "police",
                },
            },
            distance = 1.0
    })
    
    RegisterNetEvent('Toggle:Duty', function()
        onDuty = not onDuty
        TriggerServerEvent("police:server:UpdateCurrentCops")
        TriggerServerEvent("QBCore:ToggleDuty")
        TriggerServerEvent("police:server:UpdateBlips")
    end)
]]--

RegisterNetEvent('mech:openStash')
AddEventHandler('mech:openStash', function()
    TriggerEvent("inventory:client:SetCurrentStash", "mechanicstash")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "mechanicstash", {
    maxweight = 4000000,
    slots = 250,
    })
end)
