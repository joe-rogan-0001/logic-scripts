DoxCore = exports['lrp-core']:GetCoreObject()

DoxCore.Functions.CreateCallback('Dox-bobcat:server:getCops', function(source, cb)
	local cops = 0
    for k, v in pairs(DoxCore.Functions.GetPlayers()) do
        local Player = DoxCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                cops = cops + 1
            end
        end
	end
	cb(cops)
end)

RegisterServerEvent("Dox-particleserver")
AddEventHandler("Dox-particleserver", function(method)
    TriggerClientEvent("Dox-ptfxparticle", -1, method)
end)

RegisterServerEvent("Dox-particleserversec")
AddEventHandler("Dox-particleserversec", function(method)
    TriggerClientEvent("Dox-ptfxparticlesec", -1, method)
end)


RegisterServerEvent("Dox-updateIpls")
AddEventHandler("Dox-updateIpls", function()
    TriggerClientEvent("Dox-updateIpls", -1)
end)

RegisterServerEvent("setvariables")
AddEventHandler("setvariables", function(type)
    TriggerClientEvent("variables", -1, type)
end)

DoxCore.Functions.CreateUseableItem("security_card_01", function(source, item)
    local Player = DoxCore.Functions.GetPlayer(source)
        TriggerClientEvent("Dox-bobcatthirddoor", source)
		TriggerClientEvent('DoxCore:Notify', source, "Door Unlocked.", "success")
end)

DoxCore.Functions.CreateUseableItem("thermitec", function(source, item)
    --local Player = DoxCore.Functions.GetPlayer(source)
	--if Player.Functions.GetItemByName('lighter') ~= nil then
        TriggerClientEvent("Dox-middleman", source)
        --TriggerClientEvent("Dox-seconddoor", source)
    --else
        --TriggerClientEvent('DoxCore:Notify', source, "You are missing something to light the thermite..", "error")
    --end
end)

--[[
DoxCore.Functions.CreateUseableItem("thermitec", function(source, item)
    --local Player = DoxCore.Functions.GetPlayer(source)
	--if Player.Functions.GetItemByName('lighter') ~= nil then
        TriggerClientEvent("Dox-firstdoor", source)
    --else
        --TriggerClientEvent('DoxCore:Notify', source, "You are missing something to light the thermite..", "error")
    --end
end)
]]--


local SMG = {
    "weapon_smg",
    "weapon_minismg",
    "weapon_machinepistol",
    "weapon_microsmg"
}

local Rifles = {
    "weapon_assaultrifle",
    "weapon_militaryrifle",
    "weapon_bullpuprifle_mk2",
    "weapon_carbinerifle"
}

local Explosives = {
    "thermitec",
    "weapon_stickybomb",
    "weapon_grenade",
    "parachute"
}

RegisterServerEvent("Dox-bobcat:server:loot")
AddEventHandler("Dox-bobcat:server:loot", function(class)
    local src = source
    local type = class
    local Player = DoxCore.Functions.GetPlayer(src)
    if type == "rifles" then
        for i = 1, math.random(2, 4), 1 do
            local randItem = Rifles[math.random(1, #Rifles)]
            Player.Functions.AddItem(randItem, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, DoxCore.Shared.Items[randItem], 'add')
            Citizen.Wait(500)
        end
    elseif type == "explode" then
        for i = 1, math.random(3, 7), 1 do
            local randItem = Explosives[math.random(1, #Explosives)]
            Player.Functions.AddItem(randItem, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, DoxCore.Shared.Items[randItem], 'add')
            Citizen.Wait(500)
        end
    elseif type == "smg" then
        for i = 1, math.random(3, 4), 1 do
            local randItem = SMG[math.random(1, #SMG)]
            Player.Functions.AddItem(randItem, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, DoxCore.Shared.Items[randItem], 'add')
            Citizen.Wait(500)
        end
    end
end)	
