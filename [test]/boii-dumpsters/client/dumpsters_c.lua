-------------------------------
---------- CASE#2506 ----------
-------------------------------

--<!>-- DO NOT EDIT ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--
local Core = Config.Core
local CoreFolder = Config.CoreFolder
local Core = exports[CoreFolder]:GetCoreObject()
local TargetName = Config.TargetName
local CoolDown = Config.Cooldown
local DumpsterProp = Config.DumpsterProp
local DumpsterProp2 = Config.DumpsterProp2
local DumpsterProp3 = Config.DumpsterProp3
local DumpsterProp4 = Config.DumpsterProp4
local DumpsterProp5 = Config.DumpsterProp5
local DumpsterProp6 = Config.DumpsterProp6
local BinProp = Config.BinProp
local BinProp2 = Config.BinProp2
local BinProp3 = Config.BinProp3
local BinProp4 = Config.BinProp4
local BinProp5 = Config.BinProp5
local BinProp6 = Config.BinProp6
local BinProp7 = Config.BinProp7
local BinProp8 = Config.BinProp8
local BinProp9 = Config.BinProp9
local BinProp10 = Config.BinProp10
local BinProp11 = Config.BinProp11
local SearchedDumpster = {}
local SearchedBin = {}
--<!>-- DO NOT EDIT ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--

--<!>-- NOTIFICATIONS CODE START --<!>--
-- You can replace the notification event here if you do not use native qb notifications
RegisterNetEvent('boii-dumpsters:notifications')
AddEventHandler('boii-dumpsters:notifications', function(msg, type)
	Core.Functions.Notify(msg,type)
end)
--<!>-- NOTIFICATIONS CODE END --<!>--

--<!>-- TARGETING CODE START --<!>--
-- Dumpsters targeting props defined in config.lua
exports[TargetName]:AddTargetModel(DumpsterProp, {
    options = {
        {
            event = "boii-dumpsters:client:SearchDumpster",
            icon = "fas fa-box",
            label = Config.Lang['searchdumpster'],
        },
    },
    distance = 1.5
})
exports[TargetName]:AddTargetModel(DumpsterProp2, {
    options = {
        {
            event = "boii-dumpsters:client:SearchDumpster2",
            icon = "fas fa-box",
            label = Config.Lang['searchdumpster'],
        },
    },
    distance = 1.5
})
exports[TargetName]:AddTargetModel(DumpsterProp3, {
    options = {
        {
            event = "boii-dumpsters:client:SearchDumpster3",
            icon = "fas fa-box",
            label = Config.Lang['searchdumpster'],
        },
    },
    distance = 1.5
})
exports[TargetName]:AddTargetModel(DumpsterProp4, {
    options = {
        {
            event = "boii-dumpsters:client:SearchDumpster4",
            icon = "fas fa-box",
            label = Config.Lang['searchdumpster'],
        },
    },
    distance = 1.5
})
exports[TargetName]:AddTargetModel(DumpsterProp5, {
    options = {
        {
            event = "boii-dumpsters:client:SearchDumpster5",
            icon = "fas fa-box",
            label = Config.Lang['searchdumpster'],
        },
    },
    distance = 1.5
})
exports[TargetName]:AddTargetModel(DumpsterProp6, {
    options = {
        {
            event = "boii-dumpsters:client:SearchDumpster6",
            icon = "fas fa-box",
            label = Config.Lang['searchdumpster'],
        },
    },
    distance = 1.5
})
-- Bins targeting props defined in config.lua
exports[TargetName]:AddTargetModel(BinProp, {
    options = {
        {
            event = "boii-dumpsters:client:SearchBin",
            icon = "fas fa-box",
            label = Config.Lang['searchbin'],
        },
    },
    distance = 1.5
})
exports[TargetName]:AddTargetModel(BinProp2, {
    options = {
        {
            event = "boii-dumpsters:client:SearchBin2",
            icon = "fas fa-box",
            label = Config.Lang['searchbin'],
        },
    },
    distance = 1.5
})
exports[TargetName]:AddTargetModel(BinProp3, {
    options = {
        {
            event = "boii-dumpsters:client:SearchBin3",
            icon = "fas fa-box",
            label = Config.Lang['searchbin'],
        },
    },
    distance = 1.5
})
exports[TargetName]:AddTargetModel(BinProp4, {
    options = {
        {
            event = "boii-dumpsters:client:SearchBin4",
            icon = "fas fa-box",
            label = Config.Lang['searchbin'],
        },
    },
    distance = 1.5
})
exports[TargetName]:AddTargetModel(BinProp5, {
    options = {
        {
            event = "boii-dumpsters:client:SearchBin5",
            icon = "fas fa-box",
            label = Config.Lang['searchbin'],
        },
    },
    distance = 1.5
})
exports[TargetName]:AddTargetModel(BinProp6, {
    options = {
        {
            event = "boii-dumpsters:client:SearchBin6",
            icon = "fas fa-box",
            label = Config.Lang['searchbin'],
        },
    },
    distance = 1.5
})
exports[TargetName]:AddTargetModel(BinProp7, {
    options = {
        {
            event = "boii-dumpsters:client:SearchBin7",
            icon = "fas fa-box",
            label = Config.Lang['searchbin'],
        },
    },
    distance = 1.5
})
exports[TargetName]:AddTargetModel(BinProp8, {
    options = {
        {
            event = "boii-dumpsters:client:SearchBin8",
            icon = "fas fa-box",
            label = Config.Lang['searchbin'],
        },
    },
    distance = 1.5
})
exports[TargetName]:AddTargetModel(BinProp9, {
    options = {
        {
            event = "boii-dumpsters:client:SearchBin9",
            icon = "fas fa-box",
            label = Config.Lang['searchbin'],
        },
    },
    distance = 1.5
})
exports[TargetName]:AddTargetModel(BinProp10, {
    options = {
        {
            event = "boii-dumpsters:client:SearchBin10",
            icon = "fas fa-box",
            label = Config.Lang['searchbin'],
        },
    },
    distance = 1.5
})
exports[TargetName]:AddTargetModel(BinProp11, {
    options = {
        {
            event = "boii-dumpsters:client:SearchBin11",
            icon = "fas fa-box",
            label = Config.Lang['searchbin'],
        },
    },
    distance = 1.5
})
--<!>-- TARGETING CODE END --<!>--

