-- REDESIGNED BY OSMIUM | DISCORD.IO/OSMFX

--------------------
-- QBCore Core Stuff --
--------------------

local QBCore = exports['lrp-core']:GetCoreObject()

---------------
-- Variables --
---------------

local mining = false
local exploded = false
local isWashing = false
local appening = false
local alreadysent = false
local ObjectList = {}
local canwork = true

---------------------
-- Functions --
---------------------
loadModel = function(model)
    while not HasModelLoaded(model) do Wait(0) RequestModel(model) end
    return model
end

loadDict = function(dict, anim)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
end

DrawText3D = function(x, y, z, text)
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

--[[
addBlip = function(coords, sprite, colour)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Mining")
    EndTextCommandSetBlipName(blip)
end
]]--

---------------------
-- Citizen Threads --
---------------------

local closeTo = 0

--[[
exports["polyzonehelper"]:AddBoxZone("miningzone", vector3(2991.23, 2751.33, 43.53), 2.4, 2.6, {
    heading=177,
    minZ=40,
    maxZ=50,
    debug = true
})
]]--

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	canwork = true
end)

for k, v in pairs(Config.MiningPositions) do
    --print(json.encode(v))
    exports["polyzonehelper"]:AddBoxZone("miningzone", v.coords, 1, 5, {
        heading = v.heading,
        minZ=40,
        maxZ=50,
        debug = true
    })
end

AddEventHandler("polyzonehelper:enter", function(zone)
    --print("entered zone")
    local currentZone = zone
    if currentZone == 'miningzone' and not appening and canwork then
        if not alreadysent then
            alreadysent = true
            exports['textUi']:DrawTextUi('show', "[E] Plant C4")  
            mainthings()
        end
    end
end)

local enditall = false

AddEventHandler("polyzonehelper:exit", function(zone)
    --print("exited zone")
    local currentZone = zone
    if currentZone == 'miningzone' and canwork then
        alreadysent = false
        enditall = true
        exports['textUi']:HideTextUi('hide')
    end
end)

-- shitest optimisation you will ever see sorry
function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

mainthings = function()
Citizen.CreateThread(function()
    while true do

        alreadysent = true

        if enditall then
            enditall = false
            appening = false
            alreadysent = false
            mining = false
            exploded = false
            break
        end

        --if not miningman and not appening then
            --print("broken")
            --alreadysent = false
            --break
        --end

        for k, v in pairs(Config.MiningPositions) do
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true) <= 2.5 then
                closeTo = v
                break
            end
        end
        
        if type(closeTo) == 'table' then
            while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), closeTo.coords, true) <= 2.5 and not exploded do
                local counter = 0
                Wait(0)
                --helpText(Strings['press_mine'])
                --print("checking")
                if IsControlJustReleased(0, 38) then
                    local player, distance = QBCore.Functions.GetClosestPlayer()
                    if distance == -1 or distance >= 8.0 then
                        mining = true
                        GiveWeaponToPed(PlayerPedId(), GetHashKey("weapon_stickybomb"), 1, false, true)
                        Wait(1250)                                                                                      
                        TaskPlantBomb(PlayerPedId(), closeTo.coords, 218.5)

                        while mining and not exploded do
                            -- Wait(1000)
                            local time = 6
                            exports['lrp-notify']:Alert("WARNING", "Stand back from the blast!", 2000, 'warning')
							while time > 0 do 
								--QBCore.Functions.Notify("Blast in about " .. time .. "..")
                                exports['lrp-notify']:Alert("WARNING", "Blast in " ..  time, 1000, 'warning')
								Citizen.Wait(1000)
								time = time - 1
							end
							AddExplosion(closeTo.coords.x, closeTo.coords.y, closeTo.coords.z, EXPLOSION_STICKYBOMB, 4.0, true, false, 20.0)
                            exploded = true
                            appening = false
                            --print("coords:", dump(coordsthing))
                            TriggerServerEvent("mining:server:spawnObject", "prop_rock_4_c")     
                            enditall = true
                            break
                        end
                    else
                        QBCore.Functions.Notify(Strings['someone_close'], "error")
                        -- TriggerEvent('cy-notify:send', Strings['someone_close'], 1)
                    end
                end
            end
        end
        Wait(300)
    end
end)
end

RegisterNetEvent('mining:client:spawnObject', function(objectId)
  
    for k, v in pairs(Config.MiningPositions) do
        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true) <= 2.5 then
            closeTo = v
            break
        end
    end

    --print(objectId, "if this is nil contact a developer")
    --print("coords again:", closeTo.coords.x, closeTo.coords.y , closeTo.coords.z + 2.5)

    local spawnedObj = CreateObject(GetHashKey("prop_rock_4_c"), closeTo.coords.x, closeTo.coords.y , closeTo.coords.z, true, true, true)

    ObjectList[objectId] = {
        id = objectId,
        object = spawnedObj,
        coords = {
            x = closeTo.coords.x,
            y = closeTo.coords.y,
            z = closeTo.coords.z,
        },
    }

    --print("Objects:", dump(ObjectList))
