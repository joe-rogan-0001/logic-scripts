isLoggedIn = false

local slots = 40 -- Range for the inventory check, begins in 1 an finish on slots value, hotbar's slots are 1-5 
local s = {}
local sa = {}
local k = 0
local m = 0

local back_bone = 24818
local x = 0.00
local y = -0.15
local z = 0.0
local x_rotation = 0.0
local y_rotation = 0.0
local z_rotation = 0.0
local selectwep = nil
local valid = false
local weaps = {}
local current = nil 
local QBCore = exports['lrp-core']:GetCoreObject()

local slot1 = false
local slot2 = false
local slot3 = false

local slot1wep = nil
local slot2wep = nil
local slot3wep = nil

local rifles = {
    --large smgs
    ["weapon_smg"] = "w_sb_smg",
    ["weapon_assaultsmg"] = "w_sb_assaultsmg",
    ["weapon_combatpdw"] = "w_sb_mpx",
    ["weapon_combatpdwpd"] = "w_sb_mpx",
    ["weapon_gusenberg"] = "w_sb_gusenberg",
    ["weapon_mp5"] = "w_sb_mp5",
    ["weapon_mp5pd"] = "w_sb_mp5",



    -- shotguns 
    ["weapon_assaultshotgun"] = "w_sg_assaultshotgun",
    ["weapon_bullpupshotgun"] = "w_sg_bullpupshotgun",
    ["weapon_heavyshotgun"] = "w_sg_heavyshotgun",
    ["weapon_pumpshotgun"] = "w_sg_izh81",
    ["weapon_pumpshotgun_mk2"] = "w_sg_pumpshotgunmk2",
    ["weapon_pumpshotgun_mk2pd"] = "w_sg_pumpshotgunmk2",
    ["weapon_sawnoffshotgun"] = "w_sg_sawnoff",
    ["weapon_musket"] = "w_ar_musket",
    ["weapon_ltl"] = "w_sg_ltl",
    ["weapon_combatshotgun"] = "w_sg_pumpshotgunh4",

    -- rifles 
    ["weapon_advancedrifle"] = "w_ar_advancedrifle",
    ["weapon_advancedrifle2"] = "w_ar_advancedrifle2",
    ["weapon_assaultrifle"] = "w_ar_assaultrifle",
    ["weapon_assaultrifle_mk2"] = "w_ar_assaultriflemk2",
    ["weapon_bullpuprifle"] = "w_ar_bullpuprifle",
    ["weapon_bullpuprifle_mk2"] = "w_ar_bullpupriflemk2",
    ["weapon_carbinerifle"] = "w_ar_carbinerifle",
    ["weapon_specialcarbine"] = "w_ar_specialcarbine",
    ["weapon_specialcarbine_mk2"] = "w_ar_specialcarbinemk2",
    ["weapon_carbinerifle_mk2"] = "w_ar_carbineriflemk2",
    ["weapon_compactrifle"] = "w_ar_draco",
    ["weapon_scarh"] = "w_ar_scar",
    ["weapon_scarhpd"] = "w_ar_scar",
    ["weapon_m4pd"] = "w_ar_m4",
    ["weapon_mg"] = "w_mg_mg",
    ["weapon_combatmg"] = "w_mg_combatmg",
    ["weapon_combatmg_mk2"] = "w_mg_combatmgmk2",
    ["weapon_sniperrifle"] = "w_sr_m24",
    ["weapon_m14"] = "w_sr_m14",
    ["weapon_sniperrifle2"] = "w_sr_sniperrifle2",
    ["weapon_dragunov"] = "w_sr_dragunov",
    ["weapon_railgun"] = "w_ar_railgun",
}

local smallsmg = {
    --small smgs
    ["weapon_microsmg"] = "w_sb_microsmg",
    ["weapon_microsmg2"] = "w_sb_microsmg2",
    ["weapon_microsmg3"] = "w_sb_microsmg3",
    ["weapon_smg_mk2"] = "w_sb_smgmk2",
    ["weapon_machinepistol"] = "w_sb_compactsmg",
    ["weapon_minismg"] = "w_sb_minismg",

    -- small shotguns
    ["weapon_dbshotgun"] = "w_sg_doublebarrel",
    ["weapon_autoshotgun"] = "w_sg_sweeper",
    ["weapon_sawnoffshotgun"] = "w_sg_sawnoff",
    
}

local pistols = {
    --[[["weapon_pistol"] = "w_pi_pistol",
    ["weapon_pistol_mk2"] = "w_pi_pistolmk2",
    ["weapon_glock"] = "w_pi_glock",
    ["weapon_glockpd"] = "w_pi_glock",
    ["weapon_glock18c"] = "w_pi_glock18c",
    ["weapon_combatpistol"] = "w_pi_combatpistol",
    ["weapon_appistol"] = "w_pi_appistol",
    ["weapon_pistol50"] = "w_pi_pistol50",
    ["weapon_snspistol"] = "w_pi_sns_pistol",
    ["weapon_heavypistol"] = "w_pi_heavypistol",
    ["weapon_vintagepistol"] = "w_pi_vintage_pistol",
    ["weapon_revolver"] = "w_pi_revolver",
    ["weapon_doubleaction"] = "w_pi_doubleaction",]]--
}