--<!>-- DUMPSTERS CODE START --<!>--
--Search dumpsters
RegisterNetEvent('boii-dumpsters:client:SearchDumpster', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #DumpsterProp do
        local Dumpster = GetClosestObjectOfType(playerCoords, 1.5, GetHashKey(DumpsterProp[i]), false, false, false)
        local entity = nil
        if DoesEntityExist(Dumpster) then
            entity = Dumpster
            dumpster = GetEntityCoords(entity)                
                if not SearchedDumpster[entity] then
                    SearchDumpster(entity)
                else
                    TriggerEvent('boii-dumpsters:notifications', Config.Lang['alreadysearched'], 'error')
                end
            break
        else
            Wait(CoolDown * 1000)
        end
    end
end)
RegisterNetEvent('boii-dumpsters:client:SearchDumpster2', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #DumpsterProp2 do
        local Dumpster = GetClosestObjectOfType(playerCoords, 1.5, GetHashKey(DumpsterProp2[i]), false, false, false)
        local entity = nil
        if DoesEntityExist(Dumpster) then
            entity = Dumpster
            dumpster = GetEntityCoords(entity)                
                if not SearchedDumpster[entity] then
                    SearchDumpster(entity)
                else
                    TriggerEvent('boii-dumpsters:notifications', Config.Lang['alreadysearched'], 'error')
                end
            break
        else
            Wait(CoolDown * 1000)
        end
    end
end)
RegisterNetEvent('boii-dumpsters:client:SearchDumpster3', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #DumpsterProp3 do
        local Dumpster = GetClosestObjectOfType(playerCoords, 2.0, GetHashKey(DumpsterProp3[i]), false, false, false)
        local entity = nil
        if DoesEntityExist(Dumpster) then
            entity = Dumpster
            dumpster = GetEntityCoords(entity)                
                if not SearchedDumpster[entity] then
                    SearchDumpster(entity)
                else
                    TriggerEvent('boii-dumpsters:notifications', Config.Lang['alreadysearched'], 'error')
                end
            break
        else
            Wait(CoolDown * 1000)
        end
    end
end)
RegisterNetEvent('boii-dumpsters:client:SearchDumpster4', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #DumpsterProp4 do
        local Dumpster = GetClosestObjectOfType(playerCoords, 1.5, GetHashKey(DumpsterProp4[i]), false, false, false)
        local entity = nil
        if DoesEntityExist(Dumpster) then
            entity = Dumpster
            dumpster = GetEntityCoords(entity)                
                if not SearchedDumpster[entity] then
                    SearchDumpster(entity)
                else
                    TriggerEvent('boii-dumpsters:notifications', Config.Lang['alreadysearched'], 'error')
                end
            break
        else
            Wait(CoolDown * 1000)
        end
    end
end)
RegisterNetEvent('boii-dumpsters:client:SearchDumpster5', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #DumpsterProp5 do
        local Dumpster = GetClosestObjectOfType(playerCoords, 1.5, GetHashKey(DumpsterProp5[i]), false, false, false)
        local entity = nil
        if DoesEntityExist(Dumpster) then
            entity = Dumpster
            dumpster    = GetEntityCoords(entity)                
                if not SearchedDumpster[entity] then
                    SearchDumpster(entity)
                else
                    TriggerEvent('boii-dumpsters:notifications',Config.Lang['alreadysearched'], 'error')
                end
            break
        else
            Wait(CoolDown * 1000)
        end
    end
end)
RegisterNetEvent('boii-dumpsters:client:SearchDumpster6', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #DumpsterProp6 do
        local Dumpster = GetClosestObjectOfType(playerCoords, 1.5, GetHashKey(DumpsterProp6[i]), false, false, false)
        local entity = nil
        if DoesEntityExist(Dumpster) then
            entity = Dumpster
            dumpster    = GetEntityCoords(entity)                
                if not SearchedDumpster[entity] then
                    SearchDumpster(entity)
                else
                    TriggerEvent('boii-dumpsters:notifications',Config.Lang['alreadysearched'], 'error')
                end
            break
        else
            Wait(CoolDown * 1000)
        end
    end
end)
-- Function to search dumpsters
function SearchDumpster(entity)
	local playerPed = PlayerPedId()
    Core.Functions.Progressbar("search_dumpsters", Config.Lang['searchingdumpster'], Config.DumpsterSearchTime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
		anim = "fixing_a_ped",
		flags = 49,
    }, {}, {}, function()
    SearchedDumpster[entity] = true
    ClearPedTasks(playerPed)
    TriggerServerEvent('boii-dumpsters:server:SearchDumpster')
    end)