end)

local function Miningobject()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil

    for id, data in pairs(ObjectList) do
        local dist2 = #(pos - vector3(ObjectList[id].coords.x, ObjectList[id].coords.y, ObjectList[id].coords.z))
        if current then
            if dist2 < dist then
                current = id
                dist = dist2
            end
        else
            dist = dist2
            current = id
        end
    end
    return current, dist
end

RegisterNetEvent('nomorerocks')
AddEventHandler('nomorerocks', function()
    local objectId, dist = Miningobject()
    print(objectId, "if this is nil contact a developer")
    local model = loadModel(GetHashKey(Config.Objects['drill']))
    local axe = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false, false)
    --local playerCoords = GetEntityCoords(PlayerPedId())
    --local rocknear = GetClosestObjectOfType(playerCoords.x,playerCoords.y,playerCoords.z,1,GetHashKey("prop_rock_4_c"),0,0,0)

    AttachEntityToEntity(axe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.09, 0.03, -0.02, 0.0, 0.0, 0.0, false, true, true, true, 0, true)
    Wait(100)

    FreezeEntityPosition(player, true)
    local dict = loadDict('amb@world_human_const_drill@male@drill@base')
    TaskPlayAnim(PlayerPedId(), dict, 'base', 8.0, -8.0, -1, 2, 0, false, false, false)

    QBCore.Functions.Progressbar("minerock", "Mining Rock", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = true,
        disableCombat = true,
    }, {}, {}, {}, function()
        ClearPedTasks(PlayerPedId())
        FreezeEntityPosition(player, false)
        DeleteObject(axe)
        local unneededobject = QBCore.Functions.GetClosestObject(GetEntityCoords(PlayerPedId()))
        SetEntityAsMissionEntity(unneededobject, true, true)
        DeleteEntity(unneededobject)
        DeleteObject(unneededobject)
        TriggerServerEvent("mining:server:deleteObject", objectId)
        TriggerServerEvent('osm-mining:getStone')
    end)

    isWashing = false
    exploded = false
    mining = false
end)

RegisterNetEvent('mining:client:removeObject', function(objectId)
    if ObjectList[objectId].object == nil then return end

    NetworkRequestControlOfEntity(ObjectList[objectId].object)
    DeleteObject(ObjectList[objectId].object)
    ObjectList[objectId].object = nil
end)

local washcords = Config.WashCoords
local process = Config.GetMetal

Citizen.CreateThread(function()
	local sleep
	while true do
		sleep = 5
		local player = PlayerPedId()
		local playercoords = GetEntityCoords(player)
		local dist = #(vector3(playercoords.x,playercoords.y,playercoords.z)-vector3(washcords.x,washcords.y,washcords.z))
		if dist <= 3 and not isWashing and canwork then
			sleep = 5
			DrawText3D(washcords.x, washcords.y, washcords.z, 'Press [ E ] to Wash a Stone')
			if IsControlJustPressed(1, 51) then
				isWashing = true
				QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                        if result then
                            local model = loadModel(Config.Objects['stone'])
                            stone = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false, false)
                            AttachEntityToEntity(stone, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.09, 0.03, -0.02, 0.0, 0.0, 0.0, false, true, true, true, 0, true)
                            washing()
                        else
                            QBCore.Functions.Notify("You don't have material", "error")
                            isWashing = false
                        end
				end, 'stone')
			end
		else
			sleep = 2000
		end
		Citizen.Wait(sleep)
	end
end)

RegisterNetEvent('lrp-mining:client:processing')
AddEventHandler('lrp-mining:client:processing', function()
    isProcess = true

    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
            if result then
                processing()  
            else
                QBCore.Functions.Notify("You don't have Washed Stones", "error")
                isProcess = false
            end
    end, 'washedstone')

end)

--[[
Citizen.CreateThread(function()
	local sleep
	while true do
		sleep = 5
		local player = PlayerPedId()
		local playercoords = GetEntityCoords(player)
		local dist = #(vector3(playercoords.x,playercoords.y,playercoords.z)-vector3(process.x,process.y,process.z))
		if dist <= 3 and not isProcess and canwork then
			sleep = 5
			DrawText3D(process.x, process.y, process.z, 'Press [ E ] to Process Washed Stone')
			if IsControlJustPressed(1, 51) then
				isProcess = true
				QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                        if result then
                            processing()  
                        else
                            QBCore.Functions.Notify("You don't have Washed Stones", "error")
                            isProcess = false
                        end
				end, 'washedstone')
			end
		else
			sleep = 1500
		end
		Citizen.Wait(sleep)
	end
end)]]--

