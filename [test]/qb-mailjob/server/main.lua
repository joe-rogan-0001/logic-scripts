QBCore = exports['lrp-core']:GetCoreObject()
WorkingPlayers = {}
MailDelivered = {}

QBCore.Functions.CreateCallback("qb-mailjob:server:GetMailJobData", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        if Player.PlayerData.metadata['mailjob_packagesdelivered'] ~= nil then
            cb({PackagesDelivered=Player.PlayerData.metadata['mailjob_packagesdelivered']})
        else
            Player.Functions.SetMetaData("mailjob_packagesdelivered", 0)
            cb({PackagesDelivered=0})
        end
    end
end)

RegisterNetEvent("qb-mailjob:server:MailJobToggled", function(toggle)
    local src = source
    WorkingPlayers[src] = toggle
    if WorkingPlayers[src] == false then
        if MailDelivered[src] >= 1 then
            local Player = QBCore.Functions.GetPlayer(src)
            if Player then
                local level, data = GetCarrierLevelFromPackageCount(Player.PlayerData.metadata['mailjob_packagesdelivered'])
                local payAmount = math.floor((MailDelivered[src] * Config.MailDeliveredReward) * data.payMultiplier)
                Player.Functions.AddMoney("cash", payAmount)
                TriggerClientEvent("QBCore:Notify", src, "You delivered "..MailDelivered[src].." packages and are a "..data.name.." so you received $"..payAmount.." ("..data.payMultiplier.."x)")
            end
        end
    end
    MailDelivered[src] = 0
end)

RegisterNetEvent("qb-mailjob:server:DeliveredMail", function()
    local src = source
    if WorkingPlayers[src] == true then
        local Player = QBCore.Functions.GetPlayer(src)
        MailDelivered[src] = MailDelivered[src] + 1
        if Player then
            if Player.PlayerData.metadata['mailjob_packagesdelivered'] == nil then
                Player.Functions.SetMetaData("mailjob_packagesdelivered", 1)
            else
                Player.Functions.SetMetaData("mailjob_packagesdelivered", Player.PlayerData.metadata['mailjob_packagesdelivered'] + 1)
            end
        end
    end
end)

AddEventHandler('playerDropped', function ()
    local src = source
    if WorkingPlayers[src] == true then
        WorkingPlayers[src] = false
        MailDelivered[src] = 0
    end
end)
  