if not Framework.STANDALONE then
    Citizen.CreateThread(function()
        while not ESX do Wait(100) end
        ESX.RegisterUsableItem("spray_remover", function(playerId)
            TriggerClientEvent('rcore_spray:removeClosestSpray', playerId)
        end)
    end)
end

RegisterNetEvent('rcore_spray:remove')
AddEventHandler('rcore_spray:remove', function(pos)
    local Source = source

    if Framework.STANDALONE then
        RemoveSprayAtPosition(Source, pos)
        return
    end

    local xPlayer = ESX.GetPlayerFromId(Source)
    local item = SafeGetItem(xPlayer, "spray_remover")

    if item.count > 0 then
        xPlayer.removeInventoryItem("spray_remover", 1)
        RemoveSprayAtPosition(Source, pos)
    end
end)