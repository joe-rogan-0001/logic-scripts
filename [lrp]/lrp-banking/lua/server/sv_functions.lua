local QBCore = exports['lrp-core']:GetCoreObject()

function AddTransaction(source, sAccount, iAmount, sType, sReceiver, sMessage, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CitizenId = Player.PlayerData.citizenid

    local iTransactionID = math.random(1000, 100000)

    MySQL.Async.insert("INSERT INTO `transaction_history` (`citizenid`, `trans_id`, `account`, `amount`, `trans_type`, `receiver`, `message`) VALUES(?, ?, ?, ?, ?, ?, ?)", {
        CitizenId,
        iTransactionID,
        sAccount,
        iAmount,
        sType,
        sReceiver,
        sMessage
    }, function()
        RefreshTransactions(src)
    end)
end

function RefreshTransactions(source)
    local src = source
    if not src then return end

    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end

    local result = MySQL.Sync.fetchAll("SELECT * FROM transaction_history WHERE citizenid =  ? AND DATE(date) > (NOW() - INTERVAL "..SimpleBanking.Config["Days_Transaction_History"].." DAY)", {Player.PlayerData.citizenid})

    if result ~= nil then
        TriggerClientEvent("qb-banking:client:UpdateTransactions", src, result)
    end
end

QBCore.Commands.Add('givecash', 'Give cash to player.', {{name = 'id', help = 'Player ID'}, {name = 'amount', help = 'Amount'}}, true, function(source, args)
    local src = source
    local id = tonumber(args[1])
    local amount = math.ceil(tonumber(args[2]))
    
    if id and amount then
        local xPlayer = QBCore.Functions.GetPlayer(src)
        local xReciv = QBCore.Functions.GetPlayer(id)
        
        if xReciv and xPlayer then
            if not xPlayer.PlayerData.metadata["isdead"] then
                local distance = xPlayer.PlayerData.metadata["inlaststand"] and 3.0 or 10.0
                if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(id))) < distance then
                    if xPlayer.Functions.RemoveMoney('cash', amount) then
                        if xReciv.Functions.AddMoney('cash', amount) then
                            TriggerClientEvent('QBCore:Notify', src, "Success fully gave to ID " .. tostring(id) .. ' ' .. tostring(amount) .. '$.', "success")
                            TriggerClientEvent('QBCore:Notify', id, "Success recived gave " .. tostring(amount) .. '$ from ID ' .. tostring(src), "success")
                            TriggerClientEvent("payanimation", src)
                        else
                            TriggerClientEvent('QBCore:Notify', src, "Could not give item to the given id.", "error")
                        end
                    else
                        TriggerClientEvent('QBCore:Notify', src, "You don\'t have this amount.", "error")
                    end
                else
                    TriggerClientEvent('QBCore:Notify', src, "You are too far away lmfao.", "error")
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You are dead LOL.", "error")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "Wrong ID.", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Usage /givecash [ID] [AMOUNT]", "error")
    end
end)