end
--<!>-- DUMPSTERS CODE END --<!>--

--<!>-- BINS CODE START --<!>--
RegisterNetEvent('boii-dumpsters:client:SearchBin', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #BinProp do
        local Bin = GetClosestObjectOfType(playerCoords, 1.5, GetHashKey(BinProp[i]), false, false, false)
        local entity = nil
        if DoesEntityExist(Bin) then
            entity = Bin
            dumpster = GetEntityCoords(entity)                
                if not SearchedBin[entity] then
                    SearchBin(entity)
                else
                    TriggerEvent('boii-dumpsters:notifications',Config.Lang['alreadysearched'], 'error')
                end
            break
        else
            Wait(CoolDown * 1000)
        end
    end
end)
RegisterNetEvent('boii-dumpsters:client:SearchBin2', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #BinProp2 do
        local Bin = GetClosestObjectOfType(playerCoords, 1.5, GetHashKey(BinProp2[i]), false, false, false)
        local entity = nil
        if DoesEntityExist(Bin) then
            entity = Bin
            dumpster = GetEntityCoords(entity)                
                if not SearchedBin[entity] then
                    SearchBin(entity)
                else
                    TriggerEvent('boii-dumpsters:notifications',Config.Lang['alreadysearched'], 'error')
                end
            break
        else
            Wait(CoolDown * 1000)
        end
    end
end)
RegisterNetEvent('boii-dumpsters:client:SearchBin3', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #BinProp3 do
        local Bin = GetClosestObjectOfType(playerCoords, 1.5, GetHashKey(BinProp3[i]), false, false, false)
        local entity = nil
        if DoesEntityExist(Bin) then
            entity = Bin
            dumpster = GetEntityCoords(entity)                
                if not SearchedBin[entity] then
                    SearchBin(entity)
                else
                    TriggerEvent('boii-dumpsters:notifications',Config.Lang['alreadysearched'], 'error')
                end
            break
        else
            Wait(CoolDown * 1000)
        end
    end
end)
RegisterNetEvent('boii-dumpsters:client:SearchBin4', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #BinProp4 do
        local Bin = GetClosestObjectOfType(playerCoords, 1.5, GetHashKey(BinProp4[i]), false, false, false)
        local entity = nil
        if DoesEntityExist(Bin) then
            entity = Bin
            dumpster = GetEntityCoords(entity)                
                if not SearchedBin[entity] then
                    SearchBin(entity)
                else
                    TriggerEvent('boii-dumpsters:notifications',Config.Lang['alreadysearched'], 'error')
                end
            break
        else
            Wait(CoolDown * 1000)
        end
    end
end)
RegisterNetEvent('boii-dumpsters:client:SearchBin5', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #BinProp5 do
        local Bin = GetClosestObjectOfType(playerCoords, 1.5, GetHashKey(BinProp5[i]), false, false, false)
        local entity = nil
        if DoesEntityExist(Bin) then
            entity = Bin
            dumpster = GetEntityCoords(entity)                
                if not SearchedBin[entity] then
                    SearchBin(entity)
                else
                    TriggerEvent('boii-dumpsters:notifications',Config.Lang['alreadysearched'], 'error')
                end
            break
        else
            Wait(CoolDown * 1000)
        end
    end
end)
RegisterNetEvent('boii-dumpsters:client:SearchBin6', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #BinProp6 do
        local Bin = GetClosestObjectOfType(playerCoords, 1.5, GetHashKey(BinProp6[i]), false, false, false)
        local entity = nil
        if DoesEntityExist(Bin) then
            entity = Bin
            dumpster = GetEntityCoords(entity)                
                if not SearchedBin[entity] then
                    SearchBin(entity)
                else
                    TriggerEvent('boii-dumpsters:notifications',Config.Lang['alreadysearched'], 'error')
                end
            break
        else
            Wait(CoolDown * 1000)
        end
    end
end)
RegisterNetEvent('boii-dumpsters:client:SearchBin7', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #BinProp7 do
        local Bin = GetClosestObjectOfType(playerCoords, 1.5, GetHashKey(BinProp7[i]), false, false, false)
        local entity = nil
        if DoesEntityExist(Bin) then
            entity = Bin
            dumpster = GetEntityCoords(entity)                
                if not SearchedBin[entity] then
                    SearchBin(entity)
                else
                    TriggerEvent('boii-dumpsters:notifications',Config.Lang['alreadysearched'], 'error')
                end
            break
        else
            Wait(CoolDown * 1000)
        end
    end
end)
RegisterNetEvent('boii-dumpsters:client:SearchBin8', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #BinProp8 do
        local Bin = GetClosestObjectOfType(playerCoords, 1.5, GetHashKey(BinProp8[i]), false, false, false)
        local entity = nil
        if DoesEntityExist(Bin) then
            entity = Bin
            dumpster = GetEntityCoords(entity)                
                if not SearchedBin[entity] then
                    SearchBin(entity)
                else
                    TriggerEvent('boii-dumpsters:notifications',Config.Lang['alreadysearched'], 'error')
                end
            break
        else
            Wait(CoolDown * 1000)
        end
    end
end)
RegisterNetEvent('boii-dumpsters:client:SearchBin9', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #BinProp9 do
        local Bin = GetClosestObjectOfType(playerCoords, 1.5, GetHashKey(BinProp9[i]), false, false, false)
        local entity = nil
        if DoesEntityExist(Bin) then
            entity = Bin
            dumpster = GetEntityCoords(entity)                
                if not SearchedBin[entity] then
                    SearchBin(entity)
                else
                    TriggerEvent('boii-dumpsters:notifications',Config.Lang['alreadysearched'], 'error')
                end
            break
        else
            Wait(CoolDown * 1000)
        end
    end
end)
RegisterNetEvent('boii-dumpsters:client:SearchBin10', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #BinProp10 do
        local Bin = GetClosestObjectOfType(playerCoords, 1.5, GetHashKey(BinProp10[i]), false, false, false)
        local entity = nil
        if DoesEntityExist(Bin) then
            entity = Bin
            dumpster = GetEntityCoords(entity)                
                if not SearchedBin[entity] then
                    SearchBin(entity)
                else
                    TriggerEvent('boii-dumpsters:notifications',Config.Lang['alreadysearched'], 'error')
                end
            break
        else
            Wait(CoolDown * 1000)
        end
    end
end)
RegisterNetEvent('boii-dumpsters:client:SearchBin11', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #BinProp11 do
        local Bin = GetClosestObjectOfType(playerCoords, 1.5, GetHashKey(BinProp11[i]), false, false, false)
        local entity = nil
        if DoesEntityExist(Bin) then
            entity = Bin
            dumpster = GetEntityCoords(entity)                
                if not SearchedBin[entity] then
                    SearchBin(entity)
                else
                    TriggerEvent('boii-dumpsters:notifications',Config.Lang['alreadysearched'], 'error')
                end
            break
        else
            Wait(CoolDown * 1000)
        end
    end
end)
-- Function to search bins
function SearchBin(entity)
	local playerPed = PlayerPedId()
    Core.Functions.Progressbar("search_bin", Config.Lang['searchingbin'], Config.BinSearchTime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_bum_bin@base",
		anim = "base",
		flags = 49,
    }, {}, {}, function()
    SearchedBin[entity] = true
    ClearPedTasks(playerPed)
    TriggerServerEvent('boii-dumpsters:server:SearchBin')
    end)
end
--<!>-- BINS CODE END --<!>--

--<!>-- ANIMATION CODE START --<!>--
-- Animation to search
function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do 
      Wait(0) 
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end
--<!>-- ANIMATION CODE END --<!>--