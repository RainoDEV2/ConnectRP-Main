local RLCore = exports['rl-core']:GetCoreObject()
local slots = 41 -- Range for the inventory check, begins in 1 an finish on slots value, hotbar's slots are 1-5
local s = {}
local sa = {}
local k = 0
local m = 0
local back_bone = 24818
local x = 0.11
local y = -0.155
local z = 0.05
local x_rotation = 0.0
local y_rotation = 0.0
local z_rotation = 0.0
local selectwep = nil
local valid = false
local weaps = {}
local current = nil

local rifles = {
    ["weapon_microsmg"] = "w_sb_microsmg",
    ["weapon_smg"] = "w_sb_mp5",
    ["weapon_assaultsmg"] = "w_sb_assaultsmg",
    ["weapon_combatpdw"] = "W_SB_MPX",
    ["weapon_gusenberg"] = "w_sb_gusenberg",
    ["weapon_assaultshotgun"] = "w_sg_assaultshotgun",
    ["weapon_bullpupshotgun"] = "w_sg_bullpupshotgun",
    ["weapon_heavyshotgun"] = "w_sg_heavyshotgun",
    ["weapon_pumpshotgun"] = "w_sg_pumpshotgun",
    ["weapon_sawnoffshotgun"] = "w_sg_sawnoff",
    ["weapon_musket"] = "w_ar_musket",
    ["weapon_railgun"] = "w_ar_railgun",
    ["WEAPON_RPG"] = "w_lr_rpg",
    ["weapon_advancedrifle"] = "w_ar_groza",
    ["weapon_assaultrifle"] = "w_ar_assaultrifle",
    ["weapon_bullpuprifle"] = "w_ar_bullpuprifle",
    ["weapon_carbinerifle"] = "w_ar_carbinerifle",
    ["weapon_specialcarbine"] = "w_ar_specialcarbine",
    ["weapon_specialcarbine_mk2"] = "w_ar_scar",
    ["weapon_carbinerifle_mk2"] = "w_ar_carbineriflemk2",
    ["weapon_m4"] = "w_ar_M4",
    ["weapon_assaultrifle2"] = "W_AR_ASSAULTRIFLE2",
}

local katana = {
    ["weapon_katana"] = "w_me_katana",
    ["weapon_katanas"] = "katana_sheath",
}

local melee = {
    ["weapon_bat"] = "w_me_bat",
    ["weapon_golfclub"] = "w_me_gclub",
    ["weapon_bats"] = "w_me_baseball_bat_metal",
}

local function GiveWeap(wep)
    if rifles[wep] then
        back_bone = 24818
        x = 0.11
        y = -0.155
        z = 0.05
        x_rotation = 0.0
        y_rotation = 0.0
        z_rotation = 0.0
        valid = true
        selectwep = rifles[wep]
    elseif katana[wep] then
        back_bone = 24817
        x = 0.0
        y = -0.135
        z = 0.51-0.4
        x_rotation = 225.0
        y_rotation = 8.0
        z_rotation = 90.0
        valid = true
        selectwep = katana[wep]
    elseif melee[wep] then
        back_bone = 24817
        x = 0.3
        y = -0.15
        z = -0.1
        x_rotation = 0.0
        y_rotation = 300.0
        z_rotation = 0.0
        valid = true
        selectwep = melee[wep]
    end

    if valid then
        valid = false
        RequestModel(selectwep)
        local rst = 0
        while not HasModelLoaded(selectwep) and rst < 10 do
            Wait(100)
            rst = rst + 1
        end
        local bone = GetPedBoneIndex(PlayerPedId(), back_bone)
        weaps[wep] = CreateObject(GetHashKey(selectwep), 1.0 ,1.0 ,1.0, 1, 1, 0)
        AttachEntityToEntity(weaps[wep], PlayerPedId(), bone, x, y, z, x_rotation, y_rotation, z_rotation, 0, 1, 0, 1, 0, 1)
    end
end

local function DeleteWeapon(wep)
    DeleteObject(weaps[wep])
end

local function check()
    for i = 1, slots do
        k = 0
        if sa[i] then
            for j = 1, slots do
                if s[j] then
                    if sa[i].name == s[j].name then
                        k = 1
                        break
                    end
                end
            end
        else
            k = 1
        end
        if k == 0 then
            if sa[i] then
                if sa[i].type == "weapon" then
                    DeleteWeapon(sa[i].name)
                end
            end
        end
    end
    for i = 1, slots do
        m = 0
        if s[i] then
            for j = 1, slots do
                if sa[j] then
                    if s[i].name == sa[j].name then
                        m = 1
                        break
                    end
                end
            end
        else
            m = 1
        end
        if m == 0 then
            if s[i] then
                if s[i].type == "weapon" then
                    if IsPedArmed(PlayerPedId()) then
                        local wp = GetHashKey(s[i].name)
                        local aw = GetSelectedPedWeapon(PlayerPedId())
                        if wp ~= aw then
                            GiveWeap(s[i].name)
                        end
                    else
                        GiveWeap(s[i].name)
                    end
                end
            end
        end
    end
end

RegisterNetEvent('weapons:client:SetCurrentWeapon', function(weap, shootbool)
    if weap == nil then
        GiveWeap(current)
        current = nil
    else
        if current then
            GiveWeap(current)
            current = nil
        end
        current = tostring(weap.name)
        DeleteWeapon(current)
    end
end)


CreateThread(function()
    while true do
        if LocalPlayer.state.isLoggedIn then
            local xPlayer = RLCore.Functions.GetPlayerData()
            for i = 1, slots do
                sa[i] = s[i]
                s[i] = xPlayer.items[i]
            end
            check()
            Wait(500)
        else
            Wait(1000)
        end
    end
end)
