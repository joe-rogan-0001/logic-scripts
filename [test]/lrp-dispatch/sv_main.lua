local QBCore = exports['lrp-core']:GetCoreObject()

local ESX = nil

local calls = 0

--PD CHECK
function isAuth(job)
    for i = 1, #Config["AuthorizedJobs"] do
        if job == Config["AuthorizedJobs"][i] then
            return true
        end
    end
    return false
end

--EMS CHECK
function isEMS(job)
    for i = 1, #Config["EmsJobs"] do
        if job == Config["EmsJobs"][i] then
            return true
        end
    end
    return false
end

--BOTH
function isBoth(job)
    for i = 1, #Config["Both"] do
        if job == Config["Both"][i] then
            return true
        end
    end
    return false
end

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


LoadQBCoreVersion = function()
    RegisterServerEvent("dispatch:svNotify", function(data)
        calls = calls + 1
        for idx, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) and xPlayer.PlayerData.job.onduty then
                --print("dispatch:", dump(data))
                TriggerClientEvent('dispatch:clNotify', xPlayer.PlayerData.source, data, calls)
            end
        end 
    end)
    RegisterServerEvent("dispatchems:svNotify", function(data)
        calls = calls + 1
        for idx, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isEMS(xPlayer.PlayerData.job.name) and xPlayer.PlayerData.job.onduty then
                --print("dispatch:", dump(data))
                TriggerClientEvent('dispatch:clNotify', xPlayer.PlayerData.source, data, calls)
            end
        end 
    end)
    RegisterServerEvent("un-dispatch:bankrobbery", function(coords)
        for idx, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) and xPlayer.PlayerData.job.onduty then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.PlayerData.source, "bankrobbery", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:storerobbery", function(coords)
        for idx, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) and xPlayer.PlayerData.job.onduty then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.PlayerData.source, "storerobbery", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:houserobbery", function(coords)
        for idx, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) and xPlayer.PlayerData.job.onduty then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.PlayerData.source, "houserobbery", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:jewelrobbery", function(coords)
        for idx, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) and xPlayer.PlayerData.job.onduty then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.PlayerData.source, "jewelrobbery", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:jailbreak", function(coords)
        for idx, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            --print("happend")
            if isAuth(xPlayer.PlayerData.job.name) and xPlayer.PlayerData.job.onduty then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.PlayerData.source, "jailbreak", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:carjacking", function(coords)
        for idx, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) and xPlayer.PlayerData.job.onduty then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.PlayerData.source, "carjacking", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:tenThirteenA", function(coords)
        for idx, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) and xPlayer.PlayerData.job.onduty then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.PlayerData.source, "tenThirteenA", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:tenThirteenB", function(coords)
        for idx, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) and xPlayer.PlayerData.job.onduty then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.PlayerData.source, "tenThirteenB", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:tenFourteenA", function(coords)
        for idx, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) and xPlayer.PlayerData.job.onduty then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.PlayerData.source, "tenFourteenA", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:tenFourteenB", function(coords)
        for idx, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) and xPlayer.PlayerData.job.onduty then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.PlayerData.source, "tenFourteenB", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:ninesvcall", function(coords)
        --print("got it")
        for idx, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) and xPlayer.PlayerData.job.onduty then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.PlayerData.source, "ninebcall", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:ninesvcalla", function(coords)
        --print("got it")
        for idx, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) and xPlayer.PlayerData.job.onduty then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.PlayerData.source, "ninebacall", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:ninesvcallems", function(coords)
        --print("wtf")
        for idx, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            --print(xPlayer.PlayerData.job.name)
            if isEMS(xPlayer.PlayerData.job.name) and xPlayer.PlayerData.job.onduty then
                --print("trigger?")
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.PlayerData.source, "ninebcall", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:persondown", function(coords)
        for idx, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isBoth(xPlayer.PlayerData.job.name) and xPlayer.PlayerData.job.onduty then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.PlayerData.source, "persondown", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:gunshot", function(coords)
        for idx, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) and xPlayer.PlayerData.job.onduty then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.PlayerData.source, "gunshot", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:carscraping", function(coords)
        for idx, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) and xPlayer.PlayerData.job.onduty then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.PlayerData.source, "carscraping", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:drugs", function(coords)
        for idx, id in pairs(QBCore.Functions.GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(id)
            if isAuth(xPlayer.PlayerData.job.name) and xPlayer.PlayerData.job.onduty then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.PlayerData.source, "drugs", coords)
            end
        end
    end)
end

