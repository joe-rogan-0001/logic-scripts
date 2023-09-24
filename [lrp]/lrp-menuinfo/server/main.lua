
------------------------------------------------------------------------------------------------

QBCore = exports['lrp-core']:GetCoreObject()

------------------------------------------------------------------------------------------------

QBCore.Functions.CreateCallback('chicle_pause_menu:getPlayerName', function(source,cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local PlayerName = cb(Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname)
end)

------------------------------------------------------------------------------------------------

QBCore.Functions.CreateCallback('chicle_pause_menu:getPlayerMoney', function(source,cb)
    PlayerData = QBCore.Functions.GetPlayerData()

    cb( { cash = Player.PlayerData.money['cash'], bank = Player.PlayerData.money['bank'] } )
end)

------------------------------------------------------------------------------------------------