local melee = {
    --["weapon_knife"] ="prop_w_me_knife_01",
    --["weapon_nightstick"] = "w_me_nightstick",
    --["weapon_dagger"] = "w_me_dagger",
}

local meleelarge = {
    ["weapon_bat"] = "w_me_bat",
    ["weapon_golfclub"] = "w_me_gclub",
    ["weapon_crowbar"] = "w_me_crowbar",
}

local polweap = {
    --["weapon_stungun"] = "w_pi_stungun",
}


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)



Citizen.CreateThread(function()
    while true do
        if isLoggedIn then
            local xPlayer = QBCore.Functions.GetPlayerData()
            for i = 1, slots do
                sa[i] = s[i]
                s[i] = xPlayer.items[i]
            end
            check()
            Citizen.Wait(500)
        else
            Citizen.Wait(1000)
        end
    end
end)


--[[Citizen.CreateThread(function()
    while true do
        local xPlayer = QBCore.Functions.GetPlayerData()
        for i = 1, slots do
            sa[i] = s[i]
            s[i] = xPlayer.items[i]
        end
        check()
        Citizen.Wait(1000)
    end
end)]]--


function check()
    for i = 1, slots do
        k = 0
        if sa[i] ~= nil then
            for j = 1, slots do
                if s[j] ~= nil then
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
            if sa[i] ~= nil then
                if sa[i].type == "weapon" then                
                    DeleteWeapon(sa[i].name)
                    slot1 = false
                    slot2 = false
                    slot3 = false
                end
            end
        end
    end

    for i = 1, slots do
        m = 0
        if s[i] ~= nil then
            for j = 1, slots do
                if sa[j] ~= nil then
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
            if s[i] ~= nil then
                if s[i].type == "weapon"  then
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

function DeleteWeapon(wep)
    DeleteObject(weaps[wep])
end

function GiveWeap(wep)
    if rifles[wep] and slot1 == false then
        back_bone = 24818
        x = -0.10
        y = -0.15
        z = 0.12
        x_rotation = 180.0
        y_rotation = 180.0
        z_rotation = 180.0
        valid = true
        slot1 = true
        selectwep = rifles[wep]
        slot1wep = wep

    elseif rifles[wep] ~= nil and slot2 == false then
        back_bone = 24818
        x = -0.10
        y = -0.15
        z = -0.20
        x_rotation = 180.0
        y_rotation = 180.0
        z_rotation = 180.0
        valid = true
        slot2 = true
        selectwep = rifles[wep]
        slot2wep = wep
    elseif smallsmg[wep] ~= nil and slot3 == false then
        back_bone = 24818
        x = -0.10
        y = -0.18
        z = -0.05
        x_rotation = 180.0
        y_rotation = 180.0
        z_rotation = 180.0
        valid = true
        slot3 = true
        selectwep = smallsmg[wep]
        slot3wep = wep
    elseif pistols[wep] ~= nil then
        back_bone = 51826
        x = 0.05
        y = 0.0
        z = 0.1
        x_rotation = -90.0
        y_rotation = 0.0
        z_rotation = 0.0
        valid = true
        selectwep = pistols[wep]
    elseif melee[wep] ~= nil then
        back_bone = 11816
        x = -0.1
        y = -0.15
        z = 0.12
        x_rotation = 0.0
        y_rotation = 135.0
        z_rotation = 0.0
        valid = true
        selectwep = melee[wep]
    elseif meleelarge[wep] ~= nil then
        back_bone = 24818
        x = -0.20
        y = -0.15
        z = 0.0
        x_rotation = 0.0
        y_rotation = 90.0
        z_rotation = 0.0
        valid = true
        selectwep = meleelarge[wep]
    elseif polweap[wep] ~= nil then
        back_bone = 58271
        x = 0.0
        y = 0.05
        z = -0.1
        x_rotation = -65.0
        y_rotation = 0.0
        z_rotation = 0.0
        valid = true
        selectwep = polweap[wep]
    end

    if valid then
        valid = false
        local bone = GetPedBoneIndex(PlayerPedId(), back_bone)
        RequestModel(selectwep)
        while not HasModelLoaded(selectwep) do
            Citizen.Wait(10)
        end
        SetModelAsNoLongerNeeded(selectwep)
        weaps[wep] = CreateObject(GetHashKey(selectwep), 1.0, 1.0, 1.0, true, true, false)   
        SetEntityCollision(weaps[wep], false, true)
        AttachEntityToEntity(weaps[wep], PlayerPedId(), bone, x, y, z, x_rotation, y_rotation, z_rotation, 1, 1, 0, 0, 2, 1)
    end
end

RegisterNetEvent('weapons:client:SetCurrentWeapon')
AddEventHandler('weapons:client:SetCurrentWeapon', function(weap,shootbool)
    if weap == nil then

        GiveWeap(current)
        current = nil
    else
        if current ~= nil then
            GiveWeap(current)
            current = nil
        end
       

        current = tostring(weap.name)

        if slot1wep == current then
            slot1 = false 
        elseif slot2wep == current then
            slot2 = false 
        elseif slot3wep == current then
            slot3 = false 
        end

        DeleteWeapon(current)
    end
end)