LoadESXVersion = function()
    RegisterServerEvent("dispatch:svNotify", function(data)
        calls = calls + 1
        for idx, id in pairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(id)
            if isAuth(xPlayer.job.name) then
                TriggerClientEvent('dispatch:clNotify', xPlayer.source, data, calls)
            end
        end 
    end)
    RegisterServerEvent("un-dispatch:bankrobbery", function(coords)
        for idx, id in pairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(id)
            if isAuth(xPlayer.job.name) then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.source, "bankrobbery", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:storerobbery", function(coords)
        for idx, id in pairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(id)
            if isAuth(xPlayer.job.name) then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.source, "storerobbery", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:houserobbery", function(coords)
        for idx, id in pairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(id)
            if isAuth(xPlayer.job.name) then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.source, "houserobbery", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:jewelrobbery", function(coords)
        for idx, id in pairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(id)
            if isAuth(xPlayer.job.name) then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.source, "jewelrobbery", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:jailbreak", function(coords)
        for idx, id in pairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(id)
            if isAuth(xPlayer.job.name) then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.source, "jailbreak", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:carjacking", function(coords)
        for idx, id in pairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(id)
            if isAuth(xPlayer.job.name) then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.source, "carjacking", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:gunshot", function(coords)
        for idx, id in pairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(id)
            if isAuth(xPlayer.job.name) then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.source, "gunshot", coords)
            end
        end
    end)
end

LoadNopixelVersion = function()
    RegisterServerEvent("dispatch:svNotify", function(data)
        calls = calls + 1
        for idx, id in pairs(GetPlayers()) do
            local xPlayer = exports[Config["CoreSettings"]["NPBase"]["CoreName"]]:getModule("Player"):GetUser(tonumber(id))
            if isAuth(xPlayer.job) then
                TriggerClientEvent('dispatch:clNotify', xPlayer.source, data, calls)
            end
        end 
    end)
    RegisterServerEvent("un-dispatch:bankrobbery", function(coords)
        for idx, id in pairs(GetPlayers()) do
            local xPlayer = exports[Config["CoreSettings"]["NPBase"]["CoreName"]]:getModule("Player"):GetUser(tonumber(id))
            if isAuth(xPlayer.job) then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.source, "bankrobbery", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:storerobbery", function(coords)
        for idx, id in pairs(GetPlayers()) do
            local xPlayer = exports[Config["CoreSettings"]["NPBase"]["CoreName"]]:getModule("Player"):GetUser(tonumber(id))
            if isAuth(xPlayer.job) then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.source, "storerobbery", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:houserobbery", function(coords)
        for idx, id in pairs(GetPlayers()) do
            local xPlayer = exports[Config["CoreSettings"]["NPBase"]["CoreName"]]:getModule("Player"):GetUser(tonumber(id))
            if isAuth(xPlayer.job) then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.source, "houserobbery", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:jewelrobbery", function(coords)
        for idx, id in pairs(GetPlayers()) do
            local xPlayer = exports[Config["CoreSettings"]["NPBase"]["CoreName"]]:getModule("Player"):GetUser(tonumber(id))
            if isAuth(xPlayer.job) then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.source, "jewelrobbery", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:jailbreak", function(coords)
        for idx, id in pairs(GetPlayers()) do
            local xPlayer = exports[Config["CoreSettings"]["NPBase"]["CoreName"]]:getModule("Player"):GetUser(tonumber(id))
            if isAuth(xPlayer.job) then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.source, "jailbreak", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:carjacking", function(coords)
        for idx, id in pairs(GetPlayers()) do
            local xPlayer = exports[Config["CoreSettings"]["NPBase"]["CoreName"]]:getModule("Player"):GetUser(tonumber(id))
            if isAuth(xPlayer.job) then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.source, "carjacking", coords)
            end
        end
    end)
    RegisterServerEvent("un-dispatch:gunshot", function(coords)
        for idx, id in pairs(GetPlayers()) do
            local xPlayer = exports[Config["CoreSettings"]["NPBase"]["CoreName"]]:getModule("Player"):GetUser(tonumber(id))
            if isAuth(xPlayer.job) then
                TriggerClientEvent("un-dispatch:createBlip", xPlayer.source, "gunshot", coords)
            end
        end
    end)
end

Citizen.CreateThread(function()
    if Config["CoreSettings"]["Core"] == "qbcore" then
        if Config["CoreSettings"]["QBCore"]["QBCoreVersion"] == "new" then
            QBCore = Config["CoreSettings"]["QBCore"]["QBCoreExport"]
        elseif Config["CoreSettings"]["QBCore"]["QBCoreVersion"] == "old" then
            TriggerEvent(Config["CoreSettings"]["QBCore"]["QBUSTrigger"], function(obj) QBCore = obj end)
        end
        LoadQBCoreVersion()
    elseif Config["CoreSettings"]["Core"] == "esx" then
        TriggerEvent(Config["CoreSettings"]["ESX"]["ESXTrigger"], function(obj) ESX = obj end)
        LoadESXVersion()
    elseif Config["CoreSettings"]["Core"] == "npbase" then
        LoadNopixelVersion()
    end
end)


