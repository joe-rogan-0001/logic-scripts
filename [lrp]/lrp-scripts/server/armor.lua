local QBCore = exports['lrp-core']:GetCoreObject()

RegisterNetEvent('qb-setarmor:Server:GetPlayerarmor', function()
    local src = source
    local playerPed = GetPlayerPed(src)
    local Player = QBCore.Functions.GetPlayer(src)
    local metadataArmor = tonumber(Player.PlayerData.metadata.armor)
    if metadataArmor > 0 and metadataArmor <= 100 then 
        Wait(1000)
        SetPedArmour(playerPed, metadataArmor)
        print(metadataArmor.." added to player["..src.."] armor | Current armor: "..GetPedArmour(playerPed))
        if tonumber(GetPedArmour(playerPed)) ~= metadataArmor then 
            print('request to update from client because failed to update player\'s armor')
            TriggerClientEvent('qb-setarmor:client:setarmor', src, metadataArmor)
        end
    end
end)

RegisterNetEvent('qb-armor:server:updateMetadata', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local currentArmor = GetPedArmour(GetPlayerPed(src))

    Player.Functions.SetMetaData("armor", currentArmor)
    print("Set " .. Player.PlayerData.citizenid .. "armour to " .. currentArmor)
end)