function washing()
	local player = PlayerPedId()
	SetEntityCoords(player, washcords.x,washcords.y,washcords.z-1, 0.0, 0.0, 0.0, false)
	SetEntityHeading(player, 286.84)
	FreezeEntityPosition(player, true)
	local dict = loadDict('amb@prop_human_bum_bin@idle_a')
    TaskPlayAnim((player), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    QBCore.Functions.TriggerCallback('lrp-mining:server:stoneamount', function (amount)
        local time = amount * 3000    
        QBCore.Functions.Progressbar("washingstone", "Washing Stones..", time, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            FreezeEntityPosition(player, false)
            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                if result then
                    TriggerServerEvent('osm-mining:washing')
                    DeleteObject(stone)
                    isWashing = false
                else
                    QBCore.Functions.Notify("You don't have the material", "error")
                    DeleteObject(stone)
                    isWashing = false
                end
            end, 'stone')
        
        end, function() -- Cancel
            isWashing = false
            DeleteObject(stone)
            ClearPedTasksImmediately(player)
            FreezeEntityPosition(player, false)
        end)
    end)
end

function processing()
	local player = PlayerPedId()

	FreezeEntityPosition(player, true)
	local dict = loadDict('amb@prop_human_bum_bin@idle_a')
    TaskPlayAnim((player), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    
    QBCore.Functions.TriggerCallback('lrp-mining:server:washedstoneamount', function (amount)
        local time = amount * 7000
        QBCore.Functions.Progressbar("processing", "Processing..", time, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            FreezeEntityPosition(player, false)
            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                if result then
                    TriggerServerEvent('osm-mining:getItemNew')
                    isProcess = false
                else
                    QBCore.Functions.Notify("You don't have Washed Stones", "error")
                    isProcess = false
                end
            end, 'washedstone')
        
        end, function() -- Cancel
            isProcess = false
            ClearPedTasksImmediately(player)
            FreezeEntityPosition(player, false)
        end)
    end)
end

Citizen.CreateThread(function()
    local blip1 = AddBlipForCoord(washcords.x, washcords.y, washcords.z)
	SetBlipSprite(blip1, 467)
	SetBlipDisplay(blip1, 4)
	SetBlipScale(blip1, 0.7)
	SetBlipAsShortRange(blip1, true)
	SetBlipColour(blip1, 5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Mining - Wash")
    EndTextCommandSetBlipName(blip1)
end)


Citizen.CreateThread(function()
    local blip3 = AddBlipForCoord(1110.6, -2007.72, 31.04)
	SetBlipSprite(blip3, 268)
	SetBlipDisplay(blip3, 4)
	SetBlipScale(blip3, 0.7)
	SetBlipAsShortRange(blip3, true)
	SetBlipColour(blip3, 5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Mining - Smelting")
    EndTextCommandSetBlipName(blip3)
end)


Citizen.CreateThread(function()
    local blip = AddBlipForCoord(2952.03, 2786.55, 41.35)
	SetBlipSprite(blip, 527)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.7)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Mining")
    EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(24.81, -610.32, 31.63)
	SetBlipSprite(blip, 280)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.7)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Material Selling")
    EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
    for k, v in pairs(Config.MiningPositions) do
    local blip = AddBlipForCoord(v.coords.x,v.coords.y,v.coords.z)
	SetBlipSprite(blip, 271)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.1)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 0)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Mining place")
    EndTextCommandSetBlipName(blip)
    end
end)

--Code

--[[Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local inRange = false

        if not notInteressted then
            for k, v in pairs(Config.SellLocations) do
                local dist = GetDistanceBetweenCoords(pos, v["coords"]["x"], v["coords"]["y"], v["coords"]["z"], true)

                if dist < 20 then
                    inRange = true

                    if dist < 1 then
                        QBCore.Functions.DrawText3D(v["coords"]["x"], v["coords"]["y"], v["coords"]["z"] - 0.1, '~g~E~w~ - Sell Mining Items')

                        if IsControlJustPressed(0, 38) then
                            TriggerServerEvent('osm-mining:sell')
                        end
                    end
                end
            end
        else
            Citizen.Wait(5000)
        end

        if not inRange then
            Citizen.Wait(1500)
        end

        Citizen.Wait(3)
    end
end)]]

function ClearTimeOut()
    notInteressted = not notInteressted
end

RegisterNetEvent('lrp-mining:client:selling')
AddEventHandler('lrp-mining:client:selling', function()
    QBCore.Functions.Progressbar("sell", "Selling...", 2000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('osm-mining:sell')
    end, function() -- Cancel
    end)
end)