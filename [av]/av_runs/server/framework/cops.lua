currentCops = 0

CreateThread(function()
    while true do
        if Config.Framework == "ESX" then
            for k, v in pairs(Config.PoliceJobs) do
                local xPlayers = ESX.GetExtendedPlayers("job", k)
                if xPlayers then
                    for i = 1, #xPlayers do
                        currentCops += 1
                    end
                end
            end
            TriggerClientEvent("police:SetCopCount", -1, currentCops)
        end
        Wait(3 * 60 * 1000) -- Sync cops count every 3 minutes
    end
end)