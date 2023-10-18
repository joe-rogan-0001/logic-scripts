-- Framework Object
if Config.Framework == "QBCore" then
    QBCore = exports['lrp-core']:GetCoreObject()
end

if Config.Framework == "ESX" then
    ESX = exports['es_extended']:getSharedObject()
end

-- Job handlers
local PlayerJob = nil

function GetJob()
    if not PlayerJob then
        if Config.Framework == "ESX" then
            PlayerJob = ESX.GetPlayerData().job
        else
            QBCore.Functions.GetPlayerData(function(PlayerData)
                PlayerJob = PlayerData.job
            end)
        end
    end
    return PlayerJob
end

-- ESX Event for job update
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerJob = xPlayer.job
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerJob = job
end)

-- QB Core Event for job update / player loaded
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    CreateThread(function()
        Wait(1000)
        QBCore.Functions.GetPlayerData(function(PlayerData)
            PlayerJob = PlayerData.job
        end)
    end)
end)